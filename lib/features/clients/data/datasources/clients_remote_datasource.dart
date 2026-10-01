import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/client_invitation_result.dart';
import '../../domain/entities/client_member.dart';
import '../../domain/entities/create_client_request.dart';

/// Fuente remota de clientes. Supabase client.
class ClientsRemoteDatasource {
  final SupabaseClient _client;

  const ClientsRemoteDatasource(this._client);

  /// Lista de clientes del gimnasio.
  Future<List<ClientMember>> fetchClients(String gymId) async {
    try {
      final response = await _client
          .from('memberships')
          .select('''
            id,
            user_id,
            gym_id,
            role,
            is_active,
            created_at,
            profiles:user_id (
              id,
              full_name,
              email,
              avatar_url,
              phone
            )
          ''')
          .eq('gym_id', gymId)
          .eq('role', 'client')
          .order('is_active', ascending: false)
          .order('created_at', ascending: false);

      return response.map(_mapToClientMember).toList();
    } catch (e, stack) {
      debugPrint('❌ CLIENTS REMOTE fetchClients: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Un cliente por membership id.
  Future<ClientMember> fetchClient(String membershipId) async {
    try {
      final response = await _client
          .from('memberships')
          .select('''
            id,
            user_id,
            gym_id,
            role,
            is_active,
            created_at,
            profiles:user_id (
              id,
              full_name,
              email,
              avatar_url,
              phone
            )
          ''')
          .eq('id', membershipId)
          .maybeSingle();

      if (response == null) {
        throw Exception('client_not_found');
      }

      return _mapToClientMember(response);
    } catch (e, stack) {
      debugPrint('❌ CLIENTS REMOTE fetchClient: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Cuenta clientes activos.
  Future<int> fetchActiveClientCount(String gymId) async {
    try {
      final response = await _client.rpc(
        'get_active_client_count',
        params: {'p_gym_id': gymId},
      );
      return (response as int?) ?? 0;
    } catch (e, stack) {
      debugPrint('❌ CLIENTS REMOTE fetchActiveClientCount: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Límite de clientes del plan.
  Future<int?> fetchClientLimit(String gymId) async {
    try {
      final response = await _client.rpc(
        'get_client_limit',
        params: {'p_gym_id': gymId},
      );
      return response as int?;
    } catch (e, stack) {
      debugPrint('❌ CLIENTS REMOTE fetchClientLimit: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Activa/desactiva cliente.
  Future<void> setClientActive(String membershipId, bool isActive) async {
    try {
      await _client.rpc(
        'set_client_active',
        params: {'p_membership_id': membershipId, 'p_is_active': isActive},
      );
    } catch (e, stack) {
      debugPrint('❌ CLIENTS REMOTE setClientActive: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  /// Agrega cliente manualmente.
  Future<ClientInvitationResult> addClient(CreateClientRequest request) async {
    try {
      // 1. Validar cupo.
      final canAdd = await _client.rpc(
        'can_add_client',
        params: {'p_gym_id': request.gymId},
      );
      if (canAdd != true) {
        throw Exception('client_limit_reached');
      }

      // 2. Crear usuario.
      final authResponse = await _client.auth.signUp(
        email: request.email,
        password: request.tempPassword,
        data: {'full_name': request.fullName},
      );

      final userId = authResponse.user?.id;
      if (userId == null) {
        throw Exception('user_creation_failed');
      }

      // 3. Crear membership.
      final membershipResponse = await _client
          .from('memberships')
          .insert({
            'user_id': userId,
            'gym_id': request.gymId,
            'role': 'client',
            'is_active': true,
          })
          .select()
          .single();

      final membershipId = membershipResponse['id'] as String;

      return ClientInvitationResult(
        userId: userId,
        membershipId: membershipId,
        email: request.email,
        tempPassword: request.tempPassword,
      );
    } catch (e, stack) {
      debugPrint('❌ CLIENTS REMOTE addClient: $e');
      debugPrint('❌ STACK: $stack');
      rethrow;
    }
  }

  ClientMember _mapToClientMember(Map<String, dynamic> json) {
    final profile = json['profiles'] as Map<String, dynamic>?;
    return ClientMember(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      gymId: json['gym_id'] as String,
      isActive: json['is_active'] as bool,
      fullName: profile?['full_name'] as String? ?? 'Sin nombre',
      email: profile?['email'] as String?,
      avatarUrl: profile?['avatar_url'] as String?,
      phone: profile?['phone'] as String?,
      joinedAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
