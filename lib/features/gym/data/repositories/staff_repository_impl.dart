import 'package:pesao_fit/core/exceptions/app_exception.dart';
import 'package:pesao_fit/core/utils/result.dart';

import '../../domain/entities/create_staff_request.dart';
import '../../domain/entities/staff_invitation_result.dart';
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
      if (!refresh) {
        final cachedMembers = await _local.readStaffMembers(gymId);
        if (cachedMembers.isNotEmpty) {
          // FIX: obtener el límite desde remoto incluso con caché.
          int? staffLimit;
          try {
            staffLimit = await _remote.fetchStaffLimit(gymId);
          } catch (_) {
            staffLimit = null;
          }
          return Result.success(
            StaffOverview(
              members: cachedMembers,
              staffCount: cachedMembers.where((m) => m.isActive).length,
              staffLimit: staffLimit,
              isStale: true,
            ),
          );
        }
      }

      final members = await _remote.fetchStaffMembers(gymId);
      final staffCount = await _remote.fetchActiveStaffCount(gymId);
      final staffLimit = await _remote.fetchStaffLimit(gymId);

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
      } catch (_) {}

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

  @override
  Future<Result<StaffInvitationResult>> inviteStaff({
    required CreateStaffRequest request,
  }) async {
    try {
      final result = await _remote.inviteStaff(request);
      return Result.success(result);
    } on AppException catch (e) {
      return Result.failure(e);
    } catch (e) {
      final message = e.toString();
      // Traducimos errores técnicos a mensajes amigables.
      if (message.contains('plan_limit_reached')) {
        return Result.failure(
          UnknownException(
            code: 'staff/reject-error',
            message:
                'Ya llegaste al límite de tu plan. Actualiza a Hierro para agregar más miembros.',
            cause: e,
          ),
        );
      }
      if (message.contains('email') || message.contains('already')) {
        return Result.failure(
          UnknownException(
            code: 'staff/reject-error',
            message:
                'Ese correo ya está registrado. Pídele que entre con su cuenta.',
            cause: e,
          ),
        );
      }
      return Result.failure(
        UnknownException(
          code: 'staff/reject-error',
          message: 'No se pudo invitar al miembro.',
          cause: e,
        ),
      );
    }
  }
}
