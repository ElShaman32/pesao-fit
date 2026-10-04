import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../data/datasources/nutritionist_dashboard_remote_datasource.dart';
import '../../data/repositories/nutritionist_dashboard_repository_impl.dart';
import '../../domain/entities/nutritionist_stats.dart';
import '../../domain/repositories/nutritionist_dashboard_repository.dart';

part 'nutritionist_dashboard_controller.g.dart';

@riverpod
NutritionistDashboardRepository nutritionistDashboardRepository(Ref ref) {
  return NutritionistDashboardRepositoryImpl(
    remote: NutritionistDashboardRemoteDatasource(Supabase.instance.client),
  );
}

/// Controller de estadísticas del dashboard del nutricionista.
/// keepAlive para que las stats sobrevivan a la navegación entre tabs.
@Riverpod(keepAlive: true)
class NutritionistDashboardController
    extends _$NutritionistDashboardController {
  late final NutritionistDashboardRepository _repository;

  @override
  AsyncValue<NutritionistStats> build() {
    _repository = ref.watch(nutritionistDashboardRepositoryProvider);

    authProvider.addListener(_onAuthChange);
    ref.onDispose(() => authProvider.removeListener(_onAuthChange));

    if (authProvider.isLoggedIn && !authProvider.isInitializing) {
      Future.microtask(load);
    }

    return const AsyncValue.loading();
  }

  void _onAuthChange() {
    if (!authProvider.isLoggedIn) {
      state = const AsyncValue.data(
        NutritionistStats(
          totalClients: 0,
          activePlans: 0,
          totalFoods: 0,
          clientsWithoutPlan: 0,
        ),
      );
      return;
    }
    if (!authProvider.isInitializing && state.value == null) {
      load();
    }
  }

  /// Carga las stats del dashboard.
  Future<void> load() async {
    final gymId = authProvider.userGymId;
    if (gymId == null) {
      state = AsyncValue.error(
        const UnknownException(
          code: 'NutritionistDashboard/no-gym',
          message: 'Usuario sin gimnasio activo',
        ),
        StackTrace.current,
      );
      return;
    }

    state = const AsyncValue.loading();
    final result = await _repository.getStats(gymId: gymId);

    result.when(
      idle: () {},
      loading: () {},
      success: (stats) => state = AsyncValue.data(stats),
      failure: (error) => state = AsyncValue.error(error, StackTrace.current),
    );
  }
}
