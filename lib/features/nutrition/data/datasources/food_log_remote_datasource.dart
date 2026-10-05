import 'package:drift/drift.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/food_log.dart';
import '../../domain/entities/food_log_item.dart';
import '../../domain/enums/meal_type.dart';

/// DataSource del registro diario de comidas.
/// Usa RPCs de Supabase: get_daily_food_log, add_food_to_log.
/// Implementa patrón cache-first.
class FoodLogRemoteDatasource {
  FoodLogRemoteDatasource(this._client, this._db);

  final SupabaseClient _client;
  final AppDatabase _db;

  Future<(FoodLog?, List<FoodLogItem>)> fetchDailyLog({
    required String gymId,
    required DateTime date,
  }) async {
    try {
      final dateStr = date.toIso8601String().split('T')[0];

      final response = await _client.rpc(
        'get_daily_food_log',
        params: {'p_gym_id': gymId, 'p_date': dateStr},
      );

      final data = response as Map<String, dynamic>;
      final found = data['found'] as bool;

      if (!found) {
        return (null, <FoodLogItem>[]);
      }

      final logJson = data['log'] as Map<String, dynamic>;
      final itemsJson = data['items'] as List;

      final log = FoodLog.fromJson(logJson);
      await _cacheLogs([log]);

      final items = itemsJson.map((item) {
        final map = item as Map<String, dynamic>;
        return FoodLogItem(
          id: map['item_id'] as String,
          logId: log.id,
          foodId: map['food_id'] as String,
          mealType: MealType.fromDbValue(map['meal_type'] as String),
          quantity: (map['quantity'] as num).toDouble(),
          caloriesKcal: (map['calories_kcal'] as num).toDouble(),
          proteinG: (map['protein_g'] as num).toDouble(),
          carbsG: (map['carbs_g'] as num).toDouble(),
          fatsG: (map['fats_g'] as num).toDouble(),
          createdAt: DateTime.now(),
        );
      }).toList();

      await _cacheLogItems(items);

      return (log, items);
    } catch (e) {
      return _loadDailyLogFromCache(gymId, date);
    }
  }

  Future<List<FoodLog>> fetchLogHistory({
    required String gymId,
    required DateTime from,
    required DateTime to,
  }) async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) throw Exception('Usuario no autenticado');

      final response = await _client
          .from('food_logs')
          .select()
          .eq('client_id', userId)
          .eq('gym_id', gymId)
          .gte('log_date', from.toIso8601String().split('T')[0])
          .lte('log_date', to.toIso8601String().split('T')[0])
          .order('log_date', ascending: false);

      final logs = (response as List)
          .map((row) => FoodLog.fromJson(row as Map<String, dynamic>))
          .toList();

      await _cacheLogs(logs);
      return logs;
    } catch (e) {
      return _loadLogHistoryFromCache(gymId, from, to);
    }
  }

  Future<FoodLogItem> addFoodToLog({
    required String gymId,
    required String foodId,
    required MealType mealType,
    required double quantity,
  }) async {
    final response = await _client.rpc(
      'add_food_to_log',
      params: {
        'p_gym_id': gymId,
        'p_food_id': foodId,
        'p_meal_type': mealType.toDbValue(),
        'p_quantity': quantity,
      },
    );

    final data = response as Map<String, dynamic>;
    final itemId = data['item_id'] as String;
    final logId = data['log_id'] as String;

    final food = await _client.from('foods').select().eq('id', foodId).single();

    final foodMap = food;
    final factor = quantity / (foodMap['serving_size'] as num).toDouble();

    final item = FoodLogItem(
      id: itemId,
      logId: logId,
      foodId: foodId,
      mealType: mealType,
      quantity: quantity,
      caloriesKcal: (foodMap['calories_kcal'] as num).toDouble() * factor,
      proteinG: (foodMap['protein_g'] as num).toDouble() * factor,
      carbsG: (foodMap['carbs_g'] as num).toDouble() * factor,
      fatsG: (foodMap['fats_g'] as num).toDouble() * factor,
      createdAt: DateTime.now(),
    );

    await _cacheLogItems([item]);

    // Recargar el log completo para actualizar totales
    await fetchDailyLog(gymId: gymId, date: DateTime.now());

    return item;
  }

  Future<void> removeLogItem(String itemId) async {
    await _client.from('food_log_items').delete().eq('id', itemId);

    // Eliminar del cache
    await (_db.delete(
      _db.foodLogItemsTable,
    )..where((t) => t.id.equals(itemId))).go();
  }

  Future<FoodLogItem> updateLogItemQuantity({
    required String itemId,
    required double newQuantity,
  }) async {
    final itemResponse = await _client
        .from('food_log_items')
        .select()
        .eq('id', itemId)
        .single();

    final itemMap = itemResponse;
    final foodId = itemMap['food_id'] as String;

    final foodResponse = await _client
        .from('foods')
        .select()
        .eq('id', foodId)
        .single();

    final foodMap = foodResponse;
    final servingSize = (foodMap['serving_size'] as num).toDouble();
    final factor = newQuantity / servingSize;

    final newCalories = (foodMap['calories_kcal'] as num).toDouble() * factor;
    final newProtein = (foodMap['protein_g'] as num).toDouble() * factor;
    final newCarbs = (foodMap['carbs_g'] as num).toDouble() * factor;
    final newFats = (foodMap['fats_g'] as num).toDouble() * factor;

    final updatedResponse = await _client
        .from('food_log_items')
        .update({
          'quantity': newQuantity,
          'calories_kcal': newCalories,
          'protein_g': newProtein,
          'carbs_g': newCarbs,
          'fats_g': newFats,
        })
        .eq('id', itemId)
        .select()
        .single();

    final updated = FoodLogItem.fromJson(updatedResponse);
    await _cacheLogItems([updated]);

    return updated;
  }

  Future<FoodLog> updateLogNotes({
    required String logId,
    required String notes,
  }) async {
    final response = await _client
        .from('food_logs')
        .update({'notes': notes})
        .eq('id', logId)
        .select()
        .single();

    final log = FoodLog.fromJson(response);
    await _cacheLogs([log]);

    return log;
  }

  // ═══════════════════════════════════════════════════════════════════════
  // CACHE DRIFT
  // ═══════════════════════════════════════════════════════════════════════

  Future<void> _cacheLogs(List<FoodLog> logs) async {
    await _db.transaction(() async {
      for (final log in logs) {
        await _db.foodLogsTable.insertOnConflictUpdate(_logToRow(log));
      }
    });
  }

  Future<void> _cacheLogItems(List<FoodLogItem> items) async {
    await _db.transaction(() async {
      for (final item in items) {
        await _db.foodLogItemsTable.insertOnConflictUpdate(_logItemToRow(item));
      }
    });
  }

  Future<(FoodLog?, List<FoodLogItem>)> _loadDailyLogFromCache(
    String gymId,
    DateTime date,
  ) async {
    date.toIso8601String().split('T')[0];
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return (null, <FoodLogItem>[]);

    final logRow =
        await (_db.select(_db.foodLogsTable)..where(
              (t) =>
                  t.clientId.equals(userId) &
                  t.gymId.equals(gymId) &
                  t.logDate.equals(date),
            ))
            .getSingleOrNull();

    if (logRow == null) {
      return (null, <FoodLogItem>[]);
    }

    final log = _rowToLog(logRow);

    final itemRows = await (_db.select(
      _db.foodLogItemsTable,
    )..where((t) => t.logId.equals(log.id))).get();

    final items = itemRows.map(_rowToLogItem).toList();

    return (log, items);
  }

  Future<List<FoodLog>> _loadLogHistoryFromCache(
    String gymId,
    DateTime from,
    DateTime to,
  ) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return [];

    final rows =
        await (_db.select(_db.foodLogsTable)
              ..where(
                (t) =>
                    t.clientId.equals(userId) &
                    t.gymId.equals(gymId) &
                    t.logDate.isBiggerOrEqualValue(from) &
                    t.logDate.isSmallerOrEqualValue(to),
              )
              ..orderBy([
                (t) => OrderingTerm(
                  expression: t.logDate,
                  mode: OrderingMode.desc,
                ),
              ]))
            .get();

    return rows.map(_rowToLog).toList();
  }

  FoodLogsTableCompanion _logToRow(FoodLog log) {
    return FoodLogsTableCompanion(
      id: Value(log.id),
      clientId: Value(log.clientId),
      gymId: Value(log.gymId),
      logDate: Value(log.logDate),
      totalCaloriesKcal: Value(log.totalCaloriesKcal),
      totalProteinG: Value(log.totalProteinG),
      totalCarbsG: Value(log.totalCarbsG),
      totalFatsG: Value(log.totalFatsG),
      notes: Value(log.notes),
      createdAt: Value(log.createdAt),
      updatedAt: Value(log.updatedAt),
    );
  }

  FoodLogItemsTableCompanion _logItemToRow(FoodLogItem item) {
    return FoodLogItemsTableCompanion(
      id: Value(item.id),
      logId: Value(item.logId),
      foodId: Value(item.foodId),
      mealType: Value(item.mealType.toDbValue()),
      quantity: Value(item.quantity),
      caloriesKcal: Value(item.caloriesKcal),
      proteinG: Value(item.proteinG),
      carbsG: Value(item.carbsG),
      fatsG: Value(item.fatsG),
      createdAt: Value(item.createdAt),
    );
  }

  FoodLog _rowToLog(dynamic row) {
    return FoodLog(
      id: row.id as String,
      clientId: row.clientId as String,
      gymId: row.gymId as String,
      logDate: row.logDate as DateTime,
      totalCaloriesKcal: row.totalCaloriesKcal as double,
      totalProteinG: row.totalProteinG as double,
      totalCarbsG: row.totalCarbsG as double,
      totalFatsG: row.totalFatsG as double,
      notes: row.notes as String?,
      createdAt: row.createdAt as DateTime,
      updatedAt: row.updatedAt as DateTime,
    );
  }

  FoodLogItem _rowToLogItem(dynamic row) {
    return FoodLogItem(
      id: row.id as String,
      logId: row.logId as String,
      foodId: row.foodId as String,
      mealType: MealType.fromDbValue(row.mealType as String),
      quantity: row.quantity as double,
      caloriesKcal: row.caloriesKcal as double,
      proteinG: row.proteinG as double,
      carbsG: row.carbsG as double,
      fatsG: row.fatsG as double,
      createdAt: row.createdAt as DateTime,
    );
  }
}
