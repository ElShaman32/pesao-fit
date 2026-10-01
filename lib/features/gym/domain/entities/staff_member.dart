import 'package:equatable/equatable.dart';

/// Miembro del staff (entrenador o nutricionista) de un gimnasio.
/// POCO + Equatable (ADR-021: sin Freezed para entidades simples).
class StaffMember extends Equatable {
  final String id; // membership.id
  final String userId;
  final String gymId;
  final String role; // 'trainer' o 'nutritionist'
  final bool isActive;
  final String fullName;
  final String? email;
  final String? avatarUrl;
  final String? phone;

  const StaffMember({
    required this.id,
    required this.userId,
    required this.gymId,
    required this.role,
    required this.isActive,
    required this.fullName,
    this.email,
    this.avatarUrl,
    this.phone,
  });

  /// Crea una copia con algunos campos modificados.
  StaffMember copyWith({
    String? id,
    String? userId,
    String? gymId,
    String? role,
    bool? isActive,
    String? fullName,
    String? email,
    String? avatarUrl,
    String? phone,
  }) {
    return StaffMember(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      gymId: gymId ?? this.gymId,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    gymId,
    role,
    isActive,
    fullName,
    email,
    avatarUrl,
    phone,
  ];
}
