import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/nutritionist_stats.dart';

/// Fuente remota de estadísticas del dashboard del nutricionista.
class NutritionistDashboardRemoteDatasource {
  final SupabaseClient _client;

  const NutritionistDashboardRemoteDatasource(this._client);

  /// Obtiene las stats del dashboard del nutricionista.
  Future<NutritionistStats> fetchStats(String gymId) async {
    try {
      // Contar clientes activos del gym (solo IDs, mínimo payload).
      final clientsResponse = await _client
          .from('memberships')
          .select('user_id')
          .eq('gym_id', gymId)
          .eq('role', 'client')
          .eq('is_active', true);
      final totalClients = clientsResponse.length;

      // Contar planes nutricionales activos.
      final plansResponse = await _client
          .from('nutrition_plans')
          .select('id, client_id')
          .eq('gym_id', gymId)
          .eq('is_active', true);
      final activePlans = plansResponse.length;

      // IDs únicos de clientes con plan activo.
      final clientIdsWithPlan = plansResponse
          .map((e) => e['client_id'] as String)
          .toSet();

      // Contar alimentos visibles (sistema + personalizados del gym).
      final foodsResponse = await _client
          .from('foods')
          .select('id')
          .eq('is_active', true)
          .or('is_system.eq.true,gym_id.is.null,gym_id.eq.$gymId');
      final totalFoods = foodsResponse.length;

      // Clientes sin plan = total - con plan (clamped a 0).
      final clientsWithoutPlan = (totalClients - clientIdsWithPlan.length)
          .clamp(0, totalClients);

      return NutritionistStats(
        totalClients: totalClients,
        activePlans: activePlans,
        totalFoods: totalFoods,
        clientsWithoutPlan: clientsWithoutPlan,
      );
    } catch (e, stack) {
      debugPrint('❌ NUTRITIONIST_DASHBOARD fetchStats: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }
}
