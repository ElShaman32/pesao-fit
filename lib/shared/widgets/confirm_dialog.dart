import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_typography.dart';
import 'pesao_button.dart';

/// Muestra un diálogo de confirmación con el estilo PESAO FIT.
///
/// Reglas (design-system.md §7, §15):
/// - Fondo surface, radio card, borde outline.
/// - Botones PesaoButton (nada de TextButton/ElevatedButton crudos).
/// - Acción destructiva usa variante danger (rojo = error/destructivo).
///
/// Retorna true si el usuario confirmó, false si canceló o cerró.
Future<bool> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String confirmLabel,
  required String cancelLabel,
  bool isDestructive = false,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    barrierColor: AppColors.background.withValues(alpha: 0.7),
    builder: (dialogContext) => Dialog(
      backgroundColor: AppColors.surface,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: AppDimens.cardBorderRadius,
        side: BorderSide(color: AppColors.outline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: AppTypography.title),
            const SizedBox(height: AppDimens.m),
            Text(
              message,
              style: AppTypography.body.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimens.xl),
            Row(
              children: [
                Expanded(
                  child: PesaoButton(
                    label: cancelLabel,
                    variant: PesaoButtonVariant.secondary,
                    onPressed: () => Navigator.of(dialogContext).pop(false),
                  ),
                ),
                const SizedBox(width: AppDimens.m),
                Expanded(
                  child: PesaoButton(
                    label: confirmLabel,
                    variant: isDestructive
                        ? PesaoButtonVariant.danger
                        : PesaoButtonVariant.primary,
                    onPressed: () => Navigator.of(dialogContext).pop(true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
  return confirmed ?? false;
}
