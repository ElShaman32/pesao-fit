// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foods_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controlador del catálogo de alimentos.

@ProviderFor(FoodsController)
final foodsControllerProvider = FoodsControllerProvider._();

/// Controlador del catálogo de alimentos.
final class FoodsControllerProvider
    extends $NotifierProvider<FoodsController, FoodsState> {
  /// Controlador del catálogo de alimentos.
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
  Override overrideWithValue(FoodsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FoodsState>(value),
    );
  }
}

String _$foodsControllerHash() => r'48153d300bfb745e723a942044b910c176ce8200';

/// Controlador del catálogo de alimentos.

abstract class _$FoodsController extends $Notifier<FoodsState> {
  FoodsState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<FoodsState, FoodsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FoodsState, FoodsState>,
              FoodsState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
