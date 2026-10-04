import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../../../core/providers/supabase_provider.dart';
import '../../data/datasources/food_log_remote_datasource.dart';
import '../../data/repositories/food_log_repository_impl.dart';
import '../../domain/entities/food_log.dart';
import '../../domain/entities/food_log_item.dart';
import '../../domain/enums/meal_type.dart';
import '../../domain/repositories/food_log_repository.dart';

part 'food_log_controller.g.dart';

/// Estado del registro diario de comidas.
class FoodLogState {
  const FoodLogState({
    this.log,
    this.items = const [],
    this.history = const [],
    this.isLoading = false,
    this.isAdding = false,
    this.error,
  });

  final FoodLog? log;
  final List<FoodLogItem> items;
  final List<FoodLog> history;
  final bool isLoading;
  final bool isAdding;
  final String? error;

  bool get hasLog => log != null;
  bool get isEmpty => items.isEmpty && error == null;

  /// Totales del día desde el log.
  double get totalCalories => log?.totalCaloriesKcal ?? 0;
  double get totalProtein => log?.totalProteinG ?? 0;
  double get totalCarbs => log?.totalCarbsG ?? 0;
  double get totalFats => log?.totalFatsG ?? 0;

  /// Items agrupados por tipo de comida.
  Map<MealType, List<FoodLogItem>> get itemsByMealType {
    final map = <MealType, List<FoodLogItem>>{};
    for (final item in items) {
      map.putIfAbsent(item.mealType, () => []).add(item);
    }
    return map;
  }

  FoodLogState copyWith({
    FoodLog? log,
    List<FoodLogItem>? items,
    List<FoodLog>? history,
    bool? isLoading,
    bool? isAdding,
    String? error,
    bool clearError = false,
    bool clearLog = false,
  }) {
    return FoodLogState(
      log: clearLog ? null : (log ?? this.log),
      items: items ?? this.items,
      history: history ?? this.history,
      isLoading: isLoading ?? this.isLoading,
      isAdding: isAdding ?? this.isAdding,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Controlador del registro diario de comidas del cliente.
@Riverpod(keepAlive: true)
class FoodLogController extends _$FoodLogController {
  late final FoodLogRepository _repository;

  @override
  FoodLogState build() {
    _repository = FoodLogRepositoryImpl(
      remote: FoodLogRemoteDatasource(supabaseClient),
    );

    authProvider.addListener(_onAuthChange);
    ref.onDispose(() => authProvider.removeListener(_onAuthChange));

    if (authProvider.isLoggedIn && !authProvider.isInitializing) {
      Future.microtask(() => loadDailyLog(DateTime.now()));
    }

    return const FoodLogState();
  }

  void _onAuthChange() {
    if (authProvider.isLoggedIn &&
        !authProvider.isInitializing &&
        !state.isLoading &&
        state.log == null) {
      loadDailyLog(DateTime.now());
    }
  }

  String? get _gymId => authProvider.userGymId;

  /// Carga el log del día con sus items.
  Future<void> loadDailyLog(DateTime date) async {
    final gymId = _gymId;
    if (gymId == null) return;

    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.fetchDailyLog(gymId: gymId, date: date);
    result.when(
      idle: () {},
      loading: () {},
      success: (data) {
        final (log, items) = data;
        state = state.copyWith(
          isLoading: false,
          log: log,
          items: items,
          clearLog: log == null,
        );
      },
      failure: (error) {
        state = state.copyWith(isLoading: false, error: error.code);
      },
    );
  }

  /// Carga historial de logs para gráficos.
  Future<void> loadHistory({
    required DateTime from,
    required DateTime to,
  }) async {
    final gymId = _gymId;
    if (gymId == null) return;

    final result = await _repository.fetchLogHistory(
      gymId: gymId,
      from: from,
      to: to,
    );
    result.when(
      idle: () {},
      loading: () {},
      success: (history) {
        state = state.copyWith(history: history);
      },
      failure: (error) {
        state = state.copyWith(error: error.code);
      },
    );
  }

  /// Agrega un alimento al log del día.
  Future<bool> addFood({
    required String foodId,
    required MealType mealType,
    required double quantity,
  }) async {
    final gymId = _gymId;
    if (gymId == null) return false;

    state = state.copyWith(isAdding: true);

    final result = await _repository.addFoodToLog(
      gymId: gymId,
      foodId: foodId,
      mealType: mealType,
      quantity: quantity,
    );

    return result.when(
      idle: () => false,
      loading: () => false,
      success: (_) {
        state = state.copyWith(isAdding: false);
        // Recargar el log para obtener totales actualizados.
        loadDailyLog(DateTime.now());
        return true;
      },
      failure: (error) {
        state = state.copyWith(isAdding: false, error: error.code);
        return false;
      },
    );
  }

  /// Elimina un item del log.
  Future<bool> removeItem(String itemId) async {
    final result = await _repository.removeLogItem(itemId);
    return result.when(
      idle: () => false,
      loading: () => false,
      success: (_) {
        loadDailyLog(DateTime.now());
        return true;
      },
      failure: (error) {
        state = state.copyWith(error: error.code);
        return false;
      },
    );
  }

  /// Actualiza la cantidad de un item.
  Future<bool> updateItemQuantity({
    required String itemId,
    required double newQuantity,
  }) async {
    final result = await _repository.updateLogItemQuantity(
      itemId: itemId,
      newQuantity: newQuantity,
    );
    return result.when(
      idle: () => false,
      loading: () => false,
      success: (_) {
        loadDailyLog(DateTime.now());
        return true;
      },
      failure: (error) {
        state = state.copyWith(error: error.code);
        return false;
      },
    );
  }

  /// Actualiza las notas del log.
  Future<bool> updateNotes(String notes) async {
    final logId = state.log?.id;
    if (logId == null) return false;

    final result = await _repository.updateLogNotes(logId: logId, notes: notes);
    return result.when(
      idle: () => false,
      loading: () => false,
      success: (log) {
        state = state.copyWith(log: log);
        return true;
      },
      failure: (error) {
        state = state.copyWith(error: error.code);
        return false;
      },
    );
  }
}
