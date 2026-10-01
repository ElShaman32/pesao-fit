import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/staff_member.dart';

/// Fuente de datos remota para staff. Usa Supabase client.
class StaffRemoteDatasource {
  final SupabaseClient _client;

  const StaffRemoteDatasource(this._client);

  /// Obtiene el staff activo e inactivo de un gimnasio.
  /// Hace join con profiles para traer nombre, email, avatar y teléfono.
  Future<List<StaffMember>> fetchStaffMembers(String gymId) async {
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

    return response.map(_mapToStaffMember).toList();
  }

  /// Cuenta el staff activo de un gimnasio.
  Future<int> fetchActiveStaffCount(String gymId) async {
    final response = await _client.rpc(
      'get_active_staff_count',
      params: {'p_gym_id': gymId},
    );
    return (response.data as int?) ?? 0;
  }

  /// Obtiene el límite de staff del gimnasio según su suscripción activa.
  /// null = ilimitado.
  Future<int?> fetchStaffLimit(String gymId) async {
    final response = await _client.rpc(
      'get_staff_limit',
      params: {'p_gym_id': gymId},
    );
    return response.data as int?;
  }

  /// Activa o desactiva un miembro del staff.
  Future<void> setStaffActive(String membershipId, bool isActive) async {
    await _client.rpc(
      'set_staff_active',
      params: {'p_membership_id': membershipId, 'p_is_active': isActive},
    );
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
