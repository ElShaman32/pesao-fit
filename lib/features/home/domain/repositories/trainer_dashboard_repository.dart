import '../../../../core/utils/result.dart';
import '../entities/trainer_dashboard_stats.dart';

/// Contrato del repositorio del dashboard del entrenador.
abstract class TrainerDashboardRepository {
  Future<Result<TrainerDashboardStats>> fetchStats();
}
