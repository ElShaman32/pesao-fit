import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/nutrition_plan.dart';
import '../../domain/entities/nutrition_plan_day.dart';
import '../../domain/entities/nutrition_plan_meal.dart';
import '../../domain/repositories/nutrition_plan_repository.dart';
import '../datasources/nutrition_plan_remote_datasource.dart';

/// Implementación del repositorio de planes nutricionales.
class NutritionPlanRepositoryImpl implements NutritionPlanRepository {
  NutritionPlanRepositoryImpl({required NutritionPlanRemoteDatasource remote})
    : _remote = remote;

  final NutritionPlanRemoteDatasource _remote;

  // ─────────────────────────────────────────────────────────────
  // PLANES
  // ─────────────────────────────────────────────────────────────

  @override
  Future<Result<List<NutritionPlan>>> fetchNutritionistPlans() async {
    try {
      final plans = await _remote.fetchNutritionistPlans();
      return Result.success(plans);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'plan/fetch-error',
          message: 'Error al cargar planes',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<List<NutritionPlan>>> fetchClientPlans(String clientId) async {
    try {
      final plans = await _remote.fetchClientPlans(clientId);
      return Result.success(plans);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'plan/fetch-client-error',
          message: 'Error al cargar planes del cliente',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<NutritionPlanWithDays>> fetchPlanDetail(String planId) async {
    try {
      final detail = await _remote.fetchPlanDetail(planId);
      return Result.success(detail);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'plan/detail-error',
          message: 'Error al cargar detalle del plan',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<NutritionPlan>> createPlan(NutritionPlan plan) async {
    try {
      final created = await _remote.createPlan(plan);
      return Result.success(created);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'plan/create-error',
          message: 'Error al crear plan',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<NutritionPlan>> updatePlan(NutritionPlan plan) async {
    try {
      final updated = await _remote.updatePlan(plan);
      return Result.success(updated);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'plan/update-error',
          message: 'Error al actualizar plan',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> deactivatePlan(String planId) async {
    try {
      await _remote.deactivatePlan(planId);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'plan/deactivate-error',
          message: 'Error al desactivar plan',
          cause: e,
        ),
      );
    }
  }

  // ─────────────────────────────────────────────────────────────
  // DÍAS DEL PLAN
  // ─────────────────────────────────────────────────────────────

  @override
  Future<Result<NutritionPlanDay>> addDay({
    required String planId,
    required int dayNumber,
    String? dayName,
    String? notes,
  }) async {
    try {
      final day = await _remote.addDay(
        planId: planId,
        dayNumber: dayNumber,
        dayName: dayName,
        notes: notes,
      );
      return Result.success(day);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'plan/add-day-error',
          message: 'Error al agregar día al plan',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<NutritionPlanDay>> updateDay(NutritionPlanDay day) async {
    try {
      final updated = await _remote.updateDay(day);
      return Result.success(updated);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'plan/update-day-error',
          message: 'Error al actualizar día',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> deleteDay(String dayId) async {
    try {
      await _remote.deleteDay(dayId);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'plan/delete-day-error',
          message: 'Error al eliminar día',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<NutritionPlanDay>> duplicateDay({
    required String sourceDayId,
    required String targetPlanId,
    required int targetDayNumber,
  }) async {
    try {
      final day = await _remote.duplicateDay(
        sourceDayId: sourceDayId,
        targetPlanId: targetPlanId,
        targetDayNumber: targetDayNumber,
      );
      return Result.success(day);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'plan/duplicate-day-error',
          message: 'Error al duplicar día',
          cause: e,
        ),
      );
    }
  }

  // ─────────────────────────────────────────────────────────────
  // COMIDAS DEL DÍA
  // ─────────────────────────────────────────────────────────────

  @override
  Future<Result<NutritionPlanMeal>> addMealToDay({
    required String planDayId,
    required String mealTemplateId,
    required int mealOrder,
  }) async {
    try {
      final meal = await _remote.addMealToDay(
        planDayId: planDayId,
        mealTemplateId: mealTemplateId,
        mealOrder: mealOrder,
      );
      return Result.success(meal);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'plan/add-meal-error',
          message: 'Error al agregar comida al día',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> removeMealFromDay(String planMealId) async {
    try {
      await _remote.removeMealFromDay(planMealId);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'plan/remove-meal-error',
          message: 'Error al eliminar comida del día',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> reorderDayMeals({
    required String planDayId,
    required List<String> mealIdsInOrder,
  }) async {
    try {
      await _remote.reorderDayMeals(
        planDayId: planDayId,
        mealIdsInOrder: mealIdsInOrder,
      );
      return const Result.success(null);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'plan/reorder-meals-error',
          message: 'Error al reordenar comidas',
          cause: e,
        ),
      );
    }
  }
}
