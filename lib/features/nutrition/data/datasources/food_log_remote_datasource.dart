import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/food_log.dart';
import '../../domain/entities/food_log_item.dart';
import '../../domain/enums/meal_type.dart';

/// DataSource del registro diario de comidas.
/// Usa RPCs de Supabase: get_daily_food_log, add_food_to_log.
class FoodLogRemoteDatasource {
  FoodLogRemoteDatasource(this._client);

  final SupabaseClient _client;

  /// Obtiene el log del día con sus items (usa RPC get_daily_food_log).
  Future<(FoodLog?, List<FoodLogItem>)> fetchDailyLog({
    required String gymId,
    required DateTime date,
  }) async {
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
        createdAt:
            DateTime.now(), // No viene en la RPC, usar now como fallback.
      );
    }).toList();

    return (log, items);
  }

  /// Obtiene logs de un rango de fechas (para historial/gráficos).
  Future<List<FoodLog>> fetchLogHistory({
    required String gymId,
    required DateTime from,
    required DateTime to,
  }) async {
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

    return (response as List)
        .map((row) => FoodLog.fromJson(row as Map<String, dynamic>))
        .toList();
  }

  /// Agrega un alimento al log del día (usa RPC add_food_to_log).
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

    // Retornar el item creado (necesitamos el food para los macros snapshot).
    final food = await _client.from('foods').select().eq('id', foodId).single();

    final foodMap = food;
    final factor = quantity / (foodMap['serving_size'] as num).toDouble();

    return FoodLogItem(
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
  }

  /// Elimina un item del log.
  Future<void> removeLogItem(String itemId) async {
    await _client.from('food_log_items').delete().eq('id', itemId);
  }

  /// Actualiza la cantidad de un item (recalcula macros proporcionalmente).
  Future<FoodLogItem> updateLogItemQuantity({
    required String itemId,
    required double newQuantity,
  }) async {
    // Obtener el item actual para saber el food_id.
    final itemResponse = await _client
        .from('food_log_items')
        .select()
        .eq('id', itemId)
        .single();

    final itemMap = itemResponse;
    final foodId = itemMap['food_id'] as String;

    // Obtener el food para recalcular macros.
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

    // Actualizar el item.
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

    return FoodLogItem.fromJson(updatedResponse);
  }

  /// Actualiza las notas del log del día.
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

    return FoodLog.fromJson(response);
  }
}
