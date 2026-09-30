import 'package:flutter/foundation.dart';

/// Datos agregados para el dashboard del rol cliente.
///
/// Es un objeto de dominio (no de red): cuando exista la API real,
/// el repository lo mapeará a esta entidad.
@immutable
class ClientHomeData {
  const ClientHomeData({
    required this.firstName,
    required this.kcalToday,
    required this.streakDays,
    required this.nextWorkoutTitle,
    required this.nextWorkoutWhen,
    required this.hasAssignedRoutine,
  });

  final String firstName;
  final int kcalToday;
  final int streakDays;
  final String nextWorkoutTitle;
  final String nextWorkoutWhen;
  final bool hasAssignedRoutine;
}
