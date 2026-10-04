// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutritionist_dashboard_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(nutritionistDashboardRepository)
final nutritionistDashboardRepositoryProvider =
    NutritionistDashboardRepositoryProvider._();

final class NutritionistDashboardRepositoryProvider
    extends
        $FunctionalProvider<
          NutritionistDashboardRepository,
          NutritionistDashboardRepository,
          NutritionistDashboardRepository
        >
    with $Provider<NutritionistDashboardRepository> {
  NutritionistDashboardRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nutritionistDashboardRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nutritionistDashboardRepositoryHash();

  @$internal
  @override
  $ProviderElement<NutritionistDashboardRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NutritionistDashboardRepository create(Ref ref) {
    return nutritionistDashboardRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NutritionistDashboardRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NutritionistDashboardRepository>(
        value,
      ),
    );
  }
}

String _$nutritionistDashboardRepositoryHash() =>
    r'77af0715ffc01d5107fc8b6330bc4026c7132e2d';

/// Controller de estadísticas del dashboard del nutricionista.
/// keepAlive para que las stats sobrevivan a la navegación entre tabs.

@ProviderFor(NutritionistDashboardController)
final nutritionistDashboardControllerProvider =
    NutritionistDashboardControllerProvider._();

/// Controller de estadísticas del dashboard del nutricionista.
/// keepAlive para que las stats sobrevivan a la navegación entre tabs.
final class NutritionistDashboardControllerProvider
    extends
        $NotifierProvider<
          NutritionistDashboardController,
          AsyncValue<NutritionistStats>
        > {
  /// Controller de estadísticas del dashboard del nutricionista.
  /// keepAlive para que las stats sobrevivan a la navegación entre tabs.
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
  Override overrideWithValue(AsyncValue<NutritionistStats> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<NutritionistStats>>(
        value,
      ),
    );
  }
}

String _$nutritionistDashboardControllerHash() =>
    r'3e45979d739661f67014a86527c90ddf510127af';

/// Controller de estadísticas del dashboard del nutricionista.
/// keepAlive para que las stats sobrevivan a la navegación entre tabs.

abstract class _$NutritionistDashboardController
    extends $Notifier<AsyncValue<NutritionistStats>> {
  AsyncValue<NutritionistStats> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<NutritionistStats>,
              AsyncValue<NutritionistStats>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<NutritionistStats>,
                AsyncValue<NutritionistStats>
              >,
              AsyncValue<NutritionistStats>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
