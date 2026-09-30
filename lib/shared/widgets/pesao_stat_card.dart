import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_typography.dart';
import 'pesao_card.dart';

/// StatCard oficial de PESAO FIT.
///
/// Reglas:
/// - Ícono + label + número grande tabular + sub opcional.
/// - Números con tabularFigures (ya incluido en numberL).
/// - Textos deben venir desde AppStrings en la pantalla.
class PesaoStatCard extends StatelessWidget {
  const PesaoStatCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.sub,
    this.footer,
    this.onTap,
  });

  final IconData icon;

  /// Label corto de la métrica.
  final String label;

  /// Valor principal ya formateado, por ejemplo "1.850".
  final String value;

  /// Texto secundario opcional.
  final String? sub;

  /// Widget opcional para un estado más rico (badge, progreso, etc.).
  final Widget? footer;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return PesaoCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppDimens.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.surfaceHigh,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.outline,
                    width: AppDimens.strokeWidth,
                  ),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(width: AppDimens.m),
              Expanded(
                child: Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.label.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.m),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.numberL,
          ),
          if (sub != null) ...[
            const SizedBox(height: AppDimens.xs),
            Text(
              sub!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
          if (footer != null) ...[
            const SizedBox(height: AppDimens.s),
            footer!,
          ],
        ],
      ),
    );
  }
}
