import 'package:drift/drift.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/nutrition_goal.dart';
import '../../domain/enums/goal_type.dart';

/// DataSource de metas nutricionales por cliente.
/// Implementa patrón cache-first.
class NutritionGoalRemoteDatasource {
  NutritionGoalRemoteDatasource(this._client, this._db);

  final SupabaseClient _client;
  final AppDatabase _db;
  SupabaseClient get client => _client;

  Future<NutritionGoal?> fetchActiveGoal({
    required String clientId,
    required String gymId,
  }) async {
    try {
      final response = await _client
          .from('nutrition_goals')
          .select()
          .eq('client_id', clientId)
          .eq('gym_id', gymId)
          .eq('is_active', true)
          .maybeSingle();

      if (response == null) return null;

      final goal = NutritionGoal.fromJson(response);
      await _cacheGoals([goal]);
      return goal;
    } catch (e) {
      return _loadGoalFromCache(clientId, gymId);
    }
  }

  Future<NutritionGoal> upsertGoal({
    required String clientId,
    required String gymId,
    required String setBy,
    required GoalType goalType,
    required double targetCaloriesKcal,
    required double targetProteinG,
    required double targetCarbsG,
    required double targetFatsG,
    String? notes,
  }) async {
    final response = await _client
        .from('nutrition_goals')
        .upsert({
          'client_id': clientId,
          'gym_id': gymId,
          'set_by': setBy,
          'goal_type': goalType.toDbValue(),
          'target_calories_kcal': targetCaloriesKcal,
          'target_protein_g': targetProteinG,
          'target_carbs_g': targetCarbsG,
          'target_fats_g': targetFatsG,
          'notes': notes,
          'is_active': true,
        }, onConflict: 'client_id,gym_id')
        .select()
        .single();

    final goal = NutritionGoal.fromJson(response);
    await _cacheGoals([goal]);
    return goal;
  }

  // ═══════════════════════════════════════════════════════════════════════
  // CACHE DRIFT
  // ═══════════════════════════════════════════════════════════════════════

  Future<void> _cacheGoals(List<NutritionGoal> goals) async {
    await _db.transaction(() async {
      for (final goal in goals) {
        await _db.nutritionGoalsTable.insertOnConflictUpdate(_goalToRow(goal));
      }
    });
  }

  Future<NutritionGoal?> _loadGoalFromCache(
    String clientId,
    String gymId,
  ) async {
    final row =
        await (_db.select(_db.nutritionGoalsTable)..where(
              (t) =>
                  t.clientId.equals(clientId) &
                  t.gymId.equals(gymId) &
                  t.isActive.equals(true),
            ))
            .getSingleOrNull();

    if (row == null) return null;

    return _rowToGoal(row);
  }

  NutritionGoalsTableCompanion _goalToRow(NutritionGoal goal) {
    return NutritionGoalsTableCompanion(
      id: Value(goal.id),
      clientId: Value(goal.clientId),
      gymId: Value(goal.gymId),
      setBy: Value(goal.setBy),
      targetCaloriesKcal: Value(goal.targetCaloriesKcal),
      targetProteinG: Value(goal.targetProteinG),
      targetCarbsG: Value(goal.targetCarbsG),
      targetFatsG: Value(goal.targetFatsG),
      goalType: Value(goal.goalType.toDbValue()),
      notes: Value(goal.notes),
      isActive: Value(goal.isActive),
      createdAt: Value(goal.createdAt),
      updatedAt: Value(goal.updatedAt),
    );
  }

  NutritionGoal _rowToGoal(dynamic row) {
    return NutritionGoal(
      id: row.id as String,
      clientId: row.clientId as String,
      gymId: row.gymId as String,
      setBy: row.setBy as String?,
      targetCaloriesKcal: row.targetCaloriesKcal as double,
      targetProteinG: row.targetProteinG as double,
      targetCarbsG: row.targetCarbsG as double,
      targetFatsG: row.targetFatsG as double,
      goalType: GoalType.fromDbValue(row.goalType as String),
      notes: row.notes as String?,
      isActive: row.isActive as bool,
      createdAt: row.createdAt as DateTime,
      updatedAt: row.updatedAt as DateTime,
    );
  }
}
