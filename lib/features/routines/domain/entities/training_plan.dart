import 'package:equatable/equatable.dart';

import 'training_plan_week.dart';

/// Plan de entrenamiento asignado a un cliente.
/// Contiene semanas, y cada semana tiene días con rutinas asignadas.
class TrainingPlan extends Equatable {
  final String id;
  final String gymId;
  final String clientId;
  final String? trainerId;
  final String name;
  final String? description;
  final bool isActive;
  final int currentWeek;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Nombre del cliente (join desde profiles).
  final String? clientName;

  /// Semanas del plan (se cargan en el detalle).
  final List<TrainingPlanWeek> weeks;

  const TrainingPlan({
    required this.id,
    required this.gymId,
    required this.clientId,
    this.trainerId,
    required this.name,
    this.description,
    this.isActive = true,
    this.currentWeek = 1,
    required this.createdAt,
    required this.updatedAt,
    this.clientName,
    this.weeks = const [],
  });

  factory TrainingPlan.fromJson(Map<String, dynamic> json) {
    final profile = json['profiles'] as Map<String, dynamic>?;
    final weeksRaw = json['training_plan_weeks'] as List<dynamic>?;

    return TrainingPlan(
      id: json['id'] as String,
      gymId: json['gym_id'] as String,
      clientId: json['client_id'] as String,
      trainerId: json['trainer_id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      currentWeek: json['current_week'] as int? ?? 1,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      clientName: profile?['full_name'] as String?,
      weeks:
          weeksRaw
              ?.map((w) => TrainingPlanWeek.fromJson(w as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  TrainingPlan copyWith({
    String? name,
    String? description,
    bool? isActive,
    int? currentWeek,
    List<TrainingPlanWeek>? weeks,
  }) {
    return TrainingPlan(
      id: id,
      gymId: gymId,
      clientId: clientId,
      trainerId: trainerId,
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      currentWeek: currentWeek ?? this.currentWeek,
      createdAt: createdAt,
      updatedAt: updatedAt,
      clientName: clientName,
      weeks: weeks ?? this.weeks,
    );
  }

  @override
  List<Object?> get props => [
    id,
    gymId,
    clientId,
    trainerId,
    name,
    description,
    isActive,
    currentWeek,
    createdAt,
    updatedAt,
    clientName,
    weeks,
  ];
}
