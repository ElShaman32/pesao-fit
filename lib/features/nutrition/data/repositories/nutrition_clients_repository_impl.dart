import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/nutrition_client.dart';
import '../../domain/repositories/nutrition_clients_repository.dart';
import '../datasources/nutrition_clients_remote_datasource.dart';

/// Implementación del repositorio de clientes del nutricionista.
class NutritionClientsRepositoryImpl implements NutritionClientsRepository {
  final NutritionClientsRemoteDatasource _remote;

  const NutritionClientsRepositoryImpl({
    required NutritionClientsRemoteDatasource remote,
  }) : _remote = remote;

  @override
  Future<Result<List<NutritionClient>>> getClients({
    required String gymId,
  }) async {
    try {
      final clients = await _remote.fetchClients(gymId);
      return Result.success(clients);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'NutritionClients/fetch-error',
          message: 'Error al cargar los clientes del gym',
          cause: e,
        ),
      );
    }
  }
}
