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
import '../../../../shared/widgets/pesao_badge.dart';
import '../../../../shared/widgets/pesao_card.dart';
import '../../../../shared/widgets/pesao_shell.dart';
import '../../domain/entities/training_plan.dart';
import '../providers/training_plans_controller.dart';

/// Lista de planes de entrenamiento del entrenador.
class TrainingPlansListScreen extends ConsumerWidget {
  const TrainingPlansListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppStrings.of(context);
    final plansAsync = ref.watch(trainingPlansControllerProvider);
    final connectivityAsync = ref.watch(connectivityProvider);
    final isOnline = connectivityAsync.value ?? true;

    return PesaoShell(
      appBar: PesaoAppBar(
        title: l10n.trainingPlansScreenTitle,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.fitness_center_rounded,
              color: AppColors.textSecondary,
            ),
            tooltip: l10n.routinesTabTitle,
            onPressed: () => context.push(RouteNames.trainerRoutineTemplates),
          ),
        ],
      ),
      body: Column(
        children: [
          if (!isOnline) const OfflineBanner(),
          Expanded(
            child: plansAsync.when(
              data: (plans) {
                if (plans.isEmpty) {
                  return EmptyState(
                    title: l10n.trainingPlansEmptyTitle,
                    body: l10n.trainingPlansEmptyBody,
                    icon: Icons.calendar_month_rounded,
                  );
                }
                return RefreshIndicator(
                  color: AppColors.primary,
                  backgroundColor: AppColors.surface,
                  onRefresh: () =>
                      ref.read(trainingPlansControllerProvider.notifier).load(),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(AppDimens.l),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: plans.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppDimens.s),
                    itemBuilder: (context, index) {
                      final plan = plans[index];
                      return _PlanCard(
                        plan: plan,
                        onTap: () => context.pushNamed(
                          RouteNames.trainerPlanEdit,
                          pathParameters: {'planId': plan.id},
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () => const _PlansSkeleton(),
              error: (_, _) => ErrorState(
                title: l10n.trainingPlansErrorTitle,
                body: l10n.trainingPlansErrorBody,
                onRetry: () =>
                    ref.read(trainingPlansControllerProvider.notifier).load(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final TrainingPlan plan;
  final VoidCallback onTap;

  const _PlanCard({required this.plan, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return GestureDetector(
      onTap: onTap,
      child: PesaoCard(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      plan.name,
                      style: AppTypography.title.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  PesaoBadge(
                    label: plan.isActive
                        ? l10n.trainingPlanActiveBadge
                        : l10n.trainingPlanInactiveBadge,
                    variant: plan.isActive
                        ? PesaoBadgeVariant.success
                        : PesaoBadgeVariant.warning,
                  ),
                ],
              ),
              const SizedBox(height: AppDimens.xs),
              Text(
                plan.clientName ?? 'Cliente',
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              if (plan.weeks.isNotEmpty) ...[
                const SizedBox(height: AppDimens.m),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_rounded,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: AppDimens.xs),
                    Text(
                      l10n.trainingPlanCurrentWeek(
                        plan.currentWeek,
                        plan.weeks.length,
                      ),
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PlansSkeleton extends StatelessWidget {
  const _PlansSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppDimens.l),
      child: Column(
        children: [
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
