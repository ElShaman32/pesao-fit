import 'package:equatable/equatable.dart';

import 'routine_exercise.dart';

/// Rutina de entrenamiento asignada a un cliente.
/// POCO + Equatable (ADR-037).
class Routine extends Equatable {
  final String id;
  final String gymId;
  final String clientId;
  final String? trainerId;
  final String name;
  final String? description;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Ejercicios de la rutina (se cargan por separado).
  final List<RoutineExercise> exercises;

  /// Nombre del cliente (join desde profiles).
  final String? clientName;

  const Routine({
    required this.id,
    required this.gymId,
    required this.clientId,
    this.trainerId,
    required this.name,
    this.description,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
    this.exercises = const [],
    this.clientName,
  });

  factory Routine.fromJson(Map<String, dynamic> json) {
    final profile = json['profiles'] as Map<String, dynamic>?;
    final exercisesRaw = json['routine_exercises'] as List<dynamic>?;

    return Routine(
      id: json['id'] as String,
      gymId: json['gym_id'] as String,
      clientId: json['client_id'] as String,
      trainerId: json['trainer_id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      clientName: profile?['full_name'] as String?,
      exercises:
          exercisesRaw
              ?.map((e) => RoutineExercise.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Routine copyWith({
    String? name,
    String? description,
    bool? isActive,
    List<RoutineExercise>? exercises,
  }) {
    return Routine(
      id: id,
      gymId: gymId,
      clientId: clientId,
      trainerId: trainerId,
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
      exercises: exercises ?? this.exercises,
      clientName: clientName,
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
    createdAt,
    updatedAt,
    exercises,
    clientName,
  ];
}
