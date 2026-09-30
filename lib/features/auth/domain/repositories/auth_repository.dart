import '../../../../core/utils/result.dart';
import '../entities/auth_user.dart';

/// Contrato del repositorio de autenticación (domain).
/// La UI y los providers dependen de esta interfaz, nunca de Supabase.
abstract class AuthRepository {
  /// Inicia sesión con email/password (ADR-006: único método permitido).
  Future<Result<AuthUser>> signIn({
    required String email,
    required String password,
  });

  /// Registra un usuario nuevo con email/password.
  Future<Result<AuthUser>> signUp({
    required String email,
    required String password,
    required String fullName,
  });

  /// Cierra la sesión actual.
  Future<Result<bool>> signOut();

  /// Devuelve el usuario en sesión, o null si no hay nadie logueado.
  Future<Result<AuthUser?>> currentUser();

  /// Stream que emite cada cambio de sesión (login, logout, refresh).
  Stream<AuthUser?> authStateChanges();
}
