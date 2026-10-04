import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../../../core/providers/supabase_provider.dart';
import '../../data/datasources/nutrition_plan_remote_datasource.dart';
import '../../data/repositories/nutrition_plan_repository_impl.dart';
import '../../domain/entities/nutrition_plan.dart';
import '../../domain/entities/nutrition_plan_day.dart';
import '../../domain/repositories/nutrition_plan_repository.dart';

part 'nutrition_plans_controller.g.dart';

/// Estado de planes nutricionales.
class NutritionPlansState {
  const NutritionPlansState({
    this.plans = const [],
    this.selectedPlanDetail,
    this.isLoading = false,
    this.isLoadingDetail = false,
    this.isSaving = false,
    this.error,
  });

  final List<NutritionPlan> plans;
  final NutritionPlanWithDays? selectedPlanDetail;
  final bool isLoading;
  final bool isLoadingDetail;
  final bool isSaving;
  final String? error;

  bool get hasData => plans.isNotEmpty && error == null;
  bool get isEmpty => plans.isEmpty && error == null;

  NutritionPlansState copyWith({
    List<NutritionPlan>? plans,
    NutritionPlanWithDays? selectedPlanDetail,
    bool? isLoading,
    bool? isLoadingDetail,
    bool? isSaving,
    String? error,
    bool clearError = false,
    bool clearDetail = false,
  }) {
    return NutritionPlansState(
      plans: plans ?? this.plans,
      selectedPlanDetail: clearDetail
          ? null
          : (selectedPlanDetail ?? this.selectedPlanDetail),
      isLoading: isLoading ?? this.isLoading,
      isLoadingDetail: isLoadingDetail ?? this.isLoadingDetail,
      isSaving: isSaving ?? this.isSaving,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Controlador de planes nutricionales del nutricionista.
@Riverpod(keepAlive: true)
class NutritionPlansController extends _$NutritionPlansController {
  late final NutritionPlanRepository _repository;

  @override
  NutritionPlansState build() {
    _repository = NutritionPlanRepositoryImpl(
      remote: NutritionPlanRemoteDatasource(supabaseClient),
    );

    authProvider.addListener(_onAuthChange);
    ref.onDispose(() => authProvider.removeListener(_onAuthChange));

    if (authProvider.isLoggedIn && !authProvider.isInitializing) {
      Future.microtask(load);
    }

    return const NutritionPlansState();
  }

  void _onAuthChange() {
    if (authProvider.isLoggedIn &&
        !authProvider.isInitializing &&
        !state.isLoading &&
        state.plans.isEmpty) {
      load();
    }
  }

  /// Carga todos los planes del nutricionista.
  Future<void> load() async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.fetchNutritionistPlans();
    result.when(
      idle: () {},
      loading: () {},
      success: (plans) {
        state = state.copyWith(isLoading: false, plans: plans);
      },
      failure: (error) {
        state = state.copyWith(isLoading: false, error: error.code);
      },
    );
  }

  /// Carga el detalle completo de un plan (árbol: plan → días → comidas).
  Future<void> loadDetail(String planId) async {
    state = state.copyWith(isLoadingDetail: true, clearError: true);

    final result = await _repository.fetchPlanDetail(planId);
    result.when(
      idle: () {},
      loading: () {},
      success: (detail) {
        state = state.copyWith(
          isLoadingDetail: false,
          selectedPlanDetail: detail,
        );
      },
      failure: (error) {
        state = state.copyWith(isLoadingDetail: false, error: error.code);
      },
    );
  }

  /// Crea un plan nuevo.
  Future<NutritionPlan?> createPlan(NutritionPlan plan) async {
    state = state.copyWith(isSaving: true);

    final result = await _repository.createPlan(plan);
    return result.when(
      idle: () => null,
      loading: () => null,
      success: (created) {
        state = state.copyWith(isSaving: false);
        load();
        return created;
      },
      failure: (error) {
        state = state.copyWith(isSaving: false, error: error.code);
        return null;
      },
    );
  }

  /// Actualiza un plan existente.
  Future<bool> updatePlan(NutritionPlan plan) async {
    state = state.copyWith(isSaving: true);

    final result = await _repository.updatePlan(plan);
    return result.when(
      idle: () => false,
      loading: () => false,
      success: (_) {
        state = state.copyWith(isSaving: false);
        load();
        return true;
      },
      failure: (error) {
        state = state.copyWith(isSaving: false, error: error.code);
        return false;
      },
    );
  }

  /// Desactiva un plan.
  Future<bool> deactivatePlan(String planId) async {
    final result = await _repository.deactivatePlan(planId);
    return result.when(
      idle: () => false,
      loading: () => false,
      success: (_) {
        load();
        return true;
      },
      failure: (error) {
        state = state.copyWith(error: error.code);
        return false;
      },
    );
  }

  // ─────────────────────────────────────────────────────────────
  // DÍAS DEL PLAN
  // ─────────────────────────────────────────────────────────────

  /// Agrega un día al plan seleccionado.
  Future<bool> addDay({
    required String planId,
    required int dayNumber,
    String? dayName,
    String? notes,
  }) async {
    final result = await _repository.addDay(
      planId: planId,
      dayNumber: dayNumber,
      dayName: dayName,
      notes: notes,
    );
    return result.when(
      idle: () => false,
      loading: () => false,
      success: (_) {
        loadDetail(planId);
        return true;
      },
      failure: (error) {
        state = state.copyWith(error: error.code);
        return false;
      },
    );
  }

  /// Actualiza un día.
  Future<bool> updateDay(NutritionPlanDay day) async {
    final result = await _repository.updateDay(day);
    return result.when(
      idle: () => false,
      loading: () => false,
      success: (_) {
        final planId = state.selectedPlanDetail?.plan.id;
        if (planId != null) loadDetail(planId);
        return true;
      },
      failure: (error) {
        state = state.copyWith(error: error.code);
        return false;
      },
    );
  }

  /// Elimina un día.
  Future<bool> deleteDay(String dayId) async {
    final result = await _repository.deleteDay(dayId);
    return result.when(
      idle: () => false,
      loading: () => false,
      success: (_) {
        final planId = state.selectedPlanDetail?.plan.id;
        if (planId != null) loadDetail(planId);
        return true;
      },
      failure: (error) {
        state = state.copyWith(error: error.code);
        return false;
      },
    );
  }

  /// Duplica un día.
  Future<bool> duplicateDay({
    required String sourceDayId,
    required String targetPlanId,
    required int targetDayNumber,
  }) async {
    final result = await _repository.duplicateDay(
      sourceDayId: sourceDayId,
      targetPlanId: targetPlanId,
      targetDayNumber: targetDayNumber,
    );
    return result.when(
      idle: () => false,
      loading: () => false,
      success: (_) {
        loadDetail(targetPlanId);
        return true;
      },
      failure: (error) {
        state = state.copyWith(error: error.code);
        return false;
      },
    );
  }

  // ─────────────────────────────────────────────────────────────
  // COMIDAS DEL DÍA
  // ─────────────────────────────────────────────────────────────

  /// Agrega una comida (referencia a template) a un día.
  Future<bool> addMealToDay({
    required String planDayId,
    required String mealTemplateId,
    required int mealOrder,
  }) async {
    final result = await _repository.addMealToDay(
      planDayId: planDayId,
      mealTemplateId: mealTemplateId,
      mealOrder: mealOrder,
    );
    return result.when(
      idle: () => false,
      loading: () => false,
      success: (_) {
        final planId = state.selectedPlanDetail?.plan.id;
        if (planId != null) loadDetail(planId);
        return true;
      },
      failure: (error) {
        state = state.copyWith(error: error.code);
        return false;
      },
    );
  }

  /// Elimina una comida del día.
  Future<bool> removeMealFromDay(String planMealId) async {
    final result = await _repository.removeMealFromDay(planMealId);
    return result.when(
      idle: () => false,
      loading: () => false,
      success: (_) {
        final planId = state.selectedPlanDetail?.plan.id;
        if (planId != null) loadDetail(planId);
        return true;
      },
      failure: (error) {
        state = state.copyWith(error: error.code);
        return false;
      },
    );
  }

  /// Reordena las comidas de un día.
  Future<bool> reorderDayMeals({
    required String planDayId,
    required List<String> mealIdsInOrder,
  }) async {
    final result = await _repository.reorderDayMeals(
      planDayId: planDayId,
      mealIdsInOrder: mealIdsInOrder,
    );
    return result.when(
      idle: () => false,
      loading: () => false,
      success: (_) {
        final planId = state.selectedPlanDetail?.plan.id;
        if (planId != null) loadDetail(planId);
        return true;
      },
      failure: (error) {
        state = state.copyWith(error: error.code);
        return false;
      },
    );
  }

  /// Limpia el detalle seleccionado.
  void clearDetail() {
    state = state.copyWith(clearDetail: true);
  }
}
