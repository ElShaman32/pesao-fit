import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_shadows.dart';

/// FAB oficial de PESAO FIT.
///
/// Reglas:
/// - Tamaño 56.
/// - Color primary.
/// - Glow primario permitido.
/// - Es único por shell.
class PesaoFab extends StatelessWidget {
  const PesaoFab({
    super.key,
    required this.icon,
    required this.semanticLabel,
    required this.onPressed,
  });

  final IconData icon;

  /// Label para accesibilidad. Debe venir desde AppStrings.
  final String semanticLabel;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;

    return Semantics(
      button: true,
      enabled: enabled,
      label: semanticLabel,
      child: MouseRegion(
        cursor: enabled ? SystemMouseCursors.click : MouseCursor.defer,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: enabled ? onPressed : null,
          child: Container(
            width: AppDimens.fabSize,
            height: AppDimens.fabSize,
            decoration: BoxDecoration(
              color: enabled ? AppColors.primary : AppColors.surfaceHigh,
              shape: BoxShape.circle,
              boxShadow: enabled ? const [AppShadows.primaryGlow] : const [],
            ),
            child: Icon(
              icon,
              size: 24,
              color: enabled ? AppColors.onPrimary : AppColors.textDisabled,
            ),
          ),
        ),
      ),
    );
  }
}
