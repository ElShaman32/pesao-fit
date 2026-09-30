import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_typography.dart';
import 'pesao_card.dart';

/// Card con gráfico de línea oficial de PESAO FIT.
///
/// Reglas (design-system.md §7, §13; arquitectura error conocido 19):
/// - fl_chart línea con relleno gradiente primary 20%.
/// - Downsampling automático a <=100 puntos por serie.
/// - Glanceable: sin grid ni ejes, solo la tendencia.
class ChartCard extends StatelessWidget {
  const ChartCard({
    super.key,
    required this.title,
    required this.values,
    this.subtitle,
    this.height = 180,
  });

  /// Título de la card. Debe venir desde AppStrings.
  final String title;

  /// Subtítulo opcional (ej. última lectura). Debe venir desde AppStrings.
  final String? subtitle;

  /// Valores de la serie (eje Y). El eje X es el índice.
  final List<double> values;

  final double height;

  static const int _maxPoints = 100;

  /// Reduce la serie a <=100 puntos para no laggear (error conocido 19).
  List<double> _downsample(List<double> input) {
    if (input.length <= _maxPoints) return input;
    final result = <double>[];
    final step = (input.length - 1) / (_maxPoints - 1);
    for (var i = 0; i < _maxPoints; i++) {
      result.add(input[(i * step).round()]);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    assert(values.length >= 2, 'ChartCard necesita al menos 2 puntos.');

    final sampled = _downsample(values);
    final spots = <FlSpot>[
      for (var i = 0; i < sampled.length; i++) FlSpot(i.toDouble(), sampled[i]),
    ];

    final minY = sampled.reduce((a, b) => math.min(a, b));
    final maxY = sampled.reduce((a, b) => math.max(a, b));
    final range = maxY - minY;
    final padding = range == 0 ? 1.0 : range * 0.15;

    return PesaoCard(
      padding: const EdgeInsets.all(AppDimens.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.title),
          if (subtitle != null) ...[
            const SizedBox(height: AppDimens.xs),
            Text(
              subtitle!,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
          const SizedBox(height: AppDimens.m),
          SizedBox(
            height: height,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: (spots.length - 1).toDouble(),
                minY: minY - padding,
                maxY: maxY + padding,
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineTouchData: const LineTouchData(enabled: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: AppColors.primary,
                    barWidth: 2,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.primary.withValues(alpha: 0.2),
                          AppColors.primary.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
