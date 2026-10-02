import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/utils/result.dart';
import '../../data/datasources/training_plans_remote_datasource.dart';
import '../../data/repositories/training_plans_repository_impl.dart';
import '../../domain/entities/training_plan.dart';
import '../../domain/repositories/training_plans_repository.dart';

part 'training_plans_controller.g.dart';

@riverpod
TrainingPlansRepository trainingPlansRepository(Ref ref) {
  return TrainingPlansRepositoryImpl(
    remote: TrainingPlansRemoteDatasource(Supabase.instance.client),
  );
}

@Riverpod(keepAlive: true)
class TrainingPlansController extends _$TrainingPlansController {
  late final TrainingPlansRepository _repository;

  @override
  AsyncValue<List<TrainingPlan>> build() {
    _repository = ref.watch(trainingPlansRepositoryProvider);

    authProvider.addListener(_onAuthChange);
    ref.onDispose(() => authProvider.removeListener(_onAuthChange));

    if (authProvider.isLoggedIn && !authProvider.isInitializing) {
      Future.microtask(load);
    }

    return const AsyncValue.loading();
  }

  void _onAuthChange() {
    if (!authProvider.isLoggedIn) {
      state = const AsyncValue.data([]);
      return;
    }
    if (!authProvider.isInitializing && state.value == null) {
      load();
    }
  }

  Future<void> load() async {
    final gymId = authProvider.userGymId;
    if (gymId == null) return;

    state = const AsyncValue.loading();
    final result = await _repository.getPlans(gymId: gymId);

    result.when(
      idle: () {},
      loading: () {},
      success: (plans) => state = AsyncValue.data(plans),
      failure: (error) => state = AsyncValue.error(error, StackTrace.current),
    );
  }

  Future<Result<TrainingPlan>> createPlan({
    required String clientId,
    required String name,
    String? description,
  }) async {
    final gymId = authProvider.userGymId;
    if (gymId == null) {
      return const Result.failure(
        UnknownException(
          code: 'TrainingPlans/no-gym',
          message: 'Sin gimnasio activo',
        ),
      );
    }

    final result = await _repository.createPlan(
      gymId: gymId,
      clientId: clientId,
      name: name,
      description: description,
    );

    if (result.isSuccess) await load();
    return result;
  }

  Future<Result<void>> deactivatePlan(String planId) async {
    final result = await _repository.deactivatePlan(planId: planId);
    if (result.isSuccess) await load();
    return result;
  }
}
