import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/owner_dashboard_stats.dart';

/// DataSource del dashboard del dueño.
/// MVP: retorna placeholders. F4 conectará pagos reales.
class OwnerDashboardRemoteDatasource {
  OwnerDashboardRemoteDatasource(this._client);

  final SupabaseClient _client;

  Future<OwnerDashboardStats> fetchStats() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception('Usuario no autenticado');

    // Obtener el gym del dueño.
    final membership = await _client
        .from('memberships')
        .select('gym_id')
        .eq('user_id', userId)
        .eq('role', 'owner')
        .eq('is_active', true)
        .maybeSingle();

    if (membership == null) {
      throw Exception('Usuario sin membership owner activa');
    }

    final gymId = membership['gym_id'] as String;

    // Contar clientes activos del gym.
    final clientsResponse = await _client
        .from('memberships')
        .select('id')
        .eq('gym_id', gymId)
        .eq('role', 'client')
        .eq('is_active', true);
    final clientsCount = (clientsResponse as List).length;

    // MVP: pagos e ingresos en 0 hasta F4.
    return OwnerDashboardStats(
      activeClientsCount: clientsCount,
      pendingPaymentsCount: 0,
      monthlyIncomeBs: 0.0,
      recentClients: const [],
    );
  }
}
