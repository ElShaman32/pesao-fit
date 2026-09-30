import 'package:flutter/material.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_typography.dart';

/// SectionHeader oficial de PESAO FIT.
///
/// Reglas:
/// - Título de sección.
/// - Acción opcional "Ver todo".
/// - La acción debe tener touch target mínimo 48.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeAll,
  });

  /// Título de la sección. Debe venir desde AppStrings.
  final String title;

  /// Si es null, no se muestra "Ver todo".
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimens.xs,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.title,
            ),
          ),
          if (onSeeAll != null)
            Semantics(
              button: true,
              label: strings.commonSeeAll,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onSeeAll,
                child: Container(
                  constraints: const BoxConstraints(
                    minHeight: AppDimens.touchTarget,
                    minWidth: AppDimens.touchTarget,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.s,
                  ),
                  alignment: Alignment.centerRight,
                  child: Text(
                    strings.commonSeeAll,
                    style: AppTypography.label.copyWith(
                      color: AppColors.primaryText,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
