// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_templates_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controlador de plantillas de comida del nutricionista.

@ProviderFor(MealTemplatesController)
final mealTemplatesControllerProvider = MealTemplatesControllerProvider._();

/// Controlador de plantillas de comida del nutricionista.
final class MealTemplatesControllerProvider
    extends $NotifierProvider<MealTemplatesController, MealTemplatesState> {
  /// Controlador de plantillas de comida del nutricionista.
  MealTemplatesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mealTemplatesControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mealTemplatesControllerHash();

  @$internal
  @override
  MealTemplatesController create() => MealTemplatesController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MealTemplatesState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MealTemplatesState>(value),
    );
  }
}

String _$mealTemplatesControllerHash() =>
    r'45411cd758e8676e522767f1e902548579ce65a8';

/// Controlador de plantillas de comida del nutricionista.

abstract class _$MealTemplatesController extends $Notifier<MealTemplatesState> {
  MealTemplatesState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<MealTemplatesState, MealTemplatesState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MealTemplatesState, MealTemplatesState>,
              MealTemplatesState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
