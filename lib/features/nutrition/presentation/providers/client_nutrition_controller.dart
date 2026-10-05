import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../../../core/providers/database_provider.dart';
import '../../../../core/providers/supabase_provider.dart';
import '../../data/datasources/food_log_remote_datasource.dart';
import '../../data/datasources/nutrition_goal_remote_datasource.dart';
import '../../data/datasources/nutrition_plan_remote_datasource.dart';
import '../../data/repositories/food_log_repository_impl.dart';
import '../../data/repositories/nutrition_goal_repository_impl.dart';
import '../../data/repositories/nutrition_plan_repository_impl.dart';
import '../../domain/entities/food_log.dart';
import '../../domain/entities/food_log_item.dart';
import '../../domain/entities/nutrition_goal.dart';
import '../../domain/entities/nutrition_plan.dart';
import '../../domain/enums/meal_type.dart';
import '../../domain/repositories/food_log_repository.dart';
import '../../domain/repositories/nutrition_goal_repository.dart';
import '../../domain/repositories/nutrition_plan_repository.dart';

part 'client_nutrition_controller.g.dart';

/// Estado de nutrición del cliente.
/// Agrega: plan activo + metas + log del día.
class ClientNutritionState {
  const ClientNutritionState({
    this.activePlan,
    this.activeGoal,
    this.dailyLog,
    this.dailyItems = const [],
    this.isLoading = false,
    this.error,
  });

  final NutritionPlan? activePlan;
  final NutritionGoal? activeGoal;
  final FoodLog? dailyLog;
  final List<FoodLogItem> dailyItems;
  final bool isLoading;
  final String? error;

  bool get hasPlan => activePlan != null;
  bool get hasGoal => activeGoal != null;

  /// Totales consumidos hoy.
  double get totalCaloriesConsumed => dailyLog?.totalCaloriesKcal ?? 0;
  double get totalProteinConsumed => dailyLog?.totalProteinG ?? 0;
  double get totalCarbsConsumed => dailyLog?.totalCarbsG ?? 0;
  double get totalFatsConsumed => dailyLog?.totalFatsG ?? 0;

  /// Porcentaje de progreso vs metas.
  double get caloriesProgress {
    if (activeGoal == null || activeGoal!.targetCaloriesKcal == 0) return 0;
    return totalCaloriesConsumed / activeGoal!.targetCaloriesKcal;
  }

  ClientNutritionState copyWith({
    NutritionPlan? activePlan,
    NutritionGoal? activeGoal,
    FoodLog? dailyLog,
    List<FoodLogItem>? dailyItems,
    bool? isLoading,
    String? error,
    bool clearError = false,
    bool clearPlan = false,
    bool clearGoal = false,
    bool clearLog = false,
  }) {
    return ClientNutritionState(
      activePlan: clearPlan ? null : (activePlan ?? this.activePlan),
      activeGoal: clearGoal ? null : (activeGoal ?? this.activeGoal),
      dailyLog: clearLog ? null : (dailyLog ?? this.dailyLog),
      dailyItems: dailyItems ?? this.dailyItems,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Controller de nutrición del cliente.
/// Carga plan activo + metas + log del día.
@Riverpod(keepAlive: true)
class ClientNutritionController extends _$ClientNutritionController {
  late final NutritionPlanRepository _planRepository;
  late final NutritionGoalRepository _goalRepository;
  late final FoodLogRepository _foodLogRepository;

  @override
  ClientNutritionState build() {
    _planRepository = NutritionPlanRepositoryImpl(
      remote: NutritionPlanRemoteDatasource(
        supabaseClient,
        ref.read(appDatabaseProvider),
      ),
    );
    _goalRepository = NutritionGoalRepositoryImpl(
      remote: NutritionGoalRemoteDatasource(
        supabaseClient,
        ref.read(appDatabaseProvider),
      ),
    );
    _foodLogRepository = FoodLogRepositoryImpl(
      remote: FoodLogRemoteDatasource(
        supabaseClient,
        ref.read(appDatabaseProvider),
      ),
    );

    authProvider.addListener(_onAuthChange);
    ref.onDispose(() => authProvider.removeListener(_onAuthChange));

    if (authProvider.isLoggedIn && !authProvider.isInitializing) {
      Future.microtask(load);
    }

    return const ClientNutritionState();
  }

  void _onAuthChange() {
    if (authProvider.isLoggedIn &&
        !authProvider.isInitializing &&
        !state.isLoading &&
        !state.hasPlan) {
      load();
    }
  }

  String? get _gymId => authProvider.userGymId;
  String? get _clientId => authProvider.userId;

  /// Carga plan activo + metas + log del día.
  Future<void> load() async {
    final gymId = _gymId;
    final clientId = _clientId;
    if (gymId == null || clientId == null) return;

    state = state.copyWith(isLoading: true, clearError: true);

    try {
      // 1. Cargar plan activo del cliente.
      final plansResult = await _planRepository.fetchClientPlans(clientId);
      NutritionPlan? activePlan;
      plansResult.when(
        idle: () {},
        loading: () {},
        success: (plans) {
          if (plans.isNotEmpty) {
            activePlan = plans.first;
          }
        },
        failure: (error) {
          state = state.copyWith(error: error.code);
        },
      );

      // 2. Cargar metas nutricionales.
      final goalResult = await _goalRepository.fetchActiveGoal(
        clientId: clientId,
        gymId: gymId,
      );
      NutritionGoal? activeGoal;
      goalResult.when(
        idle: () {},
        loading: () {},
        success: (goal) {
          activeGoal = goal;
        },
        failure: (error) {
          state = state.copyWith(error: error.code);
        },
      );

      // 3. Cargar log del día.
      final logResult = await _foodLogRepository.fetchDailyLog(
        gymId: gymId,
        date: DateTime.now(),
      );
      FoodLog? dailyLog;
      List<FoodLogItem> dailyItems = [];
      logResult.when(
        idle: () {},
        loading: () {},
        success: (data) {
          dailyLog = data.$1;
          dailyItems = data.$2;
        },
        failure: (error) {
          state = state.copyWith(error: error.code);
        },
      );

      state = state.copyWith(
        isLoading: false,
        activePlan: activePlan,
        activeGoal: activeGoal,
        dailyLog: dailyLog,
        dailyItems: dailyItems,
        clearPlan: activePlan == null,
        clearGoal: activeGoal == null,
        clearLog: dailyLog == null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'client/nutrition-load-error',
      );
    }
  }

  /// Agrega una comida al log del día.
  Future<void> addFoodToLog({
    required String foodId,
    required MealType mealType,
    required double quantity,
  }) async {
    final gymId = _gymId;
    if (gymId == null) return;

    final result = await _foodLogRepository.addFoodToLog(
      gymId: gymId,
      foodId: foodId,
      mealType: mealType,
      quantity: quantity,
    );

    result.when(
      idle: () {},
      loading: () {},
      success: (_) {
        _reloadDailyLog();
      },
      failure: (error) {
        state = state.copyWith(error: error.code);
      },
    );
  }

  /// Elimina una comida del log.
  Future<void> removeFoodFromLog(String itemId) async {
    final result = await _foodLogRepository.removeLogItem(itemId);

    result.when(
      idle: () {},
      loading: () {},
      success: (_) {
        _reloadDailyLog();
      },
      failure: (error) {
        state = state.copyWith(error: error.code);
      },
    );
  }

  /// Recarga solo el log del día (para actualizar totales).
  Future<void> _reloadDailyLog() async {
    final gymId = _gymId;
    if (gymId == null) return;

    final logResult = await _foodLogRepository.fetchDailyLog(
      gymId: gymId,
      date: DateTime.now(),
    );

    logResult.when(
      idle: () {},
      loading: () {},
      success: (data) {
        state = state.copyWith(dailyLog: data.$1, dailyItems: data.$2);
      },
      failure: (error) {
        state = state.copyWith(error: error.code);
      },
    );
  }
}
