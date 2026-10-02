import '../../../../core/utils/result.dart';
import '../entities/training_plan.dart';

/// Contrato para gestionar planes de entrenamiento (planificador semanal).
abstract interface class TrainingPlansRepository {
  /// Lista de planes del gimnasio.
  Future<Result<List<TrainingPlan>>> getPlans({required String gymId});

  /// Detalle de un plan con semanas y días.
  Future<Result<TrainingPlan>> getPlan({required String planId});

  /// Crea un plan.
  Future<Result<TrainingPlan>> createPlan({
    required String gymId,
    required String clientId,
    required String name,
    String? description,
  });

  /// Actualiza un plan.
  Future<Result<TrainingPlan>> updatePlan({required TrainingPlan plan});

  /// Desactiva un plan.
  Future<Result<void>> deactivatePlan({required String planId});

  /// Agrega una semana al plan (valida límite del tier).
  Future<Result<void>> addWeek({
    required String planId,
    required int weekNumber,
    String? name,
  });

  /// Duplica una semana (valida permiso del tier).
  Future<Result<void>> duplicateWeek({
    required String weekId,
    required int newWeekNumber,
    String? newName,
  });

  /// Elimina una semana.
  Future<Result<void>> deleteWeek({required String weekId});

  /// Asigna una rutina a un día de la semana.
  Future<Result<void>> assignDay({
    required String weekId,
    required int dayOfWeek,
    String? routineId,
    bool isRestDay = false,
    String? notes,
  });

  /// Obtiene el plan activo del cliente con su semana actual.
  Future<Result<TrainingPlan?>> getClientPlan({
    required String userId,
    required String gymId,
  });

  /// Avanza la semana actual del plan.
  Future<Result<void>> advanceWeek({required String planId});
}
