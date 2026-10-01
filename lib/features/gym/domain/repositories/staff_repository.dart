import 'package:pesao_fit/core/utils/result.dart';
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
}
