import 'package:equatable/equatable.dart';

/// Usuario autenticado con su rol y gimnasio activo.
/// Entidad de dominio del feature de autenticación.
///
/// Implementada como clase Dart pura (POCO) con Equatable, sin Freezed.
/// [role] es null cuando el usuario está autenticado pero aún no
/// pertenece a ningún gimnasio (recién registrado, irá a onboarding).
class AuthUser extends Equatable {
  const AuthUser({
    required this.id,
    required this.email,
    required this.fullName,
    this.role,
    this.gymId,
    this.avatarUrl,
  });

  final String id;
  final String email;
  final String fullName;
  final String? role;
  final String? gymId;
  final String? avatarUrl;

  /// Construye un [AuthUser] desde un Map (ej: respuesta de Supabase).
  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      role: json['role'] as String?,
      gymId: json['gymId'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );
  }

  /// Serializa la entidad a Map (para logs, analytics, caché simple).
  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'fullName': fullName,
    'role': role,
    'gymId': gymId,
    'avatarUrl': avatarUrl,
  };

  /// Crea una copia con campos reemplazados (equivalente a copyWith de Freezed).
  AuthUser copyWith({
    String? id,
    String? email,
    String? fullName,
    String? role,
    String? gymId,
    String? avatarUrl,
  }) {
    return AuthUser(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      gymId: gymId ?? this.gymId,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  List<Object?> get props => [id, email, fullName, role, gymId, avatarUrl];

  @override
  String toString() =>
      'AuthUser(id: $id, email: $email, role: $role, gymId: $gymId)';
}
