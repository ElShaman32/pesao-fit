import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/training_plan.dart';

/// Fuente remota de planes de entrenamiento.
class TrainingPlansRemoteDatasource {
  final SupabaseClient _client;

  const TrainingPlansRemoteDatasource(this._client);

  /// Lista de planes del gym con nombre del cliente.
  Future<List<TrainingPlan>> fetchPlans(String gymId) async {
    try {
      final response = await _client
          .from('training_plans')
          .select('*, profiles:client_id (full_name)')
          .eq('gym_id', gymId)
          .order('created_at', ascending: false);

      return response.map((e) => TrainingPlan.fromJson(e)).toList();
    } catch (e, stack) {
      debugPrint('❌ TPLANS fetchPlans: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Detalle completo: plan + semanas + días + rutinas.
  Future<TrainingPlan> fetchPlan(String planId) async {
    try {
      final response = await _client
          .from('training_plans')
          .select('''
            *,
            profiles:client_id (full_name),
            training_plan_weeks (
              *,
              training_plan_days (
                *,
                routines (
                  name,
                  routine_exercises (id)
                )
              )
            )
          ''')
          .eq('id', planId)
          .single();

      return TrainingPlan.fromJson(response);
    } catch (e, stack) {
      debugPrint('❌ TPLANS fetchPlan: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Crea un plan.
  Future<TrainingPlan> createPlan({
    required String gymId,
    required String clientId,
    String? trainerId,
    required String name,
    String? description,
  }) async {
    try {
      final response = await _client
          .from('training_plans')
          .insert({
            'gym_id': gymId,
            'client_id': clientId,
            'trainer_id': trainerId,
            'name': name,
            'description': description,
          })
          .select('*, profiles:client_id (full_name)')
          .single();

      return TrainingPlan.fromJson(response);
    } catch (e, stack) {
      debugPrint('❌ TPLANS createPlan: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Actualiza un plan.
  Future<TrainingPlan> updatePlan(TrainingPlan plan) async {
    try {
      final response = await _client
          .from('training_plans')
          .update({
            'name': plan.name,
            'description': plan.description,
            'is_active': plan.isActive,
            'current_week': plan.currentWeek,
          })
          .eq('id', plan.id)
          .select('*, profiles:client_id (full_name)')
          .single();

      return TrainingPlan.fromJson(response);
    } catch (e, stack) {
      debugPrint('❌ TPLANS updatePlan: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Desactiva un plan.
  Future<void> deactivatePlan(String planId) async {
    try {
      await _client
          .from('training_plans')
          .update({'is_active': false})
          .eq('id', planId);
    } catch (e) {
      debugPrint('❌ TPLANS deactivatePlan: $e');
      rethrow;
    }
  }

  /// Agrega una semana.
  Future<void> addWeek({
    required String planId,
    required int weekNumber,
    String? name,
  }) async {
    try {
      await _client.from('training_plan_weeks').insert({
        'plan_id': planId,
        'week_number': weekNumber,
        'name': name,
      });
    } catch (e) {
      debugPrint('❌ TPLANS addWeek: $e');
      rethrow;
    }
  }

  /// Duplica una semana vía función SQL.
  Future<void> duplicateWeek({
    required String weekId,
    required int newWeekNumber,
    String? newName,
  }) async {
    try {
      await _client.rpc(
        'duplicate_plan_week',
        params: {
          'p_week_id': weekId,
          'p_new_week_number': newWeekNumber,
          'p_new_name': newName,
        },
      );
    } catch (e) {
      debugPrint('❌ TPLANS duplicateWeek: $e');
      rethrow;
    }
  }

  /// Elimina una semana.
  Future<void> deleteWeek(String weekId) async {
    try {
      await _client.from('training_plan_weeks').delete().eq('id', weekId);
    } catch (e) {
      debugPrint('❌ TPLANS deleteWeek: $e');
      rethrow;
    }
  }

  /// Asigna rutina a un día (upsert por week_id + day_of_week).
  Future<void> assignDay({
    required String weekId,
    required int dayOfWeek,
    String? routineId,
    bool isRestDay = false,
    String? notes,
  }) async {
    try {
      await _client.from('training_plan_days').upsert({
        'week_id': weekId,
        'day_of_week': dayOfWeek,
        'routine_id': routineId,
        'is_rest_day': isRestDay,
        'notes': notes,
      }, onConflict: 'week_id,day_of_week');
    } catch (e) {
      debugPrint('❌ TPLANS assignDay: $e');
      rethrow;
    }
  }

  /// Plan activo del cliente.
  Future<TrainingPlan?> fetchClientPlan(String userId, String gymId) async {
    try {
      final response = await _client
          .from('training_plans')
          .select('''
            *,
            training_plan_weeks (
              *,
              training_plan_days (
                *,
                routines (
                  name,
                  routine_exercises (id)
                )
              )
            )
          ''')
          .eq('client_id', userId)
          .eq('gym_id', gymId)
          .eq('is_active', true)
          .maybeSingle();

      if (response == null) return null;
      return TrainingPlan.fromJson(response);
    } catch (e) {
      debugPrint('❌ TPLANS fetchClientPlan: $e');
      rethrow;
    }
  }

  /// Avanza la semana actual del plan.
  Future<void> advanceWeek(String planId, int newWeek) async {
    try {
      await _client
          .from('training_plans')
          .update({'current_week': newWeek})
          .eq('id', planId);
    } catch (e) {
      debugPrint('❌ TPLANS advanceWeek: $e');
      rethrow;
    }
  }

  /// Acceso al cliente para llamadas RPC de validación.
  SupabaseClient get client => _client;
}
