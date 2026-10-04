import 'package:equatable/equatable.dart';

import '../enums/goal_type.dart';

/// Metas macro de un cliente (tabla `nutrition_goals`).
class NutritionGoal extends Equatable {
  const NutritionGoal({
    required this.id,
    required this.clientId,
    required this.gymId,
    required this.targetCaloriesKcal,
    required this.targetProteinG,
    required this.targetCarbsG,
    required this.targetFatsG,
    required this.goalType,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.setBy,
    this.notes,
  });

  final String id;
  final String clientId;
  final String gymId;
  final String? setBy;
  final double targetCaloriesKcal;
  final double targetProteinG;
  final double targetCarbsG;
  final double targetFatsG;
  final GoalType goalType;
  final String? notes;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  NutritionGoal copyWith({
    String? id,
    String? clientId,
    String? gymId,
    String? setBy,
    double? targetCaloriesKcal,
    double? targetProteinG,
    double? targetCarbsG,
    double? targetFatsG,
    GoalType? goalType,
    String? notes,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool clearSetBy = false,
    bool clearNotes = false,
  }) {
    return NutritionGoal(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      gymId: gymId ?? this.gymId,
      setBy: clearSetBy ? null : (setBy ?? this.setBy),
      targetCaloriesKcal: targetCaloriesKcal ?? this.targetCaloriesKcal,
      targetProteinG: targetProteinG ?? this.targetProteinG,
      targetCarbsG: targetCarbsG ?? this.targetCarbsG,
      targetFatsG: targetFatsG ?? this.targetFatsG,
      goalType: goalType ?? this.goalType,
      notes: clearNotes ? null : (notes ?? this.notes),
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory NutritionGoal.fromJson(Map<String, dynamic> json) {
    return NutritionGoal(
      id: json['id'] as String,
      clientId: json['client_id'] as String,
      gymId: json['gym_id'] as String,
      setBy: json['set_by'] as String?,
      targetCaloriesKcal: (json['target_calories_kcal'] as num).toDouble(),
      targetProteinG: (json['target_protein_g'] as num).toDouble(),
      targetCarbsG: (json['target_carbs_g'] as num).toDouble(),
      targetFatsG: (json['target_fats_g'] as num).toDouble(),
      goalType: GoalType.fromDbValue(json['goal_type'] as String),
      notes: json['notes'] as String?,
      isActive: json['is_active'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_id': clientId,
      'gym_id': gymId,
      'set_by': setBy,
      'target_calories_kcal': targetCaloriesKcal,
      'target_protein_g': targetProteinG,
      'target_carbs_g': targetCarbsG,
      'target_fats_g': targetFatsG,
      'goal_type': goalType.toDbValue(),
      'notes': notes,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
    id,
    clientId,
    targetCaloriesKcal,
    targetProteinG,
    targetCarbsG,
    targetFatsG,
    goalType,
  ];
}
