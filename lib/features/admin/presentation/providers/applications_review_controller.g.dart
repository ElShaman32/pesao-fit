// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applications_review_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controlador del panel de revisión de solicitudes (keepAlive para que
/// lista y detalle compartan el mismo estado).

@ProviderFor(ApplicationsReviewController)
final applicationsReviewControllerProvider =
    ApplicationsReviewControllerProvider._();

/// Controlador del panel de revisión de solicitudes (keepAlive para que
/// lista y detalle compartan el mismo estado).
final class ApplicationsReviewControllerProvider
    extends
        $NotifierProvider<
          ApplicationsReviewController,
          ApplicationsReviewState
        > {
  /// Controlador del panel de revisión de solicitudes (keepAlive para que
  /// lista y detalle compartan el mismo estado).
  ApplicationsReviewControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'applicationsReviewControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$applicationsReviewControllerHash();

  @$internal
  @override
  ApplicationsReviewController create() => ApplicationsReviewController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApplicationsReviewState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApplicationsReviewState>(value),
    );
  }
}

String _$applicationsReviewControllerHash() =>
    r'fb85b06d96abd215013f85eb54485bd7eb2a2aea';

/// Controlador del panel de revisión de solicitudes (keepAlive para que
/// lista y detalle compartan el mismo estado).

abstract class _$ApplicationsReviewController
    extends $Notifier<ApplicationsReviewState> {
  ApplicationsReviewState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<ApplicationsReviewState, ApplicationsReviewState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ApplicationsReviewState, ApplicationsReviewState>,
              ApplicationsReviewState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
