import 'package:equatable/equatable.dart';

/// Comida asignada a un día del plan (tabla `nutrition_plan_meals`).
/// Referencia una MealTemplate (no copia los datos).
class NutritionPlanMeal extends Equatable {
  const NutritionPlanMeal({
    required this.id,
    required this.planDayId,
    required this.mealTemplateId,
    required this.mealOrder,
    required this.createdAt,
  });

  final String id;
  final String planDayId;
  final String mealTemplateId;
  final int mealOrder;
  final DateTime createdAt;

  NutritionPlanMeal copyWith({
    String? id,
    String? planDayId,
    String? mealTemplateId,
    int? mealOrder,
    DateTime? createdAt,
  }) {
    return NutritionPlanMeal(
      id: id ?? this.id,
      planDayId: planDayId ?? this.planDayId,
      mealTemplateId: mealTemplateId ?? this.mealTemplateId,
      mealOrder: mealOrder ?? this.mealOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory NutritionPlanMeal.fromJson(Map<String, dynamic> json) {
    return NutritionPlanMeal(
      id: json['id'] as String,
      planDayId: json['plan_day_id'] as String,
      mealTemplateId: json['meal_template_id'] as String,
      mealOrder: json['meal_order'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plan_day_id': planDayId,
      'meal_template_id': mealTemplateId,
      'meal_order': mealOrder,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, planDayId, mealTemplateId, mealOrder];
}
