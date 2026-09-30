import '../../../../core/utils/result.dart';
import '../entities/client_dashboard_stats.dart';

/// Contrato del repositorio del dashboard del cliente (domain).
abstract class ClientDashboardRepository {
  /// Obtiene las estadísticas del dashboard del cliente autenticado.
  Future<Result<ClientDashboardStats>> fetchStats();
}
