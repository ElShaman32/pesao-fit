import '../../../../core/utils/result.dart';
import '../entities/nutrition_plan.dart';
import '../entities/nutrition_plan_day.dart';
import '../entities/nutrition_plan_meal.dart';

/// Repositorio de planes nutricionales (árbol: plan → días → comidas).
abstract interface class NutritionPlanRepository {
  // ─────────────────────────────────────────────────────────────
  // PLANES
  // ─────────────────────────────────────────────────────────────

  /// Lista planes del nutricionista (con nombre del cliente vía JOIN).
  Future<Result<List<NutritionPlan>>> fetchNutritionistPlans();

  /// Lista planes activos de un cliente específico.
  Future<Result<List<NutritionPlan>>> fetchClientPlans(String clientId);

  /// Obtiene un plan con sus días y comidas (árbol completo).
  Future<Result<NutritionPlanWithDays>> fetchPlanDetail(String planId);

  /// Crea un plan vacío (sin días).
  Future<Result<NutritionPlan>> createPlan(NutritionPlan plan);

  /// Actualiza datos básicos del plan.
  Future<Result<NutritionPlan>> updatePlan(NutritionPlan plan);

  /// Desactiva el plan (soft delete).
  Future<Result<void>> deactivatePlan(String planId);

  // ─────────────────────────────────────────────────────────────
  // DÍAS DEL PLAN
  // ─────────────────────────────────────────────────────────────

  /// Agrega un día al plan.
  Future<Result<NutritionPlanDay>> addDay({
    required String planId,
    required int dayNumber,
    String? dayName,
    String? notes,
  });

  /// Actualiza un día (nombre, notas).
  Future<Result<NutritionPlanDay>> updateDay(NutritionPlanDay day);

  /// Elimina un día y sus comidas.
  Future<Result<void>> deleteDay(String dayId);

  /// Duplica un día (copia todas las comidas al día destino).
  Future<Result<NutritionPlanDay>> duplicateDay({
    required String sourceDayId,
    required String targetPlanId,
    required int targetDayNumber,
  });

  // ─────────────────────────────────────────────────────────────
  // COMIDAS DEL DÍA
  // ─────────────────────────────────────────────────────────────

  /// Agrega una comida (referencia a MealTemplate) a un día.
  Future<Result<NutritionPlanMeal>> addMealToDay({
    required String planDayId,
    required String mealTemplateId,
    required int mealOrder,
  });

  /// Elimina una comida del día.
  Future<Result<void>> removeMealFromDay(String planMealId);

  /// Reordena las comidas de un día.
  Future<Result<void>> reorderDayMeals({
    required String planDayId,
    required List<String> mealIdsInOrder,
  });
}

/// DTO que agrupa un plan con sus días y comidas.
class NutritionPlanWithDays {
  const NutritionPlanWithDays({required this.plan, required this.days});

  final NutritionPlan plan;
  final List<NutritionPlanDayWithMeals> days;
}

/// DTO que agrupa un día con sus comidas.
class NutritionPlanDayWithMeals {
  const NutritionPlanDayWithMeals({required this.day, required this.meals});

  final NutritionPlanDay day;
  final List<NutritionPlanMeal> meals;
}
