import 'package:pesao_fit/core/exceptions/app_exception.dart';
import 'package:pesao_fit/core/utils/result.dart';

import '../../domain/entities/staff_overview.dart';
import '../../domain/repositories/staff_repository.dart';
import '../datasources/staff_local_datasource.dart';
import '../datasources/staff_remote_datasource.dart';

/// Implementación del repositorio de staff.
/// Estrategia: offline-first con fallback a caché local.
class StaffRepositoryImpl implements StaffRepository {
  final StaffRemoteDatasource _remote;
  final StaffLocalDatasource _local;

  const StaffRepositoryImpl({
    required StaffRemoteDatasource remote,
    required StaffLocalDatasource local,
  }) : _remote = remote,
       _local = local;

  @override
  Future<Result<StaffOverview>> getStaffOverview({
    required String gymId,
    bool refresh = false,
  }) async {
    try {
      // Si no pide refresh, intenta leer de caché primero.
      if (!refresh) {
        final cachedMembers = await _local.readStaffMembers(gymId);
        if (cachedMembers.isNotEmpty) {
          return Result.success(
            StaffOverview(
              members: cachedMembers,
              staffCount: cachedMembers.where((m) => m.isActive).length,
              isStale: true,
            ),
          );
        }
      }

      // Lectura remota.
      final members = await _remote.fetchStaffMembers(gymId);
      final staffCount = await _remote.fetchActiveStaffCount(gymId);
      final staffLimit = await _remote.fetchStaffLimit(gymId);

      // Actualiza caché local.
      await _local.cacheStaffMembers(members);

      return Result.success(
        StaffOverview(
          members: members,
          staffCount: staffCount,
          staffLimit: staffLimit,
          isStale: false,
        ),
      );
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      // Si falla la lectura remota, intenta fallback a caché local.
      try {
        final cachedMembers = await _local.readStaffMembers(gymId);
        if (cachedMembers.isNotEmpty) {
          return Result.success(
            StaffOverview(
              members: cachedMembers,
              staffCount: cachedMembers.where((m) => m.isActive).length,
              isStale: true,
            ),
          );
        }
      } catch (_) {
        // Ignoramos el error de caché y devolvemos el error original.
      }
      return Result.failure(
        UnknownException(
          code: 'staff/reject-error',
          message: 'No se pudo cargar el equipo',
          cause: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> setStaffActive({
    required String membershipId,
    required bool isActive,
  }) async {
    try {
      await _remote.setStaffActive(membershipId, isActive);
      return const Result.success(null);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownException(
          code: 'staff/reject-error',
          message: 'No se pudo actualizar el estado',
          cause: e,
        ),
      );
    }
  }
}
