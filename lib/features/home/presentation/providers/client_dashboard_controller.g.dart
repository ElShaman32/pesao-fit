// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_dashboard_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controlador del dashboard del cliente.
/// keepAlive para conservar estado al cambiar entre tabs del shell.

@ProviderFor(ClientDashboardController)
final clientDashboardControllerProvider = ClientDashboardControllerProvider._();

/// Controlador del dashboard del cliente.
/// keepAlive para conservar estado al cambiar entre tabs del shell.
final class ClientDashboardControllerProvider
    extends $NotifierProvider<ClientDashboardController, ClientDashboardState> {
  /// Controlador del dashboard del cliente.
  /// keepAlive para conservar estado al cambiar entre tabs del shell.
  ClientDashboardControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clientDashboardControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clientDashboardControllerHash();

  @$internal
  @override
  ClientDashboardController create() => ClientDashboardController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClientDashboardState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClientDashboardState>(value),
    );
  }
}

String _$clientDashboardControllerHash() =>
    r'be344bee517c83307ad869247121975b3d52745a';

/// Controlador del dashboard del cliente.
/// keepAlive para conservar estado al cambiar entre tabs del shell.

abstract class _$ClientDashboardController
    extends $Notifier<ClientDashboardState> {
  ClientDashboardState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ClientDashboardState, ClientDashboardState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ClientDashboardState, ClientDashboardState>,
              ClientDashboardState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
