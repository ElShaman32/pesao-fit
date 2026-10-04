import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/meal_template.dart';
import '../../domain/entities/meal_template_food.dart';
import '../../domain/enums/meal_type.dart';
import '../../domain/repositories/meal_template_repository.dart';
import '../datasources/meal_template_remote_datasource.dart';

/// Implementación del repositorio de plantillas de comida.
class MealTemplateRepositoryImpl implements MealTemplateRepository {
  MealTemplateRepositoryImpl({required MealTemplateRemoteDatasource remote})
    : _remote = remote;

  final MealTemplateRemoteDatasource _remote;

  @override
  Future<Result<List<MealTemplate>>> fetchTemplates({
    required String gymId,
    MealType? filterByMealType,
  }) async {
    try {
      final templates = await _remote.fetchTemplates(
        gymId: gymId,
        filterByMealType: filterByMealType,
      );
      return Result.success(templates);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'template/fetch-error',
          message: 'Error al cargar plantillas',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<(MealTemplate, List<MealTemplateFood>)>> fetchTemplateDetail(
    String templateId,
  ) async {
    try {
      final detail = await _remote.fetchTemplateDetail(templateId);
      return Result.success(detail);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'template/detail-error',
          message: 'Error al cargar detalle de plantilla',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<MealTemplate>> createTemplate(MealTemplate template) async {
    try {
      final created = await _remote.createTemplate(template);
      return Result.success(created);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'template/create-error',
          message: 'Error al crear plantilla',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<MealTemplate>> updateTemplate(MealTemplate template) async {
    try {
      final updated = await _remote.updateTemplate(template);
      return Result.success(updated);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'template/update-error',
          message: 'Error al actualizar plantilla',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> deactivateTemplate(String templateId) async {
    try {
      await _remote.deactivateTemplate(templateId);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'template/deactivate-error',
          message: 'Error al desactivar plantilla',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<MealTemplateFood>> addFoodToTemplate({
    required String templateId,
    required String foodId,
    required double quantity,
    int orderIndex = 0,
    String? notes,
  }) async {
    try {
      final food = await _remote.addFoodToTemplate(
        templateId: templateId,
        foodId: foodId,
        quantity: quantity,
        orderIndex: orderIndex,
        notes: notes,
      );
      return Result.success(food);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'template/add-food-error',
          message: 'Error al agregar alimento a la plantilla',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<MealTemplateFood>> updateTemplateFood({
    required String templateFoodId,
    required double newQuantity,
    String? notes,
  }) async {
    try {
      final updated = await _remote.updateTemplateFood(
        templateFoodId: templateFoodId,
        newQuantity: newQuantity,
        notes: notes,
      );
      return Result.success(updated);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'template/update-food-error',
          message: 'Error al actualizar alimento de la plantilla',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> removeFoodFromTemplate(String templateFoodId) async {
    try {
      await _remote.removeFoodFromTemplate(templateFoodId);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'template/remove-food-error',
          message: 'Error al eliminar alimento de la plantilla',
          cause: e,
        ),
      );
    }
  }
}
