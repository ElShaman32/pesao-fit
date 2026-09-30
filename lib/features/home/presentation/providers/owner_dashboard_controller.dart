import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../../../core/providers/supabase_provider.dart';
import '../../data/datasources/owner_dashboard_remote_datasource.dart';
import '../../data/repositories/owner_dashboard_repository_impl.dart';
import '../../domain/entities/owner_dashboard_stats.dart';
import '../../domain/repositories/owner_dashboard_repository.dart';

part 'owner_dashboard_controller.g.dart';

/// Estado del dashboard del dueño.
class OwnerDashboardState {
  const OwnerDashboardState({this.stats, this.isLoading = false, this.error});

  final OwnerDashboardStats? stats;
  final bool isLoading;
  final String? error;

  bool get hasData => stats != null && error == null;

  OwnerDashboardState copyWith({
    OwnerDashboardStats? stats,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return OwnerDashboardState(
      stats: stats ?? this.stats,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Controlador del dashboard del dueño.
@Riverpod(keepAlive: true)
class OwnerDashboardController extends _$OwnerDashboardController {
  late final OwnerDashboardRepository _repository;

  @override
  OwnerDashboardState build() {
    _repository = OwnerDashboardRepositoryImpl(
      remote: OwnerDashboardRemoteDatasource(supabaseClient),
    );

    authProvider.addListener(_onAuthChange);
    ref.onDispose(() => authProvider.removeListener(_onAuthChange));

    if (authProvider.isLoggedIn && !authProvider.isInitializing) {
      Future.microtask(load);
    }

    return const OwnerDashboardState();
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
