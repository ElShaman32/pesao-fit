import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

/// Implementación concreta del repositorio de autenticación.
/// Orquesta Supabase Auth + membresía para construir la sesión completa.
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthRemoteDatasource remote}) : _remote = remote;

  final AuthRemoteDatasource _remote;

  @override
  Future<Result<AuthUser>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _remote.signIn(email: email, password: password);
      final authUser = await _buildAuthUser(user);
      return Result.success(authUser);
    } on sb.AuthException catch (error) {
      return Result.failure(_mapAuthException(error));
    } catch (error) {
      return Result.failure(
        UnknownException(code: 'auth/desconocido', cause: error),
      );
    }
  }

  @override
  Future<Result<AuthUser>> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final user = await _remote.signUp(
        email: email,
        password: password,
        fullName: fullName,
      );
      final authUser = await _buildAuthUser(user);
      return Result.success(authUser);
    } on sb.AuthException catch (error) {
      return Result.failure(_mapAuthException(error));
    } catch (error) {
      return Result.failure(
        UnknownException(code: 'auth/desconocido', cause: error),
      );
    }
  }

  @override
  Future<Result<bool>> signOut() async {
    try {
      await _remote.signOut();
      return const Result.success(true);
    } catch (error) {
      return Result.failure(
        UnknownException(code: 'auth/logout-error', cause: error),
      );
    }
  }

  @override
  Future<Result<AuthUser?>> currentUser() async {
    try {
      final user = _remote.currentUser();
      if (user == null) return const Result<AuthUser?>.success(null);
      final authUser = await _buildAuthUser(user);
      return Result.success(authUser);
    } catch (error) {
      return Result.failure(
        UnknownException(code: 'auth/sesion-error', cause: error),
      );
    }
  }

  @override
  Stream<AuthUser?> authStateChanges() {
    return _remote.authStateChanges().asyncMap((authState) async {
      final user = authState.session?.user;
      if (user == null) return null;
      return _buildAuthUser(user);
    });
  }

  /// Construye el [AuthUser] a partir del usuario de Supabase.
  /// Primero lee el perfil (fuente de verdad). Si es superadmin, le asigna
  /// rol 'admin' sin necesitar membresía (ADR-039). Si no, busca su membresía.
  Future<AuthUser> _buildAuthUser(sb.User user) async {
    var fullName = 'Usuario';
    String? avatarUrl;
    String? role;
    String? gymId;

    try {
      // 1. Leer perfil (fuente de verdad para nombre, avatar y superadmin).
      final profile = await _remote.fetchProfile(user.id);
      if (profile != null) {
        fullName = profile['full_name'] as String? ?? 'Usuario';
        avatarUrl = profile['avatar_url'] as String?;

        final isSuperadmin = profile['is_superadmin'] as bool? ?? false;
        if (isSuperadmin) {
          role = 'admin';
        }
      }

      // 2. Si no es superadmin, resolver rol y gimnasio por membresía.
      if (role == null) {
        final membership = await _remote.fetchPrimaryMembership(user.id);
        if (membership != null) {
          role = membership['role'] as String?;
          gymId = membership['gym_id'] as String?;
        }
      }
    } catch (_) {
      // Si falla la consulta, el usuario queda autenticado pero sin rol.
    }

    return AuthUser(
      id: user.id,
      email: user.email ?? '',
      fullName: fullName,
      role: role,
      gymId: gymId,
      avatarUrl: avatarUrl,
    );
  }

  /// Mapea errores de Supabase Auth a [AppException] con códigos estables,
  /// para que la UI elija el microcopy venezolano desde AppStrings.
  AppException _mapAuthException(sb.AuthException error) {
    final message = error.message.toLowerCase();

    if (message.contains('invalid login credentials')) {
      return UnauthorizedException(
        code: 'auth/credenciales-invalidas',
        message: error.message,
        cause: error,
      );
    }
    if (message.contains('email not confirmed')) {
      return UnauthorizedException(
        code: 'auth/email-sin-confirmar',
        message: error.message,
        cause: error,
      );
    }
    if (message.contains('already registered') ||
        message.contains('already been registered')) {
      return ValidationException(
        code: 'auth/email-ya-registrado',
        message: error.message,
        cause: error,
      );
    }
    if (message.contains('password') &&
        (message.contains('weak') || message.contains('at least'))) {
      return ValidationException(
        code: 'auth/password-debil',
        message: error.message,
        cause: error,
      );
    }
    return UnknownException(
      code: 'auth/desconocido',
      message: error.message,
      cause: error,
    );
  }
}
