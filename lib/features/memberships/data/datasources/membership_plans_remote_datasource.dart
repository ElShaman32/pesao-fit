import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/gym_membership_plan.dart';

/// Fuente remota de planes de membresía del gimnasio.
class MembershipPlansRemoteDatasource {
  final SupabaseClient _client;

  const MembershipPlansRemoteDatasource(this._client);

  Future<List<GymMembershipPlan>> fetchPlans(String gymId) async {
    try {
      final response = await _client
          .from('gym_membership_plans')
          .select()
          .eq('gym_id', gymId)
          .order('sort_order', ascending: true)
          .order('created_at', ascending: true);

      return response.map(GymMembershipPlan.fromJson).toList();
    } catch (e, stack) {
      debugPrint('❌ PLANS fetchPlans: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  Future<GymMembershipPlan> createPlan({
    required String gymId,
    required String name,
    String? description,
    required double priceUsd,
    required int durationDays,
    bool includesTrainer = false,
    bool includesNutritionist = false,
  }) async {
    try {
      final response = await _client
          .from('gym_membership_plans')
          .insert({
            'gym_id': gymId,
            'name': name,
            'description': description,
            'price_usd': priceUsd,
            'duration_days': durationDays,
            'includes_trainer': includesTrainer,
            'includes_nutritionist': includesNutritionist,
          })
          .select()
          .single();

      return GymMembershipPlan.fromJson(response);
    } catch (e, stack) {
      debugPrint('❌ PLANS createPlan: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  Future<GymMembershipPlan> updatePlan(GymMembershipPlan plan) async {
    try {
      final response = await _client
          .from('gym_membership_plans')
          .update({
            'name': plan.name,
            'description': plan.description,
            'price_usd': plan.priceUsd,
            'duration_days': plan.durationDays,
            'includes_trainer': plan.includesTrainer,
            'includes_nutritionist': plan.includesNutritionist,
            'is_active': plan.isActive,
            'sort_order': plan.sortOrder,
          })
          .eq('id', plan.id)
          .select()
          .single();

      return GymMembershipPlan.fromJson(response);
    } catch (e, stack) {
      debugPrint('❌ PLANS updatePlan: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  Future<void> deactivatePlan(String planId) async {
    try {
      await _client
          .from('gym_membership_plans')
          .update({'is_active': false})
          .eq('id', planId);
    } catch (e, stack) {
      debugPrint('❌ PLANS deactivatePlan: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  Future<bool> canAddPlan(String gymId) async {
    try {
      final response = await _client.rpc(
        'can_add_membership_plan',
        params: {'p_gym_id': gymId},
      );
      return response as bool? ?? false;
    } catch (e, stack) {
      debugPrint('❌ PLANS canAddPlan: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }
}
