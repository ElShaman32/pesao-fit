import 'package:flutter/material.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_icons.dart';
import '../../core/theme/app_typography.dart';

/// OfflineBanner oficial de PESAO FIT.
///
/// Reglas:
/// - Pill flotante superior.
/// - Visible con emoji en UI.
/// - Semantics SIEMPRE sin emoji.
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);

    return Semantics(
      label: strings.offlineBannerSemantics,
      liveRegion: true,
      child: ExcludeSemantics(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppDimens.l,
            vertical: AppDimens.s,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.m,
            vertical: AppDimens.s,
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceHigh,
            borderRadius: AppDimens.pillBorderRadius,
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.45),
              width: AppDimens.strokeWidth,
            ),
          ),
          child: Row(
            children: [
              const Icon(
                AppIcons.offline,
                size: 16,
                color: AppColors.primaryText,
              ),
              const SizedBox(width: AppDimens.s),
              Expanded(
                child: Text(
                  strings.offlineBanner,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
