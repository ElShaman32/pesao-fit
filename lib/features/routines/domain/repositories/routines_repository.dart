import '../../../../core/utils/result.dart';
import '../entities/routine.dart';
import '../entities/routine_exercise.dart';

/// Contrato para gestionar rutinas del entrenador.
abstract interface class RoutinesRepository {
  /// Obtiene rutinas del gimnasio.
  Future<Result<List<Routine>>> getRoutines({required String gymId});

  /// Obtiene una rutina con sus ejercicios.
  Future<Result<Routine>> getRoutine({required String routineId});

  /// Crea una rutina con sus ejercicios.
  Future<Result<Routine>> createRoutine({
    required String gymId,
    required String clientId,
    required String name,
    String? description,
    required List<RoutineExerciseDraft> exercises,
  });

  /// Actualiza una rutina.
  Future<Result<Routine>> updateRoutine({
    required Routine routine,
    required List<RoutineExerciseDraft> exercises,
  });

  /// Desactiva una rutina.
  Future<Result<void>> deactivateRoutine({required String routineId});
}

/// Borrador de ejercicio para crear/editar rutinas (sin id todavía).
class RoutineExerciseDraft {
  final String exerciseId;
  final int sets;
  final int? reps;
  final double? weightKg;
  final int restSeconds;
  final String? notes;

  const RoutineExerciseDraft({
    required this.exerciseId,
    required this.sets,
    this.reps,
    this.weightKg,
    this.restSeconds = 60,
    this.notes,
  });
}
