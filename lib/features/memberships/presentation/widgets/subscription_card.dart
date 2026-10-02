import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pesao_badge.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_card.dart';
import '../../domain/entities/client_subscription.dart';
import '../providers/client_subscription_provider.dart';

/// Card que muestra la suscripción activa del cliente en su dashboard.
class SubscriptionCard extends ConsumerWidget {
  final VoidCallback onPay;

  const SubscriptionCard({super.key, required this.onPay});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subAsync = ref.watch(clientSubscriptionControllerProvider);

    return subAsync.when(
      data: (subscription) {
        if (subscription == null) {
          return _NoPlanCard();
        }
        return _ActivePlanCard(subscription: subscription, onPay: onPay);
      },
      loading: () => Container(
        height: 140,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppDimens.cardBorderRadius,
          border: Border.all(color: AppColors.outline),
        ),
      ),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}

class _NoPlanCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return PesaoCard(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.subscriptionCardNoPlanTitle,
              style: AppTypography.title.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(height: AppDimens.xs),
            Text(
              l10n.subscriptionCardNoPlanBody,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivePlanCard extends StatelessWidget {
  final ClientSubscription subscription;
  final VoidCallback onPay;

  const _ActivePlanCard({required this.subscription, required this.onPay});

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final expiresLabel = DateFormat.yMMMd(
      'es_VE',
    ).format(subscription.expiresAt);

    // Determinar el estado del saldo.
    final String balanceLabel;
    final Color balanceColor;

    if (subscription.owesMoney) {
      balanceLabel =
          '${l10n.subscriptionBalanceOwed}: \$${subscription.balanceUsd.toStringAsFixed(2)}';
      balanceColor = AppColors.warningText;
    } else if (subscription.hasCredit) {
      balanceLabel =
          '${l10n.subscriptionBalanceCredit}: \$${subscription.balanceUsd.abs().toStringAsFixed(2)}';
      balanceColor = AppColors.successText;
    } else {
      balanceLabel = l10n.subscriptionBalancePaid;
      balanceColor = AppColors.successText;
    }

    return PesaoCard(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: plan + badge de estado.
            Row(
              children: [
                Expanded(
                  child: Text(
                    subscription.planName,
                    style: AppTypography.title.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                PesaoBadge(
                  label: subscription.isExpired
                      ? l10n.subscriptionStatusExpired
                      : l10n.subscriptionStatusActive,
                  variant: subscription.isExpired
                      ? PesaoBadgeVariant.warning
                      : PesaoBadgeVariant.success,
                ),
              ],
            ),
            const SizedBox(height: AppDimens.m),

            // Precio del plan.
            Row(
              children: [
                Text(
                  '\$${subscription.planPriceUsd.toStringAsFixed(2)}',
                  style: AppTypography.numberL.copyWith(
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
              ],
            ),
            const SizedBox(height: AppDimens.s),

            // Saldo.
            Text(
              balanceLabel,
              style: AppTypography.body.copyWith(
                color: balanceColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppDimens.xs),

            // Vencimiento.
            Text(
              '${l10n.subscriptionExpiresLabel}: $expiresLabel',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimens.m),

            // Botón pagar.
            Align(
              alignment: Alignment.centerRight,
              child: PesaoButton(
                label: l10n.subscriptionPayCta,
                variant: subscription.owesMoney
                    ? PesaoButtonVariant.primary
                    : PesaoButtonVariant.secondary,
                isExpanded: false,
                onPressed: onPay,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
