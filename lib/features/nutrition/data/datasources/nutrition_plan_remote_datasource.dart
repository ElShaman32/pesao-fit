import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/nutrition_plan.dart';
import '../../domain/entities/nutrition_plan_day.dart';
import '../../domain/entities/nutrition_plan_meal.dart';
import '../../domain/repositories/nutrition_plan_repository.dart';

/// DataSource de planes nutricionales (árbol: plan → días → comidas).
class NutritionPlanRemoteDatasource {
  NutritionPlanRemoteDatasource(this._client);

  final SupabaseClient _client;

  // ─────────────────────────────────────────────────────────────
  // PLANES
  // ─────────────────────────────────────────────────────────────

  /// Lista planes del nutricionista actual.
  Future<List<NutritionPlan>> fetchNutritionistPlans() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception('Usuario no autenticado');

    final response = await _client
        .from('nutrition_plans')
        .select()
        .eq('nutritionist_id', userId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((row) => NutritionPlan.fromJson(row as Map<String, dynamic>))
        .toList();
  }

  /// Lista planes activos de un cliente específico.
  Future<List<NutritionPlan>> fetchClientPlans(String clientId) async {
    final response = await _client
        .from('nutrition_plans')
        .select()
        .eq('client_id', clientId)
        .eq('is_active', true)
        .order('created_at', ascending: false);

    return (response as List)
        .map((row) => NutritionPlan.fromJson(row as Map<String, dynamic>))
        .toList();
  }

  /// Obtiene un plan con sus días y comidas (árbol completo).
  Future<NutritionPlanWithDays> fetchPlanDetail(String planId) async {
    // 1. Obtener el plan.
    final planResponse = await _client
        .from('nutrition_plans')
        .select()
        .eq('id', planId)
        .single();

    final plan = NutritionPlan.fromJson(planResponse);

    // 2. Obtener los días del plan.
    final daysResponse = await _client
        .from('nutrition_plan_days')
        .select()
        .eq('plan_id', planId)
        .order('day_number');

    final days = <NutritionPlanDayWithMeals>[];

    for (final dayRow in daysResponse as List) {
      final day = NutritionPlanDay.fromJson(dayRow as Map<String, dynamic>);

      // 3. Obtener las comidas del día.
      final mealsResponse = await _client
          .from('nutrition_plan_meals')
          .select()
          .eq('plan_day_id', day.id)
          .order('meal_order');

      final meals = (mealsResponse as List)
          .map((row) => NutritionPlanMeal.fromJson(row as Map<String, dynamic>))
          .toList();

      days.add(NutritionPlanDayWithMeals(day: day, meals: meals));
    }

    return NutritionPlanWithDays(plan: plan, days: days);
  }

  /// Crea un plan vacío (sin días).
  Future<NutritionPlan> createPlan(NutritionPlan plan) async {
    final response = await _client
        .from('nutrition_plans')
        .insert({
          'gym_id': plan.gymId,
          'client_id': plan.clientId,
          'nutritionist_id': plan.nutritionistId,
          'name': plan.name,
          'goal': plan.goal,
          'target_calories_kcal': plan.targetCaloriesKcal,
          'target_protein_g': plan.targetProteinG,
          'target_carbs_g': plan.targetCarbsG,
          'target_fats_g': plan.targetFatsG,
          'duration_days': plan.durationDays,
          'notes': plan.notes,
        })
        .select()
        .single();

    return NutritionPlan.fromJson(response);
  }

  /// Actualiza datos básicos del plan.
  Future<NutritionPlan> updatePlan(NutritionPlan plan) async {
    final response = await _client
        .from('nutrition_plans')
        .update({
          'name': plan.name,
          'goal': plan.goal,
          'target_calories_kcal': plan.targetCaloriesKcal,
          'target_protein_g': plan.targetProteinG,
          'target_carbs_g': plan.targetCarbsG,
          'target_fats_g': plan.targetFatsG,
          'duration_days': plan.durationDays,
          'notes': plan.notes,
        })
        .eq('id', plan.id)
        .select()
        .single();

    return NutritionPlan.fromJson(response);
  }

  /// Desactiva el plan (soft delete).
  Future<void> deactivatePlan(String planId) async {
    await _client
        .from('nutrition_plans')
        .update({'is_active': false})
        .eq('id', planId);
  }

  // ─────────────────────────────────────────────────────────────
  // DÍAS DEL PLAN
  // ─────────────────────────────────────────────────────────────

  /// Agrega un día al plan.
  Future<NutritionPlanDay> addDay({
    required String planId,
    required int dayNumber,
    String? dayName,
    String? notes,
  }) async {
    final response = await _client
        .from('nutrition_plan_days')
        .insert({
          'plan_id': planId,
          'day_number': dayNumber,
          'day_name': dayName,
          'notes': notes,
        })
        .select()
        .single();

    return NutritionPlanDay.fromJson(response);
  }

  /// Actualiza un día (nombre, notas).
  Future<NutritionPlanDay> updateDay(NutritionPlanDay day) async {
    final response = await _client
        .from('nutrition_plan_days')
        .update({'day_name': day.dayName, 'notes': day.notes})
        .eq('id', day.id)
        .select()
        .single();

    return NutritionPlanDay.fromJson(response);
  }

  /// Elimina un día y sus comidas.
  Future<void> deleteDay(String dayId) async {
    await _client.from('nutrition_plan_days').delete().eq('id', dayId);
  }

  /// Duplica un día (copia todas las comidas al día destino).
  Future<NutritionPlanDay> duplicateDay({
    required String sourceDayId,
    required String targetPlanId,
    required int targetDayNumber,
  }) async {
    // 1. Obtener el día origen.
    final sourceDayResponse = await _client
        .from('nutrition_plan_days')
        .select()
        .eq('id', sourceDayId)
        .single();

    final sourceDay = NutritionPlanDay.fromJson(sourceDayResponse);

    // 2. Crear el día destino.
    final newDayResponse = await _client
        .from('nutrition_plan_days')
        .insert({
          'plan_id': targetPlanId,
          'day_number': targetDayNumber,
          'day_name': sourceDay.dayName,
          'notes': sourceDay.notes,
        })
        .select()
        .single();

    final newDay = NutritionPlanDay.fromJson(newDayResponse);

    // 3. Copiar las comidas.
    final sourceMealsResponse = await _client
        .from('nutrition_plan_meals')
        .select()
        .eq('plan_day_id', sourceDayId)
        .order('meal_order');

    final sourceMeals = sourceMealsResponse as List;

    for (final mealRow in sourceMeals) {
      final meal = mealRow as Map<String, dynamic>;
      await _client.from('nutrition_plan_meals').insert({
        'plan_day_id': newDay.id,
        'meal_template_id': meal['meal_template_id'] as String,
        'meal_order': meal['meal_order'] as int,
      });
    }

    return newDay;
  }

  // ─────────────────────────────────────────────────────────────
  // COMIDAS DEL DÍA
  // ─────────────────────────────────────────────────────────────

  /// Agrega una comida (referencia a MealTemplate) a un día.
  Future<NutritionPlanMeal> addMealToDay({
    required String planDayId,
    required String mealTemplateId,
    required int mealOrder,
  }) async {
    final response = await _client
        .from('nutrition_plan_meals')
        .insert({
          'plan_day_id': planDayId,
          'meal_template_id': mealTemplateId,
          'meal_order': mealOrder,
        })
        .select()
        .single();

    return NutritionPlanMeal.fromJson(response);
  }

  /// Elimina una comida del día.
  Future<void> removeMealFromDay(String planMealId) async {
    await _client.from('nutrition_plan_meals').delete().eq('id', planMealId);
  }

  /// Reordena las comidas de un día.
  Future<void> reorderDayMeals({
    required String planDayId,
    required List<String> mealIdsInOrder,
  }) async {
    for (var i = 0; i < mealIdsInOrder.length; i++) {
      await _client
          .from('nutrition_plan_meals')
          .update({'meal_order': i})
          .eq('id', mealIdsInOrder[i]);
    }
  }
}
