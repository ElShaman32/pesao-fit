import '../../../../core/utils/result.dart';
import '../entities/admin_dashboard_stats.dart';

/// Contrato del repositorio del dashboard del superadmin (domain).
abstract class AdminDashboardRepository {
  /// Obtiene las estadísticas agregadas + últimos gimnasios aprobados.
  Future<Result<AdminDashboardStats>> fetchStats();
}
