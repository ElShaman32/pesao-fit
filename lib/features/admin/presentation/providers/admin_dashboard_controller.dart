import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../../../core/providers/supabase_provider.dart';
import '../../data/datasources/admin_dashboard_remote_datasource.dart';
import '../../data/repositories/admin_dashboard_repository_impl.dart';
import '../../domain/entities/admin_dashboard_stats.dart';
import '../../domain/repositories/admin_dashboard_repository.dart';

part 'admin_dashboard_controller.g.dart';

/// Estado del dashboard del superadmin.
class AdminDashboardState {
  const AdminDashboardState({this.stats, this.isLoading = false, this.error});

  final AdminDashboardStats? stats;
  final bool isLoading;
  final String? error;

  bool get isEmpty =>
      !isLoading && error == null && (stats == null || stats!.isEmpty);
  bool get hasData => stats != null && error == null;

  AdminDashboardState copyWith({
    AdminDashboardStats? stats,
    bool? isLoading,
    String? error,
    bool clearError = false,
    bool clearStats = false,
  }) {
    return AdminDashboardState(
      stats: clearStats ? null : (stats ?? this.stats),
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Controlador del dashboard del superadmin.
/// keepAlive para que conserve estado al cambiar entre tabs del shell.
@Riverpod(keepAlive: true)
class AdminDashboardController extends _$AdminDashboardController {
  late final AdminDashboardRepository _repository;

  @override
  AdminDashboardState build() {
    _repository = AdminDashboardRepositoryImpl(
      remote: AdminDashboardRemoteDatasource(supabaseClient),
    );

    // Listener reactivo a la sesión (mismo patrón que el controller de
    // solicitudes). Resuelve el race condition del token al iniciar la app.
    authProvider.addListener(_onAuthChange);
    ref.onDispose(() => authProvider.removeListener(_onAuthChange));

    if (authProvider.isLoggedIn && !authProvider.isInitializing) {
      Future.microtask(load);
    }

    return const AdminDashboardState();
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
