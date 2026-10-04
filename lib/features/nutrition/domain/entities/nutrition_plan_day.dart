import 'package:equatable/equatable.dart';

/// Día dentro de un plan nutricional (tabla `nutrition_plan_days`).
class NutritionPlanDay extends Equatable {
  const NutritionPlanDay({
    required this.id,
    required this.planId,
    required this.dayNumber,
    required this.createdAt,
    required this.updatedAt,
    this.dayName,
    this.notes,
  });

  final String id;
  final String planId;
  final int dayNumber;
  final String? dayName;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  NutritionPlanDay copyWith({
    String? id,
    String? planId,
    int? dayNumber,
    String? dayName,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool clearDayName = false,
    bool clearNotes = false,
  }) {
    return NutritionPlanDay(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      dayNumber: dayNumber ?? this.dayNumber,
      dayName: clearDayName ? null : (dayName ?? this.dayName),
      notes: clearNotes ? null : (notes ?? this.notes),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory NutritionPlanDay.fromJson(Map<String, dynamic> json) {
    return NutritionPlanDay(
      id: json['id'] as String,
      planId: json['plan_id'] as String,
      dayNumber: json['day_number'] as int,
      dayName: json['day_name'] as String?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plan_id': planId,
      'day_number': dayNumber,
      'day_name': dayName,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, planId, dayNumber, dayName];
}
