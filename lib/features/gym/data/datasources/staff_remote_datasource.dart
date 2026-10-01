import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/staff_member.dart';

/// Fuente de datos remota para staff. Usa Supabase client.
class StaffRemoteDatasource {
  final SupabaseClient _client;

  const StaffRemoteDatasource(this._client);

  /// Obtiene el staff activo e inactivo de un gimnasio.
  Future<List<StaffMember>> fetchStaffMembers(String gymId) async {
    try {
      debugPrint('🔍 STAFF REMOTE: Fetching members for gymId=$gymId');

      final response = await _client
          .from('memberships')
          .select('''
            id,
            user_id,
            gym_id,
            role,
            is_active,
            profiles:user_id (
              id,
              full_name,
              email,
              avatar_url,
              phone
            )
          ''')
          .eq('gym_id', gymId)
          .inFilter('role', ['trainer', 'nutritionist'])
          .order('is_active', ascending: false)
          .order('created_at', ascending: false);

      debugPrint('✅ STAFF REMOTE: Found ${response.length} members');
      return response.map(_mapToStaffMember).toList();
    } catch (e, stack) {
      debugPrint('❌ STAFF REMOTE ERROR: ${e.toString()}');
      debugPrint('❌ STAFF REMOTE STACK: $stack');
      rethrow;
    }
  }

  /// Cuenta el staff activo de un gimnasio.
  Future<int> fetchActiveStaffCount(String gymId) async {
    try {
      debugPrint('🔍 STAFF REMOTE: Fetching active count for gymId=$gymId');
      final response = await _client.rpc(
        'get_active_staff_count',
        params: {'p_gym_id': gymId},
      );
      // Supabase 2.x: rpc() devuelve el valor directo, no un objeto con .data
      final count = (response as int?) ?? 0;
      debugPrint('✅ STAFF REMOTE: Active count = $count');
      return count;
    } catch (e, stack) {
      debugPrint('❌ STAFF REMOTE COUNT ERROR: ${e.toString()}');
      debugPrint('❌ STAFF REMOTE COUNT STACK: $stack');
      rethrow;
    }
  }

  /// Obtiene el límite de staff del gimnasio según su suscripción activa.
  Future<int?> fetchStaffLimit(String gymId) async {
    try {
      debugPrint('🔍 STAFF REMOTE: Fetching limit for gymId=$gymId');
      final response = await _client.rpc(
        'get_staff_limit',
        params: {'p_gym_id': gymId},
      );
      // Supabase 2.x: rpc() devuelve el valor directo (int o null)
      final limit = response as int?;
      debugPrint('✅ STAFF REMOTE: Limit = $limit');
      return limit;
    } catch (e, stack) {
      debugPrint('❌ STAFF REMOTE LIMIT ERROR: ${e.toString()}');
      debugPrint('❌ STAFF REMOTE LIMIT STACK: $stack');
      rethrow;
    }
  }

  /// Activa o desactiva un miembro del staff.
  Future<void> setStaffActive(String membershipId, bool isActive) async {
    try {
      debugPrint(
        '🔍 STAFF REMOTE: Setting active=$isActive for membership=$membershipId',
      );
      await _client.rpc(
        'set_staff_active',
        params: {'p_membership_id': membershipId, 'p_is_active': isActive},
      );
      debugPrint('✅ STAFF REMOTE: Status updated successfully');
    } catch (e, stack) {
      debugPrint('❌ STAFF REMOTE SET ACTIVE ERROR: ${e.toString()}');
      debugPrint('❌ STAFF REMOTE SET ACTIVE STACK: $stack');
      rethrow;
    }
  }

  /// Mapea la respuesta de Supabase a StaffMember.
  StaffMember _mapToStaffMember(Map<String, dynamic> json) {
    final profile = json['profiles'] as Map<String, dynamic>?;
    return StaffMember(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      gymId: json['gym_id'] as String,
      role: json['role'] as String,
      isActive: json['is_active'] as bool,
      fullName: profile?['full_name'] as String? ?? 'Sin nombre',
      email: profile?['email'] as String?,
      avatarUrl: profile?['avatar_url'] as String?,
      phone: profile?['phone'] as String?,
    );
  }
}
