import 'package:equatable/equatable.dart';

/// Relación entre plantilla de comida y alimento (tabla `meal_template_foods`).
class MealTemplateFood extends Equatable {
  const MealTemplateFood({
    required this.id,
    required this.mealTemplateId,
    required this.foodId,
    required this.quantity,
    required this.orderIndex,
    required this.createdAt,
    this.notes,
  });

  final String id;
  final String mealTemplateId;
  final String foodId;
  final double quantity;
  final int orderIndex;
  final String? notes;
  final DateTime createdAt;

  MealTemplateFood copyWith({
    String? id,
    String? mealTemplateId,
    String? foodId,
    double? quantity,
    int? orderIndex,
    String? notes,
    DateTime? createdAt,
    bool clearNotes = false,
  }) {
    return MealTemplateFood(
      id: id ?? this.id,
      mealTemplateId: mealTemplateId ?? this.mealTemplateId,
      foodId: foodId ?? this.foodId,
      quantity: quantity ?? this.quantity,
      orderIndex: orderIndex ?? this.orderIndex,
      notes: clearNotes ? null : (notes ?? this.notes),
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory MealTemplateFood.fromJson(Map<String, dynamic> json) {
    return MealTemplateFood(
      id: json['id'] as String,
      mealTemplateId: json['meal_template_id'] as String,
      foodId: json['food_id'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      orderIndex: json['order_index'] as int,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'meal_template_id': mealTemplateId,
      'food_id': foodId,
      'quantity': quantity,
      'order_index': orderIndex,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, mealTemplateId, foodId, quantity, orderIndex];
}
