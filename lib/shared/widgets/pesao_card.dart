import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_shadows.dart';

/// Card oficial de PESAO FIT.
///
/// Reglas visuales:
/// - Fondo surface.
/// - Borde outline.
/// - Radio 16.
/// - Glow solo cuando la card es primaria.
/// - Tint gradiente opcional.
class PesaoCard extends StatelessWidget {
  const PesaoCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppDimens.l),
    this.margin = EdgeInsets.zero,
    this.glow = false,
    this.primaryTint = false,
    this.onTap,
    this.borderColor = AppColors.outline,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool glow;
  final bool primaryTint;
  final VoidCallback? onTap;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      color: primaryTint ? null : AppColors.surface,
      gradient: primaryTint
          ? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary.withValues(alpha: 0.15),
                AppColors.surface,
              ],
            )
          : null,
      borderRadius: AppDimens.cardBorderRadius,
      border: Border.all(
        color: borderColor,
        width: AppDimens.strokeWidth,
      ),
      boxShadow: glow ? const [AppShadows.primaryGlow] : const [],
    );

    Widget card = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      margin: margin,
      padding: padding,
      decoration: decoration,
      child: child,
    );

    if (onTap != null) {
      card = MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: card,
        ),
      );

      return Semantics(
        button: true,
        child: card,
      );
    }

    return card;
  }
}
