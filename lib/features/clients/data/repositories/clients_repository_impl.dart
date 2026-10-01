import 'package:pesao_fit/core/exceptions/app_exception.dart';
import 'package:pesao_fit/core/utils/result.dart';

import '../../domain/entities/client_invitation_result.dart';
import '../../domain/entities/client_member.dart';
import '../../domain/entities/client_overview.dart';
import '../../domain/entities/create_client_request.dart';
import '../../domain/repositories/clients_repository.dart';
import '../datasources/clients_local_datasource.dart';
import '../datasources/clients_remote_datasource.dart';

/// Implementación del repositorio de clientes.
/// Estrategia: offline-first con fallback a cache.
class ClientsRepositoryImpl implements ClientsRepository {
  final ClientsRemoteDatasource _remote;
  final ClientsLocalDatasource _local;

  const ClientsRepositoryImpl({
    required ClientsRemoteDatasource remote,
    required ClientsLocalDatasource local,
  }) : _remote = remote,
       _local = local;

  @override
  Future<Result<ClientOverview>> getClientsOverview({
    required String gymId,
    bool refresh = false,
  }) async {
    try {
      // Intentar cache primero.
      if (!refresh) {
        final cachedMembers = await _local.readClients(gymId);
        if (cachedMembers.isNotEmpty) {
          // FIX: obtener el límite desde remoto incluso con caché.
          int? clientLimit;
          try {
            clientLimit = await _remote.fetchClientLimit(gymId);
          } catch (_) {
            clientLimit = null; // Offline: mostrar ilimitado.
          }
          return Result.success(
            ClientOverview(
              members: cachedMembers,
              clientCount: cachedMembers.where((m) => m.isActive).length,
              clientLimit: clientLimit,
              isStale: true,
            ),
          );
        }
      }

      // Lectura remota completa.
      final members = await _remote.fetchClients(gymId);
      final clientCount = await _remote.fetchActiveClientCount(gymId);
      final clientLimit = await _remote.fetchClientLimit(gymId);

      await _local.cacheClients(members);

      return Result.success(
        ClientOverview(
          members: members,
          clientCount: clientCount,
          clientLimit: clientLimit,
          isStale: false,
        ),
      );
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      try {
        final cachedMembers = await _local.readClients(gymId);
        if (cachedMembers.isNotEmpty) {
          return Result.success(
            ClientOverview(
              members: cachedMembers,
              clientCount: cachedMembers.where((m) => m.isActive).length,
              isStale: true,
            ),
          );
        }
      } catch (_) {}
      return Result.failure(
        UnknownException(
          code: 'client/reject-error',
          message: 'No se pudo cargar el cliente.',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<ClientMember>> getClient({required String membershipId}) async {
    try {
      final client = await _remote.fetchClient(membershipId);
      return Result.success(client);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      // Fallback a cache.
      try {
        final cachedClient = await _local.readClient(membershipId);
        if (cachedClient != null) {
          return Result.success(cachedClient);
        }
      } catch (_) {
        // Ignorar.
      }
      return Result.failure(
        UnknownException(
          code: 'client/reject-error',
          message: 'No se pudo cargar el cliente.',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> setClientActive({
    required String membershipId,
    required bool isActive,
  }) async {
    try {
      await _remote.setClientActive(membershipId, isActive);
      return const Result.success(null);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'client/reject-error',
          message: 'No se pudo actualizar el cliente.',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<ClientInvitationResult>> addClient({
    required CreateClientRequest request,
  }) async {
    try {
      final result = await _remote.addClient(request);
      return Result.success(result);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      final message = e.toString();
      if (message.contains('client_limit_reached')) {
        return Result.failure(
          UnknownException(
            code: 'client/reject-error',
            message:
                'Ya llegaste al límite de clientes de tu plan. Actualiza a Hierro para agregar más.',
            cause: e,
          ),
        );
      }
      if (message.contains('email') || message.contains('already')) {
        return Result.failure(
          UnknownException(
            code: 'client/reject-error',
            message:
                'Ese correo ya está registrado. Pídele que entre con su cuenta.',
            cause: e,
          ),
        );
      }
      return Result.failure(
        UnknownException(
          code: 'client/reject-error',
          message: 'No se pudo agregar el cliente.',
          cause: e,
        ),
      );
    }
  }
}
