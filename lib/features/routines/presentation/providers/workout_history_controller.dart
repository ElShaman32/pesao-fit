import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../domain/entities/workout_history_entry.dart';
import '../../domain/repositories/workouts_repository.dart';
import 'workout_execution_controller.dart';

part 'workout_history_controller.g.dart';

@Riverpod(keepAlive: true)
class WorkoutHistoryController extends _$WorkoutHistoryController {
  late final WorkoutsRepository _repository;

  @override
  AsyncValue<List<WorkoutHistoryEntry>> build() {
    _repository = ref.watch(workoutsRepositoryProvider);
    Future.microtask(load);
    return const AsyncValue.loading();
  }

  Future<void> load() async {
    final userId = authProvider.userId;
    if (userId == null) {
      state = const AsyncValue.data([]);
      return;
    }

    state = const AsyncValue.loading();
    final result = await _repository.getHistory(userId: userId);

    result.when(
      idle: () {},
      loading: () {},
      success: (entries) => state = AsyncValue.data(entries),
      failure: (error) => state = AsyncValue.error(error, StackTrace.current),
    );
  }
}
