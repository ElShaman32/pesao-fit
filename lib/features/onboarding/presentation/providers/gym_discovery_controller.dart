import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/supabase_provider.dart';
import '../../data/datasources/gym_discovery_remote_datasource.dart';
import '../../data/repositories/gym_discovery_repository_impl.dart';
import '../../domain/entities/gym.dart';
import '../../domain/repositories/gym_discovery_repository.dart';

part 'gym_discovery_controller.g.dart';

/// Estado del flujo de gym discovery.
class GymDiscoveryState {
  const GymDiscoveryState({
    this.gyms = const [],
    this.isLoading = false,
    this.isJoining = false,
    this.hasJoined = false,
    this.error,
  });

  final List<Gym> gyms;
  final bool isLoading;
  final bool isJoining;
  final bool hasJoined;
  final String? error;

  bool get isEmpty => !isLoading && gyms.isEmpty && error == null;

  GymDiscoveryState copyWith({
    List<Gym>? gyms,
    bool? isLoading,
    bool? isJoining,
    bool? hasJoined,
    String? error,
    bool clearError = false,
  }) {
    return GymDiscoveryState(
      gyms: gyms ?? this.gyms,
      isLoading: isLoading ?? this.isLoading,
      isJoining: isJoining ?? this.isJoining,
      hasJoined: hasJoined ?? this.hasJoined,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Controlador del flujo de gym discovery.
@riverpod
class GymDiscoveryController extends _$GymDiscoveryController {
  late final GymDiscoveryRepository _repository;
  Timer? _debounce;

  @override
  GymDiscoveryState build() {
    _repository = GymDiscoveryRepositoryImpl(
      remote: GymDiscoveryRemoteDatasource(supabaseClient),
    );
    // Cargar todos los gimnasios al iniciar.
    _loadGyms('');
    ref.onDispose(() => _debounce?.cancel());
    return const GymDiscoveryState();
  }

  /// Busca con debounce para no saturar la red.
  void search(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      _loadGyms(query);
    });
  }

  Future<void> _loadGyms(String query) async {
    state = state.copyWith(isLoading: true, clearError: true);
    final result = await _repository.searchGyms(query);
    result.when(
      idle: () {},
      loading: () {},
      success: (gyms) {
        state = state.copyWith(isLoading: false, gyms: gyms);
      },
      failure: (error) {
        state = state.copyWith(isLoading: false, error: error.code);
      },
    );
  }

  /// Crea la membresía de cliente en el gimnasio elegido.
  Future<void> joinGym(String gymId) async {
    if (state.isJoining) return;
    state = state.copyWith(isJoining: true, clearError: true);

    final result = await _repository.joinGym(gymId);
    result.when(
      idle: () {},
      loading: () {},
      success: (_) {
        state = state.copyWith(isJoining: false, hasJoined: true);
      },
      failure: (error) {
        state = state.copyWith(isJoining: false, error: error.code);
      },
    );
  }
}
