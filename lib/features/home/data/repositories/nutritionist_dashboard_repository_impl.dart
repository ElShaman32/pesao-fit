import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/nutritionist_dashboard_stats.dart';
import '../../domain/repositories/nutritionist_dashboard_repository.dart';
import '../datasources/nutritionist_dashboard_remote_datasource.dart';

/// Implementación del repositorio del dashboard del nutricionista.
class NutritionistDashboardRepositoryImpl
    implements NutritionistDashboardRepository {
  NutritionistDashboardRepositoryImpl({
    required NutritionistDashboardRemoteDatasource remote,
  }) : _remote = remote;

  final NutritionistDashboardRemoteDatasource _remote;

  @override
  Future<Result<NutritionistDashboardStats>> fetchStats() async {
    try {
      final stats = await _remote.fetchStats();
      return Result.success(stats);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'nutritionist/dashboard-error',
          message: 'Error al cargar el dashboard',
          cause: e,
        ),
      );
    }
  }
}
