import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/connectivity_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/components/rest_timer_sheet.dart';
import '../../../../shared/components/set_tracker.dart';
import '../../../../shared/widgets/confirm_dialog.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/offline_banner.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_shell.dart';
import '../../../../shared/widgets/pesao_toast.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/entities/workout_set.dart';
import '../providers/workout_execution_controller.dart';
import '../widgets/muscle_group_chip.dart';

/// Pantalla de ejecución de workout (F2-D).
class WorkoutExecutionScreen extends ConsumerStatefulWidget {
  const WorkoutExecutionScreen({super.key, required this.workoutId});

  final String workoutId;

  @override
  ConsumerState<WorkoutExecutionScreen> createState() =>
      _WorkoutExecutionScreenState();
}

class _WorkoutExecutionScreenState
    extends ConsumerState<WorkoutExecutionScreen> {
  Timer? _durationTimer;

  @override
  void initState() {
    super.initState();
    _loadIfNecessary();
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  void _loadIfNecessary() {
    final state = ref.read(workoutExecutionControllerProvider);
    if (state.workoutId != widget.workoutId || !state.hasData) {
      ref
          .read(workoutExecutionControllerProvider.notifier)
          .load(widget.workoutId);
    }
  }

  @override
  void dispose() {
    _durationTimer?.cancel();
    super.dispose();
  }

  void _onToggleSet(WorkoutSet set) {
    final state = ref.read(workoutExecutionControllerProvider);
    final wasCompleted = set.completed;

    ref.read(workoutExecutionControllerProvider.notifier).toggleSet(set.id);

    // Si se acaba de completar y tiene descanso, mostrar rest timer.
    if (!wasCompleted && set.restSeconds > 0) {
      final remaining = state.sets
          .where((s) => !s.completed && s.id != set.id)
          .length;
      if (remaining > 0) {
        RestTimerSheet.show(context, seconds: set.restSeconds);
      }
    }
  }

  Future<void> _onFinish() async {
    final l10n = AppStrings.of(context);
    final confirmed = await showConfirmDialog(
      context: context,
      title: l10n.workoutFinishConfirmTitle,
      message: l10n.workoutFinishConfirmBody,
      confirmLabel: l10n.workoutFinishCta,
      cancelLabel: l10n.commonCancel,
      isDestructive: false,
    );

    if (!confirmed || !mounted) return;

    final result = await ref
        .read(workoutExecutionControllerProvider.notifier)
        .finish();

    if (!mounted) return;

    result.when(
      idle: () {},
      loading: () {},
      success: (_) {
        showPesaoToast(
          context,
          message: l10n.workoutFinishedSuccess,
          semanticLabel: l10n.workoutFinishedSemantics,
          variant: PesaoToastVariant.success,
        );
        context.pop();
      },
      failure: (error) {
        showPesaoToast(
          context,
          message: l10n.workoutErrorTitle,
          semanticLabel: l10n.workoutErrorTitle,
          variant: PesaoToastVariant.error,
        );
      },
    );
  }

  List<_ExerciseGroup> _groupSets(List<WorkoutSet> sets) {
    final grouped = <String, List<WorkoutSet>>{};
    for (final set in sets) {
      grouped.putIfAbsent(set.exerciseId, () => []).add(set);
    }
    final entries = grouped.entries.toList()
      ..sort(
        (a, b) => a.value.first.orderIndex.compareTo(b.value.first.orderIndex),
      );
    return entries
        .map(
          (e) => _ExerciseGroup(
            exerciseId: e.key,
            exerciseName: e.value.first.exerciseName,
            muscleGroup: e.value.first.muscleGroup,
            sets: e.value,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final state = ref.watch(workoutExecutionControllerProvider);
    final connectivityAsync = ref.watch(connectivityProvider);
    final isOnline = connectivityAsync.value ?? true;

    return PesaoShell(
      appBar: PesaoAppBar(
        title: state.workout?.routineName ?? l10n.workoutScreenTitle,
      ),
      body: Column(
        children: [
          if (!isOnline) const OfflineBanner(),
          Expanded(child: _buildContent(state, isOnline, l10n)),
        ],
      ),
    );
  }

  Widget _buildContent(
    WorkoutExecutionState state,
    bool isOnline,
    AppStrings l10n,
  ) {
    if (state.isLoading && !state.hasData) {
      return const _WorkoutSkeleton();
    }
    if (state.error != null && !state.hasData) {
      return ErrorState(
        title: l10n.workoutErrorTitle,
        body: l10n.workoutErrorBody,
        onRetry: () => ref
            .read(workoutExecutionControllerProvider.notifier)
            .load(widget.workoutId),
      );
    }
    if (!state.hasData) {
      return const SizedBox.shrink();
    }
    if (state.sets.isEmpty) {
      return EmptyState(
        title: l10n.workoutEmptyTitle,
        body: l10n.workoutEmptyBody,
        icon: Icons.fitness_center_rounded,
      );
    }
    return _buildSuccess(state, isOnline, l10n);
  }

  Widget _buildSuccess(
    WorkoutExecutionState state,
    bool isOnline,
    AppStrings l10n,
  ) {
    final workout = state.workout!;
    final elapsed = DateTime.now().difference(workout.startedAt);
    final groups = _groupSets(state.sets);

    return ListView(
      padding: const EdgeInsets.all(AppDimens.l),
      children: [
        // Header: duración + progreso de series.
        Row(
          children: [
            const Icon(
              Icons.timer_outlined,
              size: 20,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: AppDimens.xs),
            Text(
              l10n.workoutDurationMinutes(elapsed.inMinutes),
              style: AppTypography.body.copyWith(
                color: AppColors.textSecondary,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
            const Spacer(),
            Text(
              l10n.workoutSetsProgress(state.completedSets, state.totalSets),
              style: AppTypography.label.copyWith(
                color: state.isComplete
                    ? AppColors.successText
                    : AppColors.textPrimary,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimens.m),
        _WorkoutProgressBar(progress: state.progress),
        const SizedBox(height: AppDimens.xl),
        // Grupos de ejercicios.
        ...groups.map(
          (group) => Padding(
            padding: const EdgeInsets.only(bottom: AppDimens.l),
            child: _ExerciseGroupBlock(
              group: group,
              enabled: isOnline,
              onToggle: _onToggleSet,
            ),
          ),
        ),
        const SizedBox(height: AppDimens.m),
        // Terminar entreno.
        PesaoButton(
          label: l10n.workoutFinishCta,
          variant: PesaoButtonVariant.primary,
          onPressed: (!isOnline || state.isFinishing) ? null : _onFinish,
        ),
        const SizedBox(height: AppDimens.xxl),
      ],
    );
  }
}

/// Agrupación de sets por ejercicio.
class _ExerciseGroup {
  final String exerciseId;
  final String? exerciseName;
  final String? muscleGroup;
  final List<WorkoutSet> sets;

  const _ExerciseGroup({
    required this.exerciseId,
    this.exerciseName,
    this.muscleGroup,
    required this.sets,
  });
}

/// Bloque de un ejercicio con todos sus sets.
class _ExerciseGroupBlock extends StatelessWidget {
  const _ExerciseGroupBlock({
    required this.group,
    required this.enabled,
    required this.onToggle,
  });

  final _ExerciseGroup group;
  final bool enabled;
  final ValueChanged<WorkoutSet> onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.l),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppDimens.cardBorderRadius,
        border: Border.all(color: AppColors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  group.exerciseName ?? 'Ejercicio',
                  style: AppTypography.title.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              if (group.muscleGroup != null)
                MuscleGroupChip(
                  group: MuscleGroup.fromDb(group.muscleGroup),
                  compact: true,
                ),
            ],
          ),
          const SizedBox(height: AppDimens.m),
          ...group.sets.map(
            (set) => SetTracker(
              setNumber: set.setNumber,
              weightKg: set.weightKg,
              reps: set.reps,
              completed: set.completed,
              enabled: enabled,
              onToggle: () => onToggle(set),
            ),
          ),
        ],
      ),
    );
  }
}

/// Barra de progreso construida con tokens (sin Material crudo).
class _WorkoutProgressBar extends StatelessWidget {
  const _WorkoutProgressBar({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final clamped = progress.clamp(0.0, 1.0);
    return ClipRRect(
      borderRadius: AppDimens.pillBorderRadius,
      child: SizedBox(
        height: 8,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Container(color: AppColors.surfaceHigh),
                Container(
                  width: constraints.maxWidth * clamped,
                  decoration: BoxDecoration(
                    color: clamped >= 1.0
                        ? AppColors.success
                        : AppColors.primary,
                    borderRadius: AppDimens.pillBorderRadius,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Skeleton que replica el layout de ejecución.
class _WorkoutSkeleton extends StatelessWidget {
  const _WorkoutSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppDimens.l),
      child: Column(
        children: [
          _SkeletonBox(height: 24),
          SizedBox(height: AppDimens.m),
          _SkeletonBox(height: 8),
          SizedBox(height: AppDimens.xl),
          _SkeletonBox(height: 160),
          SizedBox(height: AppDimens.l),
          _SkeletonBox(height: 160),
        ],
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppDimens.cardBorderRadius,
        border: Border.all(color: AppColors.outline),
      ),
    );
  }
}
