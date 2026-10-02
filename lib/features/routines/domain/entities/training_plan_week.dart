import 'package:equatable/equatable.dart';

import 'training_plan_day.dart';

/// Semana dentro de un plan de entrenamiento.
class TrainingPlanWeek extends Equatable {
  final String id;
  final String planId;
  final int weekNumber;
  final String? name;
  final DateTime createdAt;

  /// Días de la semana (se cargan en el detalle).
  final List<TrainingPlanDay> days;

  const TrainingPlanWeek({
    required this.id,
    required this.planId,
    required this.weekNumber,
    this.name,
    required this.createdAt,
    this.days = const [],
  });

  factory TrainingPlanWeek.fromJson(Map<String, dynamic> json) {
    final daysRaw = json['training_plan_days'] as List<dynamic>?;

    return TrainingPlanWeek(
      id: json['id'] as String,
      planId: json['plan_id'] as String,
      weekNumber: json['week_number'] as int,
      name: json['name'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      days:
          daysRaw
              ?.map((d) => TrainingPlanDay.fromJson(d as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  TrainingPlanWeek copyWith({String? name, List<TrainingPlanDay>? days}) {
    return TrainingPlanWeek(
      id: id,
      planId: planId,
      weekNumber: weekNumber,
      name: name ?? this.name,
      createdAt: createdAt,
      days: days ?? this.days,
    );
  }

  @override
  List<Object?> get props => [id, planId, weekNumber, name, createdAt, days];
}
