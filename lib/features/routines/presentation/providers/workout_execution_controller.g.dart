// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_execution_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(workoutsRepository)
final workoutsRepositoryProvider = WorkoutsRepositoryProvider._();

final class WorkoutsRepositoryProvider
    extends
        $FunctionalProvider<
          WorkoutsRepository,
          WorkoutsRepository,
          WorkoutsRepository
        >
    with $Provider<WorkoutsRepository> {
  WorkoutsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workoutsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workoutsRepositoryHash();

  @$internal
  @override
  $ProviderElement<WorkoutsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WorkoutsRepository create(Ref ref) {
    return workoutsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkoutsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkoutsRepository>(value),
    );
  }
}

String _$workoutsRepositoryHash() =>
    r'b912406af274504805993e4a58fbda36c90e29ad';

/// Controlador de ejecución de workout (F2-D).

@ProviderFor(WorkoutExecutionController)
final workoutExecutionControllerProvider =
    WorkoutExecutionControllerProvider._();

/// Controlador de ejecución de workout (F2-D).
final class WorkoutExecutionControllerProvider
    extends
        $NotifierProvider<WorkoutExecutionController, WorkoutExecutionState> {
  /// Controlador de ejecución de workout (F2-D).
  WorkoutExecutionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workoutExecutionControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workoutExecutionControllerHash();

  @$internal
  @override
  WorkoutExecutionController create() => WorkoutExecutionController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkoutExecutionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkoutExecutionState>(value),
    );
  }
}

String _$workoutExecutionControllerHash() =>
    r'd96c2a820db6e05157fc27126ae9bcc44f0c76a4';

/// Controlador de ejecución de workout (F2-D).

abstract class _$WorkoutExecutionController
    extends $Notifier<WorkoutExecutionState> {
  WorkoutExecutionState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<WorkoutExecutionState, WorkoutExecutionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<WorkoutExecutionState, WorkoutExecutionState>,
              WorkoutExecutionState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
