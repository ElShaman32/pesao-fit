import 'package:equatable/equatable.dart';

/// Un set individual dentro de un workout.
/// Representa una fila de workout_exercises.
class WorkoutSet extends Equatable {
  final String id;
  final String workoutId;
  final String exerciseId;
  final String? exerciseName;
  final String? muscleGroup;
  final int setNumber;
  final double? weightKg;
  final int? reps;
  final int restSeconds;
  final int orderIndex;
  final bool completed;

  const WorkoutSet({
    required this.id,
    required this.workoutId,
    required this.exerciseId,
    this.exerciseName,
    this.muscleGroup,
    required this.setNumber,
    this.weightKg,
    this.reps,
    this.restSeconds = 60,
    this.orderIndex = 0,
    this.completed = false,
  });

  factory WorkoutSet.fromJson(Map<String, dynamic> json) {
    final exercise = json['exercises'] as Map<String, dynamic>?;
    return WorkoutSet(
      id: json['id'] as String,
      workoutId: json['workout_id'] as String,
      exerciseId: json['exercise_id'] as String,
      exerciseName: exercise?['name'] as String?,
      muscleGroup: exercise?['muscle_group'] as String?,
      setNumber: json['set_number'] as int,
      weightKg: (json['weight_kg'] as num?)?.toDouble(),
      reps: json['reps'] as int?,
      restSeconds: json['rest_seconds'] as int? ?? 60,
      orderIndex: json['order_index'] as int? ?? 0,
      completed: json['completed'] as bool? ?? false,
    );
  }

  WorkoutSet copyWith({
    double? weightKg,
    int? reps,
    bool? completed,
    bool clearWeight = false,
    bool clearReps = false,
  }) {
    return WorkoutSet(
      id: id,
      workoutId: workoutId,
      exerciseId: exerciseId,
      exerciseName: exerciseName,
      muscleGroup: muscleGroup,
      setNumber: setNumber,
      weightKg: clearWeight ? null : (weightKg ?? this.weightKg),
      reps: clearReps ? null : (reps ?? this.reps),
      restSeconds: restSeconds,
      orderIndex: orderIndex,
      completed: completed ?? this.completed,
    );
  }

  @override
  List<Object?> get props => [
    id,
    workoutId,
    exerciseId,
    exerciseName,
    muscleGroup,
    setNumber,
    weightKg,
    reps,
    restSeconds,
    orderIndex,
    completed,
  ];
}
