// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_plans_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(trainingPlansRepository)
final trainingPlansRepositoryProvider = TrainingPlansRepositoryProvider._();

final class TrainingPlansRepositoryProvider
    extends
        $FunctionalProvider<
          TrainingPlansRepository,
          TrainingPlansRepository,
          TrainingPlansRepository
        >
    with $Provider<TrainingPlansRepository> {
  TrainingPlansRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trainingPlansRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trainingPlansRepositoryHash();

  @$internal
  @override
  $ProviderElement<TrainingPlansRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TrainingPlansRepository create(Ref ref) {
    return trainingPlansRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TrainingPlansRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TrainingPlansRepository>(value),
    );
  }
}

String _$trainingPlansRepositoryHash() =>
    r'fbeacebd6d49a5762d2a540058a08d32d4070e1a';

@ProviderFor(TrainingPlansController)
final trainingPlansControllerProvider = TrainingPlansControllerProvider._();

final class TrainingPlansControllerProvider
    extends
        $NotifierProvider<
          TrainingPlansController,
          AsyncValue<List<TrainingPlan>>
        > {
  TrainingPlansControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trainingPlansControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trainingPlansControllerHash();

  @$internal
  @override
  TrainingPlansController create() => TrainingPlansController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<TrainingPlan>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<TrainingPlan>>>(
        value,
      ),
    );
  }
}

String _$trainingPlansControllerHash() =>
    r'e0a05f9aee9cd203408f356fd463948e7bec1505';

abstract class _$TrainingPlansController
    extends $Notifier<AsyncValue<List<TrainingPlan>>> {
  AsyncValue<List<TrainingPlan>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<TrainingPlan>>,
              AsyncValue<List<TrainingPlan>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<TrainingPlan>>,
                AsyncValue<List<TrainingPlan>>
              >,
              AsyncValue<List<TrainingPlan>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
