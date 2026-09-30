import '../exceptions/app_exception.dart';

/// Resultado de una operación que puede fallar (arquitectura.md §4).
///
/// Estados: idle | loading | success | failure.
/// Se usa en TODOS los repositories y providers (convenciones.md §6).
///
/// Ejemplo de uso en una pantalla (los 5 estados salen de aquí + conexión):
/// ```dart
/// state.when(
///   idle: () => SkeletonLoader(...),
///   loading: () => SkeletonLoader(...),
///   success: (data) => Contenido(data),
///   failure: (error) => ErrorState(...),
/// );
/// ```
sealed class Result<T> {
  const Result();

  const factory Result.idle() = ResultIdle<T>;
  const factory Result.loading() = ResultLoading<T>;
  const factory Result.success(T data) = ResultSuccess<T>;
  const factory Result.failure(AppException error) = ResultFailure<T>;

  bool get isIdle => this is ResultIdle<T>;
  bool get isLoading => this is ResultLoading<T>;
  bool get isSuccess => this is ResultSuccess<T>;
  bool get isFailure => this is ResultFailure<T>;

  /// Datos si hay éxito; null en cualquier otro estado.
  T? get dataOrNull => switch (this) {
    ResultSuccess<T>(:final data) => data,
    _ => null,
  };

  /// Error si hay fallo; null en cualquier otro estado.
  AppException? get errorOrNull => switch (this) {
    ResultFailure<T>(:final error) => error,
    _ => null,
  };

  /// Manejo exhaustivo de los 4 estados (ideal para la UI).
  R when<R>({
    required R Function() idle,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(AppException error) failure,
  }) {
    return switch (this) {
      ResultIdle<T>() => idle(),
      ResultLoading<T>() => loading(),
      ResultSuccess<T>(:final data) => success(data),
      ResultFailure<T>(:final error) => failure(error),
    };
  }

  /// Envuelve una función que puede lanzar y la convierte en [Result].
  /// Se usará mucho en repositories para no dejar errores sueltos.
  static Result<T> guard<T>(T Function() body) {
    try {
      return Result.success(body());
    } on AppException catch (exception) {
      return Result.failure(exception);
    } catch (exception) {
      return Result.failure(UnknownException(cause: exception));
    }
  }

  /// Versión async de [guard].
  static Future<Result<T>> guardAsync<T>(Future<T> Function() body) async {
    try {
      return Result.success(await body());
    } on AppException catch (exception) {
      return Result.failure(exception);
    } catch (exception) {
      return Result.failure(UnknownException(cause: exception));
    }
  }
}

final class ResultIdle<T> extends Result<T> {
  const ResultIdle();
}

final class ResultLoading<T> extends Result<T> {
  const ResultLoading();
}

final class ResultSuccess<T> extends Result<T> {
  const ResultSuccess(this.data);
  final T data;
}

final class ResultFailure<T> extends Result<T> {
  const ResultFailure(this.error);
  final AppException error;
}
