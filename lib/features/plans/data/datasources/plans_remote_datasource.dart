import 'package:supabase_flutter/supabase_flutter.dart';

/// Baja planes desde Supabase.
class PlansRemoteDatasource {
  final SupabaseClient _client;

  PlansRemoteDatasource(this._client);

  /// Obtiene todos los planes desde la nube.
  Future<List<Map<String, dynamic>>> fetchPlans() async {
    final response = await _client
        .from('plans')
        .select()
        .order('price_usd', ascending: true);
    return List<Map<String, dynamic>>.from(response);
  }
}
