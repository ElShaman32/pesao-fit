import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/connectivity_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/offline_banner.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_card.dart';
import '../../../../shared/widgets/pesao_shell.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/entities/routine.dart';
import '../../domain/entities/routine_exercise.dart';
import '../providers/client_routine_controller.dart';
import '../widgets/muscle_group_chip.dart';

/// Pantalla de la rutina asignada al cliente (tab Rutina).
class ClientRoutineScreen extends ConsumerWidget {
  const ClientRoutineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppStrings.of(context);
    final routineAsync = ref.watch(clientRoutineControllerProvider);
    final connectivityAsync = ref.watch(connectivityProvider);
    final isOnline = connectivityAsync.value ?? true;

    return PesaoShell(
      appBar: PesaoAppBar(title: l10n.clientRoutineScreenTitle),
      body: Column(
        children: [
          if (!isOnline) const OfflineBanner(),
          Expanded(
            child: routineAsync.when(
              data: (routine) {
                if (routine == null) {
                  return EmptyState(
                    title: l10n.clientRoutineEmptyTitle,
                    body: l10n.clientRoutineEmptyBody,
                    icon: Icons.fitness_center_rounded,
                  );
                }
                return _RoutineView(routine: routine);
              },
              loading: () => const _RoutineSkeleton(),
              error: (_, _) => ErrorState(
                title: l10n.clientRoutineErrorTitle,
                body: l10n.clientRoutineErrorBody,
                onRetry: () =>
                    ref.read(clientRoutineControllerProvider.notifier).load(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoutineView extends ConsumerWidget {
  final Routine routine;

  const _RoutineView({required this.routine});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppStrings.of(context);

    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: AppColors.surface,
      onRefresh: () =>
          ref.read(clientRoutineControllerProvider.notifier).load(),
      child: ListView(
        padding: const EdgeInsets.all(AppDimens.l),
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          // Header de la rutina.
          PesaoCard(
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.l),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    routine.name,
                    style: AppTypography.headline.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (routine.description != null &&
                      routine.description!.isNotEmpty) ...[
                    const SizedBox(height: AppDimens.s),
                    Text(
                      routine.description!,
                      style: AppTypography.body.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                  const SizedBox(height: AppDimens.m),
                  Row(
                    children: [
                      const Icon(
                        Icons.fitness_center_rounded,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: AppDimens.xs),
                      Text(
                        l10n.clientRoutineExerciseCount(
                          routine.exercises.length,
                        ),
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppDimens.l),

          // Lista de ejercicios.
          ...routine.exercises.map(
            (exercise) => Padding(
              padding: const EdgeInsets.only(bottom: AppDimens.s),
              child: _ExerciseCard(exercise: exercise),
            ),
          ),
          const SizedBox(height: AppDimens.xxl),
        ],
      ),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  final RoutineExercise exercise;

  const _ExerciseCard({required this.exercise});

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return PesaoCard(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: nombre + chip de grupo muscular.
            Row(
              children: [
                Expanded(
                  child: Text(
                    exercise.exerciseName ?? 'Ejercicio',
                    style: AppTypography.title.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                if (exercise.exerciseMuscleGroup != null)
                  MuscleGroupChip(
                    group: MuscleGroup.fromDb(exercise.exerciseMuscleGroup),
                    compact: true,
                  ),
              ],
            ),
            const SizedBox(height: AppDimens.m),

            // Parámetros del ejercicio.
            Wrap(
              spacing: AppDimens.m,
              runSpacing: AppDimens.s,
              children: [
                _ParameterBadge(
                  label: l10n.clientRoutineExerciseSets(exercise.sets),
                ),
                if (exercise.reps != null)
                  _ParameterBadge(
                    label: l10n.clientRoutineExerciseReps(exercise.reps!),
                  ),
                if (exercise.weightKg != null)
                  _ParameterBadge(
                    label: l10n.clientRoutineExerciseWeight(
                      exercise.weightKg!.toStringAsFixed(1),
                    ),
                  ),
                _ParameterBadge(
                  label: l10n.clientRoutineExerciseRest(exercise.restSeconds),
                ),
              ],
            ),

            // Notas.
            if (exercise.notes != null && exercise.notes!.isNotEmpty) ...[
              const SizedBox(height: AppDimens.m),
              Text(
                l10n.clientRoutineExerciseNotes,
                style: AppTypography.label.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppDimens.xs),
              Text(
                exercise.notes!,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ParameterBadge extends StatelessWidget {
  final String label;

  const _ParameterBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.m,
        vertical: AppDimens.xs,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surfaceHigh,
        borderRadius: AppDimens.pillBorderRadius,
      ),
      child: Text(
        label,
        style: AppTypography.label.copyWith(color: AppColors.textPrimary),
      ),
    );
  }
}

class _RoutineSkeleton extends StatelessWidget {
  const _RoutineSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppDimens.l),
      child: Column(
        children: [
          _SkeletonBox(height: 120),
          SizedBox(height: AppDimens.l),
          _SkeletonBox(height: 100),
          SizedBox(height: AppDimens.s),
          _SkeletonBox(height: 100),
          SizedBox(height: AppDimens.s),
          _SkeletonBox(height: 100),
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
