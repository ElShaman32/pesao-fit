import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_icons.dart';
import '../../core/theme/app_typography.dart';

/// Variantes semánticas del toast.
enum PesaoToastVariant { success, warning, error, brand }

/// Pieza visual oficial de toast de PESAO FIT.
///
/// Reglas:
/// - Borde semántico.
/// - El texto visible puede tener emoji.
/// - El semanticLabel NUNCA debe tener emoji.
class PesaoToast extends StatelessWidget {
  const PesaoToast({
    super.key,
    required this.message,
    required this.semanticLabel,
    this.variant = PesaoToastVariant.brand,
    this.icon,
  });

  final String message;
  final String semanticLabel;
  final PesaoToastVariant variant;
  final IconData? icon;

  Color get _borderColor {
    switch (variant) {
      case PesaoToastVariant.success:
        return AppColors.success;
      case PesaoToastVariant.warning:
        return AppColors.warning;
      case PesaoToastVariant.error:
        return AppColors.error;
      case PesaoToastVariant.brand:
        return AppColors.primary;
    }
  }

  Color get _iconColor {
    switch (variant) {
      case PesaoToastVariant.success:
        return AppColors.successText;
      case PesaoToastVariant.warning:
        return AppColors.warningText;
      case PesaoToastVariant.error:
        return AppColors.errorText;
      case PesaoToastVariant.brand:
        return AppColors.primaryText;
    }
  }

  IconData get _defaultIcon {
    switch (variant) {
      case PesaoToastVariant.success:
        return AppIcons.success;
      case PesaoToastVariant.warning:
        return AppIcons.warning;
      case PesaoToastVariant.error:
        return AppIcons.error;
      case PesaoToastVariant.brand:
        return AppIcons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      liveRegion: true,
      child: ExcludeSemantics(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.m,
            vertical: AppDimens.m,
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceHigh,
            borderRadius: AppDimens.buttonBorderRadius,
            border: Border.all(
              color: _borderColor.withValues(alpha: 0.65),
              width: AppDimens.strokeWidth,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon ?? _defaultIcon, size: 20, color: _iconColor),
              const SizedBox(width: AppDimens.s),
              Expanded(
                child: Text(
                  message,
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

/// Helper para mostrar un toast usando la pieza visual [PesaoToast].
///
/// [message] puede llevar emoji si viene del microcopy.
/// [semanticLabel] NUNCA debe llevar emoji.
/// Muestra un [PesaoToast] como SnackBar flotante.
void showPesaoToast(
  BuildContext context, {
  required String message,
  required String semanticLabel,
  PesaoToastVariant variant = PesaoToastVariant.brand,
  IconData? icon,
}) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(
    SnackBar(
      content: PesaoToast(
        message: message,
        semanticLabel: semanticLabel,
        variant: variant,
        icon: icon,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: const Duration(seconds: 3),
    ),
  );
}
