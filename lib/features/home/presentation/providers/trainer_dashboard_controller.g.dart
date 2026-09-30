// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trainer_dashboard_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controlador del dashboard del entrenador.

@ProviderFor(TrainerDashboardController)
final trainerDashboardControllerProvider =
    TrainerDashboardControllerProvider._();

/// Controlador del dashboard del entrenador.
final class TrainerDashboardControllerProvider
    extends
        $NotifierProvider<TrainerDashboardController, TrainerDashboardState> {
  /// Controlador del dashboard del entrenador.
  TrainerDashboardControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trainerDashboardControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trainerDashboardControllerHash();

  @$internal
  @override
  TrainerDashboardController create() => TrainerDashboardController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TrainerDashboardState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TrainerDashboardState>(value),
    );
  }
}

String _$trainerDashboardControllerHash() =>
    r'5d7e3afa54c7be2b379f24a7bb933c8fcca8637f';

/// Controlador del dashboard del entrenador.

abstract class _$TrainerDashboardController
    extends $Notifier<TrainerDashboardState> {
  TrainerDashboardState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<TrainerDashboardState, TrainerDashboardState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TrainerDashboardState, TrainerDashboardState>,
              TrainerDashboardState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
