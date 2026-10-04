import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/nutrition_goal.dart';
import '../../domain/enums/goal_type.dart';
import '../../domain/repositories/nutrition_goal_repository.dart';
import '../datasources/nutrition_goal_remote_datasource.dart';

/// Implementación del repositorio de metas nutricionales.
class NutritionGoalRepositoryImpl implements NutritionGoalRepository {
  NutritionGoalRepositoryImpl({required NutritionGoalRemoteDatasource remote})
    : _remote = remote;

  final NutritionGoalRemoteDatasource _remote;

  @override
  Future<Result<NutritionGoal?>> fetchActiveGoal({
    required String clientId,
    required String gymId,
  }) async {
    try {
      final goal = await _remote.fetchActiveGoal(
        clientId: clientId,
        gymId: gymId,
      );
      return Result.success(goal);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'goal/fetch-error',
          message: 'Error al cargar metas nutricionales',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<NutritionGoal>> upsertGoal({
    required String clientId,
    required String gymId,
    required GoalType goalType,
    required double targetCaloriesKcal,
    required double targetProteinG,
    required double targetCarbsG,
    required double targetFatsG,
    String? notes,
  }) async {
    try {
      final userId = _remote.client.auth.currentUser?.id;
      if (userId == null) {
        return const Result.failure(
          UnauthorizedException(
            code: 'goal/unauthorized',
            message: 'Usuario no autenticado',
          ),
        );
      }

      final goal = await _remote.upsertGoal(
        clientId: clientId,
        gymId: gymId,
        setBy: userId,
        goalType: goalType,
        targetCaloriesKcal: targetCaloriesKcal,
        targetProteinG: targetProteinG,
        targetCarbsG: targetCarbsG,
        targetFatsG: targetFatsG,
        notes: notes,
      );
      return Result.success(goal);
    } catch (e) {
      return Result.failure(
        NetworkException(
          code: 'goal/upsert-error',
          message: 'Error al guardar metas nutricionales',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<NutritionGoal>> calculateSuggestedGoal({
    required String clientId,
    required String gymId,
    required GoalType goalType,
  }) async {
    // F5: Cálculo inteligente con datos del cliente (peso, altura, etc).
    // Por ahora retorna una meta genérica según el tipo de objetivo.
    try {
      final suggested = switch (goalType) {
        GoalType.lose => NutritionGoal(
          id: '',
          clientId: clientId,
          gymId: gymId,
          targetCaloriesKcal: 1800,
          targetProteinG: 160,
          targetCarbsG: 150,
          targetFatsG: 55,
          goalType: GoalType.lose,
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        GoalType.maintain => NutritionGoal(
          id: '',
          clientId: clientId,
          gymId: gymId,
          targetCaloriesKcal: 2200,
          targetProteinG: 150,
          targetCarbsG: 220,
          targetFatsG: 65,
          goalType: GoalType.maintain,
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        GoalType.gain => NutritionGoal(
          id: '',
          clientId: clientId,
          gymId: gymId,
          targetCaloriesKcal: 2800,
          targetProteinG: 180,
          targetCarbsG: 300,
          targetFatsG: 75,
          goalType: GoalType.gain,
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      };
      return Result.success(suggested);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'goal/calculate-error',
          message: 'Error al calcular meta sugerida',
          cause: e,
        ),
      );
    }
  }
}
