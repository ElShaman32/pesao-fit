import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/nutritionist_dashboard_stats.dart';

/// DataSource del dashboard del nutricionista.
/// MVP: retorna placeholders. F3 conectará planes reales.
class NutritionistDashboardRemoteDatasource {
  NutritionistDashboardRemoteDatasource(this._client);

  final SupabaseClient _client;

  Future<NutritionistDashboardStats> fetchStats() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception('Usuario no autenticado');

    // Verificar membership nutritionist.
    final membership = await _client
        .from('memberships')
        .select('gym_id')
        .eq('user_id', userId)
        .eq('role', 'nutritionist')
        .eq('is_active', true)
        .maybeSingle();

    if (membership == null) {
      throw Exception('Usuario sin membership nutritionist activa');
    }

    // MVP: todo en 0 hasta F3.
    return const NutritionistDashboardStats(
      activePlansCount: 0,
      clientsWithPlanCount: 0,
      consultsTodayCount: 0,
      recentPlans: [],
    );
  }
}
