import 'package:equatable/equatable.dart';

import '../enums/meal_type.dart';

/// Plantilla de comida reutilizable (tabla `meal_templates`).
/// Los totales se recalculan con trigger al cambiar los foods.
class MealTemplate extends Equatable {
  const MealTemplate({
    required this.id,
    required this.gymId,
    required this.nutritionistId,
    required this.name,
    required this.mealType,
    required this.totalCaloriesKcal,
    required this.totalProteinG,
    required this.totalCarbsG,
    required this.totalFatsG,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String gymId;
  final String nutritionistId;
  final String name;
  final MealType mealType;
  final double totalCaloriesKcal;
  final double totalProteinG;
  final double totalCarbsG;
  final double totalFatsG;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  MealTemplate copyWith({
    String? id,
    String? gymId,
    String? nutritionistId,
    String? name,
    MealType? mealType,
    double? totalCaloriesKcal,
    double? totalProteinG,
    double? totalCarbsG,
    double? totalFatsG,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MealTemplate(
      id: id ?? this.id,
      gymId: gymId ?? this.gymId,
      nutritionistId: nutritionistId ?? this.nutritionistId,
      name: name ?? this.name,
      mealType: mealType ?? this.mealType,
      totalCaloriesKcal: totalCaloriesKcal ?? this.totalCaloriesKcal,
      totalProteinG: totalProteinG ?? this.totalProteinG,
      totalCarbsG: totalCarbsG ?? this.totalCarbsG,
      totalFatsG: totalFatsG ?? this.totalFatsG,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory MealTemplate.fromJson(Map<String, dynamic> json) {
    return MealTemplate(
      id: json['id'] as String,
      gymId: json['gym_id'] as String,
      nutritionistId: json['nutritionist_id'] as String,
      name: json['name'] as String,
      mealType: MealType.fromDbValue(json['meal_type'] as String),
      totalCaloriesKcal: (json['total_calories_kcal'] as num).toDouble(),
      totalProteinG: (json['total_protein_g'] as num).toDouble(),
      totalCarbsG: (json['total_carbs_g'] as num).toDouble(),
      totalFatsG: (json['total_fats_g'] as num).toDouble(),
      isActive: json['is_active'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gym_id': gymId,
      'nutritionist_id': nutritionistId,
      'name': name,
      'meal_type': mealType.toDbValue(),
      'total_calories_kcal': totalCaloriesKcal,
      'total_protein_g': totalProteinG,
      'total_carbs_g': totalCarbsG,
      'total_fats_g': totalFatsG,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    mealType,
    totalCaloriesKcal,
    totalProteinG,
    totalCarbsG,
    totalFatsG,
  ];
}
