import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_typography.dart';

/// Botón de ícono oficial de PESAO FIT.
///
/// Reglas (design-system.md §6, §7):
/// - Touch target mínimo 48x48.
/// - Íconos Material rounded.
/// - Badge opcional para notificaciones (ej. campana).
/// - En pantallas se usa este componente, nunca IconButton crudo.
class PesaoIconButton extends StatelessWidget {
  const PesaoIconButton({
    super.key,
    required this.icon,
    required this.semanticLabel,
    this.onPressed,
    this.iconSize = 24,
    this.iconColor,
    this.badgeCount,
    this.isSelected = false,
  });

  final IconData icon;

  /// Label para accesibilidad (sin emoji). Debe venir desde AppStrings.
  final String semanticLabel;

  /// Si es null el botón queda deshabilitado.
  final VoidCallback? onPressed;

  final double iconSize;

  /// Color del ícono. Si es null se deriva del estado.
  final Color? iconColor;

  /// Si es > 0 muestra badge de notificación (9+ si supera 9).
  final int? badgeCount;

  final bool isSelected;

  bool get _enabled => onPressed != null;

  bool get _showBadge => badgeCount != null && badgeCount! > 0;

  Color get _resolvedColor {
    if (!_enabled) return AppColors.textDisabled;
    if (iconColor != null) return iconColor!;
    return isSelected ? AppColors.primaryText : AppColors.textSecondary;
  }

  @override
  Widget build(BuildContext context) {
    final iconWidget = Icon(icon, size: iconSize, color: _resolvedColor);

    return Semantics(
      button: true,
      enabled: _enabled,
      label: semanticLabel,
      child: MouseRegion(
        cursor: _enabled ? SystemMouseCursors.click : MouseCursor.defer,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _enabled ? onPressed : null,
          child: SizedBox(
            width: AppDimens.touchTarget,
            height: AppDimens.touchTarget,
            child: Center(
              child:
                  _showBadge
                      ? Stack(
                        clipBehavior: Clip.none,
                        children: [
                          iconWidget,
                          Positioned(
                            top: -4,
                            right: -6,
                            child: _NotificationBadge(count: badgeCount!),
                          ),
                        ],
                      )
                      : iconWidget,
            ),
          ),
        ),
      ),
    );
  }
}

/// Badge numérico de notificación (9+ cuando supera 9).
class _NotificationBadge extends StatelessWidget {
  const _NotificationBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final text = count > 9 ? '9+' : '$count';
    return Container(
      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.xs),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: AppDimens.pillBorderRadius,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: AppTypography.overline.copyWith(
          color: AppColors.onPrimary,
          letterSpacing: 0,
        ),
      ),
    );
  }
}
