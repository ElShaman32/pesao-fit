import 'package:equatable/equatable.dart';

/// Registro diario de comidas del cliente (tabla `food_logs`).
/// Un log por cliente por día. Los totales se recalculan con trigger.
class FoodLog extends Equatable {
  const FoodLog({
    required this.id,
    required this.clientId,
    required this.gymId,
    required this.logDate,
    required this.totalCaloriesKcal,
    required this.totalProteinG,
    required this.totalCarbsG,
    required this.totalFatsG,
    required this.createdAt,
    required this.updatedAt,
    this.notes,
  });

  final String id;
  final String clientId;
  final String gymId;
  final DateTime logDate;
  final double totalCaloriesKcal;
  final double totalProteinG;
  final double totalCarbsG;
  final double totalFatsG;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  FoodLog copyWith({
    String? id,
    String? clientId,
    String? gymId,
    DateTime? logDate,
    double? totalCaloriesKcal,
    double? totalProteinG,
    double? totalCarbsG,
    double? totalFatsG,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool clearNotes = false,
  }) {
    return FoodLog(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      gymId: gymId ?? this.gymId,
      logDate: logDate ?? this.logDate,
      totalCaloriesKcal: totalCaloriesKcal ?? this.totalCaloriesKcal,
      totalProteinG: totalProteinG ?? this.totalProteinG,
      totalCarbsG: totalCarbsG ?? this.totalCarbsG,
      totalFatsG: totalFatsG ?? this.totalFatsG,
      notes: clearNotes ? null : (notes ?? this.notes),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_id': clientId,
      'gym_id': gymId,
      'log_date': logDate.toIso8601String().split('T')[0],
      'total_calories_kcal': totalCaloriesKcal,
      'total_protein_g': totalProteinG,
      'total_carbs_g': totalCarbsG,
      'total_fats_g': totalFatsG,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
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
  ];
}
