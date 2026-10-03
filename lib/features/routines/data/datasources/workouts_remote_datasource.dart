import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/workout.dart';
import '../../domain/entities/workout_set.dart';

/// Fuente remota de workouts (F2-D).
class WorkoutsRemoteDatasource {
  final SupabaseClient _client;

  const WorkoutsRemoteDatasource(this._client);

  /// Inicia un workout vía función SQL. Devuelve el workoutId.
  Future<String> startWorkout({
    required String gymId,
    required String routineId,
  }) async {
    try {
      final response = await _client.rpc(
        'start_workout',
        params: {'p_gym_id': gymId, 'p_routine_id': routineId},
      );
      return response as String;
    } catch (e) {
      debugPrint('❌ WORKOUTS startWorkout: $e');
      rethrow;
    }
  }

  /// Obtiene el workout activo del cliente vía función SQL.
  Future<String?> getActiveWorkoutId() async {
    try {
      final response = await _client.rpc('get_active_workout');
      return response as String?;
    } catch (e) {
      debugPrint('❌ WORKOUTS getActiveWorkoutId: $e');
      rethrow;
    }
  }

  /// Carga un workout con el nombre de la rutina.
  Future<Workout> fetchWorkout(String workoutId) async {
    try {
      final response = await _client
          .from('workouts')
          .select('*, routines (name)')
          .eq('id', workoutId)
          .single();
      return Workout.fromJson(response);
    } catch (e) {
      debugPrint('❌ WORKOUTS fetchWorkout: $e');
      rethrow;
    }
  }

  /// Carga todos los sets de un workout ordenados por la rutina.
  Future<List<WorkoutSet>> fetchWorkoutSets(String workoutId) async {
    try {
      final response = await _client
          .from('workout_exercises')
          .select('*, exercises (name, muscle_group)')
          .eq('workout_id', workoutId)
          .order('order_index', ascending: true)
          .order('set_number', ascending: true);
      return response.map((e) => WorkoutSet.fromJson(e)).toList();
    } catch (e) {
      debugPrint('❌ WORKOUTS fetchWorkoutSets: $e');
      rethrow;
    }
  }

  /// Actualiza el estado de un set.
  Future<void> updateSet({
    required String setId,
    required bool completed,
  }) async {
    try {
      await _client
          .from('workout_exercises')
          .update({'completed': completed})
          .eq('id', setId);
    } catch (e) {
      debugPrint('❌ WORKOUTS updateSet: $e');
      rethrow;
    }
  }

  /// Finaliza el workout vía función SQL.
  Future<void> finishWorkout(String workoutId) async {
    try {
      await _client.rpc('finish_workout', params: {'p_workout_id': workoutId});
    } catch (e) {
      debugPrint('❌ WORKOUTS finishWorkout: $e');
      rethrow;
    }
  }

  /// Lista de workouts finalizados con nombre de rutina y sets.
  Future<List<dynamic>> fetchHistory(String userId) async {
    try {
      final response = await _client
          .from('workouts')
          .select('''
            *,
            routines (name),
            workout_exercises (exercise_id, completed)
          ''')
          .eq('user_id', userId)
          .not('ended_at', 'is', null)
          .order('started_at', ascending: false)
          .limit(50);
      return response;
    } catch (e) {
      debugPrint('❌ WORKOUTS fetchHistory: $e');
      rethrow;
    }
  }
}
