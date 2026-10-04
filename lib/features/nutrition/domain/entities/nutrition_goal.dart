import 'package:equatable/equatable.dart';

/// Tipo de objetivo calórico del cliente.
enum GoalType {
  lose,
  maintain,
  gain;

  String get dbValue => name;

  /// Clave de traducción para AppStrings.
  String get l10nKey => switch (this) {
    GoalType.lose => 'goalTypeLose',
    GoalType.maintain => 'goalTypeMaintain',
    GoalType.gain => 'goalTypeGain',
  };

  static GoalType fromDb(String? value) {
    return GoalType.values.firstWhere(
      (g) => g.name == value,
      orElse: () => GoalType.maintain,
    );
  }
}

/// Objetivos nutricionales standalone de un cliente.
/// Se usa cuando NO hay plan activo, o como referencia rápida.
/// POCO + Equatable (ADR-037). Mapea la tabla `nutrition_goals`.
///
/// Nota: la BD usa numeric(8,2) para los targets aquí,
/// a diferencia de nutrition_plans que usa integer.
class NutritionGoal extends Equatable {
  final String id;
  final String clientId;
  final String gymId;

  /// UUID del nutricionista que fijó el objetivo.
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

  const NutritionGoal({
    required this.id,
    required this.clientId,
    required this.gymId,
    this.setBy,
    this.targetCaloriesKcal = 2000,
    this.targetProteinG = 150,
    this.targetCarbsG = 200,
    this.targetFatsG = 65,
    this.goalType = GoalType.maintain,
    this.notes,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Distribución calórica de proteínas/carbs/grasas vs total.
  /// Se usa para el MacroRing del dashboard del cliente.
  /// Proteína y carbos = 4 kcal/g, grasa = 9 kcal/g.
  double get proteinKcal => targetProteinG * 4;
  double get carbsKcal => targetCarbsG * 4;
  double get fatsKcal => targetFatsG * 9;
  double get totalMacroKcal => proteinKcal + carbsKcal + fatsKcal;

  factory NutritionGoal.fromJson(Map<String, dynamic> json) {
    return NutritionGoal(
      id: json['id'] as String,
      clientId: json['client_id'] as String,
      gymId: json['gym_id'] as String,
      setBy: json['set_by'] as String?,
      targetCaloriesKcal:
          (json['target_calories_kcal'] as num?)?.toDouble() ?? 2000,
      targetProteinG: (json['target_protein_g'] as num?)?.toDouble() ?? 150,
      targetCarbsG: (json['target_carbs_g'] as num?)?.toDouble() ?? 200,
      targetFatsG: (json['target_fats_g'] as num?)?.toDouble() ?? 65,
      goalType: GoalType.fromDb(json['goal_type'] as String?),
      notes: json['notes'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  NutritionGoal copyWith({
    double? targetCaloriesKcal,
    double? targetProteinG,
    double? targetCarbsG,
    double? targetFatsG,
    GoalType? goalType,
    String? notes,
    bool? isActive,
  }) {
    return NutritionGoal(
      id: id,
      clientId: clientId,
      gymId: gymId,
      setBy: setBy,
      targetCaloriesKcal: targetCaloriesKcal ?? this.targetCaloriesKcal,
      targetProteinG: targetProteinG ?? this.targetProteinG,
      targetCarbsG: targetCarbsG ?? this.targetCarbsG,
      targetFatsG: targetFatsG ?? this.targetFatsG,
      goalType: goalType ?? this.goalType,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    clientId,
    gymId,
    setBy,
    targetCaloriesKcal,
    targetProteinG,
    targetCarbsG,
    targetFatsG,
    goalType,
    notes,
    isActive,
    createdAt,
    updatedAt,
  ];
}
