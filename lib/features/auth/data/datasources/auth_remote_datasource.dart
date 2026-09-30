import 'package:supabase_flutter/supabase_flutter.dart' as sb;

/// DataSource remoto de autenticación.
/// Único punto de contacto con Supabase Auth (convenciones.md §3).
class AuthRemoteDatasource {
  AuthRemoteDatasource(this._client);

  final sb.SupabaseClient _client;

  /// Inicia sesión con email/password y devuelve el usuario de Supabase.
  Future<sb.User> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final user = response.user;
    if (user == null) {
      throw Exception('La sesión no devolvió usuario');
    }
    return user;
  }

  /// Registra un usuario nuevo y devuelve el usuario creado.
  Future<sb.User> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': fullName},
    );
    final user = response.user;
    if (user == null) {
      throw Exception('El registro no devolvió usuario');
    }
    return user;
  }

  /// Cierra la sesión actual.
  Future<void> signOut() => _client.auth.signOut();

  /// Usuario en sesión, o null si no hay nadie logueado.
  sb.User? currentUser() => _client.auth.currentUser;

  /// Stream de cambios de sesión (login, logout, refresh de token).
  Stream<sb.AuthState> authStateChanges() => _client.auth.onAuthStateChange;

  /// Busca la membresía activa del usuario para resolver rol y gimnasio.
  /// Devuelve null si el usuario aún no pertenece a ningún gimnasio.
  Future<Map<String, dynamic>?> fetchPrimaryMembership(String userId) async {
    return _client
        .from('memberships')
        .select('role, gym_id')
        .eq('user_id', userId)
        .eq('is_active', true)
        .limit(1)
        .maybeSingle();
  }

  /// Lee el perfil del usuario, incluyendo el flag de superadmin.
  Future<Map<String, dynamic>?> fetchProfile(String userId) async {
    return _client
        .from('profiles')
        .select('full_name, avatar_url, is_superadmin')
        .eq('id', userId)
        .maybeSingle();
  }
}
