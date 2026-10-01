import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/payment.dart';
import '../../domain/entities/upload_payment_request.dart';
import '../../domain/repositories/client_payments_repository.dart';
import '../datasources/client_payments_remote_datasource.dart';

/// Implementación del repositorio de pagos del cliente.
class ClientPaymentsRepositoryImpl implements ClientPaymentsRepository {
  final ClientPaymentsRemoteDatasource _remote;

  const ClientPaymentsRepositoryImpl({
    required ClientPaymentsRemoteDatasource remote,
  }) : _remote = remote;

  @override
  Future<Result<Payment>> uploadPayment(UploadPaymentRequest request) async {
    try {
      final payment = await _remote.uploadPayment(
        gymId: request.gymId,
        amountBs: request.amountBs,
        amountUsd: request.amountUsd,
        rateUsed: request.rateUsed,
        receiptBytes: request.receiptBytes,
      );
      return Result.success(payment);
    } on AppException catch (e) {
      return Result<Payment>.failure(e);
    } catch (e) {
      return Result<Payment>.failure(
        UnknownException(
          code: 'payment/action-error',
          message: _friendlyError(e),
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<List<Payment>>> getMyPayments() async {
    try {
      final payments = await _remote.fetchMyPayments();
      return Result.success(payments);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'payment/reject-error',
          message: 'No se pudieron cargar tus pagos',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<double?>> getCurrentRate(String gymId) async {
    try {
      final rate = await _remote.fetchCurrentRate(gymId);
      return Result.success(rate);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'payment/reject-error',
          message: 'No se pudo obtener la tasa',
          cause: e,
        ),
      );
    }
  }

  String _friendlyError(Object error) {
    final raw = error.toString();

    if (raw.contains('Cloudinary') || raw.contains('upload')) {
      return 'No pudimos subir la imagen. Verifica tu conexión.';
    }

    if (raw.contains('forbidden') || raw.contains('row-level security')) {
      return 'Debes ser cliente activo de un gimnasio para subir pagos.';
    }

    if (raw.contains('has_client_membership')) {
      return 'Primero únete a un gimnasio para poder subir pagos.';
    }

    return 'No pudimos subir tu pago. Inténtalo de nuevo.';
  }
}
