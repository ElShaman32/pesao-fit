// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutritionist_dashboard_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controlador del dashboard del nutricionista.

@ProviderFor(NutritionistDashboardController)
final nutritionistDashboardControllerProvider =
    NutritionistDashboardControllerProvider._();

/// Controlador del dashboard del nutricionista.
final class NutritionistDashboardControllerProvider
    extends
        $NotifierProvider<
          NutritionistDashboardController,
          NutritionistDashboardState
        > {
  /// Controlador del dashboard del nutricionista.
  NutritionistDashboardControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nutritionistDashboardControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nutritionistDashboardControllerHash();

  @$internal
  @override
  NutritionistDashboardController create() => NutritionistDashboardController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NutritionistDashboardState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NutritionistDashboardState>(value),
    );
  }
}

String _$nutritionistDashboardControllerHash() =>
    r'68a090d80f05e9dbc132e950740c9fa8cd298b32';

/// Controlador del dashboard del nutricionista.

abstract class _$NutritionistDashboardController
    extends $Notifier<NutritionistDashboardState> {
  NutritionistDashboardState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<NutritionistDashboardState, NutritionistDashboardState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                NutritionistDashboardState,
                NutritionistDashboardState
              >,
              NutritionistDashboardState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
