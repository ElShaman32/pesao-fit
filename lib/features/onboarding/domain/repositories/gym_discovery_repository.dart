import '../../../../core/utils/result.dart';
import '../entities/gym.dart';

/// Contrato del repositorio de gym discovery (domain).
abstract class GymDiscoveryRepository {
  /// Busca gimnasios activos por nombre.
  Future<Result<List<Gym>>> searchGyms(String query);

  /// Crea una membresía de cliente para el usuario actual en el gimnasio.
  Future<Result<void>> joinGym(String gymId);
}
