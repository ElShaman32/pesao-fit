import 'package:equatable/equatable.dart';

/// Cliente de un gimnasio.
/// POCO + Equatable (ADR-037).
class ClientMember extends Equatable {
  final String id; // membership.id
  final String userId;
  final String gymId;
  final bool isActive;
  final String fullName;
  final String? email;
  final String? avatarUrl;
  final String? phone;
  final DateTime joinedAt;

  const ClientMember({
    required this.id,
    required this.userId,
    required this.gymId,
    required this.isActive,
    required this.fullName,
    this.email,
    this.avatarUrl,
    this.phone,
    required this.joinedAt,
  });

  ClientMember copyWith({
    String? id,
    String? userId,
    String? gymId,
    bool? isActive,
    String? fullName,
    String? email,
    String? avatarUrl,
    String? phone,
    DateTime? joinedAt,
  }) {
    return ClientMember(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      gymId: gymId ?? this.gymId,
      isActive: isActive ?? this.isActive,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phone: phone ?? this.phone,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    gymId,
    isActive,
    fullName,
    email,
    avatarUrl,
    phone,
    joinedAt,
  ];
}
