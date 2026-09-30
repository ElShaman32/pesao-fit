import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Anillo de macros oficial de PESAO FIT.
///
/// Reglas (design-system.md §7, ADR-031):
/// - CustomPainter con SweepGradient (en vez de una librería pesada).
/// - Tres segmentos: proteína (morado), carbos (verde), grasas (ámbar).
/// - kcal total en el centro con numberL tabular.
/// - El SweepGradient es el gradiente aprobado por el design system;
///   NO es un BackdropFilter/shader prohibido.
class MacroRing extends StatelessWidget {
  const MacroRing({
    super.key,
    required this.proteinGrams,
    required this.carbsGrams,
    required this.fatsGrams,
    required this.totalKcal,
    this.centerSubtitle,
    this.size = 160,
    this.strokeWidth = 14,
  });

  final double proteinGrams;
  final double carbsGrams;
  final double fatsGrams;

  /// Número grande en el centro.
  final int totalKcal;

  /// Etiqueta bajo el número (ej. "kcal"). Debe venir desde AppStrings.
  final String? centerSubtitle;

  final double size;
  final double strokeWidth;

  // Factores estándar Atwater (kcal por gramo). Son constantes universales
  // de nutrición, no lógica de negocio de PESAO.
  static const double _kcalPerGramProtein = 4;
  static const double _kcalPerGramCarbs = 4;
  static const double _kcalPerGramFats = 9;

  double get _proteinKcal => proteinGrams * _kcalPerGramProtein;
  double get _carbsKcal => carbsGrams * _kcalPerGramCarbs;
  double get _fatsKcal => fatsGrams * _kcalPerGramFats;

  double get _totalMacroKcal => _proteinKcal + _carbsKcal + _fatsKcal;

  double _fraction(double kcal) {
    if (_totalMacroKcal <= 0) return 0;
    return (kcal / _totalMacroKcal).clamp(0.0, 1.0).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final proteinFraction = _fraction(_proteinKcal);
    final carbsFraction = _fraction(_carbsKcal);
    final fatsFraction = _fraction(_fatsKcal);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size.square(size),
            painter: _MacroRingPainter(
              proteinFraction: proteinFraction,
              carbsFraction: carbsFraction,
              fatsFraction: fatsFraction,
              strokeWidth: strokeWidth,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$totalKcal',
                style: AppTypography.numberL,
              ),
              if (centerSubtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  centerSubtitle!,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _MacroRingPainter extends CustomPainter {
  _MacroRingPainter({
    required this.proteinFraction,
    required this.carbsFraction,
    required this.fatsFraction,
    required this.strokeWidth,
  });

  final double proteinFraction;
  final double carbsFraction;
  final double fatsFraction;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Pista de fondo.
    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = AppColors.surfaceHigh;
    canvas.drawCircle(center, radius, trackPaint);

    // Sin macros no se dibuja el anillo de color.
    if (proteinFraction + carbsFraction + fatsFraction <= 0) return;

    final proteinEnd = proteinFraction;
    final carbsEnd = proteinFraction + carbsFraction;

    final sweepPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt
      ..shader = SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: 3 * math.pi / 2,
        colors: const [
          AppColors.macroProtein,
          AppColors.macroProtein,
          AppColors.macroCarbs,
          AppColors.macroCarbs,
          AppColors.macroFats,
          AppColors.macroFats,
        ],
        stops: [
          0.0,
          proteinEnd,
          proteinEnd,
          carbsEnd,
          carbsEnd,
          1.0,
        ],
      ).createShader(rect);

    canvas.drawArc(rect, -math.pi / 2, 2 * math.pi, false, sweepPaint);
  }

  @override
  bool shouldRepaint(covariant _MacroRingPainter oldDelegate) {
    return oldDelegate.proteinFraction != proteinFraction ||
        oldDelegate.carbsFraction != carbsFraction ||
        oldDelegate.fatsFraction != fatsFraction ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
