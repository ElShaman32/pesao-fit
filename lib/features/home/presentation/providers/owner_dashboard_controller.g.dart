// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_dashboard_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controlador del dashboard del dueño.

@ProviderFor(OwnerDashboardController)
final ownerDashboardControllerProvider = OwnerDashboardControllerProvider._();

/// Controlador del dashboard del dueño.
final class OwnerDashboardControllerProvider
    extends $NotifierProvider<OwnerDashboardController, OwnerDashboardState> {
  /// Controlador del dashboard del dueño.
  OwnerDashboardControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ownerDashboardControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ownerDashboardControllerHash();

  @$internal
  @override
  OwnerDashboardController create() => OwnerDashboardController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OwnerDashboardState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OwnerDashboardState>(value),
    );
  }
}

String _$ownerDashboardControllerHash() =>
    r'bbf9340c9571ffa0a996fdbecca5151ecfd2ae10';

/// Controlador del dashboard del dueño.

abstract class _$OwnerDashboardController
    extends $Notifier<OwnerDashboardState> {
  OwnerDashboardState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<OwnerDashboardState, OwnerDashboardState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<OwnerDashboardState, OwnerDashboardState>,
              OwnerDashboardState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
