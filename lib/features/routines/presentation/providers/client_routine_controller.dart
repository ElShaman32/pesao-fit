import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../domain/entities/routine.dart';
import '../../domain/repositories/routines_repository.dart';
import 'routines_controller.dart';

part 'client_routine_controller.g.dart';

@Riverpod(keepAlive: true)
class ClientRoutineController extends _$ClientRoutineController {
  late final RoutinesRepository _repository;

  @override
  AsyncValue<Routine?> build() {
    _repository = ref.watch(routinesRepositoryProvider);
    Future.microtask(load);
    return const AsyncValue.loading();
  }

  Future<void> load() async {
    final userId = authProvider.userId;
    if (userId == null) {
      state = const AsyncValue.data(null);
      return;
    }

    state = const AsyncValue.loading();
    final result = await _repository.getClientRoutine(userId: userId);

    result.when(
      idle: () {},
      loading: () {},
      success: (routine) => state = AsyncValue.data(routine),
      failure: (error) => state = AsyncValue.error(error, StackTrace.current),
    );
  }
}
