import '../../../../core/utils/result.dart';
import '../entities/nutritionist_dashboard_stats.dart';

/// Repositorio abstracto del dashboard del nutricionista.
abstract interface class NutritionistDashboardRepository {
  Future<Result<NutritionistDashboardStats>> fetchStats();
}
