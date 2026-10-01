import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/payment.dart';

/// Fuente remota de pagos. Usa Supabase client.
class PaymentsRemoteDatasource {
  final SupabaseClient _client;

  const PaymentsRemoteDatasource(this._client);

  /// Obtiene pagos de clientes del gimnasio.
  Future<List<Payment>> fetchOwnerPayments(String gymId) async {
    try {
      debugPrint('🔍 PAYMENTS REMOTE: fetchOwnerPayments gymId=$gymId');

      final response = await _client
          .from('payments')
          .select('''
            id,
            gym_id,
            user_id,
            amount_bs,
            amount_usd,
            rate_used,
            receipt_url,
            status,
            payment_kind,
            verified_by,
            rejected_reason,
            created_at,
            updated_at,
            profiles:user_id (
              full_name,
              avatar_url
            )
          ''')
          .eq('gym_id', gymId)
          .eq('payment_kind', 'client_membership')
          .order('created_at', ascending: false);

      debugPrint('✅ PAYMENTS REMOTE: ${response.length} pagos encontrados.');

      return response.map((json) => Payment.fromJson(json)).toList();
    } catch (e, stack) {
      debugPrint('❌ PAYMENTS REMOTE fetchOwnerPayments: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Aprueba un pago usando la función SQL segura.
  Future<void> approvePayment(String paymentId) async {
    try {
      debugPrint('🔍 PAYMENTS REMOTE: approvePayment id=$paymentId');
      await _client.rpc('approve_payment', params: {'p_payment_id': paymentId});
      debugPrint('✅ PAYMENTS REMOTE: pago aprobado.');
    } catch (e, stack) {
      debugPrint('❌ PAYMENTS REMOTE approvePayment: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Rechaza un pago usando la función SQL segura.
  Future<void> rejectPayment(String paymentId, String reason) async {
    try {
      debugPrint('🔍 PAYMENTS REMOTE: rejectPayment id=$paymentId');
      await _client.rpc(
        'reject_payment',
        params: {'p_payment_id': paymentId, 'p_reason': reason},
      );
      debugPrint('✅ PAYMENTS REMOTE: pago rechazado.');
    } catch (e, stack) {
      debugPrint('❌ PAYMENTS REMOTE rejectPayment: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }
}
