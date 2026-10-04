import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/nutritionist_dashboard_stats.dart';

/// DataSource del dashboard del nutricionista.
/// Patrón owner_dashboard_remote_datasource: lanza Exception plano,
/// el repository convierte a NetworkException.
class NutritionistDashboardRemoteDatasource {
  NutritionistDashboardRemoteDatasource(this._client);

  final SupabaseClient _client;

  Future<NutritionistDashboardStats> fetchStats() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception('Usuario no autenticado');

    // Una sola query: todos los planes del nutricionista con JOIN a cliente.
    final response = await _client
        .from('nutrition_plans')
        .select('''
          id,
          name,
          client_id,
          created_at,
          is_active,
          client:profiles!nutrition_plans_client_id_fkey (
            full_name
          )
        ''')
        .eq('nutritionist_id', userId)
        .order('created_at', ascending: false);

    final rows = List<Map<String, dynamic>>.from(response as List);

    final activePlans = rows.where((r) => r['is_active'] == true);
    final activePlansCount = activePlans.length;

    final distinctClients = activePlans
        .map((r) => r['client_id'] as String)
        .toSet();
    final clientsWithPlanCount = distinctClients.length;

    // Últimos 5 planes activos (ya vienen ordenados DESC).
    final recentPlans = activePlans.take(5).map((row) {
      final client = row['client'] as Map<String, dynamic>?;
      return RecentPlan(
        id: row['id'] as String,
        clientName: (client?['full_name'] as String?) ?? 'Cliente',
        createdAt: DateTime.parse(row['created_at'] as String),
      );
    }).toList();

    // F4: consultations (por ahora 0, se integra con chat).
    const consultsTodayCount = 0;

    return NutritionistDashboardStats(
      activePlansCount: activePlansCount,
      clientsWithPlanCount: clientsWithPlanCount,
      consultsTodayCount: consultsTodayCount,
      recentPlans: recentPlans,
    );
  }
}
