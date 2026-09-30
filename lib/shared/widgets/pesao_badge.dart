import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_icons.dart';
import '../../core/theme/app_typography.dart';

/// Variantes semánticas del badge.
enum PesaoBadgeVariant {
  success,
  warning,
  error,
  brand,
}

/// Badge oficial de PESAO FIT.
///
/// Semántica:
/// - success: solo éxito.
/// - warning: alerta.
/// - error: error.
/// - brand: estado neutro de marca.
class PesaoBadge extends StatelessWidget {
  const PesaoBadge({
    super.key,
    required this.label,
    this.variant = PesaoBadgeVariant.brand,
    this.icon,
  });

  final String label;
  final PesaoBadgeVariant variant;
  final IconData? icon;

  Color get _foreground {
    switch (variant) {
      case PesaoBadgeVariant.success:
        return AppColors.successText;
      case PesaoBadgeVariant.warning:
        return AppColors.warningText;
      case PesaoBadgeVariant.error:
        return AppColors.errorText;
      case PesaoBadgeVariant.brand:
        return AppColors.primaryText;
    }
  }

  Color get _border {
    switch (variant) {
      case PesaoBadgeVariant.success:
        return AppColors.success;
      case PesaoBadgeVariant.warning:
        return AppColors.warning;
      case PesaoBadgeVariant.error:
        return AppColors.error;
      case PesaoBadgeVariant.brand:
        return AppColors.primary;
    }
  }

  IconData get _defaultIcon {
    switch (variant) {
      case PesaoBadgeVariant.success:
        return AppIcons.success;
      case PesaoBadgeVariant.warning:
        return AppIcons.warning;
      case PesaoBadgeVariant.error:
        return AppIcons.error;
      case PesaoBadgeVariant.brand:
        return AppIcons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final foreground = _foreground;

    return Semantics(
      label: label,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.s,
          vertical: AppDimens.xs,
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceHigh,
          borderRadius: AppDimens.pillBorderRadius,
          border: Border.all(
            color: _border.withValues(alpha: 0.45),
            width: AppDimens.strokeWidth,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? _defaultIcon,
              size: 16,
              color: foreground,
            ),
            const SizedBox(width: AppDimens.xs),
            Text(
              label,
              style: AppTypography.label.copyWith(
                color: foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
