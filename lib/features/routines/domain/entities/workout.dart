import 'package:equatable/equatable.dart';

/// Sesión de entrenamiento ejecutada por un cliente.
/// POCO + Equatable (ADR-037).
class Workout extends Equatable {
  final String id;
  final String gymId;
  final String userId;
  final String? routineId;
  final String? routineName;
  final DateTime startedAt;
  final DateTime? endedAt;
  final String? notes;

  const Workout({
    required this.id,
    required this.gymId,
    required this.userId,
    this.routineId,
    this.routineName,
    required this.startedAt,
    this.endedAt,
    this.notes,
  });

  bool get isActive => endedAt == null;

  factory Workout.fromJson(Map<String, dynamic> json) {
    final routine = json['routines'] as Map<String, dynamic>?;
    return Workout(
      id: json['id'] as String,
      gymId: json['gym_id'] as String,
      userId: json['user_id'] as String,
      routineId: json['routine_id'] as String?,
      routineName: routine?['name'] as String?,
      startedAt: DateTime.parse(json['started_at'] as String),
      endedAt: json['ended_at'] != null
          ? DateTime.parse(json['ended_at'] as String)
          : null,
      notes: json['notes'] as String?,
    );
  }

  @override
  List<Object?> get props => [
    id,
    gymId,
    userId,
    routineId,
    routineName,
    startedAt,
    endedAt,
    notes,
  ];
}
