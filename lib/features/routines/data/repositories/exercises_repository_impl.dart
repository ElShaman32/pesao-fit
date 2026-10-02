import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/repositories/exercises_repository.dart';
import '../datasources/exercises_remote_datasource.dart';

/// Implementación del repositorio de ejercicios.
class ExercisesRepositoryImpl implements ExercisesRepository {
  final ExercisesRemoteDatasource _remote;

  const ExercisesRepositoryImpl({required ExercisesRemoteDatasource remote})
    : _remote = remote;

  @override
  Future<Result<List<Exercise>>> getExercises({required String gymId}) async {
    try {
      final exercises = await _remote.fetchExercises(gymId);
      return Result.success(exercises);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'Exercises/fetch-error',
          message: 'Error al cargar ejercicios',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<Exercise>> createExercise({
    required String gymId,
    required String name,
    String? description,
    required MuscleGroup muscleGroup,
  }) async {
    try {
      final exercise = await _remote.createExercise(
        gymId: gymId,
        name: name,
        description: description,
        muscleGroup: muscleGroup,
      );
      return Result.success(exercise);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'Exercises/create-error',
          message: 'Error al crear ejercicio',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<Exercise>> updateExercise({required Exercise exercise}) async {
    try {
      final updated = await _remote.updateExercise(exercise);
      return Result.success(updated);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'Exercises/update-error',
          message: 'Error al actualizar ejercicio',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> deleteExercise({required String exerciseId}) async {
    try {
      await _remote.deleteExercise(exerciseId);
      return const Result<void>.success(null);
    } on AppException catch (e) {
      return Result<void>.failure(e);
    } catch (e) {
      return Result<void>.failure(
        UnknownException(
          code: 'Exercises/delete-error',
          message: 'Error al eliminar ejercicio',
          cause: e,
        ),
      );
    }
  }
}
