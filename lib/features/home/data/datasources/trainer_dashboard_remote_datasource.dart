import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/trainer_dashboard_stats.dart';

/// DataSource del dashboard del entrenador.
/// MVP: retorna placeholders. F2 conectará rutinas/workouts reales.
class TrainerDashboardRemoteDatasource {
  TrainerDashboardRemoteDatasource(this._client);

  final SupabaseClient _client;

  Future<TrainerDashboardStats> fetchStats() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception('Usuario no autenticado');

    // Verificar membership trainer.
    final membership = await _client
        .from('memberships')
        .select('gym_id')
        .eq('user_id', userId)
        .eq('role', 'trainer')
        .eq('is_active', true)
        .maybeSingle();

    if (membership == null) {
      throw Exception('Usuario sin membership trainer activa');
    }

    final gymId = membership['gym_id'] as String;

    // Contar clientes del gym (placeholder: asignados al trainer).
    final clientsResponse = await _client
        .from('memberships')
        .select('id')
        .eq('gym_id', gymId)
        .eq('role', 'client')
        .eq('is_active', true);
    final clientsCount = (clientsResponse as List).length;

    // MVP: sesiones y rutinas en 0 hasta F2.
    return TrainerDashboardStats(
      assignedClientsCount: clientsCount,
      sessionsTodayCount: 0,
      activeRoutinesCount: 0,
      upcomingSessions: const [],
    );
  }
}
