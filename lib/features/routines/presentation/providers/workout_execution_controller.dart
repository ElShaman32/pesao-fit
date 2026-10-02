import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../data/datasources/workouts_remote_datasource.dart';
import '../../data/repositories/workouts_repository_impl.dart';
import '../../domain/entities/workout.dart';
import '../../domain/entities/workout_set.dart';
import '../../domain/repositories/workouts_repository.dart';

part 'workout_execution_controller.g.dart';

@riverpod
WorkoutsRepository workoutsRepository(Ref ref) {
  return WorkoutsRepositoryImpl(
    remote: WorkoutsRemoteDatasource(Supabase.instance.client),
  );
}

/// Estado de la pantalla de ejecución de workout.
class WorkoutExecutionState {
  final String? workoutId;
  final Workout? workout;
  final List<WorkoutSet> sets;
  final bool isLoading;
  final bool isFinishing;
  final String? error;

  const WorkoutExecutionState({
    this.workoutId,
    this.workout,
    this.sets = const [],
    this.isLoading = false,
    this.isFinishing = false,
    this.error,
  });

  int get completedSets => sets.where((s) => s.completed).length;
  int get totalSets => sets.length;
  double get progress => totalSets == 0 ? 0 : completedSets / totalSets;
  bool get isComplete => totalSets > 0 && completedSets == totalSets;
  bool get hasData => workout != null;

  WorkoutExecutionState copyWith({
    String? workoutId,
    Workout? workout,
    List<WorkoutSet>? sets,
    bool? isLoading,
    bool? isFinishing,
    String? error,
    bool clearError = false,
  }) {
    return WorkoutExecutionState(
      workoutId: workoutId ?? this.workoutId,
      workout: workout ?? this.workout,
      sets: sets ?? this.sets,
      isLoading: isLoading ?? this.isLoading,
      isFinishing: isFinishing ?? this.isFinishing,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Controlador de ejecución de workout (F2-D).
@Riverpod(keepAlive: true)
class WorkoutExecutionController extends _$WorkoutExecutionController {
  late final WorkoutsRepository _repository;

  @override
  WorkoutExecutionState build() {
    _repository = ref.watch(workoutsRepositoryProvider);
    return const WorkoutExecutionState();
  }

  /// Inicia un nuevo workout o retoma el activo.
  /// Devuelve el workoutId para navegar a la pantalla de ejecución.
  Future<Result<String>> startOrResume({
    required String gymId,
    required String routineId,
  }) async {
    final activeResult = await _repository.getActiveWorkoutId();
    if (activeResult.isSuccess && activeResult.dataOrNull != null) {
      return Result.success(activeResult.dataOrNull!);
    }
    return _repository.startWorkout(gymId: gymId, routineId: routineId);
  }

  /// Carga el workout y sus sets.
  Future<void> load(String workoutId) async {
    state = state.copyWith(
      isLoading: true,
      clearError: true,
      workoutId: workoutId,
    );

    final workoutResult = await _repository.getWorkout(workoutId: workoutId);
    final setsResult = await _repository.getWorkoutSets(workoutId: workoutId);

    if (workoutResult.isSuccess && setsResult.isSuccess) {
      state = state.copyWith(
        isLoading: false,
        workout: workoutResult.dataOrNull,
        sets: setsResult.dataOrNull ?? [],
      );
    } else {
      final errorMessage = _errorOf(workoutResult) ?? _errorOf(setsResult);
      state = state.copyWith(isLoading: false, error: errorMessage);
    }
  }

  /// Toggle optimista de un set.
  Future<void> toggleSet(String setId) async {
    final set = state.sets.where((s) => s.id == setId).firstOrNull;
    if (set == null) return;

    final newCompleted = !set.completed;

    // Optimista: actualizar state local inmediatamente.
    state = state.copyWith(
      sets: state.sets
          .map((s) => s.id == setId ? s.copyWith(completed: newCompleted) : s)
          .toList(),
    );

    // Persistir en Supabase.
    final result = await _repository.updateSet(
      setId: setId,
      completed: newCompleted,
    );

    // Si falla, revertir.
    if (result.isFailure) {
      state = state.copyWith(
        sets: state.sets
            .map(
              (s) => s.id == setId ? s.copyWith(completed: set.completed) : s,
            )
            .toList(),
      );
      debugPrint('❌ WORKOUT toggleSet revertido');
    }
  }

  /// Finaliza el workout activo.
  Future<Result<void>> finish() async {
    final workoutId = state.workoutId;
    if (workoutId == null) {
      return const Result.failure(
        UnknownException(
          code: 'Workouts/no-active',
          message: 'No hay workout activo',
        ),
      );
    }

    state = state.copyWith(isFinishing: true);
    final result = await _repository.finishWorkout(workoutId: workoutId);
    state = state.copyWith(isFinishing: false);

    if (result.isSuccess) {
      // Limpiar el state para el próximo workout.
      state = const WorkoutExecutionState();
    }
    return result;
  }

  /// Extrae el mensaje de error de un Result fallido.
  String? _errorOf<T>(Result<T> result) {
    String? error;
    result.when(
      idle: () {},
      loading: () {},
      success: (_) {},
      failure: (e) => error = e.toString(),
    );
    return error;
  }
}
