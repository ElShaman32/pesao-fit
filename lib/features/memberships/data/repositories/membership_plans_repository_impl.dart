import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/gym_membership_plan.dart';
import '../../domain/repositories/membership_plans_repository.dart';
import '../datasources/membership_plans_remote_datasource.dart';

/// Implementación del repositorio de planes de membresía.
class MembershipPlansRepositoryImpl implements MembershipPlansRepository {
  final MembershipPlansRemoteDatasource _remote;

  const MembershipPlansRepositoryImpl({
    required MembershipPlansRemoteDatasource remote,
  }) : _remote = remote;

  @override
  Future<Result<List<GymMembershipPlan>>> getPlans({
    required String gymId,
  }) async {
    try {
      final plans = await _remote.fetchPlans(gymId);
      return Result.success(plans);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'Membership/fetch-plans',
          message: 'No se pudieron cargar los planes',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<GymMembershipPlan>> createPlan({
    required String gymId,
    required String name,
    String? description,
    required double priceUsd,
    required int durationDays,
    bool includesTrainer = false,
    bool includesNutritionist = false,
  }) async {
    try {
      final plan = await _remote.createPlan(
        gymId: gymId,
        name: name,
        description: description,
        priceUsd: priceUsd,
        durationDays: durationDays,
        includesTrainer: includesTrainer,
        includesNutritionist: includesNutritionist,
      );
      return Result.success(plan);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'Membership/creating-error',
          message: 'No se pudo crear el plan',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<GymMembershipPlan>> updatePlan({
    required GymMembershipPlan plan,
  }) async {
    try {
      final updated = await _remote.updatePlan(plan);
      return Result.success(updated);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'Membership/updating-error',
          message: 'No se pudo actualizar el plan',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> deactivatePlan({required String planId}) async {
    try {
      await _remote.deactivatePlan(planId);
      return const Result<void>.success(null);
    } on AppException catch (e) {
      return Result<void>.failure(e);
    } catch (e) {
      return Result<void>.failure(
        UnknownException(
          code: 'Membership/deactivating-error',
          message: 'No se pudo desactivar el plan',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<bool>> canAddPlan({required String gymId}) async {
    try {
      final canAdd = await _remote.canAddPlan(gymId);
      return Result.success(canAdd);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'Membership/can-add-plan-error',
          message: 'No se pudo verificar el límite',
          cause: e,
        ),
      );
    }
  }
}
