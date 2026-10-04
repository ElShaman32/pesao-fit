// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutritionist_clients_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(nutritionClientsRepository)
final nutritionClientsRepositoryProvider =
    NutritionClientsRepositoryProvider._();

final class NutritionClientsRepositoryProvider
    extends
        $FunctionalProvider<
          NutritionClientsRepository,
          NutritionClientsRepository,
          NutritionClientsRepository
        >
    with $Provider<NutritionClientsRepository> {
  NutritionClientsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nutritionClientsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nutritionClientsRepositoryHash();

  @$internal
  @override
  $ProviderElement<NutritionClientsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NutritionClientsRepository create(Ref ref) {
    return nutritionClientsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NutritionClientsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NutritionClientsRepository>(value),
    );
  }
}

String _$nutritionClientsRepositoryHash() =>
    r'b3f8c16cbd4b9a612b8b85929bf6d0408a3bd4a4';

/// Controller de la lista de clientes del nutricionista.
/// keepAlive para que la lista sobreviva al navegar al detalle y volver.

@ProviderFor(NutritionistClientsController)
final nutritionistClientsControllerProvider =
    NutritionistClientsControllerProvider._();

/// Controller de la lista de clientes del nutricionista.
/// keepAlive para que la lista sobreviva al navegar al detalle y volver.
final class NutritionistClientsControllerProvider
    extends
        $NotifierProvider<
          NutritionistClientsController,
          AsyncValue<List<NutritionClient>>
        > {
  /// Controller de la lista de clientes del nutricionista.
  /// keepAlive para que la lista sobreviva al navegar al detalle y volver.
  NutritionistClientsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nutritionistClientsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nutritionistClientsControllerHash();

  @$internal
  @override
  NutritionistClientsController create() => NutritionistClientsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<NutritionClient>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<NutritionClient>>>(
        value,
      ),
    );
  }
}

String _$nutritionistClientsControllerHash() =>
    r'67e44d92e58c105d2e1e0b3734ea5d0e09d766cc';

/// Controller de la lista de clientes del nutricionista.
/// keepAlive para que la lista sobreviva al navegar al detalle y volver.

abstract class _$NutritionistClientsController
    extends $Notifier<AsyncValue<List<NutritionClient>>> {
  AsyncValue<List<NutritionClient>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<NutritionClient>>,
              AsyncValue<List<NutritionClient>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<NutritionClient>>,
                AsyncValue<List<NutritionClient>>
              >,
              AsyncValue<List<NutritionClient>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
