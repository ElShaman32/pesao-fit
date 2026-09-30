import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_typography.dart';

/// Muestra un bottom sheet modal con el estilo PESAO FIT.
///
/// Reglas (design-system.md §5, §6, §7):
/// - Radio superior 24.
/// - Fondo surface.
/// - Barrier solo oscurece, NUNCA desenfoca (sin BackdropFilter).
/// - Motion 300ms easeOutCubic según §6.
Future<T?> showPesaoBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isDismissible = true,
  bool enableDrag = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    builder:
        (sheetContext) => SafeArea(top: false, child: builder(sheetContext)),
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    backgroundColor: AppColors.surface,
    barrierColor: AppColors.background.withValues(alpha: 0.7),
    shape: const RoundedRectangleBorder(
      borderRadius: AppDimens.sheetTopBorderRadius,
    ),
  );
}

/// Cabecera para bottom sheets: asa de arrastre + título opcional.
class PesaoBottomSheetHeader extends StatelessWidget {
  const PesaoBottomSheetHeader({super.key, this.title});

  /// Título opcional. Debe venir desde AppStrings.
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimens.l,
        AppDimens.m,
        AppDimens.l,
        AppDimens.s,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: const BoxDecoration(
                color: AppColors.textDisabled,
                borderRadius: AppDimens.pillBorderRadius,
              ),
            ),
          ),
          if (title != null) ...[
            const SizedBox(height: AppDimens.m),
            Text(title!, style: AppTypography.title),
          ],
        ],
      ),
    );
  }
}
