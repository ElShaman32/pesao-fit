import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/owner_application.dart';
import '../../domain/repositories/owner_application_repository.dart';
import '../datasources/owner_application_remote_datasource.dart';

/// Implementación del repositorio de solicitudes de dueño.
class OwnerApplicationRepositoryImpl implements OwnerApplicationRepository {
  OwnerApplicationRepositoryImpl({
    required OwnerApplicationRemoteDatasource remote,
  }) : _remote = remote;

  final OwnerApplicationRemoteDatasource _remote;

  @override
  Future<Result<OwnerApplication>> submit(OwnerApplication application) async {
    try {
      final result = await _remote.submit(application);
      return Result.success(result);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'owner-app/submit-error',
          message: 'Error al enviar solicitud',
          cause: e,
        ),
      );
    }
  }
}
