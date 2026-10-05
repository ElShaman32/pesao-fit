import 'package:drift/drift.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/nutrition_plan.dart';
import '../../domain/entities/nutrition_plan_day.dart';
import '../../domain/entities/nutrition_plan_meal.dart';
import '../../domain/repositories/nutrition_plan_repository.dart';

/// DataSource de planes nutricionales (árbol: plan → días → comidas).
/// Implementa patrón cache-first: lee de Drift si falla red.
class NutritionPlanRemoteDatasource {
  NutritionPlanRemoteDatasource(this._client, this._db);

  final SupabaseClient _client;
  final AppDatabase _db;

  // ═══════════════════════════════════════════════════════════════════════
  // PLANES
  // ═══════════════════════════════════════════════════════════════════════

  Future<List<NutritionPlan>> fetchNutritionistPlans() async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) throw Exception('Usuario no autenticado');

      final response = await _client
          .from('nutrition_plans')
          .select()
          .eq('nutritionist_id', userId)
          .order('created_at', ascending: false);

      final plans = (response as List)
          .map((row) => NutritionPlan.fromJson(row as Map<String, dynamic>))
          .toList();

      await _cachePlans(plans);
      return plans;
    } catch (e) {
      return _loadPlansFromCache();
    }
  }

  Future<List<NutritionPlan>> fetchClientPlans(String clientId) async {
    try {
      final response = await _client
          .from('nutrition_plans')
          .select()
          .eq('client_id', clientId)
          .eq('is_active', true)
          .order('created_at', ascending: false);

      final plans = (response as List)
          .map((row) => NutritionPlan.fromJson(row as Map<String, dynamic>))
          .toList();

      await _cachePlans(plans);
      return plans;
    } catch (e) {
      return _loadPlansFromCache(clientId: clientId);
    }
  }

  Future<NutritionPlanWithDays> fetchPlanDetail(String planId) async {
    try {
      final planResponse = await _client
          .from('nutrition_plans')
          .select()
          .eq('id', planId)
          .single();

      final plan = NutritionPlan.fromJson(planResponse);
      await _cachePlans([plan]);

      final daysResponse = await _client
          .from('nutrition_plan_days')
          .select()
          .eq('plan_id', planId)
          .order('day_number');

      final days = <NutritionPlanDayWithMeals>[];

      for (final dayRow in daysResponse as List) {
        final day = NutritionPlanDay.fromJson(dayRow as Map<String, dynamic>);

        final mealsResponse = await _client
            .from('nutrition_plan_meals')
            .select()
            .eq('plan_day_id', day.id)
            .order('meal_order');

        final meals = (mealsResponse as List)
            .map(
              (row) => NutritionPlanMeal.fromJson(row as Map<String, dynamic>),
            )
            .toList();

        days.add(NutritionPlanDayWithMeals(day: day, meals: meals));
      }

      return NutritionPlanWithDays(plan: plan, days: days);
    } catch (e) {
      return _loadPlanDetailFromCache(planId);
    }
  }

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

    final created = NutritionPlan.fromJson(response);
    await _cachePlans([created]);
    return created;
  }

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

    final updated = NutritionPlan.fromJson(response);
    await _cachePlans([updated]);
    return updated;
  }

  Future<void> deactivatePlan(String planId) async {
    await _client
        .from('nutrition_plans')
        .update({'is_active': false})
        .eq('id', planId);

    await (_db.update(_db.nutritionPlansTable)
          ..where((t) => t.id.equals(planId)))
        .write(const NutritionPlansTableCompanion(isActive: Value(false)));
  }

  // ═══════════════════════════════════════════════════════════════════════
  // DÍAS DEL PLAN
  // ═══════════════════════════════════════════════════════════════════════

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

  Future<NutritionPlanDay> updateDay(NutritionPlanDay day) async {
    final response = await _client
        .from('nutrition_plan_days')
        .update({'day_name': day.dayName, 'notes': day.notes})
        .eq('id', day.id)
        .select()
        .single();

    return NutritionPlanDay.fromJson(response);
  }

  Future<void> deleteDay(String dayId) async {
    await _client.from('nutrition_plan_days').delete().eq('id', dayId);
  }

  Future<NutritionPlanDay> duplicateDay({
    required String sourceDayId,
    required String targetPlanId,
    required int targetDayNumber,
  }) async {
    final sourceDayResponse = await _client
        .from('nutrition_plan_days')
        .select()
        .eq('id', sourceDayId)
        .single();

    final sourceDay = NutritionPlanDay.fromJson(sourceDayResponse);

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

  // ═══════════════════════════════════════════════════════════════════════
  // COMIDAS DEL DÍA
  // ═══════════════════════════════════════════════════════════════════════

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

  Future<void> removeMealFromDay(String planMealId) async {
    await _client.from('nutrition_plan_meals').delete().eq('id', planMealId);
  }

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

  // ═══════════════════════════════════════════════════════════════════════
  // CACHE DRIFT
  // ═══════════════════════════════════════════════════════════════════════

  Future<void> _cachePlans(List<NutritionPlan> plans) async {
    await _db.transaction(() async {
      for (final plan in plans) {
        await _db.nutritionPlansTable.insertOnConflictUpdate(_planToRow(plan));
      }
    });
  }

  Future<List<NutritionPlan>> _loadPlansFromCache({String? clientId}) async {
    final query = _db.select(_db.nutritionPlansTable);

    if (clientId != null) {
      query.where((t) => t.clientId.equals(clientId) & t.isActive.equals(true));
    }

    query.orderBy([
      (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
    ]);

    final rows = await query.get();
    return rows.map(_rowToPlan).toList();
  }

  Future<NutritionPlanWithDays> _loadPlanDetailFromCache(String planId) async {
    final planRow = await (_db.select(
      _db.nutritionPlansTable,
    )..where((t) => t.id.equals(planId))).getSingleOrNull();

    if (planRow == null) {
      throw Exception('Plan not found in cache: $planId');
    }

    final plan = _rowToPlan(planRow);

    // Nota: Los días y comidas no se cachean en Drift (solo planes)
    // Si necesitas offline completo, habría que cachear también días/comidas
    return NutritionPlanWithDays(plan: plan, days: []);
  }

  NutritionPlansTableCompanion _planToRow(NutritionPlan plan) {
    return NutritionPlansTableCompanion(
      id: Value(plan.id),
      gymId: Value(plan.gymId),
      clientId: Value(plan.clientId),
      nutritionistId: Value(plan.nutritionistId),
      name: Value(plan.name),
      goal: Value(plan.goal),
      targetCaloriesKcal: Value(plan.targetCaloriesKcal),
      targetProteinG: Value(plan.targetProteinG),
      targetCarbsG: Value(plan.targetCarbsG),
      targetFatsG: Value(plan.targetFatsG),
      durationDays: Value(plan.durationDays),
      notes: Value(plan.notes),
      isActive: Value(plan.isActive),
      createdAt: Value(plan.createdAt),
      updatedAt: Value(plan.updatedAt),
    );
  }

  NutritionPlan _rowToPlan(dynamic row) {
    return NutritionPlan(
      id: row.id as String,
      gymId: row.gymId as String,
      clientId: row.clientId as String,
      nutritionistId: row.nutritionistId as String,
      name: row.name as String,
      goal: row.goal as String?,
      targetCaloriesKcal: row.targetCaloriesKcal as double,
      targetProteinG: row.targetProteinG as double,
      targetCarbsG: row.targetCarbsG as double,
      targetFatsG: row.targetFatsG as double,
      durationDays: row.durationDays as int,
      notes: row.notes as String?,
      isActive: row.isActive as bool,
      createdAt: row.createdAt as DateTime,
      updatedAt: row.updatedAt as DateTime,
    );
  }
}
