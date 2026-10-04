import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../data/datasources/nutrition_clients_remote_datasource.dart';
import '../../data/repositories/nutrition_clients_repository_impl.dart';
import '../../domain/entities/nutrition_client.dart';
import '../../domain/repositories/nutrition_clients_repository.dart';

part 'nutritionist_clients_controller.g.dart';

@riverpod
NutritionClientsRepository nutritionClientsRepository(Ref ref) {
  return NutritionClientsRepositoryImpl(
    remote: NutritionClientsRemoteDatasource(Supabase.instance.client),
  );
}

/// Controller de la lista de clientes del nutricionista.
/// keepAlive para que la lista sobreviva al navegar al detalle y volver.
@Riverpod(keepAlive: true)
class NutritionistClientsController extends _$NutritionistClientsController {
  late final NutritionClientsRepository _repository;

  @override
  AsyncValue<List<NutritionClient>> build() {
    _repository = ref.watch(nutritionClientsRepositoryProvider);

    authProvider.addListener(_onAuthChange);
    ref.onDispose(() => authProvider.removeListener(_onAuthChange));

    if (authProvider.isLoggedIn && !authProvider.isInitializing) {
      Future.microtask(load);
    }

    return const AsyncValue.loading();
  }

  void _onAuthChange() {
    if (!authProvider.isLoggedIn) {
      state = const AsyncValue.data([]);
      return;
    }
    if (!authProvider.isInitializing && state.value == null) {
      load();
    }
  }

  /// Carga los clientes del gym del nutricionista.
  Future<void> load() async {
    final gymId = authProvider.userGymId;
    if (gymId == null) {
      state = AsyncValue.error(
        const UnknownException(
          code: 'NutritionClients/no-gym',
          message: 'Usuario sin gimnasio activo',
        ),
        StackTrace.current,
      );
      return;
    }

    state = const AsyncValue.loading();
    final result = await _repository.getClients(gymId: gymId);

    result.when(
      idle: () {},
      loading: () {},
      success: (clients) => state = AsyncValue.data(clients),
      failure: (error) => state = AsyncValue.error(error, StackTrace.current),
    );
  }
}
