import '../../../../core/utils/result.dart';
import '../entities/nutrition_goal.dart';
import '../enums/goal_type.dart';

/// Repositorio de metas nutricionales por cliente.
abstract interface class NutritionGoalRepository {
  /// Obtiene la meta activa del cliente (o null si no tiene).
  Future<Result<NutritionGoal?>> fetchActiveGoal({
    required String clientId,
    required String gymId,
  });

  /// Crea o actualiza la meta del cliente (upsert por client_id + gym_id).
  Future<Result<NutritionGoal>> upsertGoal({
    required String clientId,
    required String gymId,
    required GoalType goalType,
    required double targetCaloriesKcal,
    required double targetProteinG,
    required double targetCarbsG,
    required double targetFatsG,
    String? notes,
  });

  /// Calcula metas sugeridas basado en datos del cliente (peso, altura, etc).
  /// No persiste, solo retorna la sugerencia.
  Future<Result<NutritionGoal>> calculateSuggestedGoal({
    required String clientId,
    required String gymId,
    required GoalType goalType,
  });
}
