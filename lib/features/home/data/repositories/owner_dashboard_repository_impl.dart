import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/owner_dashboard_stats.dart';
import '../../domain/repositories/owner_dashboard_repository.dart';
import '../datasources/owner_dashboard_remote_datasource.dart';

/// Implementación del repositorio del dashboard del dueño.
class OwnerDashboardRepositoryImpl implements OwnerDashboardRepository {
  OwnerDashboardRepositoryImpl({required OwnerDashboardRemoteDatasource remote})
    : _remote = remote;

  final OwnerDashboardRemoteDatasource _remote;

  @override
  Future<Result<OwnerDashboardStats>> fetchStats() async {
    try {
      final stats = await _remote.fetchStats();
      return Result.success(stats);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'owner/dashboard-error',
          message: 'Error al cargar el dashboard',
          cause: e,
        ),
      );
    }
  }
}
