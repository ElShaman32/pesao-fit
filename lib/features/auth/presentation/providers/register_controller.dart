import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/auth_provider.dart';

part 'register_controller.g.dart';

/// Estado inmutable del formulario de registro.
class RegisterState {
  const RegisterState({
    this.fullName = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.isSubmitting = false,
    this.error,
  });

  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;
  final bool isSubmitting;
  final String? error;

  bool get isValid {
    final nameOk = fullName.trim().isNotEmpty;
    final emailOk = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(email);
    final passOk = password.length >= 6;
    final confirmOk = confirmPassword == password && confirmPassword.isNotEmpty;
    return nameOk && emailOk && passOk && confirmOk && !isSubmitting;
  }

  RegisterState copyWith({
    String? fullName,
    String? email,
    String? password,
    String? confirmPassword,
    bool? isSubmitting,
    String? error,
    bool clearError = false,
  }) {
    return RegisterState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Controlador del formulario de registro.
@riverpod
class RegisterController extends _$RegisterController {
  @override
  RegisterState build() => const RegisterState();

  void setFullName(String value) {
    state = state.copyWith(fullName: value, clearError: true);
  }

  void setEmail(String value) {
    state = state.copyWith(email: value, clearError: true);
  }

  void setPassword(String value) {
    state = state.copyWith(password: value, clearError: true);
  }

  void setConfirmPassword(String value) {
    state = state.copyWith(confirmPassword: value, clearError: true);
  }

  /// Capitaliza la primera letra de cada palabra del nombre.
  /// Garantiza dato limpio en la BD aunque el usuario escriba en minúsculas.
  /// Ej: "leonel RODRIGUEZ" -> "Leonel Rodriguez".
  String _capitalizeWords(String input) {
    return input
        .trim()
        .split(' ')
        .where((word) => word.isNotEmpty)
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  /// Ejecuta el registro real a través de [AuthNotifier].
  Future<void> submit() async {
    if (!state.isValid || state.isSubmitting) return;

    state = state.copyWith(isSubmitting: true, clearError: true);

    final result = await authProvider.signUp(
      email: state.email.trim(),
      password: state.password,
      fullName: _capitalizeWords(state.fullName),
    );

    result.when(
      idle: () {},
      loading: () {},
      success: (_) {
        // AuthNotifier ya disparó notifyListeners → GoRouter redirige a onboarding
        // (porque el usuario recién registrado no tiene membresía aún).
        state = state.copyWith(isSubmitting: false);
      },
      failure: (error) {
        final code = error.code ?? 'auth/desconocido';
        state = state.copyWith(isSubmitting: false, error: code);
      },
    );
  }
}
