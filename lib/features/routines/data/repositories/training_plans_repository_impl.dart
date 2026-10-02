import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/training_plan.dart';
import '../../domain/repositories/training_plans_repository.dart';
import '../datasources/training_plans_remote_datasource.dart';

/// Implementación del repositorio de planes de entrenamiento.
class TrainingPlansRepositoryImpl implements TrainingPlansRepository {
  final TrainingPlansRemoteDatasource _remote;

  const TrainingPlansRepositoryImpl({
    required TrainingPlansRemoteDatasource remote,
  }) : _remote = remote;

  @override
  Future<Result<List<TrainingPlan>>> getPlans({required String gymId}) async {
    try {
      final plans = await _remote.fetchPlans(gymId);
      return Result.success(plans);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'TrainingPlans/fetch-error',
          message: 'Error al cargar planes',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<TrainingPlan>> getPlan({required String planId}) async {
    try {
      final plan = await _remote.fetchPlan(planId);
      return Result.success(plan);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'TrainingPlans/fetch-detail-error',
          message: 'Error al cargar el plan',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<TrainingPlan>> createPlan({
    required String gymId,
    required String clientId,
    required String name,
    String? description,
  }) async {
    try {
      final plan = await _remote.createPlan(
        gymId: gymId,
        clientId: clientId,
        name: name,
        description: description,
      );
      return Result.success(plan);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'TrainingPlans/create-error',
          message: 'Error al crear plan',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<TrainingPlan>> updatePlan({required TrainingPlan plan}) async {
    try {
      final updated = await _remote.updatePlan(plan);
      return Result.success(updated);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'TrainingPlans/update-error',
          message: 'Error al actualizar plan',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> deactivatePlan({required String planId}) async {
    try {
      await _remote.deactivatePlan(planId);
      return const Result<void>.success(null);
    } catch (e) {
      return Result<void>.failure(
        UnknownException(
          code: 'TrainingPlans/deactivate-error',
          message: 'Error al desactivar plan',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> addWeek({
    required String planId,
    required int weekNumber,
    String? name,
  }) async {
    try {
      // Verificar límite antes de insertar.
      final canAdd = await _clientCanAddWeek(planId);
      if (!canAdd) {
        return const Result<void>.failure(
          UnknownException(
            code: 'TrainingPlans/week-limit-reached',
            message: 'Límite de semanas alcanzado',
          ),
        );
      }

      await _remote.addWeek(planId: planId, weekNumber: weekNumber, name: name);
      return const Result<void>.success(null);
    } catch (e) {
      return Result<void>.failure(
        UnknownException(
          code: 'TrainingPlans/add-week-error',
          message: 'Error al agregar semana',
          cause: e,
        ),
      );
    }
  }

  Future<bool> _clientCanAddWeek(String planId) async {
    try {
      final client = _remote.client;
      final response = await client.rpc(
        'can_add_plan_week',
        params: {'p_plan_id': planId},
      );
      return response as bool? ?? false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<Result<void>> duplicateWeek({
    required String weekId,
    required int newWeekNumber,
    String? newName,
  }) async {
    try {
      await _remote.duplicateWeek(
        weekId: weekId,
        newWeekNumber: newWeekNumber,
        newName: newName,
      );
      return const Result<void>.success(null);
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('duplicate_not_allowed')) {
        return const Result<void>.failure(
          UnknownException(
            code: 'TrainingPlans/duplicate-locked',
            message: 'Duplicación no disponible en este plan',
          ),
        );
      }
      if (msg.contains('week_limit_reached')) {
        return const Result<void>.failure(
          UnknownException(
            code: 'TrainingPlans/week-limit-reached',
            message: 'Límite de semanas alcanzado',
          ),
        );
      }
      return Result<void>.failure(
        UnknownException(
          code: 'TrainingPlans/duplicate-error',
          message: 'Error al duplicar semana',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> deleteWeek({required String weekId}) async {
    try {
      await _remote.deleteWeek(weekId);
      return const Result<void>.success(null);
    } catch (e) {
      return Result<void>.failure(
        UnknownException(
          code: 'TrainingPlans/delete-week-error',
          message: 'Error al eliminar semana',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> assignDay({
    required String weekId,
    required int dayOfWeek,
    String? routineId,
    bool isRestDay = false,
    String? notes,
  }) async {
    try {
      await _remote.assignDay(
        weekId: weekId,
        dayOfWeek: dayOfWeek,
        routineId: routineId,
        isRestDay: isRestDay,
        notes: notes,
      );
      return const Result<void>.success(null);
    } catch (e) {
      return Result<void>.failure(
        UnknownException(
          code: 'TrainingPlans/assign-day-error',
          message: 'Error al asignar rutina',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<TrainingPlan?>> getClientPlan({
    required String userId,
    required String gymId,
  }) async {
    try {
      final plan = await _remote.fetchClientPlan(userId, gymId);
      return Result.success(plan);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'TrainingPlans/fetch-client-error',
          message: 'Error al cargar plan del cliente',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> advanceWeek({required String planId}) async {
    try {
      // Obtener el plan para saber la semana actual.
      final plan = await _remote.fetchPlan(planId);
      final newWeek = plan.currentWeek + 1;
      await _remote.advanceWeek(planId, newWeek);
      return const Result<void>.success(null);
    } catch (e) {
      return Result<void>.failure(
        UnknownException(
          code: 'TrainingPlans/advance-week-error',
          message: 'Error al avanzar semana',
          cause: e,
        ),
      );
    }
  }
}
