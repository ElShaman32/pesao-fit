// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gym_discovery_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controlador del flujo de gym discovery.

@ProviderFor(GymDiscoveryController)
final gymDiscoveryControllerProvider = GymDiscoveryControllerProvider._();

/// Controlador del flujo de gym discovery.
final class GymDiscoveryControllerProvider
    extends $NotifierProvider<GymDiscoveryController, GymDiscoveryState> {
  /// Controlador del flujo de gym discovery.
  GymDiscoveryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gymDiscoveryControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gymDiscoveryControllerHash();

  @$internal
  @override
  GymDiscoveryController create() => GymDiscoveryController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GymDiscoveryState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GymDiscoveryState>(value),
    );
  }
}

String _$gymDiscoveryControllerHash() =>
    r'733418b7f8b49ad714b9330aa3b6601a72cfd86f';

/// Controlador del flujo de gym discovery.

abstract class _$GymDiscoveryController extends $Notifier<GymDiscoveryState> {
  GymDiscoveryState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<GymDiscoveryState, GymDiscoveryState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GymDiscoveryState, GymDiscoveryState>,
              GymDiscoveryState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
