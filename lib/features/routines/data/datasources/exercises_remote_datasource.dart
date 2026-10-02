import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/exercise.dart';

/// Fuente remota de ejercicios.
class ExercisesRemoteDatasource {
  final SupabaseClient _client;

  const ExercisesRemoteDatasource(this._client);

  /// Obtiene ejercicios globales + personalizados del gym.
  Future<List<Exercise>> fetchExercises(String gymId) async {
    try {
      final response = await _client
          .from('exercises')
          .select()
          .or('is_global.eq.true,source_gym_id.eq.$gymId')
          .order('is_global', ascending: false)
          .order('name', ascending: true);

      return response
          .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e, stack) {
      debugPrint('❌ EXERCISES fetchExercises: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Crea un ejercicio personalizado.
  Future<Exercise> createExercise({
    required String gymId,
    required String name,
    String? description,
    required MuscleGroup muscleGroup,
  }) async {
    try {
      final response = await _client
          .from('exercises')
          .insert({
            'name': name,
            'description': description,
            'muscle_group': muscleGroup.dbValue,
            'is_global': false,
            'source_gym_id': gymId,
          })
          .select()
          .single();

      return Exercise.fromJson(response);
    } catch (e, stack) {
      debugPrint('❌ EXERCISES createExercise: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Actualiza un ejercicio.
  Future<Exercise> updateExercise(Exercise exercise) async {
    try {
      final response = await _client
          .from('exercises')
          .update({
            'name': exercise.name,
            'description': exercise.description,
            'muscle_group': exercise.muscleGroup.dbValue,
          })
          .eq('id', exercise.id)
          .select()
          .single();

      return Exercise.fromJson(response);
    } catch (e, stack) {
      debugPrint('❌ EXERCISES updateExercise: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Elimina un ejercicio personalizado.
  Future<void> deleteExercise(String exerciseId) async {
    try {
      await _client.from('exercises').delete().eq('id', exerciseId);
    } catch (e, stack) {
      debugPrint('❌ EXERCISES deleteExercise: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }
}
