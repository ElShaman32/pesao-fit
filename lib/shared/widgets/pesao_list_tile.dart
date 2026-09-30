import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_typography.dart';

/// ListTile oficial de PESAO FIT.
///
/// Reglas:
/// - Altura mínima de tile.
/// - Fondo surfaceHigh.
/// - Textos pasan desde AppStrings en pantalla.
/// - No usa ListTile crudo de Material.
class PesaoListTile extends StatelessWidget {
  const PesaoListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.enabled = true,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final canTap = enabled && onTap != null;

    final titleColor = enabled
        ? AppColors.textPrimary
        : AppColors.textDisabled;

    final subtitleColor = enabled
        ? AppColors.textSecondary
        : AppColors.textDisabled;

    final tile = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      constraints: const BoxConstraints(
        minHeight: AppDimens.tileMinHeight,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.l,
        vertical: AppDimens.m,
      ),
      decoration: BoxDecoration(
        color: enabled ? AppColors.surfaceHigh : AppColors.surface,
        borderRadius: AppDimens.buttonBorderRadius,
        border: Border.all(
          color: AppColors.outline,
          width: AppDimens.strokeWidth,
        ),
      ),
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: AppDimens.m),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.body.copyWith(
                    color: titleColor,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: AppDimens.xs),
                  Text(
                    subtitle!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodySmall.copyWith(
                      color: subtitleColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: AppDimens.m),
            trailing!,
          ],
        ],
      ),
    );

    return Semantics(
      button: canTap,
      enabled: enabled,
      child: MouseRegion(
        cursor: canTap ? SystemMouseCursors.click : MouseCursor.defer,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: canTap ? onTap : null,
          child: tile,
        ),
      ),
    );
  }
}
