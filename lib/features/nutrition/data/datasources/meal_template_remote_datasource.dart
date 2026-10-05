import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/meal_template.dart';
import '../../domain/entities/meal_template_food.dart';
import '../../domain/enums/meal_type.dart';

/// DataSource de plantillas de comida del nutricionista.
/// Implementa patrón cache-first.
class MealTemplateRemoteDatasource {
  MealTemplateRemoteDatasource(this._client);

  final SupabaseClient _client;

  Future<List<MealTemplate>> fetchTemplates({
    required String gymId,
    MealType? filterByMealType,
    int limit = 50,
  }) async {
    try {
      var filter = _client
          .from('meal_templates')
          .select()
          .eq('gym_id', gymId)
          .eq('is_active', true);

      if (filterByMealType != null) {
        filter = filter.eq('meal_type', filterByMealType.toDbValue());
      }

      final response = await filter
          .order('created_at', ascending: false)
          .limit(limit);

      final templates = (response as List)
          .map((row) => MealTemplate.fromJson(row as Map<String, dynamic>))
          .toList();

      // Nota: No cacheamos templates en Drift (solo se usan con conexión)
      // Si necesitas offline, descomenta las líneas de cache
      // await _cacheTemplates(templates);

      return templates;
    } catch (e) {
      // Si necesitas offline, implementa _loadTemplatesFromCache
      return [];
    }
  }

  Future<(MealTemplate, List<MealTemplateFood>)> fetchTemplateDetail(
    String templateId,
  ) async {
    try {
      final templateResponse = await _client
          .from('meal_templates')
          .select()
          .eq('id', templateId)
          .single();

      final template = MealTemplate.fromJson(templateResponse);

      final foodsResponse = await _client
          .from('meal_template_foods')
          .select()
          .eq('meal_template_id', templateId)
          .order('order_index');

      final foods = (foodsResponse as List)
          .map((row) => MealTemplateFood.fromJson(row as Map<String, dynamic>))
          .toList();

      return (template, foods);
    } catch (e) {
      // Si necesitas offline, implementa fallback a cache
      rethrow;
    }
  }

  Future<MealTemplate> createTemplate(MealTemplate template) async {
    final response = await _client
        .from('meal_templates')
        .insert({
          'gym_id': template.gymId,
          'nutritionist_id': template.nutritionistId,
          'name': template.name,
          'meal_type': template.mealType.toDbValue(),
          'total_calories_kcal': 0,
          'total_protein_g': 0,
          'total_carbs_g': 0,
          'total_fats_g': 0,
        })
        .select()
        .single();

    return MealTemplate.fromJson(response);
  }

  Future<MealTemplate> updateTemplate(MealTemplate template) async {
    final response = await _client
        .from('meal_templates')
        .update({
          'name': template.name,
          'meal_type': template.mealType.toDbValue(),
        })
        .eq('id', template.id)
        .select()
        .single();

    return MealTemplate.fromJson(response);
  }

  Future<void> deactivateTemplate(String templateId) async {
    await _client
        .from('meal_templates')
        .update({'is_active': false})
        .eq('id', templateId);
  }

  Future<MealTemplateFood> addFoodToTemplate({
    required String templateId,
    required String foodId,
    required double quantity,
    int orderIndex = 0,
    String? notes,
  }) async {
    final response = await _client
        .from('meal_template_foods')
        .insert({
          'meal_template_id': templateId,
          'food_id': foodId,
          'quantity': quantity,
          'order_index': orderIndex,
          'notes': notes,
        })
        .select()
        .single();

    return MealTemplateFood.fromJson(response);
  }

  Future<MealTemplateFood> updateTemplateFood({
    required String templateFoodId,
    required double newQuantity,
    String? notes,
  }) async {
    final updateData = <String, dynamic>{'quantity': newQuantity};
    if (notes != null) {
      updateData['notes'] = notes;
    }

    final response = await _client
        .from('meal_template_foods')
        .update(updateData)
        .eq('id', templateFoodId)
        .select()
        .single();

    return MealTemplateFood.fromJson(response);
  }

  Future<void> removeFoodFromTemplate(String templateFoodId) async {
    await _client.from('meal_template_foods').delete().eq('id', templateFoodId);
  }
}
