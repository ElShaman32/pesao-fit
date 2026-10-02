import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/utils/result.dart';
import '../../data/datasources/exercises_remote_datasource.dart';
import '../../data/repositories/exercises_repository_impl.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/repositories/exercises_repository.dart';

part 'exercises_controller.g.dart';

@riverpod
ExercisesRepository exercisesRepository(Ref ref) {
  return ExercisesRepositoryImpl(
    remote: ExercisesRemoteDatasource(Supabase.instance.client),
  );
}

@Riverpod(keepAlive: true)
class ExercisesController extends _$ExercisesController {
  late final ExercisesRepository _repository;

  @override
  AsyncValue<List<Exercise>> build() {
    _repository = ref.watch(exercisesRepositoryProvider);

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
    final result = await _repository.getExercises(gymId: gymId);

    result.when(
      idle: () {},
      loading: () {},
      success: (exercises) => state = AsyncValue.data(exercises),
      failure: (error) => state = AsyncValue.error(error, StackTrace.current),
    );
  }

  Future<Result<Exercise>> createExercise({
    required String name,
    String? description,
    required MuscleGroup muscleGroup,
  }) async {
    final gymId = authProvider.userGymId;
    if (gymId == null) {
      return const Result.failure(
        UnknownException(code: 'Exercises/no-gym', message: 'Sin gimnasio'),
      );
    }

    final result = await _repository.createExercise(
      gymId: gymId,
      name: name,
      description: description,
      muscleGroup: muscleGroup,
    );

    if (result.isSuccess) await load();
    return result;
  }
}
