import 'package:equatable/equatable.dart';

/// Ejercicio dentro de una rutina con series, reps, peso y descanso.
/// POCO + Equatable (ADR-037).
class RoutineExercise extends Equatable {
  final String id;
  final String routineId;
  final String exerciseId;
  final int sets;
  final int? reps;
  final double? weightKg;
  final int restSeconds;
  final int orderIndex;
  final String? notes;

  /// Nombre del ejercicio (join desde exercises).
  final String? exerciseName;

  /// Grupo muscular del ejercicio (join desde exercises).
  final String? exerciseMuscleGroup;

  const RoutineExercise({
    required this.id,
    required this.routineId,
    required this.exerciseId,
    required this.sets,
    this.reps,
    this.weightKg,
    this.restSeconds = 60,
    required this.orderIndex,
    this.notes,
    this.exerciseName,
    this.exerciseMuscleGroup,
  });

  factory RoutineExercise.fromJson(Map<String, dynamic> json) {
    final exercise = json['exercises'] as Map<String, dynamic>?;

    return RoutineExercise(
      id: json['id'] as String,
      routineId: json['routine_id'] as String,
      exerciseId: json['exercise_id'] as String,
      sets: json['sets'] as int,
      reps: json['reps'] as int?,
      weightKg: (json['weight_kg'] as num?)?.toDouble(),
      restSeconds: json['rest_seconds'] as int? ?? 60,
      orderIndex: json['order_index'] as int,
      notes: json['notes'] as String?,
      exerciseName: exercise?['name'] as String?,
      exerciseMuscleGroup: exercise?['muscle_group'] as String?,
    );
  }

  RoutineExercise copyWith({
    int? sets,
    int? reps,
    double? weightKg,
    int? restSeconds,
    int? orderIndex,
    String? notes,
  }) {
    return RoutineExercise(
      id: id,
      routineId: routineId,
      exerciseId: exerciseId,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      weightKg: weightKg ?? this.weightKg,
      restSeconds: restSeconds ?? this.restSeconds,
      orderIndex: orderIndex ?? this.orderIndex,
      notes: notes ?? this.notes,
      exerciseName: exerciseName,
      exerciseMuscleGroup: exerciseMuscleGroup,
    );
  }

  @override
  List<Object?> get props => [
    id,
    routineId,
    exerciseId,
    sets,
    reps,
    weightKg,
    restSeconds,
    orderIndex,
    notes,
    exerciseName,
    exerciseMuscleGroup,
  ];
}
