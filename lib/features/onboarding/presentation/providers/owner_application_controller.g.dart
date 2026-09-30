// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_application_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controlador del formulario de solicitud de dueño.

@ProviderFor(OwnerApplicationController)
final ownerApplicationControllerProvider =
    OwnerApplicationControllerProvider._();

/// Controlador del formulario de solicitud de dueño.
final class OwnerApplicationControllerProvider
    extends
        $NotifierProvider<OwnerApplicationController, OwnerApplicationState> {
  /// Controlador del formulario de solicitud de dueño.
  OwnerApplicationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ownerApplicationControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ownerApplicationControllerHash();

  @$internal
  @override
  OwnerApplicationController create() => OwnerApplicationController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OwnerApplicationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OwnerApplicationState>(value),
    );
  }
}

String _$ownerApplicationControllerHash() =>
    r'2c80cd11134a87d70016c68eb1f5f0d16c4832b4';

/// Controlador del formulario de solicitud de dueño.

abstract class _$OwnerApplicationController
    extends $Notifier<OwnerApplicationState> {
  OwnerApplicationState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<OwnerApplicationState, OwnerApplicationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<OwnerApplicationState, OwnerApplicationState>,
              OwnerApplicationState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
