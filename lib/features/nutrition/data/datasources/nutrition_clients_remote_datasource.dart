import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/nutrition_client.dart';

/// Fuente remota de clientes del nutricionista (Supabase).
/// Obtiene miembros del gym con rol 'client' + su perfil.
class NutritionClientsRemoteDatasource {
  final SupabaseClient _client;

  const NutritionClientsRemoteDatasource(this._client);

  /// Obtiene todos los clientes activos del gym.
  Future<List<NutritionClient>> fetchClients(String gymId) async {
    try {
      final response = await _client
          .from('memberships')
          .select('''
            user_id,
            created_at,
            profiles:user_id (
              id,
              full_name,
              email,
              avatar_url
            )
          ''')
          .eq('gym_id', gymId)
          .eq('role', 'client')
          .eq('is_active', true)
          .order('created_at', ascending: true);

      return response.map((e) => NutritionClient.fromJson(e)).toList();
    } catch (e, stack) {
      debugPrint('❌ NUTRITION_CLIENTS fetchClients: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }
}
