// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutritionist_clients_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controlador de clientes asignados al nutricionista.

@ProviderFor(NutritionistClientsController)
final nutritionistClientsControllerProvider =
    NutritionistClientsControllerProvider._();

/// Controlador de clientes asignados al nutricionista.
final class NutritionistClientsControllerProvider
    extends
        $NotifierProvider<
          NutritionistClientsController,
          NutritionistClientsState
        > {
  /// Controlador de clientes asignados al nutricionista.
  NutritionistClientsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nutritionistClientsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nutritionistClientsControllerHash();

  @$internal
  @override
  NutritionistClientsController create() => NutritionistClientsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NutritionistClientsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NutritionistClientsState>(value),
    );
  }
}

String _$nutritionistClientsControllerHash() =>
    r'8e44b050c5ddae3d5e84e4d342f63d96688baad8';

/// Controlador de clientes asignados al nutricionista.

abstract class _$NutritionistClientsController
    extends $Notifier<NutritionistClientsState> {
  NutritionistClientsState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<NutritionistClientsState, NutritionistClientsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NutritionistClientsState, NutritionistClientsState>,
              NutritionistClientsState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
