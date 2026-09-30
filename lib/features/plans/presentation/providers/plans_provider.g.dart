// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plans_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(plansRepository)
final plansRepositoryProvider = PlansRepositoryProvider._();

final class PlansRepositoryProvider
    extends
        $FunctionalProvider<PlansRepository, PlansRepository, PlansRepository>
    with $Provider<PlansRepository> {
  PlansRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'plansRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$plansRepositoryHash();

  @$internal
  @override
  $ProviderElement<PlansRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PlansRepository create(Ref ref) {
    return plansRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlansRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlansRepository>(value),
    );
  }
}

String _$plansRepositoryHash() => r'bb0f227b298a28098ed96d1042f116c73b288e0a';

@ProviderFor(plans)
final plansProvider = PlansProvider._();

final class PlansProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          FutureOr<List<Map<String, dynamic>>>
        >
    with
        $FutureModifier<List<Map<String, dynamic>>>,
        $FutureProvider<List<Map<String, dynamic>>> {
  PlansProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'plansProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$plansHash();

  @$internal
  @override
  $FutureProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Map<String, dynamic>>> create(Ref ref) {
    return plans(ref);
  }
}

String _$plansHash() => r'7128ff258c5048778c0cab6b6be09cf3eabc5118';
