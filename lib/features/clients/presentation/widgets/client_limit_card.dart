import 'package:flutter/material.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pesao_card.dart';
import '../../../../shared/widgets/pesao_progress.dart';

/// Card que muestra el límite de clientes del plan.
class ClientLimitCard extends StatelessWidget {
  final int clientCount;
  final int? clientLimit;

  const ClientLimitCard({
    super.key,
    required this.clientCount,
    required this.clientLimit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final isUnlimited = clientLimit == null;
    final progress = isUnlimited ? 0.0 : clientCount / (clientLimit ?? 1);
    final isNearLimit = !isUnlimited && progress >= 0.8;

    return PesaoCard(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.clientsLimitTitle,
              style: AppTypography.title.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimens.m),
            if (isUnlimited)
              Text(
                l10n.clientsLimitUnlimited,
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              )
            else ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$clientCount / $clientLimit',
                    style: AppTypography.numberM.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (isNearLimit)
                    Text(
                      l10n.clientsLimitNearLimit,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.warning,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppDimens.s),
              PesaoProgress(value: progress),
            ],
          ],
        ),
      ),
    );
  }
}