// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foods_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(foodsRepository)
final foodsRepositoryProvider = FoodsRepositoryProvider._();

final class FoodsRepositoryProvider
    extends
        $FunctionalProvider<FoodsRepository, FoodsRepository, FoodsRepository>
    with $Provider<FoodsRepository> {
  FoodsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'foodsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$foodsRepositoryHash();

  @$internal
  @override
  $ProviderElement<FoodsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FoodsRepository create(Ref ref) {
    return foodsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FoodsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FoodsRepository>(value),
    );
  }
}

String _$foodsRepositoryHash() => r'7cde12a9ef5dadbbddb3052dadb787b5e99cd885';

/// Controller del catálogo de alimentos. keepAlive para que el catálogo
/// sobreviva a la navegación entre tabs del nutricionista.

@ProviderFor(FoodsController)
final foodsControllerProvider = FoodsControllerProvider._();

/// Controller del catálogo de alimentos. keepAlive para que el catálogo
/// sobreviva a la navegación entre tabs del nutricionista.
final class FoodsControllerProvider
    extends $NotifierProvider<FoodsController, AsyncValue<List<Food>>> {
  /// Controller del catálogo de alimentos. keepAlive para que el catálogo
  /// sobreviva a la navegación entre tabs del nutricionista.
  FoodsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'foodsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$foodsControllerHash();

  @$internal
  @override
  FoodsController create() => FoodsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<Food>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<Food>>>(value),
    );
  }
}

String _$foodsControllerHash() => r'df44c45f7aacd2dcd260245f1b23eadc2a548e56';

/// Controller del catálogo de alimentos. keepAlive para que el catálogo
/// sobreviva a la navegación entre tabs del nutricionista.

abstract class _$FoodsController extends $Notifier<AsyncValue<List<Food>>> {
  AsyncValue<List<Food>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<Food>>, AsyncValue<List<Food>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Food>>, AsyncValue<List<Food>>>,
              AsyncValue<List<Food>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
