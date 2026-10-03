import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/workout.dart';
import '../../domain/entities/workout_history_entry.dart';
import '../../domain/entities/workout_set.dart';
import '../../domain/repositories/workouts_repository.dart';
import '../datasources/workouts_remote_datasource.dart';

/// Implementación del repositorio de workouts (F2-D).
class WorkoutsRepositoryImpl implements WorkoutsRepository {
  final WorkoutsRemoteDatasource _remote;

  const WorkoutsRepositoryImpl({required WorkoutsRemoteDatasource remote})
    : _remote = remote;

  @override
  Future<Result<String>> startWorkout({
    required String gymId,
    required String routineId,
  }) async {
    try {
      final workoutId = await _remote.startWorkout(
        gymId: gymId,
        routineId: routineId,
      );
      return Result.success(workoutId);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('workout_already_active')) {
        return Result.failure(
          UnknownException(
            code: 'Workouts/already-active',
            message: 'Ya hay un workout activo',
            cause: e,
          ),
        );
      }
      return Result.failure(
        UnknownException(
          code: 'Workouts/start-error',
          message: 'Error al iniciar workout',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<String?>> getActiveWorkoutId() async {
    try {
      final id = await _remote.getActiveWorkoutId();
      return Result.success(id);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'Workouts/fetch-active-error',
          message: 'Error al buscar workout activo',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<Workout>> getWorkout({required String workoutId}) async {
    try {
      final workout = await _remote.fetchWorkout(workoutId);
      return Result.success(workout);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'Workouts/fetch-error',
          message: 'Error al cargar workout',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<List<WorkoutSet>>> getWorkoutSets({
    required String workoutId,
  }) async {
    try {
      final sets = await _remote.fetchWorkoutSets(workoutId);
      return Result.success(sets);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'Workouts/fetch-sets-error',
          message: 'Error al cargar sets',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> updateSet({
    required String setId,
    required bool completed,
  }) async {
    try {
      await _remote.updateSet(setId: setId, completed: completed);
      return const Result<void>.success(null);
    } on AppException catch (e) {
      return Result<void>.failure(e);
    } catch (e) {
      return Result<void>.failure(
        UnknownException(
          code: 'Workouts/toggle-set-error',
          message: 'Error al actualizar set',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> finishWorkout({required String workoutId}) async {
    try {
      await _remote.finishWorkout(workoutId);
      return const Result<void>.success(null);
    } on AppException catch (e) {
      return Result<void>.failure(e);
    } catch (e) {
      return Result<void>.failure(
        UnknownException(
          code: 'Workouts/finish-error',
          message: 'Error al finalizar workout',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<List<WorkoutHistoryEntry>>> getHistory({
    required String userId,
  }) async {
    try {
      final response = await _remote.fetchHistory(userId);
      final entries = response
          .map((e) => WorkoutHistoryEntry.fromJson(e as Map<String, dynamic>))
          .toList();
      return Result.success(entries);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'Workouts/fetch-history-error',
          message: 'Error al cargar historial',
          cause: e,
        ),
      );
    }
  }
}
