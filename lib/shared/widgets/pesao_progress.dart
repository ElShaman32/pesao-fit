import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';

/// Variante semántica del color de relleno.
enum PesaoProgressVariant { brand, success, warning }

/// Barra de progreso determinístico oficial de PESAO FIT.
///
/// Reglas (design-system.md §2, §7):
/// - Pista surfaceHigh; relleno primary/success/warning según variante.
/// - No es un spinner: la carga se resuelve con SkeletonLoader.
/// - [value] entre 0.0 y 1.0.
class PesaoProgress extends StatelessWidget {
  const PesaoProgress({
    super.key,
    required this.value,
    this.variant = PesaoProgressVariant.brand,
    this.height = 8,
    this.semanticLabel,
  });

  final double value;
  final PesaoProgressVariant variant;
  final double height;

  /// Label para accesibilidad. Debe venir desde AppStrings.
  final String? semanticLabel;

  double get _clamped => value.clamp(0.0, 1.0).toDouble();

  Color get _fillColor {
    switch (variant) {
      case PesaoProgressVariant.brand:
        return AppColors.primary;
      case PesaoProgressVariant.success:
        return AppColors.success;
      case PesaoProgressVariant.warning:
        return AppColors.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      value: '${(_clamped * 100).round()}%',
      child: Container(
        height: height,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: AppColors.surfaceHigh,
          borderRadius: AppDimens.pillBorderRadius,
        ),
        child: AnimatedFractionallySizedBox(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          alignment: Alignment.centerLeft,
          widthFactor: _clamped,
          child: Container(
            decoration: BoxDecoration(
              color: _fillColor,
              borderRadius: AppDimens.pillBorderRadius,
            ),
          ),
        ),
      ),
    );
  }
}
