// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_nutrition_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller de nutrición del cliente.
/// Carga plan activo + metas + log del día.

@ProviderFor(ClientNutritionController)
final clientNutritionControllerProvider = ClientNutritionControllerProvider._();

/// Controller de nutrición del cliente.
/// Carga plan activo + metas + log del día.
final class ClientNutritionControllerProvider
    extends $NotifierProvider<ClientNutritionController, ClientNutritionState> {
  /// Controller de nutrición del cliente.
  /// Carga plan activo + metas + log del día.
  ClientNutritionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clientNutritionControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clientNutritionControllerHash();

  @$internal
  @override
  ClientNutritionController create() => ClientNutritionController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClientNutritionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClientNutritionState>(value),
    );
  }
}

String _$clientNutritionControllerHash() =>
    r'a7079113464e8cef9bb29e5045f563765a34bea5';

/// Controller de nutrición del cliente.
/// Carga plan activo + metas + log del día.

abstract class _$ClientNutritionController
    extends $Notifier<ClientNutritionState> {
  ClientNutritionState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ClientNutritionState, ClientNutritionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ClientNutritionState, ClientNutritionState>,
              ClientNutritionState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
