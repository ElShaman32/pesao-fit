import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/entities/auth_user.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../utils/result.dart';
import 'supabase_provider.dart';

/// Instancia global de autenticación.
///
/// Sigue siendo un singleton accesible desde el redirect de GoRouter
/// (que no tiene BuildContext del app), pero ahora está conectado a
/// Supabase Auth real en lugar de ser un placeholder.
///
/// El [GoRouter] lo usa como `refreshListenable`: cada vez que este
/// ChangeNotifier dispara `notifyListeners()`, el router re-evalúa
/// el redirect automáticamente (login/logout).
final authProvider = AuthNotifier(
  AuthRepositoryImpl(remote: AuthRemoteDatasource(supabaseClient)),
);

/// Roles de usuario en el sistema (mapeo desde el string de Supabase).
enum UserRole { client, trainer, owner, nutritionist, admin }

/// ChangeNotifier que envuelve el [AuthRepository] y escucha los cambios
/// de sesión de Supabase Auth en tiempo real.
///
/// Expone la misma API pública que tenía antes (para no romper el router),
/// pero internamente usa el flujo domain → data → repository del proyecto.
class AuthNotifier extends ChangeNotifier {
  AuthNotifier(this._repository) {
    // Inicializa estado desde la sesión actual (si existe, ej: app reiniciada
    // con token válido) y luego suscribe al stream de cambios.
    _init();
  }

  final AuthRepository _repository;
  StreamSubscription<AuthUser?>? _authSubscription;

  bool _isInitializing = true;
  bool _isLoggedIn = false;
  UserRole? _userRole;
  String? _userId;
  String? _userEmail;
  String? _userFullName;
  String? _userGymId;
  String? _avatarUrl;

  // --- API pública (compatible con GoRouter existente) ---

  /// True mientras se restaura la sesión inicial al abrir la app.
  bool get isInitializing => _isInitializing;
  bool get isLoggedIn => _isLoggedIn;
  UserRole? get userRole => _userRole;
  String? get userId => _userId;

  // --- API extendida para la UI (nombre, avatar, gimnasio) ---

  String? get userEmail => _userEmail;
  String? get userFullName => _userFullName;
  String? get userGymId => _userGymId;
  String? get avatarUrl => _avatarUrl;

  /// Indica si el usuario está autenticado pero AÚN no pertenece a
  /// ningún gimnasio (recién registrado → debe ir a onboarding).
  bool get needsOnboarding => _isLoggedIn && _userRole == null;

  /// Inicializa estado desde la sesión actual y suscribe al stream.
  Future<void> _init() async {
    try {
      // Leer sesión actual (ej: token persistido de Supabase).
      final result = await _repository.currentUser();
      if (result.isSuccess && result.dataOrNull != null) {
        _applyAuthUser(result.dataOrNull!);
      }
    } catch (_) {
      // Si falla la restauración, el usuario queda como no logueado.
    } finally {
      // Marcar fin de inicialización SIEMPRE, incluso si hubo error.
      _isInitializing = false;
      notifyListeners();
    }

    // Suscribirse a cambios de sesión (login, logout, refresh token).
    _authSubscription = _repository.authStateChanges().listen((authUser) {
      if (authUser == null) {
        _clearState();
      } else {
        _applyAuthUser(authUser);
      }
      notifyListeners();
    });
  }

  /// Inicia sesión con email/password (ADR-006: único método permitido).
  ///
  /// Devuelve [Result] para que la UI maneje errores con microcopy VE.
  Future<Result<AuthUser>> signIn({
    required String email,
    required String password,
  }) async {
    final result = await _repository.signIn(email: email, password: password);
    if (result.isSuccess && result.dataOrNull != null) {
      _applyAuthUser(result.dataOrNull!);
      notifyListeners();
    }
    return result;
  }

  /// Registra un usuario nuevo con email/password.
  Future<Result<AuthUser>> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final result = await _repository.signUp(
      email: email,
      password: password,
      fullName: fullName,
    );
    if (result.isSuccess && result.dataOrNull != null) {
      _applyAuthUser(result.dataOrNull!);
      notifyListeners();
    }
    return result;
  }

  /// Cierra la sesión actual.
  Future<Result<bool>> signOut() async {
    final result = await _repository.signOut();
    if (result.isSuccess) {
      _clearState();
      notifyListeners();
    }
    return result;
  }

  /// Recarga el usuario actual desde Supabase.
  /// Útil tras cambios de membresía (ej: unirse a un gimnasio).
  Future<void> refresh() async {
    final result = await _repository.currentUser();
    if (result.isSuccess && result.dataOrNull != null) {
      _applyAuthUser(result.dataOrNull!);
    } else {
      _clearState();
    }
    notifyListeners();
  }

  /// Legacy: mantener API anterior para compatibilidad si queda algún
  /// código que llame `login()`. Redirige a [signOut] en logout.
  @Deprecated('Usar signIn() o signUp() con Result<T> en su lugar.')
  void login({required UserRole role, required String userId}) {
    _isLoggedIn = true;
    _userRole = role;
    _userId = userId;
    notifyListeners();
  }

  /// Legacy: logout anterior. Ahora es un alias de [signOut].
  void logout() {
    signOut();
  }

  /// Aplica el [AuthUser] al estado interno del notifier.
  void _applyAuthUser(AuthUser user) {
    _isLoggedIn = true;
    _userId = user.id;
    _userEmail = user.email;
    _userFullName = user.fullName;
    _userGymId = user.gymId;
    _avatarUrl = user.avatarUrl;
    _userRole = _mapRole(user.role);
  }

  /// Limpia todo el estado cuando el usuario se desloguea.
  void _clearState() {
    _isLoggedIn = false;
    _userId = null;
    _userEmail = null;
    _userFullName = null;
    _userRole = null;
    _userGymId = null;
    _avatarUrl = null;
  }

  /// Mapea el string de Supabase ('client', 'trainer', ...) al enum [UserRole].
  /// Devuelve null si el usuario no tiene rol (necesita onboarding).
  UserRole? _mapRole(String? role) {
    if (role == null) return null;
    switch (role) {
      case 'client':
        return UserRole.client;
      case 'trainer':
        return UserRole.trainer;
      case 'owner':
        return UserRole.owner;
      case 'nutritionist':
        return UserRole.nutritionist;
      case 'admin':
        return UserRole.admin;
      default:
        return null;
    }
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}
