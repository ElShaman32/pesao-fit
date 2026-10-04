import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/food.dart';
import '../../domain/entities/food_favorite.dart';
import '../../domain/repositories/food_repository.dart';
import '../datasources/food_remote_datasource.dart';

/// Implementación del repositorio de alimentos.
class FoodRepositoryImpl implements FoodRepository {
  FoodRepositoryImpl({required FoodRemoteDatasource remote}) : _remote = remote;

  final FoodRemoteDatasource _remote;

  @override
  Future<Result<List<Food>>> searchFoods({
    required String query,
    required String gymId,
    int limit = 20,
  }) async {
    try {
      final foods = await _remote.searchFoods(
        query: query,
        gymId: gymId,
        limit: limit,
      );
      return Result.success(foods);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'food/search-error',
          message: 'Error al buscar alimentos',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<List<Food>>> fetchFoods({required String gymId}) async {
    try {
      final foods = await _remote.fetchFoods(gymId: gymId);
      return Result.success(foods);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'food/fetch-error',
          message: 'Error al cargar alimentos',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<Food>> fetchFoodById(String foodId) async {
    try {
      final food = await _remote.fetchFoodById(foodId);
      return Result.success(food);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'food/fetch-error',
          message: 'Error al cargar alimento',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<Food>> createFood(Food food) async {
    try {
      final created = await _remote.createFood(food);
      return Result.success(created);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'food/create-error',
          message: 'Error al crear alimento',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<Food>> updateFood(Food food) async {
    try {
      final updated = await _remote.updateFood(food);
      return Result.success(updated);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'food/update-error',
          message: 'Error al actualizar alimento',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> deactivateFood(String foodId) async {
    try {
      await _remote.deactivateFood(foodId);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'food/deactivate-error',
          message: 'Error al desactivar alimento',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<List<FoodFavorite>>> fetchFavorites(String clientId) async {
    try {
      final favorites = await _remote.fetchFavorites(clientId);
      return Result.success(favorites);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'food/favorites-error',
          message: 'Error al cargar favoritos',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<bool>> toggleFavorite({
    required String clientId,
    required String foodId,
  }) async {
    try {
      final isFavorite = await _remote.toggleFavorite(
        clientId: clientId,
        foodId: foodId,
      );
      return Result.success(isFavorite);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'food/toggle-favorite-error',
          message: 'Error al cambiar favorito',
          cause: e,
        ),
      );
    }
  }
}
