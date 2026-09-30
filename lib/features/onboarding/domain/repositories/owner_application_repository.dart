import '../../../../core/utils/result.dart';
import '../entities/owner_application.dart';

/// Contrato del repositorio de solicitudes de dueño (domain).
abstract class OwnerApplicationRepository {
  /// Envía una nueva solicitud de registro de gimnasio.
  Future<Result<OwnerApplication>> submit(OwnerApplication application);
}
