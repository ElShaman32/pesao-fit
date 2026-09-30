import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_dimens.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../shared/widgets/pesao_button.dart';
import '../../../../../shared/widgets/pesao_card.dart';

/// PrimaryCard "acción de hoy" del dashboard.
///
/// Reglas (design-system.md §10):
/// - Glow primary permitido (es la card primaria).
/// - CTA con PesaoButton (nada de botones crudos).
class PrimaryCard extends StatelessWidget {
  const PrimaryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.actionLabel,
    required this.onAction,
  });

  final String title;
  final String subtitle;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return PesaoCard(
      glow: true,
      primaryTint: true,
      padding: const EdgeInsets.all(AppDimens.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.title,
          ),
          const SizedBox(height: AppDimens.xs),
          Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.body.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppDimens.l),
          PesaoButton(
            label: actionLabel,
            onPressed: onAction,
            isExpanded: true,
          ),
        ],
      ),
    );
  }
}
