import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_typography.dart';

/// Chip/Pill oficial de PESAO FIT.
///
/// Reglas:
/// - Radio pill.
/// - Seleccionado = primary fill.
/// - No seleccionado = surfaceHigh + outline.
/// - Touch target mínimo 48.
class PesaoChip extends StatelessWidget {
  const PesaoChip({
    super.key,
    required this.label,
    this.selected = false,
    this.icon,
    this.onTap,
  });

  final String label;
  final bool selected;
  final IconData? icon;
  final VoidCallback? onTap;

  bool get _enabled => onTap != null;

  Color get _background {
    if (!_enabled) {
      return AppColors.surface;
    }

    return selected ? AppColors.primary : AppColors.surfaceHigh;
  }

  Color get _foreground {
    if (!_enabled) {
      return AppColors.textDisabled;
    }

    return selected ? AppColors.onPrimary : AppColors.textPrimary;
  }

  Border get _border {
    if (!_enabled) {
      return Border.all(
        color: AppColors.outline,
        width: AppDimens.strokeWidth,
      );
    }

    return Border.all(
      color: selected ? AppColors.primary : AppColors.outline,
      width: AppDimens.strokeWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    final foreground = _foreground;

    return Semantics(
      button: true,
      enabled: _enabled,
      selected: selected,
      label: label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _enabled ? onTap : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.xs,
            vertical: AppDimens.s,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            height: 32,
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.m,
            ),
            decoration: BoxDecoration(
              color: _background,
              borderRadius: AppDimens.pillBorderRadius,
              border: _border,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: 16,
                    color: foreground,
                  ),
                  const SizedBox(width: AppDimens.xs),
                ],
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.label.copyWith(
                    color: foreground,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
