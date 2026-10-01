import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/payment.dart';
import '../../domain/repositories/payments_repository.dart';
import '../datasources/payments_remote_datasource.dart';

/// Implementación del repositorio de pagos.
///
/// F4-A no cachea pagos en Drift por integridad financiera.
/// Los pagos siempre se consultan frescos contra Supabase.
class PaymentsRepositoryImpl implements PaymentsRepository {
  final PaymentsRemoteDatasource _remote;

  const PaymentsRepositoryImpl({required PaymentsRemoteDatasource remote})
    : _remote = remote;

  @override
  Future<Result<List<Payment>>> getOwnerPayments({
    required String gymId,
  }) async {
    try {
      final payments = await _remote.fetchOwnerPayments(gymId);
      return Result.success(payments);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'payment/reject-error',
          message: 'No se pudo cargar los pagos',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> approvePayment({required String paymentId}) async {
    try {
      await _remote.approvePayment(paymentId);
      return const Result<void>.success(null);
    } on AppException catch (e) {
      return Result<void>.failure(e);
    } catch (e) {
      return Result<void>.failure(
        UnknownException(
          code: 'payment/action-error',
          message: _friendlyPaymentError(e),
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> rejectPayment({
    required String paymentId,
    required String reason,
  }) async {
    try {
      await _remote.rejectPayment(paymentId, reason);
      return const Result<void>.success(null);
    } on AppException catch (e) {
      return Result<void>.failure(e);
    } catch (e) {
      return Result<void>.failure(
        UnknownException(
          code: 'payment/action-error',
          message: _friendlyPaymentError(e),
          cause: e,
        ),
      );
    }
  }

  /// Traduce errores técnicos a mensajes suaves.
  String _friendlyPaymentError(Object error) {
    final raw = error.toString();

    if (raw.contains('payment_not_found')) {
      return 'No encontramos ese pago.';
    }

    if (raw.contains('payment_not_pending')) {
      return 'Este pago ya no está pendiente.';
    }

    if (raw.contains('reason_required')) {
      return 'Escribe un motivo para rechazar el pago.';
    }

    if (raw.contains('forbidden')) {
      return 'No tienes permiso para hacer esto.';
    }

    return 'No pudimos completar la acción.';
  }
}
