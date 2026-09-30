// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_home_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider del dashboard del cliente.
///
/// Notifier cuyo estado es directamente `Result<ClientHomeData>`,
///
/// /// para que la pantalla pueda usar state.when(idle/loading/success/failure).
///
/// Hoy devuelve datos simulados (FASE 0). En F2 se reemplaza la carga
/// por el caso de uso real manteniendo la misma estructura.

@ProviderFor(ClientHome)
final clientHomeProvider = ClientHomeProvider._();

/// Provider del dashboard del cliente.
///
/// Notifier cuyo estado es directamente `Result<ClientHomeData>`,
///
/// /// para que la pantalla pueda usar state.when(idle/loading/success/failure).
///
/// Hoy devuelve datos simulados (FASE 0). En F2 se reemplaza la carga
/// por el caso de uso real manteniendo la misma estructura.
final class ClientHomeProvider
    extends $NotifierProvider<ClientHome, Result<ClientHomeData>> {
  /// Provider del dashboard del cliente.
  ///
  /// Notifier cuyo estado es directamente `Result<ClientHomeData>`,
  ///
  /// /// para que la pantalla pueda usar state.when(idle/loading/success/failure).
  ///
  /// Hoy devuelve datos simulados (FASE 0). En F2 se reemplaza la carga
  /// por el caso de uso real manteniendo la misma estructura.
  ClientHomeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clientHomeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clientHomeHash();

  @$internal
  @override
  ClientHome create() => ClientHome();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Result<ClientHomeData> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Result<ClientHomeData>>(value),
    );
  }
}

String _$clientHomeHash() => r'7ecdfa17e160a8f0a84811f9067bae06d0721b62';

/// Provider del dashboard del cliente.
///
/// Notifier cuyo estado es directamente `Result<ClientHomeData>`,
///
/// /// para que la pantalla pueda usar state.when(idle/loading/success/failure).
///
/// Hoy devuelve datos simulados (FASE 0). En F2 se reemplaza la carga
/// por el caso de uso real manteniendo la misma estructura.

abstract class _$ClientHome extends $Notifier<Result<ClientHomeData>> {
  Result<ClientHomeData> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<Result<ClientHomeData>, Result<ClientHomeData>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Result<ClientHomeData>, Result<ClientHomeData>>,
              Result<ClientHomeData>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
