import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/client_subscription.dart';
import '../../domain/repositories/client_subscription_repository.dart';
import '../datasources/client_subscription_remote_datasource.dart';

/// Implementación del repositorio de suscripciones de clientes.
class ClientSubscriptionRepositoryImpl implements ClientSubscriptionRepository {
  final ClientSubscriptionRemoteDatasource _remote;

  const ClientSubscriptionRepositoryImpl({
    required ClientSubscriptionRemoteDatasource remote,
  }) : _remote = remote;

  @override
  Future<Result<ClientSubscription?>> getMySubscription() async {
    try {
      final subscription = await _remote.fetchMySubscription();
      return Result.success(subscription);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'client/fetch-subscription-error',
          message: 'No se pudo cargar tu suscripción',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> assignPlan({
    required String userId,
    required String gymId,
    required String planId,
  }) async {
    try {
      await _remote.assignPlan(userId: userId, gymId: gymId, planId: planId);
      return const Result<void>.success(null);
    } on AppException catch (e) {
      return Result<void>.failure(e);
    } catch (e) {
      return Result<void>.failure(
        UnknownException(
          code: 'client/assign-plan-error',
          message: 'No se pudo asignar el plan',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<ClientSubscription?>> getClientSubscription({
    required String userId,
    required String gymId,
  }) async {
    try {
      final subscription = await _remote.fetchClientSubscription(
        userId: userId,
        gymId: gymId,
      );
      return Result.success(subscription);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'client/fetch-subscription-error',
          message: 'No se pudo cargar la suscripción',
          cause: e,
        ),
      );
    }
  }
}
