import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/services/cloudinary_service.dart';
import '../../domain/entities/payment.dart';

/// Fuente remota combinada: Cloudinary (imagen) + Supabase (pago).
class ClientPaymentsRemoteDatasource {
  final SupabaseClient _client;
  final CloudinaryService _cloudinary;

  const ClientPaymentsRemoteDatasource({
    required SupabaseClient client,
    required CloudinaryService cloudinary,
  }) : _client = client,
       _cloudinary = cloudinary;

  /// Sube imagen a Cloudinary e inserta el pago en Supabase en una sola operación.
  ///
  /// El RLS de `Payments client insert own` valida que:
  /// - status = 'pending'
  /// - user_id = auth.uid()
  /// - payment_kind = 'client_membership'
  /// - receipt_url no vacío
  /// - el usuario tenga membership de cliente en el gimnasio
  Future<Payment> uploadPayment({
    required String gymId,
    required double amountBs,
    required double amountUsd,
    required double rateUsed,
    required Uint8List receiptBytes,
    String? subscriptionId, // ← NUEVO
  }) async {
    try {
      final paymentId = const Uuid().v4();

      debugPrint('💰 UPLOAD: subiendo comprobante paymentId=$paymentId');

      // 1) Subir imagen a Cloudinary con el payment_id como public_id.
      final uploadResult = await _cloudinary.uploadImage(
        bytes: receiptBytes,
        publicId: paymentId,
        folder: 'receipts',
        filename: 'receipt_$paymentId',
      );

      debugPrint('💰 UPLOAD: imagen subida. Insertando pago...');

      // 2) Insertar pago en Supabase con el payment_id generado localmente.
      final response = await _client
          .from('payments')
          .insert({
            'id': paymentId,
            'gym_id': gymId,
            'user_id': _client.auth.currentUser!.id,
            'amount_bs': amountBs,
            'amount_usd': amountUsd,
            'rate_used': rateUsed,
            'receipt_url': uploadResult.secureUrl,
            'status': 'pending',
            'payment_kind': 'client_membership',
            'subscription_id': subscriptionId, // ← NUEVO
          })
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
          .single();

      return Payment.fromJson(response);
    } catch (e, stack) {
      debugPrint('❌ UPLOAD PAYMENT ERROR: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Lista los pagos del usuario actual (RLS client own).
  Future<List<Payment>> fetchMyPayments() async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) return [];

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
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return response.map(Payment.fromJson).toList();
    } catch (e, stack) {
      debugPrint('❌ FETCH MY PAYMENTS: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Obtiene la tasa BCV vigente del gimnasio (gym_settings).
  Future<double?> fetchCurrentRate(String gymId) async {
    try {
      final response = await _client
          .from('gym_settings')
          .select('bcv_rate')
          .eq('gym_id', gymId)
          .maybeSingle();

      final raw = response?['bcv_rate'];
      if (raw == null) return null;
      return (raw as num).toDouble();
    } catch (e, stack) {
      debugPrint('❌ FETCH CURRENT RATE: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }
}
