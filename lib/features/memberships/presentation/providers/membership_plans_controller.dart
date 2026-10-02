import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/utils/result.dart';
import '../../data/datasources/membership_plans_remote_datasource.dart';
import '../../data/repositories/membership_plans_repository_impl.dart';
import '../../domain/entities/gym_membership_plan.dart';
import '../../domain/repositories/membership_plans_repository.dart';

part 'membership_plans_controller.g.dart';

@riverpod
MembershipPlansRepository membershipPlansRepository(Ref ref) {
  return MembershipPlansRepositoryImpl(
    remote: MembershipPlansRemoteDatasource(Supabase.instance.client),
  );
}

@Riverpod(keepAlive: true)
class MembershipPlansController extends _$MembershipPlansController {
  late final MembershipPlansRepository _repository;

  @override
  AsyncValue<List<GymMembershipPlan>> build() {
    _repository = ref.watch(membershipPlansRepositoryProvider);

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

  Future<void> load() async {
    final gymId = authProvider.userGymId;
    if (gymId == null) return;

    state = const AsyncValue.loading();
    final result = await _repository.getPlans(gymId: gymId);

    result.when(
      idle: () {},
      loading: () {},
      success: (plans) => state = AsyncValue.data(plans),
      failure: (error) => state = AsyncValue.error(error, StackTrace.current),
    );
  }

  Future<Result<GymMembershipPlan>> createPlan({
    required String name,
    String? description,
    required double priceUsd,
    required int durationDays,
    bool includesTrainer = false,
    bool includesNutritionist = false,
  }) async {
    final gymId = authProvider.userGymId;
    if (gymId == null) {
      return const Result.failure(
        UnknownException(
          code: 'Membership/create-plan-error',
          message: 'Sin gimnasio activo',
          cause: e,
        ),
      );
    }

    // Verificar límite de planes.
    final canAddResult = await _repository.canAddPlan(gymId: gymId);
    if (canAddResult.dataOrNull == false) {
      return const Result.failure(
        UnknownException(
          code: 'Membership/create-plan-error',
          message: 'plan_limit_reached',
          cause: e,
        ),
      );
    }

    final result = await _repository.createPlan(
      gymId: gymId,
      name: name,
      description: description,
      priceUsd: priceUsd,
      durationDays: durationDays,
      includesTrainer: includesTrainer,
      includesNutritionist: includesNutritionist,
    );

    if (result.isSuccess) await load();
    return result;
  }

  Future<Result<GymMembershipPlan>> updatePlan(GymMembershipPlan plan) async {
    final result = await _repository.updatePlan(plan: plan);
    if (result.isSuccess) await load();
    return result;
  }

  Future<Result<void>> deactivatePlan(String planId) async {
    final result = await _repository.deactivatePlan(planId: planId);
    if (result.isSuccess) await load();
    return result;
  }
}
