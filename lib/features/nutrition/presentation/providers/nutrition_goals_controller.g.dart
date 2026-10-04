// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition_goals_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(nutritionGoalsRepository)
final nutritionGoalsRepositoryProvider = NutritionGoalsRepositoryProvider._();

final class NutritionGoalsRepositoryProvider
    extends
        $FunctionalProvider<
          NutritionGoalsRepository,
          NutritionGoalsRepository,
          NutritionGoalsRepository
        >
    with $Provider<NutritionGoalsRepository> {
  NutritionGoalsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nutritionGoalsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nutritionGoalsRepositoryHash();

  @$internal
  @override
  $ProviderElement<NutritionGoalsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NutritionGoalsRepository create(Ref ref) {
    return nutritionGoalsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NutritionGoalsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NutritionGoalsRepository>(value),
    );
  }
}

String _$nutritionGoalsRepositoryHash() =>
    r'fbe22ba50f99206c9fe8ec8f5260aee3aeb60ad4';

/// Controller de objetivos nutricionales del cliente actualmente en foco.
/// El nutricionista fija/edita goals desde la pantalla de detalle del cliente.

@ProviderFor(NutritionGoalsController)
final nutritionGoalsControllerProvider = NutritionGoalsControllerProvider._();

/// Controller de objetivos nutricionales del cliente actualmente en foco.
/// El nutricionista fija/edita goals desde la pantalla de detalle del cliente.
final class NutritionGoalsControllerProvider
    extends
        $NotifierProvider<
          NutritionGoalsController,
          AsyncValue<NutritionGoal?>
        > {
  /// Controller de objetivos nutricionales del cliente actualmente en foco.
  /// El nutricionista fija/edita goals desde la pantalla de detalle del cliente.
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
  Override overrideWithValue(AsyncValue<NutritionGoal?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<NutritionGoal?>>(value),
    );
  }
}

String _$nutritionGoalsControllerHash() =>
    r'33f32ed69114fa45a3ffb6776422b56da14225ad';

/// Controller de objetivos nutricionales del cliente actualmente en foco.
/// El nutricionista fija/edita goals desde la pantalla de detalle del cliente.

abstract class _$NutritionGoalsController
    extends $Notifier<AsyncValue<NutritionGoal?>> {
  AsyncValue<NutritionGoal?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<NutritionGoal?>, AsyncValue<NutritionGoal?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<NutritionGoal?>,
                AsyncValue<NutritionGoal?>
              >,
              AsyncValue<NutritionGoal?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
