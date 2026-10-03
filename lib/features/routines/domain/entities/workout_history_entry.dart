import 'package:equatable/equatable.dart';

/// Entrada del historial de workouts del cliente.
class WorkoutHistoryEntry extends Equatable {
  final String id;
  final String? routineName;
  final DateTime startedAt;
  final DateTime? endedAt;
  final int exerciseCount;
  final int completedSets;

  const WorkoutHistoryEntry({
    required this.id,
    this.routineName,
    required this.startedAt,
    this.endedAt,
    required this.exerciseCount,
    required this.completedSets,
  });

  int get durationMinutes {
    if (endedAt == null) return 0;
    return endedAt!.difference(startedAt).inMinutes;
  }

  factory WorkoutHistoryEntry.fromJson(Map<String, dynamic> json) {
    final routine = json['routines'] as Map<String, dynamic>?;
    final setsRaw = json['workout_exercises'] as List<dynamic>?;
    final completedSets =
        setsRaw
            ?.where(
              (s) => (s as Map<String, dynamic>)['completed'] as bool? ?? false,
            )
            .length ??
        0;

    return WorkoutHistoryEntry(
      id: json['id'] as String,
      routineName: routine?['name'] as String?,
      startedAt: DateTime.parse(json['started_at'] as String),
      endedAt: json['ended_at'] != null
          ? DateTime.parse(json['ended_at'] as String)
          : null,
      exerciseCount:
          (setsRaw
              ?.map((s) => (s as Map<String, dynamic>)['exercise_id'])
              .toSet()
              .length) ??
          0,
      completedSets: completedSets,
    );
  }

  @override
  List<Object?> get props => [
    id,
    routineName,
    startedAt,
    endedAt,
    exerciseCount,
    completedSets,
  ];
}
