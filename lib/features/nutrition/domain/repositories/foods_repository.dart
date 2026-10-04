import '../../../../core/utils/result.dart';
import '../entities/food.dart';

/// Contrato para gestionar el catálogo de alimentos (sistema + personalizados).
/// La UI nunca toca Supabase directamente (convenciones.md §2).
abstract interface class FoodsRepository {
  /// Obtiene alimentos visibles para el gym (sistema + personalizados).
  Future<Result<List<Food>>> getFoods({required String gymId});

  /// Obtiene un alimento por su ID.
  Future<Result<Food>> getFoodById({required String foodId});

  /// Busca alimentos por nombre (case-insensitive) en el catálogo visible.
  Future<Result<List<Food>>> searchFoods({
    required String gymId,
    required String query,
  });

  /// Crea un alimento personalizado del gym.
  Future<Result<Food>> createFood({
    required String gymId,
    required String name,
    String? brand,
    String? barcode,
    double servingSize,
    String servingUnit,
    required double caloriesKcal,
    required double proteinG,
    required double carbsG,
    required double fatsG,
    double? fiberG,
    double? sugarG,
    double? sodiumMg,
  });

  /// Actualiza un alimento existente.
  Future<Result<Food>> updateFood({required Food food});

  /// Desactiva (borrado lógico) un alimento personalizado.
  Future<Result<void>> deleteFood({required String foodId});
}
