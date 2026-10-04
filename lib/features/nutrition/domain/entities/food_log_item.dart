import 'package:equatable/equatable.dart';

import '../enums/meal_type.dart';

/// Ítem de comida dentro de un log diario (tabla `food_log_items`).
/// Los macros son snapshot al momento de agregar (no se recalculan si cambia el food).
class FoodLogItem extends Equatable {
  const FoodLogItem({
    required this.id,
    required this.logId,
    required this.foodId,
    required this.mealType,
    required this.quantity,
    required this.caloriesKcal,
    required this.proteinG,
    required this.carbsG,
    required this.fatsG,
    required this.createdAt,
  });

  final String id;
  final String logId;
  final String foodId;
  final MealType mealType;
  final double quantity;
  final double caloriesKcal;
  final double proteinG;
  final double carbsG;
  final double fatsG;
  final DateTime createdAt;

  FoodLogItem copyWith({
    String? id,
    String? logId,
    String? foodId,
    MealType? mealType,
    double? quantity,
    double? caloriesKcal,
    double? proteinG,
    double? carbsG,
    double? fatsG,
    DateTime? createdAt,
  }) {
    return FoodLogItem(
      id: id ?? this.id,
      logId: logId ?? this.logId,
      foodId: foodId ?? this.foodId,
      mealType: mealType ?? this.mealType,
      quantity: quantity ?? this.quantity,
      caloriesKcal: caloriesKcal ?? this.caloriesKcal,
      proteinG: proteinG ?? this.proteinG,
      carbsG: carbsG ?? this.carbsG,
      fatsG: fatsG ?? this.fatsG,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory FoodLogItem.fromJson(Map<String, dynamic> json) {
    return FoodLogItem(
      id: json['id'] as String,
      logId: json['log_id'] as String,
      foodId: json['food_id'] as String,
      mealType: MealType.fromDbValue(json['meal_type'] as String),
      quantity: (json['quantity'] as num).toDouble(),
      caloriesKcal: (json['calories_kcal'] as num).toDouble(),
      proteinG: (json['protein_g'] as num).toDouble(),
      carbsG: (json['carbs_g'] as num).toDouble(),
      fatsG: (json['fats_g'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'log_id': logId,
      'food_id': foodId,
      'meal_type': mealType.toDbValue(),
      'quantity': quantity,
      'calories_kcal': caloriesKcal,
      'protein_g': proteinG,
      'carbs_g': carbsG,
      'fats_g': fatsG,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, logId, foodId, mealType, quantity];
}
