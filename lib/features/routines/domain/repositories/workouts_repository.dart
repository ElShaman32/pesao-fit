import '../../../../core/utils/result.dart';
import '../entities/workout.dart';
import '../entities/workout_history_entry.dart';
import '../entities/workout_set.dart';

/// Contrato para la ejecución de workouts (F2-D).
abstract interface class WorkoutsRepository {
  /// Inicia un nuevo workout y pre-carga los sets desde la rutina.
  Future<Result<String>> startWorkout({
    required String gymId,
    required String routineId,
  });

  /// Obtiene el workout activo del cliente (si existe).
  Future<Result<String?>> getActiveWorkoutId();

  /// Carga un workout con el nombre de la rutina.
  Future<Result<Workout>> getWorkout({required String workoutId});

  /// Carga todos los sets de un workout con info del ejercicio.
  Future<Result<List<WorkoutSet>>> getWorkoutSets({required String workoutId});

  /// Actualiza el estado de un set (completado o no).
  Future<Result<void>> updateSet({
    required String setId,
    required bool completed,
  });

  /// Finaliza el workout (setea ended_at).
  Future<Result<void>> finishWorkout({required String workoutId});

  /// Lista de workouts finalizados del cliente (ordenados por fecha desc).
  Future<Result<List<WorkoutHistoryEntry>>> getHistory({
    required String userId,
  });
}
