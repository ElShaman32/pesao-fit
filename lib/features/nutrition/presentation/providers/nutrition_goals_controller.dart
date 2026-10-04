import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../../../core/providers/supabase_provider.dart';
import '../../data/datasources/nutrition_goal_remote_datasource.dart';
import '../../data/repositories/nutrition_goal_repository_impl.dart';
import '../../domain/entities/nutrition_goal.dart';
import '../../domain/enums/goal_type.dart';
import '../../domain/repositories/nutrition_goal_repository.dart';

part 'nutrition_goals_controller.g.dart';

/// Estado de metas nutricionales.
class NutritionGoalsState {
  const NutritionGoalsState({
    this.activeGoal,
    this.suggestedGoal,
    this.isLoading = false,
    this.isSaving = false,
    this.error,
  });

  final NutritionGoal? activeGoal;
  final NutritionGoal? suggestedGoal;
  final bool isLoading;
  final bool isSaving;
  final String? error;

  bool get hasGoal => activeGoal != null;

  NutritionGoalsState copyWith({
    NutritionGoal? activeGoal,
    NutritionGoal? suggestedGoal,
    bool? isLoading,
    bool? isSaving,
    String? error,
    bool clearError = false,
    bool clearActiveGoal = false,
    bool clearSuggestedGoal = false,
  }) {
    return NutritionGoalsState(
      activeGoal: clearActiveGoal ? null : (activeGoal ?? this.activeGoal),
      suggestedGoal: clearSuggestedGoal
          ? null
          : (suggestedGoal ?? this.suggestedGoal),
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Controlador de metas nutricionales por cliente.
@Riverpod(keepAlive: true)
class NutritionGoalsController extends _$NutritionGoalsController {
  late final NutritionGoalRepository _repository;

  @override
  NutritionGoalsState build() {
    _repository = NutritionGoalRepositoryImpl(
      remote: NutritionGoalRemoteDatasource(supabaseClient),
    );

    return const NutritionGoalsState();
  }

  String? get _gymId => authProvider.userGymId;

  /// Carga la meta activa de un cliente.
  Future<void> loadGoal({required String clientId}) async {
    final gymId = _gymId;
    if (gymId == null) return;

    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.fetchActiveGoal(
      clientId: clientId,
      gymId: gymId,
    );
    result.when(
      idle: () {},
      loading: () {},
      success: (goal) {
        state = state.copyWith(
          isLoading: false,
          activeGoal: goal,
          clearActiveGoal: goal == null,
        );
      },
      failure: (error) {
        state = state.copyWith(isLoading: false, error: error.code);
      },
    );
  }

  /// Guarda o actualiza la meta de un cliente.
  Future<bool> saveGoal({
    required String clientId,
    required GoalType goalType,
    required double targetCaloriesKcal,
    required double targetProteinG,
    required double targetCarbsG,
    required double targetFatsG,
    String? notes,
  }) async {
    final gymId = _gymId;
    if (gymId == null) return false;

    state = state.copyWith(isSaving: true);

    final result = await _repository.upsertGoal(
      clientId: clientId,
      gymId: gymId,
      goalType: goalType,
      targetCaloriesKcal: targetCaloriesKcal,
      targetProteinG: targetProteinG,
      targetCarbsG: targetCarbsG,
      targetFatsG: targetFatsG,
      notes: notes,
    );
    return result.when(
      idle: () => false,
      loading: () => false,
      success: (goal) {
        state = state.copyWith(isSaving: false, activeGoal: goal);
        return true;
      },
      failure: (error) {
        state = state.copyWith(isSaving: false, error: error.code);
        return false;
      },
    );
  }

  /// Calcula una meta sugerida basado en el objetivo.
  Future<void> calculateSuggestion({
    required String clientId,
    required GoalType goalType,
  }) async {
    final gymId = _gymId;
    if (gymId == null) return;

    final result = await _repository.calculateSuggestedGoal(
      clientId: clientId,
      gymId: gymId,
      goalType: goalType,
    );
    result.when(
      idle: () {},
      loading: () {},
      success: (suggested) {
        state = state.copyWith(suggestedGoal: suggested);
      },
      failure: (error) {
        state = state.copyWith(error: error.code);
      },
    );
  }

  /// Limpia el estado al cambiar de cliente.
  void reset() {
    state = const NutritionGoalsState();
  }
}
