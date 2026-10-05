// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition_goals_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controlador de metas nutricionales por cliente.

@ProviderFor(NutritionGoalsController)
final nutritionGoalsControllerProvider = NutritionGoalsControllerProvider._();

/// Controlador de metas nutricionales por cliente.
final class NutritionGoalsControllerProvider
    extends $NotifierProvider<NutritionGoalsController, NutritionGoalsState> {
  /// Controlador de metas nutricionales por cliente.
  NutritionGoalsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nutritionGoalsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nutritionGoalsControllerHash();

  @$internal
  @override
  NutritionGoalsController create() => NutritionGoalsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NutritionGoalsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NutritionGoalsState>(value),
    );
  }
}

String _$nutritionGoalsControllerHash() =>
    r'73daad0dad59a72e6be0d45f05f9a37ce986d226';

/// Controlador de metas nutricionales por cliente.

abstract class _$NutritionGoalsController
    extends $Notifier<NutritionGoalsState> {
  NutritionGoalsState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<NutritionGoalsState, NutritionGoalsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NutritionGoalsState, NutritionGoalsState>,
              NutritionGoalsState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
