import 'package:equatable/equatable.dart';

/// Plan nutricional asignado a un cliente (tabla `nutrition_plans`).
class NutritionPlan extends Equatable {
  const NutritionPlan({
    required this.id,
    required this.gymId,
    required this.clientId,
    required this.nutritionistId,
    required this.name,
    required this.targetCaloriesKcal,
    required this.targetProteinG,
    required this.targetCarbsG,
    required this.targetFatsG,
    required this.durationDays,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.goal,
    this.notes,
  });

  final String id;
  final String gymId;
  final String clientId;
  final String nutritionistId;
  final String name;
  final String? goal;
  final double targetCaloriesKcal;
  final double targetProteinG;
  final double targetCarbsG;
  final double targetFatsG;
  final int durationDays;
  final String? notes;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  NutritionPlan copyWith({
    String? id,
    String? gymId,
    String? clientId,
    String? nutritionistId,
    String? name,
    String? goal,
    double? targetCaloriesKcal,
    double? targetProteinG,
    double? targetCarbsG,
    double? targetFatsG,
    int? durationDays,
    String? notes,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool clearGoal = false,
    bool clearNotes = false,
  }) {
    return NutritionPlan(
      id: id ?? this.id,
      gymId: gymId ?? this.gymId,
      clientId: clientId ?? this.clientId,
      nutritionistId: nutritionistId ?? this.nutritionistId,
      name: name ?? this.name,
      goal: clearGoal ? null : (goal ?? this.goal),
      targetCaloriesKcal: targetCaloriesKcal ?? this.targetCaloriesKcal,
      targetProteinG: targetProteinG ?? this.targetProteinG,
      targetCarbsG: targetCarbsG ?? this.targetCarbsG,
      targetFatsG: targetFatsG ?? this.targetFatsG,
      durationDays: durationDays ?? this.durationDays,
      notes: clearNotes ? null : (notes ?? this.notes),
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory NutritionPlan.fromJson(Map<String, dynamic> json) {
    return NutritionPlan(
      id: json['id'] as String,
      gymId: json['gym_id'] as String,
      clientId: json['client_id'] as String,
      nutritionistId: json['nutritionist_id'] as String,
      name: json['name'] as String,
      goal: json['goal'] as String?,
      targetCaloriesKcal: (json['target_calories_kcal'] as num).toDouble(),
      targetProteinG: (json['target_protein_g'] as num).toDouble(),
      targetCarbsG: (json['target_carbs_g'] as num).toDouble(),
      targetFatsG: (json['target_fats_g'] as num).toDouble(),
      durationDays: json['duration_days'] as int,
      notes: json['notes'] as String?,
      isActive: json['is_active'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gym_id': gymId,
      'client_id': clientId,
      'nutritionist_id': nutritionistId,
      'name': name,
      'goal': goal,
      'target_calories_kcal': targetCaloriesKcal,
      'target_protein_g': targetProteinG,
      'target_carbs_g': targetCarbsG,
      'target_fats_g': targetFatsG,
      'duration_days': durationDays,
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
    nutritionistId,
    name,
    targetCaloriesKcal,
    durationDays,
    isActive,
  ];
}
