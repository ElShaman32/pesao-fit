import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/routine.dart';
import '../../domain/repositories/routines_repository.dart';

/// Fuente remota de rutinas.
class RoutinesRemoteDatasource {
  final SupabaseClient _client;

  const RoutinesRemoteDatasource(this._client);

  /// Obtiene rutinas del gym con nombre del cliente.
  Future<List<Routine>> fetchRoutines(String gymId) async {
    try {
      final response = await _client
          .from('routines')
          .select('''
            *,
            profiles:client_id (full_name)
          ''')
          .eq('gym_id', gymId)
          .eq('is_active', true)
          .order('created_at', ascending: false);

      return response.map((e) => Routine.fromJson(e)).toList();
    } catch (e, stack) {
      debugPrint('❌ ROUTINES fetchRoutines: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Obtiene una rutina con sus ejercicios.
  Future<Routine> fetchRoutine(String routineId) async {
    try {
      final response = await _client
          .from('routines')
          .select('''
            *,
            profiles:client_id (full_name),
            routine_exercises (
              *,
              exercises (name, muscle_group)
            )
          ''')
          .eq('id', routineId)
          .single();

      return Routine.fromJson(response);
    } catch (e, stack) {
      debugPrint('❌ ROUTINES fetchRoutine: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Crea una rutina con sus ejercicios en una transacción.
  Future<Routine> createRoutine({
    required String gymId,
    required String clientId,
    String? trainerId,
    required String name,
    String? description,
    required List<RoutineExerciseDraft> exercises,
  }) async {
    try {
      // 1) Crear la rutina.
      final routineResponse = await _client
          .from('routines')
          .insert({
            'gym_id': gymId,
            'client_id': clientId,
            'trainer_id': trainerId,
            'name': name,
            'description': description,
          })
          .select()
          .single();

      final routineId = routineResponse['id'] as String;

      // 2) Crear los ejercicios de la rutina.
      if (exercises.isNotEmpty) {
        final exerciseRows = exercises.asMap().entries.map((entry) {
          final draft = entry.value;
          return {
            'routine_id': routineId,
            'exercise_id': draft.exerciseId,
            'sets': draft.sets,
            'reps': draft.reps,
            'weight_kg': draft.weightKg,
            'rest_seconds': draft.restSeconds,
            'order_index': entry.key + 1,
            'notes': draft.notes,
          };
        }).toList();

        await _client.from('routine_exercises').insert(exerciseRows);
      }

      // 3) Retornar la rutina completa.
      return await fetchRoutine(routineId);
    } catch (e, stack) {
      debugPrint('❌ ROUTINES createRoutine: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Actualiza una rutina y sus ejercicios.
  Future<Routine> updateRoutine({
    required Routine routine,
    required List<RoutineExerciseDraft> exercises,
  }) async {
    try {
      // 1) Actualizar la rutina.
      await _client
          .from('routines')
          .update({
            'name': routine.name,
            'description': routine.description,
            'is_active': routine.isActive,
          })
          .eq('id', routine.id);

      // 2) Borrar ejercicios existentes y re-crear.
      await _client
          .from('routine_exercises')
          .delete()
          .eq('routine_id', routine.id);

      if (exercises.isNotEmpty) {
        final exerciseRows = exercises.asMap().entries.map((entry) {
          final draft = entry.value;
          return {
            'routine_id': routine.id,
            'exercise_id': draft.exerciseId,
            'sets': draft.sets,
            'reps': draft.reps,
            'weight_kg': draft.weightKg,
            'rest_seconds': draft.restSeconds,
            'order_index': entry.key + 1,
            'notes': draft.notes,
          };
        }).toList();

        await _client.from('routine_exercises').insert(exerciseRows);
      }

      // 3) Retornar la rutina actualizada.
      return await fetchRoutine(routine.id);
    } catch (e, stack) {
      debugPrint('❌ ROUTINES updateRoutine: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Desactiva una rutina.
  Future<void> deactivateRoutine(String routineId) async {
    try {
      await _client
          .from('routines')
          .update({'is_active': false})
          .eq('id', routineId);
    } catch (e, stack) {
      debugPrint('❌ ROUTINES deactivateRoutine: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Obtiene la rutina activa asignada al cliente.
  Future<Routine?> fetchClientRoutine(String userId) async {
    try {
      final response = await _client
          .from('routines')
          .select('''
            *,
            profiles:client_id (full_name),
            routine_exercises (
              *,
              exercises (name, muscle_group)
            )
          ''')
          .eq('client_id', userId)
          .eq('is_active', true)
          .order('created_at', ascending: false)
          .limit(1)
          .maybeSingle();

      if (response == null) return null;
      return Routine.fromJson(response);
    } catch (e, stack) {
      debugPrint('❌ ROUTINES fetchClientRoutine: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }
}
