// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_training_plan_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ClientTrainingPlanController)
final clientTrainingPlanControllerProvider =
    ClientTrainingPlanControllerProvider._();

final class ClientTrainingPlanControllerProvider
    extends
        $NotifierProvider<
          ClientTrainingPlanController,
          AsyncValue<TrainingPlan?>
        > {
  ClientTrainingPlanControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clientTrainingPlanControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clientTrainingPlanControllerHash();

  @$internal
  @override
  ClientTrainingPlanController create() => ClientTrainingPlanController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<TrainingPlan?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<TrainingPlan?>>(value),
    );
  }
}

String _$clientTrainingPlanControllerHash() =>
    r'58a9e21dcdd219cf97d946af10d6653b0d5fff0a';

abstract class _$ClientTrainingPlanController
    extends $Notifier<AsyncValue<TrainingPlan?>> {
  AsyncValue<TrainingPlan?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<TrainingPlan?>, AsyncValue<TrainingPlan?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TrainingPlan?>, AsyncValue<TrainingPlan?>>,
              AsyncValue<TrainingPlan?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
