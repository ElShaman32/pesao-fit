import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/connectivity_provider.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/confirm_dialog.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/offline_banner.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_badge.dart';
import '../../../../shared/widgets/pesao_card.dart';
import '../../../../shared/widgets/pesao_shell.dart';
import '../../../../shared/widgets/pesao_toast.dart';
import '../../domain/entities/gym_membership_plan.dart';
import '../providers/membership_plans_controller.dart';

/// Lista de planes de membresía del gimnasio (owner).
class MembershipPlansScreen extends ConsumerWidget {
  const MembershipPlansScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppStrings.of(context);
    final plansAsync = ref.watch(membershipPlansControllerProvider);
    final connectivityAsync = ref.watch(connectivityProvider);
    final isOnline = connectivityAsync.value ?? true;

    return PesaoShell(
      appBar: PesaoAppBar(title: l10n.plansScreenTitle),
      body: Column(
        children: [
          if (!isOnline) const OfflineBanner(),
          Expanded(
            child: plansAsync.when(
              data: (plans) {
                if (plans.isEmpty) {
                  return EmptyState(
                    title: l10n.plansEmptyTitle,
                    body: l10n.plansEmptyBody,
                    icon: Icons.playlist_add_rounded,
                  );
                }
                return RefreshIndicator(
                  color: AppColors.primary,
                  backgroundColor: AppColors.surface,
                  onRefresh: () => ref
                      .read(membershipPlansControllerProvider.notifier)
                      .load(),
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
                          RouteNames.ownerPlanForm,
                          pathParameters: {'planId': plan.id},
                        ),
                        onDeactivate: () =>
                            _confirmDeactivate(context, ref, plan),
                      );
                    },
                  ),
                );
              },
              loading: () => const _PlansSkeleton(),
              error: (error, _) => ErrorState(
                title: l10n.plansErrorTitle,
                body: l10n.plansErrorBody,
                onRetry: () =>
                    ref.read(membershipPlansControllerProvider.notifier).load(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDeactivate(
    BuildContext context,
    WidgetRef ref,
    GymMembershipPlan plan,
  ) async {
    final l10n = AppStrings.of(context);

    final confirmed = await showConfirmDialog(
      context: context,
      title: l10n.planDeactivateConfirmTitle,
      message: l10n.planDeactivateConfirmBody,
      confirmLabel: l10n.planDeactivateConfirmTitle,
      cancelLabel: l10n.commonCancel,
      isDestructive: true,
    );

    if (!confirmed || !context.mounted) return;

    final result = await ref
        .read(membershipPlansControllerProvider.notifier)
        .deactivatePlan(plan.id);

    if (!context.mounted) return;

    result.when(
      idle: () {},
      loading: () {},
      success: (_) {
        showPesaoToast(
          context,
          message: l10n.planDeactivatedSuccess,
          semanticLabel: l10n.planDeactivatedSemantics,
          variant: PesaoToastVariant.success,
        );
      },
      failure: (_) {
        showPesaoToast(
          context,
          message: l10n.paymentActionError,
          semanticLabel: l10n.paymentActionError,
          variant: PesaoToastVariant.error,
        );
      },
    );
  }
}

class _PlanCard extends StatelessWidget {
  final GymMembershipPlan plan;
  final VoidCallback onTap;
  final VoidCallback onDeactivate;

  const _PlanCard({
    required this.plan,
    required this.onTap,
    required this.onDeactivate,
  });

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
                        ? l10n.planActiveBadge
                        : l10n.planInactiveBadge,
                    variant: plan.isActive
                        ? PesaoBadgeVariant.success
                        : PesaoBadgeVariant.warning,
                  ),
                ],
              ),
              if (plan.description != null && plan.description!.isNotEmpty) ...[
                const SizedBox(height: AppDimens.xs),
                Text(
                  plan.description!,
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
                  Text(
                    '\$${plan.priceUsd.toStringAsFixed(2)}',
                    style: AppTypography.numberM.copyWith(
                      color: AppColors.primaryText,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                  Text(
                    l10n.planPerMonth,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Spacer(),
                  if (plan.includesTrainer)
                    const Icon(
                      Icons.fitness_center_rounded,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                  if (plan.includesNutritionist) ...[
                    const SizedBox(width: AppDimens.xs),
                    const Icon(
                      Icons.restaurant_rounded,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                  ],
                  if (plan.isActive) ...[
                    const SizedBox(width: AppDimens.m),
                    IconButton(
                      icon: const Icon(
                        Icons.visibility_off_rounded,
                        size: 20,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: onDeactivate,
                      tooltip: l10n.planDeactivateConfirmTitle,
                    ),
                  ],
                ],
              ),
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
