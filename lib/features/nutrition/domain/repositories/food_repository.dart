import '../../../../core/utils/result.dart';
import '../entities/food.dart';
import '../entities/food_favorite.dart';

/// Repositorio del catálogo de alimentos y favoritos.
abstract interface class FoodRepository {
  /// Busca alimentos por nombre/marca (catálogo global + del gimnasio).
  Future<Result<List<Food>>> searchFoods({
    required String query,
    required String gymId,
    int limit = 20,
  });

  /// Obtiene todos los alimentos activos (global + gimnasio).
  Future<Result<List<Food>>> fetchFoods({required String gymId});

  /// Obtiene un alimento por ID.
  Future<Result<Food>> fetchFoodById(String foodId);

  /// Crea un alimento del gimnasio.
  Future<Result<Food>> createFood(Food food);

  /// Actualiza un alimento (solo si es del gimnasio y usuario es staff).
  Future<Result<Food>> updateFood(Food food);

  /// Desactiva un alimento (soft delete).
  Future<Result<void>> deactivateFood(String foodId);

  /// Obtiene los alimentos favoritos del cliente.
  Future<Result<List<FoodFavorite>>> fetchFavorites(String clientId);

  /// Toggle favorito: si existe lo quita, si no lo agrega.
  /// Retorna true si quedó como favorito, false si se quitó.
  Future<Result<bool>> toggleFavorite({
    required String clientId,
    required String foodId,
  });
}
