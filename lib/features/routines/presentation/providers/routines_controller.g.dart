// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routines_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(routinesRepository)
final routinesRepositoryProvider = RoutinesRepositoryProvider._();

final class RoutinesRepositoryProvider
    extends
        $FunctionalProvider<
          RoutinesRepository,
          RoutinesRepository,
          RoutinesRepository
        >
    with $Provider<RoutinesRepository> {
  RoutinesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routinesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routinesRepositoryHash();

  @$internal
  @override
  $ProviderElement<RoutinesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RoutinesRepository create(Ref ref) {
    return routinesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RoutinesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RoutinesRepository>(value),
    );
  }
}

String _$routinesRepositoryHash() =>
    r'a8231954f8ea2d7411f4c9c770bd4a89ec58b0b1';

@ProviderFor(RoutinesController)
final routinesControllerProvider = RoutinesControllerProvider._();

final class RoutinesControllerProvider
    extends $NotifierProvider<RoutinesController, AsyncValue<List<Routine>>> {
  RoutinesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routinesControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routinesControllerHash();

  @$internal
  @override
  RoutinesController create() => RoutinesController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<Routine>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<Routine>>>(value),
    );
  }
}

String _$routinesControllerHash() =>
    r'dcc11c4dc84fc7caaf3e15f61fc30ef695ac7bc8';

abstract class _$RoutinesController
    extends $Notifier<AsyncValue<List<Routine>>> {
  AsyncValue<List<Routine>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<Routine>>, AsyncValue<List<Routine>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Routine>>, AsyncValue<List<Routine>>>,
              AsyncValue<List<Routine>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
