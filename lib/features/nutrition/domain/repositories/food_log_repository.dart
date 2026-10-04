import '../../../../core/utils/result.dart';
import '../entities/food_log.dart';
import '../entities/food_log_item.dart';
import '../enums/meal_type.dart';

/// Repositorio del registro diario de comidas.
abstract interface class FoodLogRepository {
  /// Obtiene el log del día (o lo crea si no existe) con sus items.
  Future<Result<(FoodLog?, List<FoodLogItem>)>> fetchDailyLog({
    required String gymId,
    required DateTime date,
  });

  /// Obtiene logs de un rango de fechas (para historial/gráficos).
  Future<Result<List<FoodLog>>> fetchLogHistory({
    required String gymId,
    required DateTime from,
    required DateTime to,
  });

  /// Agrega un alimento al log del día (usa RPC add_food_to_log).
  /// Los macros se calculan proporcionalmente al serving_size.
  Future<Result<FoodLogItem>> addFoodToLog({
    required String gymId,
    required String foodId,
    required MealType mealType,
    required double quantity,
  });

  /// Elimina un item del log.
  Future<Result<void>> removeLogItem(String itemId);

  /// Actualiza la cantidad de un item (recalcula macros).
  Future<Result<FoodLogItem>> updateLogItemQuantity({
    required String itemId,
    required double newQuantity,
  });

  /// Actualiza las notas del log del día.
  Future<Result<FoodLog>> updateLogNotes({
    required String logId,
    required String notes,
  });
}
