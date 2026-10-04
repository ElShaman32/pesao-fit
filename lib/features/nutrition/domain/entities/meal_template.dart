import 'package:equatable/equatable.dart';

import 'meal_type.dart';

/// Plantilla de comida reutilizable creada por el nutricionista.
/// POCO + Equatable (ADR-037). Mapea la tabla `meal_templates`.
///
/// Los totales se recalculan con recalc_meal_template_totals()
/// cada vez que se agregan/quitan alimentos.
class MealTemplate extends Equatable {
  final String id;
  final String gymId;
  final String nutritionistId;
  final String name;
  final MealType mealType;

  // --- Totales precalculados por recalc_meal_template_totals() ---
  final double totalCaloriesKcal;
  final double totalProteinG;
  final double totalCarbsG;
  final double totalFatsG;

  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MealTemplate({
    required this.id,
    required this.gymId,
    required this.nutritionistId,
    required this.name,
    required this.mealType,
    this.totalCaloriesKcal = 0,
    this.totalProteinG = 0,
    this.totalCarbsG = 0,
    this.totalFatsG = 0,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MealTemplate.fromJson(Map<String, dynamic> json) {
    return MealTemplate(
      id: json['id'] as String,
      gymId: json['gym_id'] as String,
      nutritionistId: json['nutritionist_id'] as String,
      name: json['name'] as String,
      mealType: MealType.fromDb(json['meal_type'] as String?),
      totalCaloriesKcal: (json['total_calories_kcal'] as num?)?.toDouble() ?? 0,
      totalProteinG: (json['total_protein_g'] as num?)?.toDouble() ?? 0,
      totalCarbsG: (json['total_carbs_g'] as num?)?.toDouble() ?? 0,
      totalFatsG: (json['total_fats_g'] as num?)?.toDouble() ?? 0,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  MealTemplate copyWith({String? name, MealType? mealType, bool? isActive}) {
    return MealTemplate(
      id: id,
      gymId: gymId,
      nutritionistId: nutritionistId,
      name: name ?? this.name,
      mealType: mealType ?? this.mealType,
      totalCaloriesKcal: totalCaloriesKcal,
      totalProteinG: totalProteinG,
      totalCarbsG: totalCarbsG,
      totalFatsG: totalFatsG,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    gymId,
    nutritionistId,
    name,
    mealType,
    totalCaloriesKcal,
    totalProteinG,
    totalCarbsG,
    totalFatsG,
    isActive,
    createdAt,
    updatedAt,
  ];
}

/// Alimento dentro de un meal_template con su cantidad.
/// POCO + Equatable (ADR-037). Mapea la tabla `meal_template_foods`.
///
/// UNIQUE(meal_template_id, food_id) en BD:
/// un alimento solo aparece una vez por template.
class MealTemplateFood extends Equatable {
  final String id;
  final String mealTemplateId;
  final String foodId;
  final double quantity;
  final int orderIndex;
  final String? notes;
  final DateTime createdAt;

  /// Nombre del alimento (denormalizado para display sin JOIN).
  final String? foodName;

  const MealTemplateFood({
    required this.id,
    required this.mealTemplateId,
    required this.foodId,
    required this.quantity,
    this.orderIndex = 0,
    this.notes,
    required this.createdAt,
    this.foodName,
  });

  factory MealTemplateFood.fromJson(Map<String, dynamic> json) {
    return MealTemplateFood(
      id: json['id'] as String,
      mealTemplateId: json['meal_template_id'] as String,
      foodId: json['food_id'] as String,
      quantity: (json['quantity'] as num?)?.toDouble() ?? 0,
      orderIndex: (json['order_index'] as num?)?.toInt() ?? 0,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      foodName: json['food_name'] as String?,
    );
  }

  MealTemplateFood copyWith({
    double? quantity,
    int? orderIndex,
    String? notes,
  }) {
    return MealTemplateFood(
      id: id,
      mealTemplateId: mealTemplateId,
      foodId: foodId,
      quantity: quantity ?? this.quantity,
      orderIndex: orderIndex ?? this.orderIndex,
      notes: notes ?? this.notes,
      createdAt: createdAt,
      foodName: foodName,
    );
  }

  @override
  List<Object?> get props => [
    id,
    mealTemplateId,
    foodId,
    quantity,
    orderIndex,
    notes,
    createdAt,
    foodName,
  ];
}
