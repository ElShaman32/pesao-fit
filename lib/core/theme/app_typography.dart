import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Tipografías del design system (design-system.md §3, ADR-025).
///
/// - Manrope: UI general.
/// - Barlow Condensed: display (títulos de pantalla, héroes).
/// - Los números SIEMPRE usan [FontFeature.tabularFigures] para que no "bailen".
///
/// Las fuentes van embebidas en assets/fonts (NUNCA Google Fonts por red).
abstract final class AppTypography {
  static const String manropeFamily = 'Manrope';
  static const String barlowCondensedFamily = 'BarlowCondensed';

  /// Títulos de pantalla y héroes. Barlow Condensed 700, 32.
  static const TextStyle display = TextStyle(
    fontFamily: barlowCondensedFamily,
    fontWeight: FontWeight.w700,
    fontSize: 32,
    height: 1.15,
    color: AppColors.textPrimary,
  );

  /// Encabezados de dashboard. Manrope 800, 24.
  static const TextStyle headline = TextStyle(
    fontFamily: manropeFamily,
    fontWeight: FontWeight.w800,
    fontSize: 24,
    height: 1.25,
    color: AppColors.textPrimary,
  );

  /// AppBar y títulos de card. Manrope 700, 18.
  static const TextStyle title = TextStyle(
    fontFamily: manropeFamily,
    fontWeight: FontWeight.w700,
    fontSize: 18,
    height: 1.3,
    color: AppColors.textPrimary,
  );

  /// Texto general. Manrope 500, 14.
  static const TextStyle body = TextStyle(
    fontFamily: manropeFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.45,
    color: AppColors.textPrimary,
  );

  /// Secundarios. Manrope 500, 12.
  static const TextStyle bodySmall = TextStyle(
    fontFamily: manropeFamily,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 1.4,
    color: AppColors.textSecondary,
  );

  /// Botones y badges. Manrope 700, 12.
  static const TextStyle label = TextStyle(
    fontFamily: manropeFamily,
    fontWeight: FontWeight.w700,
    fontSize: 12,
    height: 1.2,
    letterSpacing: 0.4,
    color: AppColors.textPrimary,
  );

  /// Mayúsculas con tracking. Manrope 700, 10, letterSpacing 1.5.
  static const TextStyle overline = TextStyle(
    fontFamily: manropeFamily,
    fontWeight: FontWeight.w700,
    fontSize: 10,
    height: 1.2,
    letterSpacing: 1.5,
    color: AppColors.textSecondary,
  );

  /// Números grandes (kcal, kg). Manrope 800, 28, tabular.
  static const TextStyle numberL = TextStyle(
    fontFamily: manropeFamily,
    fontWeight: FontWeight.w800,
    fontSize: 28,
    height: 1.1,
    color: AppColors.textPrimary,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// Números medianos (repes, series). Manrope 800, 20, tabular.
  static const TextStyle numberM = TextStyle(
    fontFamily: manropeFamily,
    fontWeight: FontWeight.w800,
    fontSize: 20,
    height: 1.2,
    color: AppColors.textPrimary,
    fontFeatures: [FontFeature.tabularFigures()],
  );
}
