import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/routine.dart';
import '../../domain/repositories/routines_repository.dart';
import '../datasources/routines_remote_datasource.dart';

/// Implementación del repositorio de rutinas.
class RoutinesRepositoryImpl implements RoutinesRepository {
  final RoutinesRemoteDatasource _remote;

  const RoutinesRepositoryImpl({required RoutinesRemoteDatasource remote})
    : _remote = remote;

  @override
  Future<Result<List<Routine>>> getRoutines({required String gymId}) async {
    try {
      final routines = await _remote.fetchRoutines(gymId);
      return Result.success(routines);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'Routines/fetch-error',
          message: 'Error al cargar rutinas',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<Routine>> getRoutine({required String routineId}) async {
    try {
      final routine = await _remote.fetchRoutine(routineId);
      return Result.success(routine);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'Routines/fetch-detail-error',
          message: 'Error al cargar la rutina',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<Routine>> createRoutine({
    required String gymId,
    required String clientId,
    required String name,
    String? description,
    required List<RoutineExerciseDraft> exercises,
  }) async {
    try {
      final routine = await _remote.createRoutine(
        gymId: gymId,
        clientId: clientId,
        name: name,
        description: description,
        exercises: exercises,
      );
      return Result.success(routine);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'Routines/create-error',
          message: 'Error al crear rutina',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<Routine>> updateRoutine({
    required Routine routine,
    required List<RoutineExerciseDraft> exercises,
  }) async {
    try {
      final updated = await _remote.updateRoutine(
        routine: routine,
        exercises: exercises,
      );
      return Result.success(updated);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'Routines/update-error',
          message: 'Error al actualizar rutina',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> deactivateRoutine({required String routineId}) async {
    try {
      await _remote.deactivateRoutine(routineId);
      return const Result<void>.success(null);
    } on AppException catch (e) {
      return Result<void>.failure(e);
    } catch (e) {
      return Result<void>.failure(
        UnknownException(
          code: 'Routines/deactivate-error',
          message: 'Error al desactivar rutina',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<Routine?>> getClientRoutine({required String userId}) async {
    try {
      final routine = await _remote.fetchClientRoutine(userId);
      return Result.success(routine);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'Routines/fetch-client-error',
          message: 'Error al cargar la rutina del cliente',
          cause: e,
        ),
      );
    }
  }
}
