import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../../../core/providers/supabase_provider.dart';
import '../../data/datasources/gym_application_review_remote_datasource.dart';
import '../../data/repositories/gym_application_review_repository_impl.dart';
import '../../domain/entities/gym_application.dart';
import '../../domain/repositories/gym_application_review_repository.dart';

part 'applications_review_controller.g.dart';

/// Estado del panel de revisión de solicitudes.
class ApplicationsReviewState {
  const ApplicationsReviewState({
    this.applications = const [],
    this.isLoading = false,
    this.isActing = false,
    this.error,
  });

  final List<GymApplication> applications;
  final bool isLoading;
  final bool isActing;
  final String? error;

  bool get isEmpty => !isLoading && applications.isEmpty && error == null;

  ApplicationsReviewState copyWith({
    List<GymApplication>? applications,
    bool? isLoading,
    bool? isActing,
    String? error,
    bool clearError = false,
  }) {
    return ApplicationsReviewState(
      applications: applications ?? this.applications,
      isLoading: isLoading ?? this.isLoading,
      isActing: isActing ?? this.isActing,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Controlador del panel de revisión de solicitudes (keepAlive para que
/// lista y detalle compartan el mismo estado).
@Riverpod(keepAlive: true)
class ApplicationsReviewController extends _$ApplicationsReviewController {
  late final GymApplicationReviewRepository _repository;

  @override
  ApplicationsReviewState build() {
    _repository = GymApplicationReviewRepositoryImpl(
      remote: GymApplicationReviewRemoteDatasource(supabaseClient),
    );

    // Escuchar cambios de sesión: recargar cuando la sesión esté disponible.
    // Esto resuelve el race condition donde build() corre antes de que
    // el token se propague al cliente HTTP de Supabase.
    authProvider.addListener(_onAuthChange);
    ref.onDispose(() => authProvider.removeListener(_onAuthChange));

    // Si ya hay sesión, cargar con microtask para dejar asentarse el token.
    if (authProvider.isLoggedIn) {
      Future.microtask(loadPending);
    }

    return const ApplicationsReviewState();
  }

  /// Se dispara cuando la sesión cambia. Recarga si hay sesión y la lista
  /// está vacía (evita pisar una carga en curso o datos ya presentes).
  void _onAuthChange() {
    if (authProvider.isLoggedIn &&
        !state.isLoading &&
        state.applications.isEmpty) {
      loadPending();
    }
  }

  /// Carga las solicitudes pendientes.
  Future<void> loadPending() async {
    state = state.copyWith(isLoading: true, clearError: true);
    final result = await _repository.fetchPending();
    result.when(
      idle: () {},
      loading: () {},
      success: (applications) {
        state = state.copyWith(isLoading: false, applications: applications);
      },
      failure: (error) {
        state = state.copyWith(isLoading: false, error: error.code);
      },
    );
  }

  /// Busca una solicitud por id (para la pantalla de detalle).
  GymApplication? getById(String id) {
    try {
      return state.applications.firstWhere((app) => app.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Aprueba una solicitud. Devuelve true si tuvo éxito.
  Future<bool> approve(String applicationId) async {
    if (state.isActing) return false;
    state = state.copyWith(isActing: true, clearError: true);

    final result = await _repository.approve(applicationId);
    var ok = false;
    result.when(
      idle: () {},
      loading: () {},
      success: (_) => ok = true,
      failure: (error) {
        state = state.copyWith(error: error.code);
      },
    );

    if (ok) await loadPending();
    state = state.copyWith(isActing: false);
    return ok;
  }

  /// Rechaza una solicitud con motivo. Devuelve true si tuvo éxito.
  Future<bool> reject(String applicationId, String reason) async {
    if (state.isActing) return false;
    state = state.copyWith(isActing: true, clearError: true);

    final result = await _repository.reject(applicationId, reason);
    var ok = false;
    result.when(
      idle: () {},
      loading: () {},
      success: (_) => ok = true,
      failure: (error) {
        state = state.copyWith(error: error.code);
      },
    );

    if (ok) await loadPending();
    state = state.copyWith(isActing: false);
    return ok;
  }
}
