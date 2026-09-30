import '../../../../core/utils/result.dart';
import '../entities/nutritionist_dashboard_stats.dart';

/// Contrato del repositorio del dashboard del nutricionista.
abstract class NutritionistDashboardRepository {
  Future<Result<NutritionistDashboardStats>> fetchStats();
}
