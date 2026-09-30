import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/client_dashboard_stats.dart';

/// DataSource remoto del dashboard del cliente.
///
/// MVP: retorna stats placeholder en 0. En F2/F3 se conectan queries
/// reales a workouts, body_measurements y planes de nutrición.
class ClientDashboardRemoteDatasource {
  ClientDashboardRemoteDatasource(this._client);

  final SupabaseClient _client;

  /// Obtiene stats del dashboard.
  /// MVP: verifica que el usuario es cliente activo y retorna placeholders.
  Future<ClientDashboardStats> fetchStats() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('Usuario no autenticado');
    }

    // Verificar que tiene membresía client activa.
    final membership = await _client
        .from('memberships')
        .select('role, gym_id')
        .eq('user_id', userId)
        .eq('role', 'client')
        .eq('is_active', true)
        .maybeSingle();

    if (membership == null) {
      throw Exception('Usuario sin membresía client activa');
    }

    // MVP: retornar placeholders. En F2/F3 se conectan datos reales.
    return const ClientDashboardStats(
      kcalToday: 0,
      kcalGoal: 2200,
      streakDays: 0,
      nextWorkoutLabel: null,
      hasWorkoutToday: false,
    );
  }
}
