import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/create_staff_request.dart';
import '../../domain/entities/staff_invitation_result.dart';
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

  /// Crea un nuevo usuario (signUp) y lo agrega como miembro del staff.
  /// Devuelve las credenciales temporales para que el dueño las comparta.
  Future<StaffInvitationResult> inviteStaff(CreateStaffRequest request) async {
    try {
      debugPrint(
        '🔍 STAFF REMOTE: Inviting ${request.email} as ${request.role}',
      );

      // 1. Validar que hay cupo en el plan.
      final canAdd = await _client.rpc(
        'can_add_staff',
        params: {'p_gym_id': request.gymId},
      );
      if (canAdd != true) {
        throw Exception('plan_limit_reached');
      }

      // 2. Crear el usuario en auth.users.
      //    El trigger handle_new_user creará automáticamente el profile.
      final authResponse = await _client.auth.signUp(
        email: request.email,
        password: request.tempPassword,
        data: {'full_name': request.fullName},
      );

      final userId = authResponse.user?.id;
      if (userId == null) {
        throw Exception('user_creation_failed');
      }

      // 3. Crear la membership como trainer/nutritionist.
      final membershipResponse = await _client
          .from('memberships')
          .insert({
            'user_id': userId,
            'gym_id': request.gymId,
            'role': request.role,
            'is_active': true,
          })
          .select()
          .single();

      final membershipId = membershipResponse['id'] as String;

      debugPrint(
        '✅ STAFF REMOTE: Staff created. userId=$userId, membershipId=$membershipId',
      );

      return StaffInvitationResult(
        userId: userId,
        membershipId: membershipId,
        email: request.email,
        tempPassword: request.tempPassword,
      );
    } catch (e, stack) {
      debugPrint('❌ STAFF REMOTE INVITE ERROR: ${e.toString()}');
      debugPrint('❌ STAFF REMOTE INVITE STACK: $stack');
      rethrow;
    }
  }
}
