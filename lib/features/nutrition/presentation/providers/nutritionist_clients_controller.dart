import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../../../core/providers/supabase_provider.dart';

part 'nutritionist_clients_controller.g.dart';

/// Cliente asignado al nutricionista (vista simplificada).
class NutritionistClient {
  const NutritionistClient({
    required this.userId,
    required this.fullName,
    required this.email,
    this.avatarUrl,
    this.activePlansCount = 0,
    this.lastLogDate,
  });

  final String userId;
  final String fullName;
  final String email;
  final String? avatarUrl;
  final int activePlansCount;
  final DateTime? lastLogDate;
}

/// Estado de clientes del nutricionista.
class NutritionistClientsState {
  const NutritionistClientsState({
    this.clients = const [],
    this.isLoading = false,
    this.error,
  });

  final List<NutritionistClient> clients;
  final bool isLoading;
  final String? error;

  bool get hasData => clients.isNotEmpty && error == null;
  bool get isEmpty => clients.isEmpty && error == null;

  NutritionistClientsState copyWith({
    List<NutritionistClient>? clients,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return NutritionistClientsState(
      clients: clients ?? this.clients,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Controlador de clientes asignados al nutricionista.
@Riverpod(keepAlive: true)
class NutritionistClientsController extends _$NutritionistClientsController {
  @override
  NutritionistClientsState build() {
    authProvider.addListener(_onAuthChange);
    ref.onDispose(() => authProvider.removeListener(_onAuthChange));

    if (authProvider.isLoggedIn && !authProvider.isInitializing) {
      Future.microtask(load);
    }

    return const NutritionistClientsState();
  }

  void _onAuthChange() {
    if (authProvider.isLoggedIn &&
        !authProvider.isInitializing &&
        !state.isLoading &&
        state.clients.isEmpty) {
      load();
    }
  }

  String? get _gymId => authProvider.userGymId;

  /// Carga los clientes del gimnasio con rol 'client'.
  Future<void> load() async {
    final gymId = _gymId;
    if (gymId == null) return;

    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final response = await supabaseClient
          .from('memberships')
          .select('''
            user_id,
            user:profiles!memberships_user_id_fkey (
              full_name,
              email,
              avatar_url
            )
          ''')
          .eq('gym_id', gymId)
          .eq('role', 'client')
          .eq('is_active', true)
          .order('created_at');

      final rows = response as List;
      final clients = <NutritionistClient>[];

      for (final row in rows) {
        final map = row as Map<String, dynamic>;
        final userId = map['user_id'] as String;
        final profile = map['user'] as Map<String, dynamic>?;

        // Contar planes activos del cliente con este nutricionista.
        final plansResponse = await supabaseClient
            .from('nutrition_plans')
            .select('id')
            .eq('client_id', userId)
            .eq('nutritionist_id', authProvider.userId ?? '')
            .eq('is_active', true);

        final plansCount = (plansResponse as List).length;

        // Obtener fecha del último food log.
        final lastLogResponse = await supabaseClient
            .from('food_logs')
            .select('log_date')
            .eq('client_id', userId)
            .eq('gym_id', gymId)
            .order('log_date', ascending: false)
            .limit(1)
            .maybeSingle();

        DateTime? lastLogDate;
        if (lastLogResponse != null) {
          lastLogDate = DateTime.parse(lastLogResponse['log_date'] as String);
        }

        clients.add(
          NutritionistClient(
            userId: userId,
            fullName: (profile?['full_name'] as String?) ?? 'Cliente',
            email: (profile?['email'] as String?) ?? '',
            avatarUrl: profile?['avatar_url'] as String?,
            activePlansCount: plansCount,
            lastLogDate: lastLogDate,
          ),
        );
      }

      state = state.copyWith(isLoading: false, clients: clients);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'NutritionistClients/fetch-error',
      );
    }
  }
}
