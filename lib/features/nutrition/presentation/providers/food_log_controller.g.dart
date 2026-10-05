// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_log_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controlador del registro diario de comidas del cliente.

@ProviderFor(FoodLogController)
final foodLogControllerProvider = FoodLogControllerProvider._();

/// Controlador del registro diario de comidas del cliente.
final class FoodLogControllerProvider
    extends $NotifierProvider<FoodLogController, FoodLogState> {
  /// Controlador del registro diario de comidas del cliente.
  FoodLogControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'foodLogControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$foodLogControllerHash();

  @$internal
  @override
  FoodLogController create() => FoodLogController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FoodLogState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FoodLogState>(value),
    );
  }
}

String _$foodLogControllerHash() => r'7ca50958b284ab7b54c5f8cbc8111e3da527a473';

/// Controlador del registro diario de comidas del cliente.

abstract class _$FoodLogController extends $Notifier<FoodLogState> {
  FoodLogState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<FoodLogState, FoodLogState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FoodLogState, FoodLogState>,
              FoodLogState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
