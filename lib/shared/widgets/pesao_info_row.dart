import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_typography.dart';

/// Fila de etiqueta + valor para mostrar datos en pantallas de detalle.
///
/// Reglas:
/// - Label arriba con `AppTypography.label`, color `textSecondary`.
/// - Valor debajo con `AppTypography.body`, color `textPrimary`.
/// - Espaciado vertical compacto (usada dentro de `PesaoCard`).
class PesaoInfoRow extends StatelessWidget {
  const PesaoInfoRow({super.key, required this.label, required this.value});

  /// Etiqueta del dato. Debe venir desde AppStrings.
  final String label;

  /// Valor a mostrar. Puede ser texto formateado, monto, fecha, etc.
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.label.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppDimens.xs),
        Text(
          value,
          style: AppTypography.body.copyWith(color: AppColors.textPrimary),
        ),
      ],
    );
  }
}
