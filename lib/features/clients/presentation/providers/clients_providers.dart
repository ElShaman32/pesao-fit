import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../../../core/providers/database_provider.dart';
import '../../../../core/utils/result.dart';
import '../../data/datasources/clients_local_datasource.dart';
import '../../data/datasources/clients_remote_datasource.dart';
import '../../data/repositories/clients_repository_impl.dart';
import '../../domain/entities/client_invitation_result.dart';
import '../../domain/entities/client_member.dart';
import '../../domain/entities/client_overview.dart';
import '../../domain/entities/create_client_request.dart';
import '../../domain/repositories/clients_repository.dart';

part 'clients_providers.g.dart';

/// Proveedor del repositorio de clientes.
@riverpod
ClientsRepository clientsRepository(Ref ref) {
  return ClientsRepositoryImpl(
    remote: ClientsRemoteDatasource(Supabase.instance.client),
    local: ClientsLocalDatasource(ref.watch(appDatabaseProvider)),
  );
}

/// Controlador de clientes del dueño.
@Riverpod(keepAlive: true)
class OwnerClientsController extends _$OwnerClientsController {
  late final ClientsRepository _repository;

  @override
  Result<ClientOverview> build() {
    _repository = ref.watch(clientsRepositoryProvider);

    if (authProvider.isLoggedIn && !authProvider.isInitializing) {
      Future.microtask(load);
    }

    return const Result.idle();
  }

  Future<void> load() async {
    final gymId = authProvider.userGymId;
    debugPrint('🔍 CLIENTS LOAD: gymId = $gymId');

    if (gymId == null) {
      debugPrint('⚠️ CLIENTS LOAD: gymId es null.');
      return;
    }

    state = const Result.loading();
    final result = await _repository.getClientsOverview(gymId: gymId);

    result.when(
      idle: () {},
      loading: () {},
      success: (overview) {
        debugPrint('✅ CLIENTS LOAD: ${overview.members.length} clientes.');
        state = Result.success(overview);
      },
      failure: (error) {
        debugPrint('❌ CLIENTS LOAD: $error');
        state = Result.failure(error);
      },
    );
  }

  Future<void> setClientActive(String membershipId, bool isActive) async {
    final result = await _repository.setClientActive(
      membershipId: membershipId,
      isActive: isActive,
    );

    result.when(
      idle: () {},
      loading: () {},
      success: (_) {
        load();
      },
      failure: (error) {
        debugPrint('❌ CLIENTS MUTATION: $error');
        state = Result.failure(error);
      },
    );
  }

  Future<ClientInvitationResult?> addClient(CreateClientRequest request) async {
    final result = await _repository.addClient(request: request);

    return result.when(
      idle: () => null,
      loading: () => null,
      success: (invitation) {
        load();
        return invitation;
      },
      failure: (error) {
        throw Exception(error.toString());
      },
    );
  }
}

/// Proveedor para detalle de cliente.
@riverpod
Future<ClientMember> clientDetail(Ref ref, String membershipId) async {
  final repository = ref.watch(clientsRepositoryProvider);
  final result = await repository.getClient(membershipId: membershipId);

  return result.when(
    idle: () => throw Exception('idle'),
    loading: () => throw Exception('loading'),
    success: (client) => client,
    failure: (error) => throw Exception(error.toString()),
  );
}
