import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/gym.dart';
import '../../domain/repositories/gym_discovery_repository.dart';
import '../datasources/gym_discovery_remote_datasource.dart';

/// Implementación del repositorio de gym discovery.
class GymDiscoveryRepositoryImpl implements GymDiscoveryRepository {
  GymDiscoveryRepositoryImpl({required GymDiscoveryRemoteDatasource remote})
    : _remote = remote;

  final GymDiscoveryRemoteDatasource _remote;

  @override
  Future<Result<List<Gym>>> searchGyms(String query) async {
    try {
      final gyms = await _remote.searchGyms(query);
      return Result.success(gyms);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'gym-discovery/search-error',
          message: 'Error al buscar gimnasios',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> joinGym(String gymId) async {
    try {
      await _remote.joinGym(gymId);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'gym-discovery/join-error',
          message: 'Error al unirse al gimnasio',
          cause: e,
        ),
      );
    }
  }
}
