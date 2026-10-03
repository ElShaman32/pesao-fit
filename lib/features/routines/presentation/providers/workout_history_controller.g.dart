// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_history_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WorkoutHistoryController)
final workoutHistoryControllerProvider = WorkoutHistoryControllerProvider._();

final class WorkoutHistoryControllerProvider
    extends
        $NotifierProvider<
          WorkoutHistoryController,
          AsyncValue<List<WorkoutHistoryEntry>>
        > {
  WorkoutHistoryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workoutHistoryControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workoutHistoryControllerHash();

  @$internal
  @override
  WorkoutHistoryController create() => WorkoutHistoryController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<WorkoutHistoryEntry>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<AsyncValue<List<WorkoutHistoryEntry>>>(value),
    );
  }
}

String _$workoutHistoryControllerHash() =>
    r'2dc37466b444379c586781a0442e684499a6ae14';

abstract class _$WorkoutHistoryController
    extends $Notifier<AsyncValue<List<WorkoutHistoryEntry>>> {
  AsyncValue<List<WorkoutHistoryEntry>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<WorkoutHistoryEntry>>,
              AsyncValue<List<WorkoutHistoryEntry>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<WorkoutHistoryEntry>>,
                AsyncValue<List<WorkoutHistoryEntry>>
              >,
              AsyncValue<List<WorkoutHistoryEntry>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
