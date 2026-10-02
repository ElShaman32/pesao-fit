import '../../../../core/utils/result.dart';
import '../entities/gym_membership_plan.dart';

/// Contrato para gestionar planes de membresía del gimnasio (owner).
abstract interface class MembershipPlansRepository {
  Future<Result<List<GymMembershipPlan>>> getPlans({required String gymId});

  Future<Result<GymMembershipPlan>> createPlan({
    required String gymId,
    required String name,
    String? description,
    required double priceUsd,
    required int durationDays,
    bool includesTrainer = false,
    bool includesNutritionist = false,
  });

  Future<Result<GymMembershipPlan>> updatePlan({
    required GymMembershipPlan plan,
  });

  Future<Result<void>> deactivatePlan({required String planId});

  /// Verifica si el gym puede crear más planes según su tier.
  Future<Result<bool>> canAddPlan({required String gymId});
}
