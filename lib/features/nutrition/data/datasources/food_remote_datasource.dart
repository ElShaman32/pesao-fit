import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/food.dart';
import '../../domain/entities/food_favorite.dart';

/// DataSource del catálogo de alimentos y favoritos.
class FoodRemoteDatasource {
  FoodRemoteDatasource(this._client);

  final SupabaseClient _client;

  /// Busca alimentos por nombre/marca (global + del gimnasio).
  Future<List<Food>> searchFoods({
    required String query,
    required String gymId,
    int limit = 20,
  }) async {
    final response = await _client
        .from('foods')
        .select()
        .or('name.ilike.%$query%,brand.ilike.%$query%')
        .eq('is_active', true)
        .or('gym_id.eq.$gymId,gym_id.is.null')
        .order('is_system', ascending: false)
        .order('name')
        .limit(limit);

    return (response as List)
        .map((row) => Food.fromJson(row as Map<String, dynamic>))
        .toList();
  }

  /// Obtiene todos los alimentos activos (global + gimnasio).
  Future<List<Food>> fetchFoods({required String gymId, int limit = 50}) async {
    final response = await _client
        .from('foods')
        .select()
        .eq('is_active', true)
        .or('gym_id.eq.$gymId,gym_id.is.null')
        .order('is_system', ascending: false)
        .order('name')
        .limit(limit);

    return response.map((json) => Food.fromJson(json)).toList();
  }

  /// Obtiene un alimento por ID.
  Future<Food> fetchFoodById(String foodId) async {
    final response = await _client
        .from('foods')
        .select()
        .eq('id', foodId)
        .single();

    return Food.fromJson(response);
  }

  /// Crea un alimento del gimnasio.
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

    return Food.fromJson(response);
  }

  /// Actualiza un alimento.
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

    return Food.fromJson(response);
  }

  /// Desactiva un alimento (soft delete).
  Future<void> deactivateFood(String foodId) async {
    await _client.from('foods').update({'is_active': false}).eq('id', foodId);
  }

  /// Obtiene los alimentos favoritos del cliente.
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

  /// Toggle favorito. Retorna true si quedó como favorito.
  Future<bool> toggleFavorite({
    required String clientId,
    required String foodId,
  }) async {
    // Verificar si ya existe.
    final existing = await _client
        .from('food_favorites')
        .select('id')
        .eq('client_id', clientId)
        .eq('food_id', foodId)
        .maybeSingle();

    if (existing != null) {
      // Ya existe → eliminar.
      await _client
          .from('food_favorites')
          .delete()
          .eq('id', existing['id'] as String);
      return false;
    } else {
      // No existe → crear.
      await _client.from('food_favorites').insert({
        'client_id': clientId,
        'food_id': foodId,
      });
      return true;
    }
  }
}
