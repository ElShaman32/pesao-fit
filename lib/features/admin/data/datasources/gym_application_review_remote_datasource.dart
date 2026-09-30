import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/gym_application.dart';

/// DataSource remoto de revisión de solicitudes.
/// Único punto de contacto con Supabase para gym_applications (lado admin).
class GymApplicationReviewRemoteDatasource {
  GymApplicationReviewRemoteDatasource(this._client);

  final SupabaseClient _client;

  /// Lee solicitudes pendientes. RLS permite solo al superadmin (is_superadmin()).
  Future<List<GymApplication>> fetchPending() async {
    final response = await _client
        .from('gym_applications')
        .select()
        .eq('status', 'pending')
        .order('submitted_at', ascending: false);

    return (response as List)
        .map((json) => GymApplication.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Llama a la función SQL approve_gym (transaccional, solo superadmin).
  Future<void> approve(String applicationId) async {
    await _client.rpc(
      'approve_gym',
      params: {'p_application_id': applicationId},
    );
  }

  /// Llama a la función SQL reject_gym (solo superadmin).
  Future<void> reject(String applicationId, String reason) async {
    await _client.rpc(
      'reject_gym',
      params: {'p_application_id': applicationId, 'p_reason': reason},
    );
  }
}
