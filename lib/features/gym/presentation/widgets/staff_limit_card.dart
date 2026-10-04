import 'package:flutter/material.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pesao_card.dart';
import '../../../../shared/widgets/pesao_progress.dart';

class StaffLimitCard extends StatelessWidget {
  final int staffCount;
  final int? staffLimit;

  const StaffLimitCard({
    super.key,
    required this.staffCount,
    required this.staffLimit,
  });

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final isUnlimited = staffLimit == null;
    final progress = isUnlimited ? 0.0 : staffCount / (staffLimit ?? 1);
    final isNearLimit = !isUnlimited && progress >= 0.8;

    return PesaoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            strings.staffLimitTitle,
            style: AppTypography.title.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppDimens.m),
          if (isUnlimited)
            Text(
              strings.staffLimitUnlimited,
              style: AppTypography.body.copyWith(
                color: AppColors.textSecondary,
              ),
            )
          else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$staffCount / $staffLimit',
                  style: AppTypography.numberM.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                if (isNearLimit)
                  Text(
                    strings.staffLimitNearLimit,
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
    );
  }
}
