import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../../../core/providers/supabase_provider.dart';
import '../../data/datasources/client_dashboard_remote_datasource.dart';
import '../../data/repositories/client_dashboard_repository_impl.dart';
import '../../domain/entities/client_dashboard_stats.dart';
import '../../domain/repositories/client_dashboard_repository.dart';

part 'client_dashboard_controller.g.dart';

/// Estado del dashboard del cliente.
class ClientDashboardState {
  const ClientDashboardState({this.stats, this.isLoading = false, this.error});

  final ClientDashboardStats? stats;
  final bool isLoading;
  final String? error;

  bool get isEmpty => !isLoading && error == null && stats == null;
  bool get hasData => stats != null && error == null;

  ClientDashboardState copyWith({
    ClientDashboardStats? stats,
    bool? isLoading,
    String? error,
    bool clearError = false,
    bool clearStats = false,
  }) {
    return ClientDashboardState(
      stats: clearStats ? null : (stats ?? this.stats),
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Controlador del dashboard del cliente.
/// keepAlive para conservar estado al cambiar entre tabs del shell.
@Riverpod(keepAlive: true)
class ClientDashboardController extends _$ClientDashboardController {
  late final ClientDashboardRepository _repository;

  @override
  ClientDashboardState build() {
    _repository = ClientDashboardRepositoryImpl(
      remote: ClientDashboardRemoteDatasource(supabaseClient),
    );

    // Listener reactivo a la sesión (mismo patrón que admin).
    authProvider.addListener(_onAuthChange);
    ref.onDispose(() => authProvider.removeListener(_onAuthChange));

    if (authProvider.isLoggedIn && !authProvider.isInitializing) {
      Future.microtask(load);
    }

    return const ClientDashboardState();
  }

  void _onAuthChange() {
    if (authProvider.isLoggedIn &&
        !authProvider.isInitializing &&
        !state.isLoading &&
        state.stats == null) {
      load();
    }
  }

  /// Carga/recarga las estadísticas del dashboard.
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
