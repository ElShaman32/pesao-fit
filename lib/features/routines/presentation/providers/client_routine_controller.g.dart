// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_routine_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ClientRoutineController)
final clientRoutineControllerProvider = ClientRoutineControllerProvider._();

final class ClientRoutineControllerProvider
    extends $NotifierProvider<ClientRoutineController, AsyncValue<Routine?>> {
  ClientRoutineControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clientRoutineControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clientRoutineControllerHash();

  @$internal
  @override
  ClientRoutineController create() => ClientRoutineController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<Routine?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<Routine?>>(value),
    );
  }
}

String _$clientRoutineControllerHash() =>
    r'78398a02e3db3168183c4a61dc28576ab4f4e0c9';

abstract class _$ClientRoutineController
    extends $Notifier<AsyncValue<Routine?>> {
  AsyncValue<Routine?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Routine?>, AsyncValue<Routine?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Routine?>, AsyncValue<Routine?>>,
              AsyncValue<Routine?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
