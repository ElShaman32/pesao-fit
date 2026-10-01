import '../../../../core/utils/result.dart';

import '../entities/payment.dart';

/// Contrato para gestionar pagos manuales.
abstract interface class PaymentsRepository {
  /// Obtiene los pagos del gimnasio visibles para el dueño.
  Future<Result<List<Payment>>> getOwnerPayments({
    required String gymId,
  });

  /// Aprueba un pago pendiente.
  Future<Result<void>> approvePayment({
    required String paymentId,
  });

  /// Rechaza un pago pendiente con motivo.
  Future<Result<void>> rejectPayment({
    required String paymentId,
    required String reason,
  });
}