import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/nutrition_goal.dart';
import '../../domain/repositories/nutrition_goals_repository.dart';
import '../datasources/nutrition_goals_remote_datasource.dart';

/// Implementación del repositorio de objetivos nutricionales.
class NutritionGoalsRepositoryImpl implements NutritionGoalsRepository {
  final NutritionGoalsRemoteDatasource _remote;

  const NutritionGoalsRepositoryImpl({
    required NutritionGoalsRemoteDatasource remote,
  }) : _remote = remote;

  @override
  Future<Result<NutritionGoal?>> getGoalForClient({
    required String clientId,
    required String gymId,
  }) async {
    try {
      final goal = await _remote.fetchGoalForClient(clientId, gymId);
      return Result.success(goal);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'NutritionGoals/fetch-error',
          message: 'Error al cargar los objetivos del cliente',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<NutritionGoal>> setGoal({
    required String clientId,
    required String gymId,
    String? setBy,
    required double targetCaloriesKcal,
    required double targetProteinG,
    required double targetCarbsG,
    required double targetFatsG,
    required GoalType goalType,
    String? notes,
  }) async {
    try {
      final goal = await _remote.setGoal(
        clientId: clientId,
        gymId: gymId,
        setBy: setBy,
        targetCaloriesKcal: targetCaloriesKcal,
        targetProteinG: targetProteinG,
        targetCarbsG: targetCarbsG,
        targetFatsG: targetFatsG,
        goalType: goalType,
        notes: notes,
      );
      return Result.success(goal);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'NutritionGoals/set-error',
          message: 'Error al guardar los objetivos',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> deactivateGoal({required String goalId}) async {
    try {
      await _remote.deactivateGoal(goalId);
      return const Result<void>.success(null);
    } on AppException catch (e) {
      return Result<void>.failure(e);
    } catch (e) {
      return Result<void>.failure(
        UnknownException(
          code: 'NutritionGoals/deactivate-error',
          message: 'Error al desactivar los objetivos',
          cause: e,
        ),
      );
    }
  }
}
