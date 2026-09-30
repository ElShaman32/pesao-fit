import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/gym.dart';

/// DataSource remoto de gym discovery.
/// Único punto de contacto con Supabase para búsqueda y membresías.
class GymDiscoveryRemoteDatasource {
  GymDiscoveryRemoteDatasource(this._client);

  final SupabaseClient _client;

  /// Busca gimnasios activos cuyo nombre coincida con la query.
  Future<List<Gym>> searchGyms(String query) async {
    // Primero los filtros (eq, ilike), al final la transformación (order).
    final request = _client.from('gyms').select().eq('is_active', true);

    final filtered = query.isEmpty
        ? request
        : request.ilike('name', '%$query%');

    final response = await filtered.order('name');

    return (response as List)
        .map((json) => Gym.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Crea una membresía de cliente para el usuario actual.
  Future<void> joinGym(String gymId) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('Usuario no autenticado');
    }

    await _client.from('memberships').insert({
      'user_id': userId,
      'gym_id': gymId,
      'role': 'client',
      'is_active': true,
    });
  }
}
