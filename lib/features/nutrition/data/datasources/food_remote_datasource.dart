import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/food.dart';

/// Fuente remota de alimentos (Supabase).
/// Usa borrado lógico (is_active = false) para preservar integridad referencial.
class FoodsRemoteDatasource {
  final SupabaseClient _client;

  const FoodsRemoteDatasource(this._client);

  /// Obtiene alimentos activos del sistema + personalizados del gym.
  Future<List<Food>> fetchFoods(String gymId) async {
    try {
      final response = await _client
          .from('foods')
          .select()
          .eq('is_active', true)
          .or('is_system.eq.true,gym_id.is.null,gym_id.eq.$gymId')
          .order('is_system', ascending: false)
          .order('name', ascending: true);

      return response.map((e) => Food.fromJson(e)).toList();
    } catch (e, stack) {
      debugPrint('❌ FOODS fetchFoods: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Obtiene un alimento por ID.
  Future<Food> fetchFoodById(String foodId) async {
    try {
      final response = await _client
          .from('foods')
          .select()
          .eq('id', foodId)
          .eq('is_active', true)
          .single();
      return Food.fromJson(response);
    } catch (e, stack) {
      debugPrint('❌ FOODS fetchFoodById: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Búsqueda por nombre (case-insensitive, usa índice trigram).
  Future<List<Food>> searchFoods(String gymId, String query) async {
    try {
      final response = await _client
          .from('foods')
          .select()
          .eq('is_active', true)
          .or('is_system.eq.true,gym_id.is.null,gym_id.eq.$gymId')
          .ilike('name', '%$query%')
          .order('is_system', ascending: false)
          .order('name', ascending: true)
          .limit(50);

      return response.map((e) => Food.fromJson(e)).toList();
    } catch (e, stack) {
      debugPrint('❌ FOODS searchFoods: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Crea un alimento personalizado del gym (source = 'custom').
  Future<Food> createFood({
    required String gymId,
    required String name,
    String? brand,
    String? barcode,
    required double servingSize,
    required String servingUnit,
    required double caloriesKcal,
    required double proteinG,
    required double carbsG,
    required double fatsG,
    double? fiberG,
    double? sugarG,
    double? sodiumMg,
  }) async {
    try {
      final response = await _client
          .from('foods')
          .insert({
            'gym_id': gymId,
            'name': name,
            'brand': brand,
            'barcode': barcode,
            'serving_size': servingSize,
            'serving_unit': servingUnit,
            'calories_kcal': caloriesKcal,
            'protein_g': proteinG,
            'carbs_g': carbsG,
            'fats_g': fatsG,
            'fiber_g': fiberG,
            'sugar_g': sugarG,
            'sodium_mg': sodiumMg,
            'is_system': false,
            'is_active': true,
            'source': 'custom',
          })
          .select()
          .single();

      return Food.fromJson(response);
    } catch (e, stack) {
      debugPrint('❌ FOODS createFood: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Actualiza un alimento.
  Future<Food> updateFood(Food food) async {
    try {
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
    } catch (e, stack) {
      debugPrint('❌ FOODS updateFood: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Borrado lógico: desactiva el alimento sin eliminarlo.
  /// Preserva integridad con meal_template_foods y food_log_items.
  Future<void> deleteFood(String foodId) async {
    try {
      await _client.from('foods').update({'is_active': false}).eq('id', foodId);
    } catch (e, stack) {
      debugPrint('❌ FOODS deleteFood: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }
}
