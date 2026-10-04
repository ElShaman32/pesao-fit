import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/utils/result.dart';
import '../../data/datasources/nutrition_goals_remote_datasource.dart';
import '../../data/repositories/nutrition_goals_repository_impl.dart';
import '../../domain/entities/nutrition_goal.dart';
import '../../domain/repositories/nutrition_goals_repository.dart';

part 'nutrition_goals_controller.g.dart';

@riverpod
NutritionGoalsRepository nutritionGoalsRepository(Ref ref) {
  return NutritionGoalsRepositoryImpl(
    remote: NutritionGoalsRemoteDatasource(Supabase.instance.client),
  );
}

/// Controller de objetivos nutricionales del cliente actualmente en foco.
/// El nutricionista fija/edita goals desde la pantalla de detalle del cliente.
@Riverpod(keepAlive: true)
class NutritionGoalsController extends _$NutritionGoalsController {
  late final NutritionGoalsRepository _repository;

  @override
  AsyncValue<NutritionGoal?> build() {
    _repository = ref.watch(nutritionGoalsRepositoryProvider);

    authProvider.addListener(_onAuthChange);
    ref.onDispose(() => authProvider.removeListener(_onAuthChange));

    return const AsyncValue.data(null);
  }

  void _onAuthChange() {
    if (!authProvider.isLoggedIn) {
      state = const AsyncValue.data(null);
    }
  }

  /// Carga el goal activo del cliente en foco.
  Future<void> loadForClient({required String clientId}) async {
    final gymId = authProvider.userGymId;
    if (gymId == null) {
      state = AsyncValue.error(
        const UnknownException(
          code: 'NutritionGoals/no-gym',
          message: 'Usuario sin gimnasio activo',
        ),
        StackTrace.current,
      );
      return;
    }

    state = const AsyncValue.loading();

    final result = await _repository.getGoalForClient(
      clientId: clientId,
      gymId: gymId,
    );

    result.when(
      idle: () {},
      loading: () {},
      success: (goal) => state = AsyncValue.data(goal),
      failure: (error) => state = AsyncValue.error(error, StackTrace.current),
    );
  }

  /// Guarda (crea o actualiza) el goal del cliente en foco.
  Future<Result<NutritionGoal>> setGoal({
    required String clientId,
    required double targetCaloriesKcal,
    required double targetProteinG,
    required double targetCarbsG,
    required double targetFatsG,
    required GoalType goalType,
    String? notes,
  }) async {
    final gymId = authProvider.userGymId;
    if (gymId == null) {
      return const Result.failure(
        UnknownException(
          code: 'NutritionGoals/no-gym',
          message: 'Sin gimnasio',
        ),
      );
    }

    final result = await _repository.setGoal(
      clientId: clientId,
      gymId: gymId,
      setBy: authProvider.userId,
      targetCaloriesKcal: targetCaloriesKcal,
      targetProteinG: targetProteinG,
      targetCarbsG: targetCarbsG,
      targetFatsG: targetFatsG,
      goalType: goalType,
      notes: notes,
    );

    if (result.isSuccess) {
      await loadForClient(clientId: clientId);
    }
    return result;
  }
}
