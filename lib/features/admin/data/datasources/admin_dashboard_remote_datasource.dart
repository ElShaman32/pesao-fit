import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/admin_dashboard_stats.dart';

/// DataSource remoto del dashboard del superadmin.
/// Queries agregadas (COUNT) sobre tablas principales.
class AdminDashboardRemoteDatasource {
  AdminDashboardRemoteDatasource(this._client);

  final SupabaseClient _client;

  /// Obtiene estadísticas agregadas en paralelo para mejor performance.
  Future<AdminDashboardStats> fetchStats() async {
    final results = await Future.wait([
      _countActiveGyms(),
      _countPendingApplications(),
      _countActiveSubscriptions(),
      _fetchRecentGyms(),
    ]);

    return AdminDashboardStats(
      activeGymsCount: results[0] as int,
      pendingApplicationsCount: results[1] as int,
      activeSubscriptionsCount: results[2] as int,
      recentlyApprovedGyms: results[3] as List<RecentGym>,
    );
  }

  Future<int> _countActiveGyms() async {
    final response = await _client
        .from('gyms')
        .select('id')
        .eq('is_active', true);
    return (response as List).length;
  }

  Future<int> _countPendingApplications() async {
    final response = await _client
        .from('gym_applications')
        .select('id')
        .eq('status', 'pending');
    return (response as List).length;
  }

  Future<int> _countActiveSubscriptions() async {
    final response = await _client
        .from('subscriptions')
        .select('id')
        .eq('status', 'active');
    return (response as List).length;
  }

  Future<List<RecentGym>> _fetchRecentGyms() async {
    // Gimnasios aprobados = tienen al menos una membership owner.
    // Tomamos los 3 más recientes por created_at del gym.
    final response = await _client
        .from('gyms')
        .select()
        .eq('is_active', true)
        .order('created_at', ascending: false)
        .limit(3);

    return (response as List).map((json) {
      return RecentGym(
        id: json['id'] as String,
        name: json['name'] as String,
        city: (json['city'] as String?) ?? '',
        state: (json['state'] as String?) ?? '',
        approvedAt: DateTime.parse(json['created_at'] as String),
      );
    }).toList();
  }
}
