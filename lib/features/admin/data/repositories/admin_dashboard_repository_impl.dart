import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/admin_dashboard_stats.dart';
import '../../domain/repositories/admin_dashboard_repository.dart';
import '../datasources/admin_dashboard_remote_datasource.dart';

/// Implementación del repositorio del dashboard del superadmin.
class AdminDashboardRepositoryImpl implements AdminDashboardRepository {
  AdminDashboardRepositoryImpl({required AdminDashboardRemoteDatasource remote})
    : _remote = remote;

  final AdminDashboardRemoteDatasource _remote;

  @override
  Future<Result<AdminDashboardStats>> fetchStats() async {
    try {
      final stats = await _remote.fetchStats();
      return Result.success(stats);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'admin/dashboard-error',
          message: 'Error al cargar el dashboard',
          cause: e,
        ),
      );
    }
  }
}
