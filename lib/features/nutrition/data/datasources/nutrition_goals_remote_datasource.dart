import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/nutrition_goal.dart';

/// Fuente remota de objetivos nutricionales (Supabase).
///
/// Usa select-then-insert/update en lugar de upsert() para ser robusto
/// frente a la presencia/ausencia de la constraint UNIQUE(client_id, gym_id).
class NutritionGoalsRemoteDatasource {
  final SupabaseClient _client;

  const NutritionGoalsRemoteDatasource(this._client);

  /// Obtiene el goal activo de un cliente en un gym.
  /// Devuelve null si no existe.
  Future<NutritionGoal?> fetchGoalForClient(
    String clientId,
    String gymId,
  ) async {
    try {
      final response = await _client
          .from('nutrition_goals')
          .select()
          .eq('client_id', clientId)
          .eq('gym_id', gymId)
          .eq('is_active', true)
          .order('created_at', ascending: false)
          .limit(1)
          .maybeSingle();

      if (response == null) return null;
      return NutritionGoal.fromJson(response);
    } catch (e, stack) {
      debugPrint('❌ NUTRITION_GOALS fetchGoalForClient: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Crea o actualiza el goal de un cliente (idempotente).
  /// El set_by lo deriva la RLS/auth.uid() en el servidor; aquí lo pasamos
  /// explícito para claridad (el nutritionist que lo fija).
  Future<NutritionGoal> setGoal({
    required String clientId,
    required String gymId,
    required String? setBy,
    required double targetCaloriesKcal,
    required double targetProteinG,
    required double targetCarbsG,
    required double targetFatsG,
    required GoalType goalType,
    String? notes,
  }) async {
    try {
      // Buscar goal existente para (client_id, gym_id).
      final existing = await _client
          .from('nutrition_goals')
          .select('id')
          .eq('client_id', clientId)
          .eq('gym_id', gymId)
          .order('created_at', ascending: false)
          .limit(1)
          .maybeSingle();

      final payload = {
        'client_id': clientId,
        'gym_id': gymId,
        'set_by': setBy,
        'target_calories_kcal': targetCaloriesKcal,
        'target_protein_g': targetProteinG,
        'target_carbs_g': targetCarbsG,
        'target_fats_g': targetFatsG,
        'goal_type': goalType.dbValue,
        'notes': notes,
        'is_active': true,
      };

      if (existing != null) {
        // UPDATE del goal existente.
        final response = await _client
            .from('nutrition_goals')
            .update(payload)
            .eq('id', existing['id'] as String)
            .select()
            .single();
        return NutritionGoal.fromJson(response);
      } else {
        // INSERT de un goal nuevo.
        final response = await _client
            .from('nutrition_goals')
            .insert(payload)
            .select()
            .single();
        return NutritionGoal.fromJson(response);
      }
    } catch (e, stack) {
      debugPrint('❌ NUTRITION_GOALS setGoal: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Desactiva el goal (borrado lógico).
  Future<void> deactivateGoal(String goalId) async {
    try {
      await _client
          .from('nutrition_goals')
          .update({'is_active': false})
          .eq('id', goalId);
    } catch (e, stack) {
      debugPrint('❌ NUTRITION_GOALS deactivateGoal: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }
}
