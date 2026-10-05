import 'package:drift/drift.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/food.dart';
import '../../domain/entities/food_favorite.dart';

/// DataSource del catálogo de alimentos y favoritos.
/// Implementa patrón cache-first: lee de Drift si falla red.
class FoodRemoteDatasource {
  FoodRemoteDatasource(this._client, this._db);

  final SupabaseClient _client;
  final AppDatabase _db;

  // ═══════════════════════════════════════════════════════════════════════
  // MÉTODOS PÚBLICOS (patrón cache-first)
  // ═══════════════════════════════════════════════════════════════════════

  Future<List<Food>> searchFoods({
    required String query,
    required String gymId,
    int limit = 20,
  }) async {
    try {
      final response = await _client
          .from('foods')
          .select()
          .or('name.ilike.%$query%,brand.ilike.%$query%')
          .eq('is_active', true)
          .or('gym_id.eq.$gymId,gym_id.is.null')
          .order('is_system', ascending: false)
          .order('name')
          .limit(limit);

      final foods = (response as List)
          .map((row) => Food.fromJson(row as Map<String, dynamic>))
          .toList();

      await _cacheFoods(foods);
      return foods;
    } catch (e) {
      return _searchFoodsFromCache(query, gymId, limit);
    }
  }

  Future<List<Food>> fetchFoods({required String gymId, int limit = 50}) async {
    try {
      final response = await _client
          .from('foods')
          .select()
          .eq('is_active', true)
          .or('gym_id.eq.$gymId,gym_id.is.null')
          .order('is_system', ascending: false)
          .order('name')
          .limit(limit);

      final foods = (response as List)
          .map((row) => Food.fromJson(row as Map<String, dynamic>))
          .toList();

      await _cacheFoods(foods);
      return foods;
    } catch (e) {
      return _loadFoodsFromCache(gymId, limit);
    }
  }

  Future<Food> fetchFoodById(String foodId) async {
    try {
      final response = await _client
          .from('foods')
          .select()
          .eq('id', foodId)
          .single();

      final food = Food.fromJson(response);
      await _cacheFoods([food]);
      return food;
    } catch (e) {
      return _loadFoodFromCache(foodId);
    }
  }

  Future<Food> createFood(Food food) async {
    final response = await _client
        .from('foods')
        .insert(
          food.toJson()
            ..remove('id')
            ..remove('created_at')
            ..remove('updated_at'),
        )
        .select()
        .single();

    final created = Food.fromJson(response);
    await _cacheFoods([created]);
    return created;
  }

  Future<Food> updateFood(Food food) async {
    final response = await _client
        .from('foods')
        .update({
          'name': food.name,
          'brand': food.brand,
          'barcode': food.barcode,
          'serving_size': food.servingSize,
          'serving_unit': food.servingUnit,
          'calories_kcal': food.caloriesKcal,
          'protein_g': food.proteinG,
          'carbs_g': food.carbsG,
          'fats_g': food.fatsG,
          'fiber_g': food.fiberG,
          'sugar_g': food.sugarG,
          'sodium_mg': food.sodiumMg,
          'image_url': food.imageUrl,
        })
        .eq('id', food.id)
        .select()
        .single();

    final updated = Food.fromJson(response);
    await _cacheFoods([updated]);
    return updated;
  }

  Future<void> deactivateFood(String foodId) async {
    await _client.from('foods').update({'is_active': false}).eq('id', foodId);

    // CORREGIDO: Sintaxis correcta de Drift update
    await (_db.update(_db.foodsTable)..where((t) => t.id.equals(foodId))).write(
      const FoodsTableCompanion(isActive: Value(false)),
    );
  }

  Future<List<FoodFavorite>> fetchFavorites(String clientId) async {
    final response = await _client
        .from('food_favorites')
        .select()
        .eq('client_id', clientId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((row) => FoodFavorite.fromJson(row as Map<String, dynamic>))
        .toList();
  }

  Future<bool> toggleFavorite({
    required String clientId,
    required String foodId,
  }) async {
    final existing = await _client
        .from('food_favorites')
        .select('id')
        .eq('client_id', clientId)
        .eq('food_id', foodId)
        .maybeSingle();

    if (existing != null) {
      await _client
          .from('food_favorites')
          .delete()
          .eq('id', existing['id'] as String);
      return false;
    } else {
      await _client.from('food_favorites').insert({
        'client_id': clientId,
        'food_id': foodId,
      });
      return true;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════
  // MÉTODOS PRIVADOS (cache Drift)
  // ═══════════════════════════════════════════════════════════════════════

  Future<void> _cacheFoods(List<Food> foods) async {
    await _db.transaction(() async {
      for (final food in foods) {
        await _db.foodsTable.insertOnConflictUpdate(_foodToRow(food));
      }
    });
  }

  Future<List<Food>> _searchFoodsFromCache(
    String query,
    String gymId,
    int limit,
  ) async {
    final results =
        await (_db.select(_db.foodsTable)
              ..where(
                (t) =>
                    t.isActive.equals(true) &
                    (t.gymId.equals(gymId) | t.gymId.isNull()) &
                    (t.name.like('%$query%') | t.brand.like('%$query%')),
              )
              ..orderBy([
                (t) => OrderingTerm(
                  expression: t.isSystem,
                  mode: OrderingMode.desc,
                ),
                (t) => OrderingTerm(expression: t.name),
              ])
              ..limit(limit))
            .get();

    return results.map(_rowToFood).toList();
  }

  Future<List<Food>> _loadFoodsFromCache(String gymId, int limit) async {
    final results =
        await (_db.select(_db.foodsTable)
              ..where(
                (t) =>
                    t.isActive.equals(true) &
                    (t.gymId.equals(gymId) | t.gymId.isNull()),
              )
              ..orderBy([
                (t) => OrderingTerm(
                  expression: t.isSystem,
                  mode: OrderingMode.desc,
                ),
                (t) => OrderingTerm(expression: t.name),
              ])
              ..limit(limit))
            .get();

    return results.map(_rowToFood).toList();
  }

  // ═══════════════════════════════════════════════════════════════════════
  // MAPPERS (Drift ↔ Entity)
  // ═══════════════════════════════════════════════════════════════════════

  FoodsTableCompanion _foodToRow(Food food) {
    return FoodsTableCompanion(
      id: Value(food.id),
      gymId: Value(food.gymId),
      name: Value(food.name),
      brand: Value(food.brand),
      barcode: Value(food.barcode),
      servingSize: Value(food.servingSize),
      servingUnit: Value(food.servingUnit),
      caloriesKcal: Value(food.caloriesKcal),
      proteinG: Value(food.proteinG),
      carbsG: Value(food.carbsG),
      fatsG: Value(food.fatsG),
      fiberG: Value(food.fiberG),
      sugarG: Value(food.sugarG),
      sodiumMg: Value(food.sodiumMg),
      isVerified: Value(food.isVerified),
      isSystem: Value(food.isSystem),
      createdBy: Value(food.createdBy),
      source: Value(food.source),
      externalId: Value(food.externalId),
      imageUrl: Value(food.imageUrl),
      isActive: Value(food.isActive),
      createdAt: Value(food.createdAt),
      updatedAt: Value(food.updatedAt),
    );
  }

  // CORREGIDO: Usar dynamic para evitar conflictos de tipos
  Food _rowToFood(dynamic row) {
    return Food(
      id: row.id as String,
      gymId: row.gymId as String?,
      name: row.name as String,
      brand: row.brand as String?,
      barcode: row.barcode as String?,
      servingSize: row.servingSize as double,
      servingUnit: row.servingUnit as String,
      caloriesKcal: row.caloriesKcal as double,
      proteinG: row.proteinG as double,
      carbsG: row.carbsG as double,
      fatsG: row.fatsG as double,
      fiberG: row.fiberG as double?,
      sugarG: row.sugarG as double?,
      sodiumMg: row.sodiumMg as double?,
      isVerified: row.isVerified as bool,
      isSystem: row.isSystem as bool,
      createdBy: row.createdBy as String?,
      source: row.source as String,
      externalId: row.externalId as String?,
      imageUrl: row.imageUrl as String?,
      isActive: row.isActive as bool,
      createdAt: row.createdAt as DateTime,
      updatedAt: row.updatedAt as DateTime,
    );
  }

  Future<Food> _loadFoodFromCache(String foodId) async {
    final row = await (_db.select(
      _db.foodsTable,
    )..where((t) => t.id.equals(foodId))).getSingleOrNull();

    if (row == null) {
      throw Exception('Food not found in cache: $foodId');
    }

    return _rowToFood(row);
  }
}
