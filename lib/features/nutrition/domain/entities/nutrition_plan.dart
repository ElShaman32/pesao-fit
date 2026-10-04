import 'package:equatable/equatable.dart';

/// Plan nutricional asignado a un cliente.
/// POCO + Equatable (ADR-037). Mapea la tabla `nutrition_plans`.
///
/// Nota: los targets aquí son INTEGER en BD (a diferencia de
/// nutrition_goals que usa numeric). Se mapean a int.
class NutritionPlan extends Equatable {
  final String id;
  final String gymId;
  final String clientId;
  final String nutritionistId;
  final String name;

  /// Objetivo textual libre: "Perder grasa", "Aumentar masa", etc.
  final String? goal;

  // --- Targets integrados en el plan (integer en BD) ---
  final int targetCaloriesKcal;
  final int targetProteinG;
  final int targetCarbsG;
  final int targetFatsG;

  /// Duración del plan en días (default 7 en BD).
  final int durationDays;

  final String? notes;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const NutritionPlan({
    required this.id,
    required this.gymId,
    required this.clientId,
    required this.nutritionistId,
    required this.name,
    this.goal,
    required this.targetCaloriesKcal,
    required this.targetProteinG,
    required this.targetCarbsG,
    required this.targetFatsG,
    this.durationDays = 7,
    this.notes,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NutritionPlan.fromJson(Map<String, dynamic> json) {
    return NutritionPlan(
      id: json['id'] as String,
      gymId: json['gym_id'] as String,
      clientId: json['client_id'] as String,
      nutritionistId: json['nutritionist_id'] as String,
      name: json['name'] as String,
      goal: json['goal'] as String?,
      targetCaloriesKcal: (json['target_calories_kcal'] as num?)?.toInt() ?? 0,
      targetProteinG: (json['target_protein_g'] as num?)?.toInt() ?? 0,
      targetCarbsG: (json['target_carbs_g'] as num?)?.toInt() ?? 0,
      targetFatsG: (json['target_fats_g'] as num?)?.toInt() ?? 0,
      durationDays: (json['duration_days'] as num?)?.toInt() ?? 7,
      notes: json['notes'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  NutritionPlan copyWith({
    String? name,
    String? goal,
    int? targetCaloriesKcal,
    int? targetProteinG,
    int? targetCarbsG,
    int? targetFatsG,
    int? durationDays,
    String? notes,
    bool? isActive,
  }) {
    return NutritionPlan(
      id: id,
      gymId: gymId,
      clientId: clientId,
      nutritionistId: nutritionistId,
      name: name ?? this.name,
      goal: goal ?? this.goal,
      targetCaloriesKcal: targetCaloriesKcal ?? this.targetCaloriesKcal,
      targetProteinG: targetProteinG ?? this.targetProteinG,
      targetCarbsG: targetCarbsG ?? this.targetCarbsG,
      targetFatsG: targetFatsG ?? this.targetFatsG,
      durationDays: durationDays ?? this.durationDays,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    gymId,
    clientId,
    nutritionistId,
    name,
    goal,
    targetCaloriesKcal,
    targetProteinG,
    targetCarbsG,
    targetFatsG,
    durationDays,
    notes,
    isActive,
    createdAt,
    updatedAt,
  ];
}

/// Día dentro de un plan nutricional.
/// POCO + Equatable (ADR-037). Mapea la tabla `nutrition_plan_days`.
///
/// UNIQUE(plan_id, day_number) en BD.
/// day_number es 1-based (1 = primer día del plan).
class NutritionPlanDay extends Equatable {
  final String id;
  final String planId;
  final int dayNumber;
  final String? dayName;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const NutritionPlanDay({
    required this.id,
    required this.planId,
    required this.dayNumber,
    this.dayName,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NutritionPlanDay.fromJson(Map<String, dynamic> json) {
    return NutritionPlanDay(
      id: json['id'] as String,
      planId: json['plan_id'] as String,
      dayNumber: (json['day_number'] as num?)?.toInt() ?? 1,
      dayName: json['day_name'] as String?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  NutritionPlanDay copyWith({String? dayName, String? notes}) {
    return NutritionPlanDay(
      id: id,
      planId: planId,
      dayNumber: dayNumber,
      dayName: dayName ?? this.dayName,
      notes: notes ?? this.notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    planId,
    dayNumber,
    dayName,
    notes,
    createdAt,
    updatedAt,
  ];
}

/// Asignación de un meal_template a un día del plan.
/// POCO + Equatable (ADR-037). Mapea la tabla `nutrition_plan_meals`.
///
/// UNIQUE(plan_day_id, meal_template_id) en BD.
/// Un template solo puede aparecer una vez por día.
class NutritionPlanMeal extends Equatable {
  final String id;
  final String planDayId;
  final String mealTemplateId;
  final int mealOrder;
  final DateTime createdAt;

  const NutritionPlanMeal({
    required this.id,
    required this.planDayId,
    required this.mealTemplateId,
    this.mealOrder = 0,
    required this.createdAt,
  });

  factory NutritionPlanMeal.fromJson(Map<String, dynamic> json) {
    return NutritionPlanMeal(
      id: json['id'] as String,
      planDayId: json['plan_day_id'] as String,
      mealTemplateId: json['meal_template_id'] as String,
      mealOrder: (json['meal_order'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  @override
  List<Object?> get props => [
    id,
    planDayId,
    mealTemplateId,
    mealOrder,
    createdAt,
  ];
}
