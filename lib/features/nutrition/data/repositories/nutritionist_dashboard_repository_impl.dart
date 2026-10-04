import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/nutritionist_stats.dart';
import '../../domain/repositories/nutritionist_dashboard_repository.dart';
import '../datasources/nutritionist_dashboard_remote_datasource.dart';

/// Implementación del repositorio de stats del dashboard.
class NutritionistDashboardRepositoryImpl
    implements NutritionistDashboardRepository {
  final NutritionistDashboardRemoteDatasource _remote;

  const NutritionistDashboardRepositoryImpl({
    required NutritionistDashboardRemoteDatasource remote,
  }) : _remote = remote;

  @override
  Future<Result<NutritionistStats>> getStats({required String gymId}) async {
    try {
      final stats = await _remote.fetchStats(gymId);
      return Result.success(stats);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'NutritionistDashboard/fetch-error',
          message: 'Error al cargar estadísticas del dashboard',
          cause: e,
        ),
      );
    }
  }
}
