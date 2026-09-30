import '../../../../core/utils/result.dart';
import '../entities/owner_dashboard_stats.dart';

/// Contrato del repositorio del dashboard del dueño.
abstract class OwnerDashboardRepository {
  Future<Result<OwnerDashboardStats>> fetchStats();
}
