import 'package:pesao_fit/core/providers/auth_provider.dart';
import 'package:pesao_fit/core/providers/supabase_provider.dart';
import 'package:pesao_fit/core/providers/database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/staff_local_datasource.dart';
import '../../data/datasources/staff_remote_datasource.dart';
import '../../data/repositories/staff_repository_impl.dart';
import '../../domain/entities/staff_overview.dart';
import '../../domain/repositories/staff_repository.dart';

part 'staff_providers.g.dart';

/// Proveedor del datasource remoto de staff.
@riverpod
StaffRemoteDatasource staffRemoteDatasource(StaffRemoteDatasourceRef ref) {
  final client = ref.watch(supabaseProvider);
  return StaffRemoteDatasource(client);
}

/// Proveedor del datasource local de staff.
@riverpod
StaffLocalDatasource staffLocalDatasource(StaffLocalDatasourceRef ref) {
  final db = ref.watch(databaseProvider);
  return StaffLocalDatasource(db);
}

/// Proveedor del repositorio de staff.
@riverpod
StaffRepository staffRepository(StaffRepositoryRef ref) {
  return StaffRepositoryImpl(
    remote: ref.watch(staffRemoteDatasourceProvider),
    local: ref.watch(staffLocalDatasourceProvider),
  );
}

/// Controller del staff del gimnasio del owner actual.
/// keepAlive para evitar recargas innecesarias.
/// Escucha authProvider para recargar cuando cambia la sesión.
@Riverpod(keepAlive: true)
class OwnerStaffController extends _$OwnerStaffController {
  @override
  Future<StaffOverview> build() async {
    // Escucha el estado de autenticación.
    final authState = ref.watch(authProvider);

    // Si no hay usuario autenticado, devuelve un overview vacío.
    if (!authState.isAuthenticated) {
      return const StaffOverview(members: [], staffCount: 0);
    }

    // Obtiene el gymId del usuario actual.
    // Asumimos que el owner tiene un membership con role='owner'.
    final gymId = await _getOwnerGymId();
    if (gymId == null) {
      return const StaffOverview(members: [], staffCount: 0);
    }

    // Carga el overview del staff.
    final repository = ref.read(staffRepositoryProvider);
    final result = await repository.getStaffOverview(gymId: gymId);

    return result.when(
      success: (overview) => overview,
      failure: (error) => throw error,
    );
  }

  /// Fuerza una recarga remota del staff.
  Future<void> refresh() async {
    final authState = ref.read(authProvider);
    if (!authState.isAuthenticated) return;

    final gymId = await _getOwnerGymId();
    if (gymId == null) return;

    final repository = ref.read(staffRepositoryProvider);
    final result = await repository.getStaffOverview(
      gymId: gymId,
      refresh: true,
    );

    state = result.when(
      success: (overview) => AsyncValue.data(overview),
      failure: (error) => AsyncValue.error(error, StackTrace.current),
    );
  }

  /// Activa o desactiva un miembro del staff.
  Future<void> setStaffActive(String membershipId, bool isActive) async {
    final repository = ref.read(staffRepositoryProvider);
    final result = await repository.setStaffActive(
      membershipId: membershipId,
      isActive: isActive,
    );

    if (result.isSuccess) {
      // Recarga el overview después de la mutación.
      await refresh();
    } else {
      throw result.failure!;
    }
  }

  /// Obtiene el gymId del owner actual.
  /// Busca en memberships donde role='owner' y user_id=auth.uid().
  Future<String?> _getOwnerGymId() async {
    final client = ref.read(supabaseProvider);
    final userId = ref.read(authProvider).user?.id;
    if (userId == null) return null;

    final response = await client
        .from('memberships')
        .select('gym_id')
        .eq('user_id', userId)
        .eq('role', 'owner')
        .eq('is_active', true)
        .maybeSingle();

    return response?['gym_id'] as String?;
  }
}
