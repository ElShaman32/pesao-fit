import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/utils/result.dart';
import '../../data/datasources/routines_remote_datasource.dart';
import '../../data/repositories/routines_repository_impl.dart';
import '../../domain/entities/routine.dart';
import '../../domain/repositories/routines_repository.dart';

part 'routines_controller.g.dart';

@riverpod
RoutinesRepository routinesRepository(Ref ref) {
  return RoutinesRepositoryImpl(
    remote: RoutinesRemoteDatasource(Supabase.instance.client),
  );
}

@Riverpod(keepAlive: true)
class RoutinesController extends _$RoutinesController {
  late final RoutinesRepository _repository;

  @override
  AsyncValue<List<Routine>> build() {
    _repository = ref.watch(routinesRepositoryProvider);

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
    final result = await _repository.getRoutines(gymId: gymId);

    result.when(
      idle: () {},
      loading: () {},
      success: (routines) => state = AsyncValue.data(routines),
      failure: (error) => state = AsyncValue.error(error, StackTrace.current),
    );
  }

  Future<Result<Routine>> createRoutine({
    required String clientId,
    required String name,
    String? description,
    required List<RoutineExerciseDraft> exercises,
  }) async {
    final gymId = authProvider.userGymId;
    // trainerId lo usa el datasource si se requiere auditoría futura.
    // final trainerId = authProvider.userId;

    if (gymId == null) {
      return const Result.failure(
        UnknownException(code: 'Routines/no-gym', message: 'Sin gimnasio'),
      );
    }

    final result = await _repository.createRoutine(
      gymId: gymId,
      clientId: clientId,
      name: name,
      description: description,
      exercises: exercises,
    );

    if (result.isSuccess) await load();
    return result;
  }

  Future<Result<void>> deactivateRoutine(String routineId) async {
    final result = await _repository.deactivateRoutine(routineId: routineId);
    if (result.isSuccess) await load();
    return result;
  }
}
