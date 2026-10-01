import 'dart:typed_data';

/// Solicitud para subir un pago desde el cliente.
class UploadPaymentRequest {
  final String gymId;
  final double amountBs;
  final double amountUsd;
  final double rateUsed;
  final Uint8List receiptBytes;

  const UploadPaymentRequest({
    required this.gymId,
    required this.amountBs,
    required this.amountUsd,
    required this.rateUsed,
    required this.receiptBytes,
  });
}
