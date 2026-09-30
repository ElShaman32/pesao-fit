/// Excepción base de PESAO FIT.
///
/// Reglas (convenciones.md §6, arquitectura.md):
/// - Se lanza en datasources / repositories / usecases.
/// - La UI NUNCA muestra [message] directo; mapea [code] a AppStrings.
/// - [message] es para logs (Sentry), no para el usuario.
sealed class AppException implements Exception {
  const AppException({this.code, this.message, this.cause});

  /// Código estable para que la UI elija el microcopy (AppStrings).
  /// Ejemplo: 'auth/email-invalid', 'network/sin-senal'.
  final String? code;

  /// Descripción técnica para logs. NUNCA se muestra al usuario.
  final String? message;

  /// Excepción original que causó esta, si viene de otra librería.
  final Object? cause;

  @override
  String toString() => '$runtimeType(code: $code, message: $message)';
}

/// Sin conexión o timeout.
final class NetworkException extends AppException {
  const NetworkException({super.code, super.message, super.cause});
}

/// Sesión inválida o vencida.
final class UnauthorizedException extends AppException {
  const UnauthorizedException({super.code, super.message, super.cause});
}

/// Datos de entrada inválidos (validaciones suaves).
final class ValidationException extends AppException {
  const ValidationException({super.code, super.message, super.cause});
}

/// Recurso no encontrado.
final class NotFoundException extends AppException {
  const NotFoundException({super.code, super.message, super.cause});
}

/// Error no contemplado.
final class UnknownException extends AppException {
  const UnknownException({super.code, super.message, super.cause});
}
