import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../domain/entities/training_plan.dart';
import '../../domain/repositories/training_plans_repository.dart';
import 'training_plans_controller.dart';

part 'client_training_plan_controller.g.dart';

@Riverpod(keepAlive: true)
class ClientTrainingPlanController extends _$ClientTrainingPlanController {
  late final TrainingPlansRepository _repository;

  @override
  AsyncValue<TrainingPlan?> build() {
    _repository = ref.watch(trainingPlansRepositoryProvider);
    Future.microtask(load);
    return const AsyncValue.loading();
  }

  Future<void> load() async {
    final userId = authProvider.userId;
    final gymId = authProvider.userGymId;

    if (userId == null || gymId == null) {
      state = const AsyncValue.data(null);
      return;
    }

    state = const AsyncValue.loading();
    final result = await _repository.getClientPlan(
      userId: userId,
      gymId: gymId,
    );

    result.when(
      idle: () {},
      loading: () {},
      success: (plan) => state = AsyncValue.data(plan),
      failure: (error) => state = AsyncValue.error(error, StackTrace.current),
    );
  }
}
