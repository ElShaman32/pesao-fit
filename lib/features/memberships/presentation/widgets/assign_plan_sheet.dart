import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pesao_toast.dart';
import '../../domain/entities/gym_membership_plan.dart';
import '../providers/membership_plans_controller.dart';
import '../providers/client_subscription_provider.dart';

/// Muestra el sheet para asignar un plan a un cliente.
Future<bool> showAssignPlanSheet(
  BuildContext context, {
  required String userId,
  required String gymId,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => _AssignPlanSheet(userId: userId, gymId: gymId),
  ).then((v) => v ?? false);
}

class _AssignPlanSheet extends ConsumerWidget {
  final String userId;
  final String gymId;

  const _AssignPlanSheet({required this.userId, required this.gymId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppStrings.of(context);
    final plansAsync = ref.watch(membershipPlansControllerProvider);

    return Padding(
      padding: const EdgeInsets.all(AppDimens.l),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle.
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: const BoxDecoration(
                color: AppColors.outline,
                borderRadius: AppDimens.pillBorderRadius,
              ),
            ),
          ),
          const SizedBox(height: AppDimens.l),
          Text(
            l10n.assignPlanTitle,
            style: AppTypography.headline.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimens.xs),
          Text(
            l10n.assignPlanSubtitle,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimens.l),

          plansAsync.when(
            data: (plans) {
              final activePlans = plans.where((p) => p.isActive).toList();

              if (activePlans.isEmpty) {
                return Column(
                  children: [
                    const Icon(
                      Icons.playlist_add_rounded,
                      size: 48,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(height: AppDimens.s),
                    Text(
                      l10n.assignPlanNoPlansTitle,
                      style: AppTypography.title.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppDimens.xs),
                    Text(
                      l10n.assignPlanNoPlansBody,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDimens.l),
                  ],
                );
              }

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: activePlans.length,
                separatorBuilder: (_, _) => const SizedBox(height: AppDimens.s),
                itemBuilder: (context, index) {
                  final plan = activePlans[index];
                  return _PlanOption(
                    plan: plan,
                    onTap: () => _assignPlan(context, ref, plan),
                  );
                },
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: AppDimens.xl),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, _) => const SizedBox.shrink(),
          ),
          const SizedBox(height: AppDimens.l),
        ],
      ),
    );
  }

  Future<void> _assignPlan(
    BuildContext context,
    WidgetRef ref,
    GymMembershipPlan plan,
  ) async {
    final l10n = AppStrings.of(context);
    final repository = ref.read(clientSubscriptionRepositoryProvider);

    final result = await repository.assignPlan(
      userId: userId,
      gymId: gymId,
      planId: plan.id,
    );

    if (!context.mounted) return;

    result.when(
      idle: () {},
      loading: () {},
      success: (_) {
        showPesaoToast(
          context,
          message: l10n.assignPlanSuccess,
          semanticLabel: l10n.assignPlanSemantics,
          variant: PesaoToastVariant.success,
        );
        Navigator.of(context).pop(true);
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

class _PlanOption extends StatelessWidget {
  final GymMembershipPlan plan;
  final VoidCallback onTap;

  const _PlanOption({required this.plan, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppDimens.l),
        decoration: BoxDecoration(
          color: AppColors.surfaceHigh,
          borderRadius: AppDimens.cardBorderRadius,
          border: Border.all(color: AppColors.outline),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plan.name,
                    style: AppTypography.title.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppDimens.xs),
                  Text(
                    '\$${plan.priceUsd.toStringAsFixed(2)} / ${plan.durationDays}d',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
