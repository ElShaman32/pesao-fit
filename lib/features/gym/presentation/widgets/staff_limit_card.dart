import 'package:flutter/material.dart';
import 'package:pesao_fit/core/l10n/app_strings.dart';
import 'package:pesao_fit/core/theme/app_colors.dart';
import 'package:pesao_fit/shared/widgets/pesao_card.dart';
import 'package:pesao_fit/shared/widgets/pesao_progress.dart';

/// Card que muestra el límite de staff del gimnasio.
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
    final isUnlimited = staffLimit == null;
    final progress = isUnlimited ? 0.0 : staffCount / (staffLimit ?? 1);
    final isNearLimit = !isUnlimited && progress >= 0.8;

    return PesaoCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.staffLimitTitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          if (isUnlimited)
            Text(
              AppStrings.staffLimitUnlimited,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            )
          else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$staffCount / $staffLimit',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (isNearLimit)
                  Text(
                    AppStrings.staffLimitNearLimit,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.warning,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            PesaoProgress(
              value: progress,
              color: isNearLimit ? AppColors.warning : AppColors.primary,
            ),
          ],
        ],
      ),
    );
  }
}
