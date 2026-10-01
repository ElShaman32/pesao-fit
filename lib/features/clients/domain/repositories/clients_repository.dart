import 'package:pesao_fit/core/utils/result.dart';

import '../entities/client_invitation_result.dart';
import '../entities/client_member.dart';
import '../entities/client_overview.dart';
import '../entities/create_client_request.dart';

/// Contrato para gestionar clientes del gimnasio.
abstract interface class ClientsRepository {
  /// Obtiene el resumen de clientes.
  Future<Result<ClientOverview>> getClientsOverview({
    required String gymId,
    bool refresh = false,
  });

  /// Obtiene un cliente por membership id.
  Future<Result<ClientMember>> getClient({required String membershipId});

  /// Activa o desactiva la membresía de un cliente.
  Future<Result<void>> setClientActive({
    required String membershipId,
    required bool isActive,
  });

  /// Agrega un cliente manualmente (crea usuario + membership).
  Future<Result<ClientInvitationResult>> addClient({
    required CreateClientRequest request,
  });
}
