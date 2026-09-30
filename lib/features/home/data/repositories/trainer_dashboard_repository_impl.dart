import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/trainer_dashboard_stats.dart';
import '../../domain/repositories/trainer_dashboard_repository.dart';
import '../datasources/trainer_dashboard_remote_datasource.dart';

/// Implementación del repositorio del dashboard del entrenador.
class TrainerDashboardRepositoryImpl implements TrainerDashboardRepository {
  TrainerDashboardRepositoryImpl({
    required TrainerDashboardRemoteDatasource remote,
  }) : _remote = remote;

  final TrainerDashboardRemoteDatasource _remote;

  @override
  Future<Result<TrainerDashboardStats>> fetchStats() async {
    try {
      final stats = await _remote.fetchStats();
      return Result.success(stats);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'trainer/dashboard-error',
          message: 'Error al cargar el dashboard',
          cause: e,
        ),
      );
    }
  }
}
