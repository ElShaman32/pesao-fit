import 'package:equatable/equatable.dart';

import 'meal_type.dart';

/// Registro diario de comidas de un cliente.
/// POCO + Equatable (ADR-037). Mapea la tabla `food_logs`.
///
/// UNIQUE(client_id, gym_id, log_date) en BD: un solo log por día.
class FoodLog extends Equatable {
  final String id;
  final String clientId;
  final String gymId;
  final DateTime logDate;

  // --- Totales precalculados por recalc_food_log_totals() ---
  final double totalCaloriesKcal;
  final double totalProteinG;
  final double totalCarbsG;
  final double totalFatsG;

  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const FoodLog({
    required this.id,
    required this.clientId,
    required this.gymId,
    required this.logDate,
    this.totalCaloriesKcal = 0,
    this.totalProteinG = 0,
    this.totalCarbsG = 0,
    this.totalFatsG = 0,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  /// true si el log es de hoy (para resaltar en la UI).
  bool get isToday {
    final now = DateTime.now();
    return logDate.year == now.year &&
        logDate.month == now.month &&
        logDate.day == now.day;
  }

  factory FoodLog.fromJson(Map<String, dynamic> json) {
    return FoodLog(
      id: json['id'] as String,
      clientId: json['client_id'] as String,
      gymId: json['gym_id'] as String,
      logDate: DateTime.parse(json['log_date'] as String),
      totalCaloriesKcal: (json['total_calories_kcal'] as num?)?.toDouble() ?? 0,
      totalProteinG: (json['total_protein_g'] as num?)?.toDouble() ?? 0,
      totalCarbsG: (json['total_carbs_g'] as num?)?.toDouble() ?? 0,
      totalFatsG: (json['total_fats_g'] as num?)?.toDouble() ?? 0,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  /// Crea una copia con totales actualizados (optimistic update).
  FoodLog withTotals({
    required double calories,
    required double protein,
    required double carbs,
    required double fats,
  }) {
    return FoodLog(
      id: id,
      clientId: clientId,
      gymId: gymId,
      logDate: logDate,
      totalCaloriesKcal: calories,
      totalProteinG: protein,
      totalCarbsG: carbs,
      totalFatsG: fats,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    clientId,
    gymId,
    logDate,
    totalCaloriesKcal,
    totalProteinG,
    totalCarbsG,
    totalFatsG,
    notes,
    createdAt,
    updatedAt,
  ];
}

/// Item individual dentro del registro diario.
/// POCO + Equatable (ADR-037). Mapea la tabla `food_log_items`.
///
/// Los macros se guardan como SNAPSHOT al momento del registro.
/// Si el alimento se edita después, el log NO cambia.
class FoodLogItem extends Equatable {
  final String id;
  final String logId;
  final String foodId;
  final MealType mealType;
  final double quantity;

  // --- Snapshot de macros al momento del registro ---
  final double caloriesKcal;
  final double proteinG;
  final double carbsG;
  final double fatsG;

  /// Nombre del alimento (denormalizado para display sin JOIN).
  /// Se llena en el datasource con un select anidado.
  final String? foodName;

  final DateTime createdAt;

  const FoodLogItem({
    required this.id,
    required this.logId,
    required this.foodId,
    required this.mealType,
    required this.quantity,
    this.caloriesKcal = 0,
    this.proteinG = 0,
    this.carbsG = 0,
    this.fatsG = 0,
    this.foodName,
    required this.createdAt,
  });

  factory FoodLogItem.fromJson(Map<String, dynamic> json) {
    return FoodLogItem(
      id: json['id'] as String,
      logId: json['log_id'] as String,
      foodId: json['food_id'] as String,
      mealType: MealType.fromDb(json['meal_type'] as String?),
      quantity: (json['quantity'] as num?)?.toDouble() ?? 0,
      caloriesKcal: (json['calories_kcal'] as num?)?.toDouble() ?? 0,
      proteinG: (json['protein_g'] as num?)?.toDouble() ?? 0,
      carbsG: (json['carbs_g'] as num?)?.toDouble() ?? 0,
      fatsG: (json['fats_g'] as num?)?.toDouble() ?? 0,
      foodName: json['food_name'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  @override
  List<Object?> get props => [
    id,
    logId,
    foodId,
    mealType,
    quantity,
    caloriesKcal,
    proteinG,
    carbsG,
    fatsG,
    foodName,
    createdAt,
  ];
}
