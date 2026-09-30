import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/client_dashboard_stats.dart';
import '../../domain/repositories/client_dashboard_repository.dart';
import '../datasources/client_dashboard_remote_datasource.dart';

/// Implementación del repositorio del dashboard del cliente.
class ClientDashboardRepositoryImpl implements ClientDashboardRepository {
  ClientDashboardRepositoryImpl({
    required ClientDashboardRemoteDatasource remote,
  }) : _remote = remote;

  final ClientDashboardRemoteDatasource _remote;

  @override
  Future<Result<ClientDashboardStats>> fetchStats() async {
    try {
      final stats = await _remote.fetchStats();
      return Result.success(stats);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'client/dashboard-error',
          message: 'Error al cargar el dashboard',
          cause: e,
        ),
      );
    }
  }
}
