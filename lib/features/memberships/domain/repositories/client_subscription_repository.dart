import '../../../../core/utils/result.dart';
import '../entities/client_subscription.dart';

/// Contrato para la suscripción del cliente y asignación de planes.
abstract interface class ClientSubscriptionRepository {
  /// Obtiene la suscripción activa del cliente actual.
  Future<Result<ClientSubscription?>> getMySubscription();

  /// Asigna un plan a un cliente (solo owner).
  Future<Result<void>> assignPlan({
    required String userId,
    required String gymId,
    required String planId,
  });

  /// Obtiene la suscripción activa de un cliente específico (owner).
  Future<Result<ClientSubscription?>> getClientSubscription({
    required String userId,
    required String gymId,
  });
}
