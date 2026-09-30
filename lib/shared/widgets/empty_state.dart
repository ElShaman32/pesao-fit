import 'package:flutter/material.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_icons.dart';
import '../../core/theme/app_typography.dart';
import 'pesao_button.dart';

/// EmptyState oficial de PESAO FIT.
///
/// Reglas:
/// - Ícono + microcopy suave + CTA opcional.
/// - Textos desde AppStrings.
/// - Nunca debe sonar agresivo.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    this.icon,
    this.title,
    this.body,
    this.actionLabel,
    this.onAction,
  });

  final IconData? icon;
  final String? title;
  final String? body;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);

    final effectiveTitle = title ?? strings.emptyGenericTitle;
    final effectiveBody = body ?? strings.emptyGenericBody;
    final hasAction = actionLabel != null && onAction != null;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.surfaceHigh,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.outline,
                  width: AppDimens.strokeWidth,
                ),
              ),
              child: Icon(
                icon ?? AppIcons.info,
                size: 32,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: AppDimens.xl),
            Text(
              effectiveTitle,
              textAlign: TextAlign.center,
              style: AppTypography.headline,
            ),
            const SizedBox(height: AppDimens.s),
            Text(
              effectiveBody,
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            if (hasAction) ...[
              const SizedBox(height: AppDimens.xl),
              PesaoButton(
                label: actionLabel!,
                onPressed: onAction,
                isExpanded: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
