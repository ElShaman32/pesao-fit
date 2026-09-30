import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/gym_application.dart';
import '../../domain/repositories/gym_application_review_repository.dart';
import '../datasources/gym_application_review_remote_datasource.dart';

/// Implementación del repositorio de revisión de solicitudes.
class GymApplicationReviewRepositoryImpl
    implements GymApplicationReviewRepository {
  GymApplicationReviewRepositoryImpl({
    required GymApplicationReviewRemoteDatasource remote,
  }) : _remote = remote;

  final GymApplicationReviewRemoteDatasource _remote;

  @override
  Future<Result<List<GymApplication>>> fetchPending() async {
    try {
      final applications = await _remote.fetchPending();
      return Result.success(applications);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'admin/fetch-applications-error',
          message: 'Error al cargar solicitudes',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> approve(String applicationId) async {
    try {
      await _remote.approve(applicationId);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'admin/approve-error',
          message: 'Error al aprobar gimnasio',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> reject(String applicationId, String reason) async {
    try {
      await _remote.reject(applicationId, reason);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'admin/reject-error',
          message: 'Error al rechazar solicitud',
          cause: e,
        ),
      );
    }
  }
}
