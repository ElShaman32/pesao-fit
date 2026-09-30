import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../../../core/providers/supabase_provider.dart';
import '../../data/datasources/trainer_dashboard_remote_datasource.dart';
import '../../data/repositories/trainer_dashboard_repository_impl.dart';
import '../../domain/entities/trainer_dashboard_stats.dart';
import '../../domain/repositories/trainer_dashboard_repository.dart';

part 'trainer_dashboard_controller.g.dart';

/// Estado del dashboard del entrenador.
class TrainerDashboardState {
  const TrainerDashboardState({this.stats, this.isLoading = false, this.error});

  final TrainerDashboardStats? stats;
  final bool isLoading;
  final String? error;

  bool get hasData => stats != null && error == null;

  TrainerDashboardState copyWith({
    TrainerDashboardStats? stats,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return TrainerDashboardState(
      stats: stats ?? this.stats,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Controlador del dashboard del entrenador.
@Riverpod(keepAlive: true)
class TrainerDashboardController extends _$TrainerDashboardController {
  late final TrainerDashboardRepository _repository;

  @override
  TrainerDashboardState build() {
    _repository = TrainerDashboardRepositoryImpl(
      remote: TrainerDashboardRemoteDatasource(supabaseClient),
    );

    authProvider.addListener(_onAuthChange);
    ref.onDispose(() => authProvider.removeListener(_onAuthChange));

    if (authProvider.isLoggedIn && !authProvider.isInitializing) {
      Future.microtask(load);
    }

    return const TrainerDashboardState();
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
