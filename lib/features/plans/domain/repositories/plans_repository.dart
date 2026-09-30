import '../../../../core/database/app_database.dart';
import '../../../../core/utils/result.dart';

/// Contrato del repositorio de planes.
abstract class PlansRepository {
  /// Obtiene planes con estrategia offline-first.
  /// [forceRefresh] ignora caché y fuerza descarga de red.
  Future<Result<List<Plan>>> getPlans({bool forceRefresh = false});
}
