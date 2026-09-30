import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/auth_provider.dart';

part 'login_controller.g.dart';

/// Estado inmutable del formulario de login.
class LoginState {
  const LoginState({
    this.email = '',
    this.password = '',
    this.isSubmitting = false,
    this.error,
  });

  final String email;
  final String password;
  final bool isSubmitting;
  final String? error;

  bool get isValid {
    final emailOk = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(email);
    final passOk = password.length >= 6;
    return emailOk && passOk && !isSubmitting;
  }

  LoginState copyWith({
    String? email,
    String? password,
    bool? isSubmitting,
    String? error,
    bool clearError = false,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Controlador del formulario de login.
@riverpod
class LoginController extends _$LoginController {
  @override
  LoginState build() => const LoginState();

  void setEmail(String value) {
    state = state.copyWith(email: value, clearError: true);
  }

  void setPassword(String value) {
    state = state.copyWith(password: value, clearError: true);
  }

  /// Ejecuta el login real a través de [AuthNotifier].
  /// Mapea códigos de error a microcopy venezolano.
  Future<void> submit() async {
    if (!state.isValid || state.isSubmitting) return;

    state = state.copyWith(isSubmitting: true, clearError: true);

    final result = await authProvider.signIn(
      email: state.email.trim(),
      password: state.password,
    );

    result.when(
      idle: () {},
      loading: () {},
      success: (_) {
        // El AuthNotifier ya disparó notifyListeners → GoRouter hace el redirect.
        state = state.copyWith(isSubmitting: false);
      },
      failure: (error) {
        final message = _mapErrorCode(error.code);
        state = state.copyWith(isSubmitting: false, error: message);
      },
    );
  }

  /// Mapea el código de [AppException] al microcopy venezolano.
  /// Los códigos vienen del AuthRepository (auth/credenciales-invalidas, etc).
  String _mapErrorCode(String? code) {
    // Usamos AppStrings en la UI, aquí devolvemos la clave
    // para que el widget la resuelva con context.l10n.
    // Retornamos el código mismo y el widget lo mapea.
    return code ?? 'auth/desconocido';
  }
}
