import 'package:equatable/equatable.dart';

/// Día dentro de una semana del plan.
/// dayOfWeek: 1=Lunes ... 7=Domingo.
class TrainingPlanDay extends Equatable {
  final String id;
  final String weekId;
  final int dayOfWeek;
  final String? routineId;
  final bool isRestDay;
  final String? notes;
  final DateTime createdAt;

  /// Nombre de la rutina (join desde routines).
  final String? routineName;

  /// Cantidad de ejercicios de la rutina.
  final int? exerciseCount;

  const TrainingPlanDay({
    required this.id,
    required this.weekId,
    required this.dayOfWeek,
    this.routineId,
    this.isRestDay = false,
    this.notes,
    required this.createdAt,
    this.routineName,
    this.exerciseCount,
  });

  bool get hasRoutine => routineId != null && !isRestDay;

  factory TrainingPlanDay.fromJson(Map<String, dynamic> json) {
    final routine = json['routines'] as Map<String, dynamic>?;

    return TrainingPlanDay(
      id: json['id'] as String,
      weekId: json['week_id'] as String,
      dayOfWeek: json['day_of_week'] as int,
      routineId: json['routine_id'] as String?,
      isRestDay: json['is_rest_day'] as bool? ?? false,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      routineName: routine?['name'] as String?,
      exerciseCount: routine?['routine_exercises'] != null
          ? (routine!['routine_exercises'] as List).length
          : null,
    );
  }

  TrainingPlanDay copyWith({
    String? routineId,
    bool? isRestDay,
    String? notes,
    bool clearRoutine = false,
    bool clearNotes = false,
  }) {
    return TrainingPlanDay(
      id: id,
      weekId: weekId,
      dayOfWeek: dayOfWeek,
      routineId: clearRoutine ? null : (routineId ?? this.routineId),
      isRestDay: isRestDay ?? this.isRestDay,
      notes: clearNotes ? null : (notes ?? this.notes),
      createdAt: createdAt,
      routineName: routineName,
      exerciseCount: exerciseCount,
    );
  }

  @override
  List<Object?> get props => [
    id,
    weekId,
    dayOfWeek,
    routineId,
    isRestDay,
    notes,
    createdAt,
    routineName,
    exerciseCount,
  ];
}
