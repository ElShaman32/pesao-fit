import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/nutrition_goal.dart';
import '../../domain/enums/goal_type.dart';

/// DataSource de metas nutricionales por cliente.
class NutritionGoalRemoteDatasource {
  NutritionGoalRemoteDatasource(this._client);

  final SupabaseClient _client;

  SupabaseClient get client => _client;

  /// Obtiene la meta activa del cliente (o null si no tiene).
  Future<NutritionGoal?> fetchActiveGoal({
    required String clientId,
    required String gymId,
  }) async {
    final response = await _client
        .from('nutrition_goals')
        .select()
        .eq('client_id', clientId)
        .eq('gym_id', gymId)
        .eq('is_active', true)
        .maybeSingle();

    if (response == null) return null;

    return NutritionGoal.fromJson(response);
  }

  /// Crea o actualiza la meta del cliente (upsert por client_id + gym_id).
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

    return NutritionGoal.fromJson(response);
  }
}
