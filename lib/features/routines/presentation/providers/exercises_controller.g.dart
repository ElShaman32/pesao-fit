// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercises_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(exercisesRepository)
final exercisesRepositoryProvider = ExercisesRepositoryProvider._();

final class ExercisesRepositoryProvider
    extends
        $FunctionalProvider<
          ExercisesRepository,
          ExercisesRepository,
          ExercisesRepository
        >
    with $Provider<ExercisesRepository> {
  ExercisesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exercisesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exercisesRepositoryHash();

  @$internal
  @override
  $ProviderElement<ExercisesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ExercisesRepository create(Ref ref) {
    return exercisesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExercisesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExercisesRepository>(value),
    );
  }
}

String _$exercisesRepositoryHash() =>
    r'd69c167648bb0e23c0d3768eafec8dae9a61560a';

@ProviderFor(ExercisesController)
final exercisesControllerProvider = ExercisesControllerProvider._();

final class ExercisesControllerProvider
    extends $NotifierProvider<ExercisesController, AsyncValue<List<Exercise>>> {
  ExercisesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exercisesControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exercisesControllerHash();

  @$internal
  @override
  ExercisesController create() => ExercisesController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<Exercise>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<Exercise>>>(value),
    );
  }
}

String _$exercisesControllerHash() =>
    r'2cd976024e5a3db4c325c7415f4724177e795c20';

abstract class _$ExercisesController
    extends $Notifier<AsyncValue<List<Exercise>>> {
  AsyncValue<List<Exercise>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<Exercise>>, AsyncValue<List<Exercise>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<Exercise>>,
                AsyncValue<List<Exercise>>
              >,
              AsyncValue<List<Exercise>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
