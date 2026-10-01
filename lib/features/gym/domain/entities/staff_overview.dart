import 'package:equatable/equatable.dart';

import 'staff_member.dart';

/// Resumen del equipo de un gimnasio: miembros, cupos, límites.
/// POCO + Equatable (ADR-021: sin Freezed para entidades simples).
class StaffOverview extends Equatable {
  final List<StaffMember> members;
  final int staffCount;
  final int? staffLimit; // null = ilimitado
  final bool isStale; // true si los datos son de caché offline

  const StaffOverview({
    required this.members,
    required this.staffCount,
    this.staffLimit,
    this.isStale = false,
  });

  /// true si el gimnasio tiene cupos ilimitados de staff.
  bool get isUnlimited => staffLimit == null;

  /// true si todavía puede agregar más miembros al equipo.
  bool get hasAvailableSlot => isUnlimited || staffCount < (staffLimit ?? 0);

  /// Crea una copia con algunos campos modificados.
  StaffOverview copyWith({
    List<StaffMember>? members,
    int? staffCount,
    int? staffLimit,
    bool? isStale,
  }) {
    return StaffOverview(
      members: members ?? this.members,
      staffCount: staffCount ?? this.staffCount,
      staffLimit: staffLimit ?? this.staffLimit,
      isStale: isStale ?? this.isStale,
    );
  }

  @override
  List<Object?> get props => [members, staffCount, staffLimit, isStale];
}
