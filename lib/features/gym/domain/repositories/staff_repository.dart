import 'package:pesao_fit/core/utils/result.dart';

import '../entities/staff_overview.dart';

/// Contrato para gestionar el staff de un gimnasio.
/// Todas las operaciones devuelven Result<T> (ADR-022).
abstract interface class StaffRepository {
  /// Obtiene el resumen del staff de un gimnasio.
  /// Si [refresh] es true, fuerza lectura remota y actualiza caché local.
  Future<Result<StaffOverview>> getStaffOverview({
    required String gymId,
    bool refresh = false,
  });

  /// Activa o desactiva un miembro del staff.
  Future<Result<void>> setStaffActive({
    required String membershipId,
    required bool isActive,
  });
}
