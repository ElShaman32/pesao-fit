import '../../../../core/utils/result.dart';
import '../entities/nutrition_client.dart';

/// Contrato para obtener la lista de clientes del nutricionista.
abstract interface class NutritionClientsRepository {
  /// Obtiene los clientes activos del gym del nutricionista.
  Future<Result<List<NutritionClient>>> getClients({required String gymId});
}
