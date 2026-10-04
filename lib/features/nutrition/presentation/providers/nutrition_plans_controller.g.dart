// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition_plans_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controlador de planes nutricionales del nutricionista.

@ProviderFor(NutritionPlansController)
final nutritionPlansControllerProvider = NutritionPlansControllerProvider._();

/// Controlador de planes nutricionales del nutricionista.
final class NutritionPlansControllerProvider
    extends $NotifierProvider<NutritionPlansController, NutritionPlansState> {
  /// Controlador de planes nutricionales del nutricionista.
  NutritionPlansControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nutritionPlansControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nutritionPlansControllerHash();

  @$internal
  @override
  NutritionPlansController create() => NutritionPlansController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NutritionPlansState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NutritionPlansState>(value),
    );
  }
}

String _$nutritionPlansControllerHash() =>
    r'f970373425134daab70071acfe1f87bd9507b1ee';

/// Controlador de planes nutricionales del nutricionista.

abstract class _$NutritionPlansController
    extends $Notifier<NutritionPlansState> {
  NutritionPlansState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<NutritionPlansState, NutritionPlansState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NutritionPlansState, NutritionPlansState>,
              NutritionPlansState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
