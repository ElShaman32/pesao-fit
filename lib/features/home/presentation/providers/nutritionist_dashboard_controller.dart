import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../../../core/providers/supabase_provider.dart';
import '../../data/datasources/nutritionist_dashboard_remote_datasource.dart';
import '../../data/repositories/nutritionist_dashboard_repository_impl.dart';
import '../../domain/entities/nutritionist_dashboard_stats.dart';
import '../../domain/repositories/nutritionist_dashboard_repository.dart';

part 'nutritionist_dashboard_controller.g.dart';

/// Estado del dashboard del nutricionista.
class NutritionistDashboardState {
  const NutritionistDashboardState({
    this.stats,
    this.isLoading = false,
    this.error,
  });

  final NutritionistDashboardStats? stats;
  final bool isLoading;
  final String? error;

  bool get hasData => stats != null && error == null;

  NutritionistDashboardState copyWith({
    NutritionistDashboardStats? stats,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return NutritionistDashboardState(
      stats: stats ?? this.stats,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Controlador del dashboard del nutricionista.
@Riverpod(keepAlive: true)
class NutritionistDashboardController
    extends _$NutritionistDashboardController {
  late final NutritionistDashboardRepository _repository;

  @override
  NutritionistDashboardState build() {
    _repository = NutritionistDashboardRepositoryImpl(
      remote: NutritionistDashboardRemoteDatasource(supabaseClient),
    );

    authProvider.addListener(_onAuthChange);
    ref.onDispose(() => authProvider.removeListener(_onAuthChange));

    if (authProvider.isLoggedIn && !authProvider.isInitializing) {
      Future.microtask(load);
    }

    return const NutritionistDashboardState();
  }

  void _onAuthChange() {
    if (authProvider.isLoggedIn &&
        !authProvider.isInitializing &&
        !state.isLoading &&
        state.stats == null) {
      load();
    }
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, clearError: true);
    final result = await _repository.fetchStats();
    result.when(
      idle: () {},
      loading: () {},
      success: (stats) {
        state = state.copyWith(isLoading: false, stats: stats);
      },
      failure: (error) {
        state = state.copyWith(isLoading: false, error: error.code);
      },
    );
  }
}
