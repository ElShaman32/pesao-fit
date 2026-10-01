import 'package:pesao_fit/core/utils/result.dart';
import '../entities/create_staff_request.dart';
import '../entities/staff_invitation_result.dart';
import '../entities/staff_overview.dart';

/// Contrato para gestionar el staff de un gimnasio.
/// Todas las operaciones devuelven `Result<T>`.
abstract interface class StaffRepository {
  Future<Result<StaffOverview>> getStaffOverview({
    required String gymId,
    bool refresh = false,
  });

  Future<Result<void>> setStaffActive({
    required String membershipId,
    required bool isActive,
  });

  /// Invita a un nuevo miembro del staff (crea usuario + membership).
  Future<Result<StaffInvitationResult>> inviteStaff({
    required CreateStaffRequest request,
  });
}
