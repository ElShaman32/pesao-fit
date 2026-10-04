import '../../../../core/utils/result.dart';
import '../entities/nutrition_goal.dart';

/// Contrato para gestionar los objetivos nutricionales de un cliente.
abstract interface class NutritionGoalsRepository {
  /// Obtiene el goal activo de un cliente en un gym (null si no tiene).
  Future<Result<NutritionGoal?>> getGoalForClient({
    required String clientId,
    required String gymId,
  });

  /// Crea o actualiza el goal de un cliente (idempotente por client+gym).
  Future<Result<NutritionGoal>> setGoal({
    required String clientId,
    required String gymId,
    required double targetCaloriesKcal,
    required double targetProteinG,
    required double targetCarbsG,
    required double targetFatsG,
    required GoalType goalType,
    String? notes,
    String? setBy,
  });

  /// Desactiva el goal de un cliente (sin borrarlo, para auditoría).
  Future<Result<void>> deactivateGoal({required String goalId});
}
