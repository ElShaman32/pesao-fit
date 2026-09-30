import 'package:flutter/material.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_icons.dart';
import '../../core/theme/app_typography.dart';
import 'pesao_button.dart';

/// ErrorState oficial de PESAO FIT.
///
/// Reglas:
/// - Microcopy suave.
/// - Nunca culpar al usuario.
/// - Siempre ofrecer siguiente paso, normalmente "Reintentar".
class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    this.icon,
    this.title,
    this.body,
    this.actionLabel,
    this.onRetry,
  });

  final IconData? icon;
  final String? title;
  final String? body;
  final String? actionLabel;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);

    final effectiveTitle = title ?? strings.errorGenericTitle;
    final effectiveBody = body ?? strings.errorGenericBody;
    final effectiveActionLabel = actionLabel ?? strings.errorGenericButton;

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
                  color: AppColors.error.withValues(alpha: 0.35),
                  width: AppDimens.strokeWidth,
                ),
              ),
              child: Icon(
                icon ?? AppIcons.error,
                size: 32,
                color: AppColors.errorText,
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
            if (onRetry != null) ...[
              const SizedBox(height: AppDimens.xl),
              PesaoButton(
                label: effectiveActionLabel,
                onPressed: onRetry,
                isExpanded: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
