import '../../../../core/utils/result.dart';

import '../entities/payment.dart';
import '../entities/upload_payment_request.dart';

/// Contrato para pagos del cliente (subir comprobante + listar los suyos).
abstract interface class ClientPaymentsRepository {
  /// Sube comprobante: imagen a Cloudinary + pago pendiente a Supabase.
  Future<Result<Payment>> uploadPayment(UploadPaymentRequest request);

  /// Lista los pagos del cliente actual.
  Future<Result<List<Payment>>> getMyPayments();

  /// Obtiene la tasa BCV vigente del gimnasio (si existe).
  Future<Result<double?>> getCurrentRate(String gymId);
}
