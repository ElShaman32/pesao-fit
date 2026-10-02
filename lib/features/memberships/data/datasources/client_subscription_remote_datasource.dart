import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/client_subscription.dart';

/// Fuente remota de suscripciones de clientes.
class ClientSubscriptionRemoteDatasource {
  final SupabaseClient _client;

  const ClientSubscriptionRemoteDatasource(this._client);

  /// Suscripción activa del cliente actual.
  Future<ClientSubscription?> fetchMySubscription() async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) return null;

      final response = await _client
          .from('client_subscriptions')
          .select('*, gym_membership_plans(name, price_usd, duration_days)')
          .eq('user_id', userId)
          .eq('status', 'active')
          .maybeSingle();

      if (response == null) return null;
      return ClientSubscription.fromJson(response);
    } catch (e, stack) {
      debugPrint('❌ SUBSCRIPTION fetchMySubscription: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Suscripción activa de un cliente específico (para el owner).
  Future<ClientSubscription?> fetchClientSubscription({
    required String userId,
    required String gymId,
  }) async {
    try {
      final response = await _client
          .from('client_subscriptions')
          .select('*, gym_membership_plans(name, price_usd, duration_days)')
          .eq('user_id', userId)
          .eq('gym_id', gymId)
          .eq('status', 'active')
          .maybeSingle();

      if (response == null) return null;
      return ClientSubscription.fromJson(response);
    } catch (e, stack) {
      debugPrint('❌ SUBSCRIPTION fetchClientSubscription: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Asigna un plan a un cliente vía función SQL segura.
  Future<void> assignPlan({
    required String userId,
    required String gymId,
    required String planId,
  }) async {
    try {
      await _client.rpc(
        'assign_plan_to_client',
        params: {'p_user_id': userId, 'p_gym_id': gymId, 'p_plan_id': planId},
      );
    } catch (e, stack) {
      debugPrint('❌ SUBSCRIPTION assignPlan: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }
}
