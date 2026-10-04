import '../../../../core/utils/result.dart';
import '../entities/meal_template.dart';
import '../entities/meal_template_food.dart';
import '../enums/meal_type.dart';

/// Repositorio de plantillas de comida del nutricionista.
abstract interface class MealTemplateRepository {
  /// Lista todas las plantillas activas del gimnasio.
  Future<Result<List<MealTemplate>>> fetchTemplates({
    required String gymId,
    MealType? filterByMealType,
  });

  /// Obtiene una plantilla con sus foods.
  Future<Result<(MealTemplate, List<MealTemplateFood>)>> fetchTemplateDetail(
    String templateId,
  );

  /// Crea una plantilla vacía (sin foods).
  Future<Result<MealTemplate>> createTemplate(MealTemplate template);

  /// Actualiza datos básicos de la plantilla (nombre, mealType).
  Future<Result<MealTemplate>> updateTemplate(MealTemplate template);

  /// Desactiva la plantilla (soft delete).
  Future<Result<void>> deactivateTemplate(String templateId);

  /// Agrega un alimento a la plantilla.
  /// El trigger recalcula los totales automáticamente.
  Future<Result<MealTemplateFood>> addFoodToTemplate({
    required String templateId,
    required String foodId,
    required double quantity,
    int orderIndex = 0,
    String? notes,
  });

  /// Actualiza cantidad de un alimento en la plantilla.
  Future<Result<MealTemplateFood>> updateTemplateFood({
    required String templateFoodId,
    required double newQuantity,
    String? notes,
  });

  /// Elimina un alimento de la plantilla.
  Future<Result<void>> removeFoodFromTemplate(String templateFoodId);
}
