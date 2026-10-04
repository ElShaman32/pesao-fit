import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/food_log.dart';
import '../../domain/entities/food_log_item.dart';
import '../../domain/enums/meal_type.dart';
import '../../domain/repositories/food_log_repository.dart';
import '../datasources/food_log_remote_datasource.dart';

/// Implementación del repositorio del registro diario de comidas.
class FoodLogRepositoryImpl implements FoodLogRepository {
  FoodLogRepositoryImpl({required FoodLogRemoteDatasource remote})
    : _remote = remote;

  final FoodLogRemoteDatasource _remote;

  @override
  Future<Result<(FoodLog?, List<FoodLogItem>)>> fetchDailyLog({
    required String gymId,
    required DateTime date,
  }) async {
    try {
      final result = await _remote.fetchDailyLog(gymId: gymId, date: date);
      return Result.success(result);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'food-log/fetch-error',
          message: 'Error al cargar el registro del día',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<List<FoodLog>>> fetchLogHistory({
    required String gymId,
    required DateTime from,
    required DateTime to,
  }) async {
    try {
      final logs = await _remote.fetchLogHistory(
        gymId: gymId,
        from: from,
        to: to,
      );
      return Result.success(logs);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'food-log/history-error',
          message: 'Error al cargar el historial',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<FoodLogItem>> addFoodToLog({
    required String gymId,
    required String foodId,
    required MealType mealType,
    required double quantity,
  }) async {
    try {
      final item = await _remote.addFoodToLog(
        gymId: gymId,
        foodId: foodId,
        mealType: mealType,
        quantity: quantity,
      );
      return Result.success(item);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'food-log/add-error',
          message: 'Error al agregar alimento al registro',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> removeLogItem(String itemId) async {
    try {
      await _remote.removeLogItem(itemId);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'food-log/remove-error',
          message: 'Error al eliminar alimento del registro',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<FoodLogItem>> updateLogItemQuantity({
    required String itemId,
    required double newQuantity,
  }) async {
    try {
      final item = await _remote.updateLogItemQuantity(
        itemId: itemId,
        newQuantity: newQuantity,
      );
      return Result.success(item);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'food-log/update-error',
          message: 'Error al actualizar cantidad',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<FoodLog>> updateLogNotes({
    required String logId,
    required String notes,
  }) async {
    try {
      final log = await _remote.updateLogNotes(logId: logId, notes: notes);
      return Result.success(log);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'food-log/notes-error',
          message: 'Error al actualizar notas',
          cause: e,
        ),
      );
    }
  }
}
