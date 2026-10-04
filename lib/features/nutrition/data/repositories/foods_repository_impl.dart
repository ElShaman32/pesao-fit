import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/food.dart';
import '../../domain/repositories/foods_repository.dart';
import '../datasources/food_remote_datasource.dart';

/// Implementación del repositorio de alimentos.
/// Atrapa excepciones del datasource y las envuelve en `Result<T>`.
class FoodsRepositoryImpl implements FoodsRepository {
  final FoodsRemoteDatasource _remote;

  const FoodsRepositoryImpl({required FoodsRemoteDatasource remote})
    : _remote = remote;

  @override
  Future<Result<List<Food>>> getFoods({required String gymId}) async {
    try {
      final foods = await _remote.fetchFoods(gymId);
      return Result.success(foods);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'Foods/fetch-error',
          message: 'Error al cargar el catálogo de alimentos',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<Food>> getFoodById({required String foodId}) async {
    try {
      final food = await _remote.fetchFoodById(foodId);
      return Result.success(food);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'Foods/fetch-error',
          message: 'Error al cargar el alimento',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<List<Food>>> searchFoods({
    required String gymId,
    required String query,
  }) async {
    try {
      final foods = await _remote.searchFoods(gymId, query);
      return Result.success(foods);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'Foods/fetch-error',
          message: 'Error al buscar alimentos',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<Food>> createFood({
    required String gymId,
    required String name,
    String? brand,
    String? barcode,
    double servingSize = 100,
    String servingUnit = 'g',
    required double caloriesKcal,
    required double proteinG,
    required double carbsG,
    required double fatsG,
    double? fiberG,
    double? sugarG,
    double? sodiumMg,
  }) async {
    try {
      final food = await _remote.createFood(
        gymId: gymId,
        name: name,
        brand: brand,
        barcode: barcode,
        servingSize: servingSize,
        servingUnit: servingUnit,
        caloriesKcal: caloriesKcal,
        proteinG: proteinG,
        carbsG: carbsG,
        fatsG: fatsG,
        fiberG: fiberG,
        sugarG: sugarG,
        sodiumMg: sodiumMg,
      );
      return Result.success(food);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'Foods/create-error',
          message: 'Error al crear el alimento',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<Food>> updateFood({required Food food}) async {
    try {
      final updated = await _remote.updateFood(food);
      return Result.success(updated);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'Foods/update-error',
          message: 'Error al actualizar el alimento',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> deleteFood({required String foodId}) async {
    try {
      await _remote.deleteFood(foodId);
      return const Result<void>.success(null);
    } on AppException catch (e) {
      return Result<void>.failure(e);
    } catch (e) {
      return Result<void>.failure(
        UnknownException(
          code: 'Foods/delete-error',
          message: 'Error al eliminar el alimento',
          cause: e,
        ),
      );
    }
  }
}
