import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/connectivity_provider.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/offline_banner.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_card.dart';
import '../../../../shared/widgets/pesao_shell.dart';
import '../../domain/entities/routine.dart';
import '../providers/routines_controller.dart';

/// Lista de rutinas del entrenador (tab Rutinas).
class RoutinesListScreen extends ConsumerWidget {
  const RoutinesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppStrings.of(context);
    final routinesAsync = ref.watch(routinesControllerProvider);
    final connectivityAsync = ref.watch(connectivityProvider);
    final isOnline = connectivityAsync.value ?? true;

    return PesaoShell(
      appBar: PesaoAppBar(
        title: l10n.routinesScreenTitle,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.fitness_center_rounded,
              color: AppColors.textSecondary,
            ),
            tooltip: l10n.exercisesScreenTitle,
            onPressed: () => context.push(RouteNames.trainerExercises),
          ),
        ],
      ),
      body: Column(
        children: [
          if (!isOnline) const OfflineBanner(),
          Expanded(
            child: routinesAsync.when(
              data: (routines) {
                if (routines.isEmpty) {
                  return EmptyState(
                    title: l10n.routinesEmptyTitle,
                    body: l10n.routinesEmptyBody,
                    icon: Icons.fitness_center_rounded,
                  );
                }
                return RefreshIndicator(
                  color: AppColors.primary,
                  backgroundColor: AppColors.surface,
                  onRefresh: () =>
                      ref.read(routinesControllerProvider.notifier).load(),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(AppDimens.l),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: routines.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppDimens.s),
                    itemBuilder: (context, index) {
                      final routine = routines[index];
                      return _RoutineCard(
                        routine: routine,
                        onTap: () => context.pushNamed(
                          RouteNames.trainerRoutineEdit,
                          pathParameters: {'routineId': routine.id},
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () => const _RoutinesSkeleton(),
              error: (_, _) => ErrorState(
                title: l10n.routinesErrorTitle,
                body: l10n.routinesErrorBody,
                onRetry: () =>
                    ref.read(routinesControllerProvider.notifier).load(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoutineCard extends StatelessWidget {
  final Routine routine;
  final VoidCallback onTap;

  const _RoutineCard({required this.routine, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: PesaoCard(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                routine.name,
                style: AppTypography.title.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimens.xs),
              Text(
                routine.clientName ?? 'Cliente',
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              if (routine.description != null &&
                  routine.description!.isNotEmpty) ...[
                const SizedBox(height: AppDimens.xs),
                Text(
                  routine.description!,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
                    '${routine.exercises.length} ejercicios',
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
    );
  }
}

class _RoutinesSkeleton extends StatelessWidget {
  const _RoutinesSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppDimens.l),
      child: Column(
        children: [
          _SkeletonBox(height: 120),
          SizedBox(height: AppDimens.s),
          _SkeletonBox(height: 120),
          SizedBox(height: AppDimens.s),
          _SkeletonBox(height: 120),
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
