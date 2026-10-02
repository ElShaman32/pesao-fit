import '../../../../core/utils/result.dart';
import '../entities/exercise.dart';

/// Contrato para gestionar ejercicios (biblioteca + personalizados).
abstract interface class ExercisesRepository {
  /// Obtiene ejercicios visibles para el gym (globales + personalizados).
  Future<Result<List<Exercise>>> getExercises({required String gymId});

  /// Crea un ejercicio personalizado del gym.
  Future<Result<Exercise>> createExercise({
    required String gymId,
    required String name,
    String? description,
    required MuscleGroup muscleGroup,
  });

  /// Actualiza un ejercicio.
  Future<Result<Exercise>> updateExercise({required Exercise exercise});

  /// Desactiva (borra) un ejercicio personalizado.
  Future<Result<void>> deleteExercise({required String exerciseId});
}
