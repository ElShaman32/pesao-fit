import '../../../../core/utils/result.dart';
import '../entities/nutritionist_stats.dart';

/// Contrato para obtener estadísticas del dashboard del nutricionista.
abstract interface class NutritionistDashboardRepository {
  /// Obtiene las stats del dashboard.
  Future<Result<NutritionistStats>> getStats({required String gymId});
}
