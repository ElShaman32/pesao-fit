import '../../../../core/utils/result.dart';
import '../entities/gym_application.dart';

/// Contrato del repositorio de revisión de solicitudes (domain).
abstract class GymApplicationReviewRepository {
  /// Obtiene todas las solicitudes pendientes, más recientes primero.
  Future<Result<List<GymApplication>>> fetchPending();

  /// Aprueba una solicitud (crea gym + membership + subscription).
  Future<Result<void>> approve(String applicationId);

  /// Rechaza una solicitud con motivo.
  Future<Result<void>> reject(String applicationId, String reason);
}
