import 'package:flutter/material.dart';

/// Espaciado, radios y alturas del design system (design-system.md §4).
/// Grid base de 4pt. Touch target mínimo 48x48.
abstract final class AppDimens {
  // --- Espaciado (grid 4pt) -------------------------------------------------

  static const double xs = 4;
  static const double s = 8;
  static const double m = 12;
  static const double l = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;

  /// Padding horizontal obligatorio de cada pantalla.
  static const double screenPadding = 16;

  // --- Radios -----------------------------------------------------------------

  static const double radiusPill = 999;
  static const double radiusCard = 16;
  static const double radiusButton = 12;
  static const double radiusInput = 12;
  static const double radiusSheetTop = 24;

  static const BorderRadius pillBorderRadius =
      BorderRadius.all(Radius.circular(radiusPill));
  static const BorderRadius cardBorderRadius =
      BorderRadius.all(Radius.circular(radiusCard));
  static const BorderRadius buttonBorderRadius =
      BorderRadius.all(Radius.circular(radiusButton));
  static const BorderRadius inputBorderRadius =
      BorderRadius.all(Radius.circular(radiusInput));
  static const BorderRadius sheetTopBorderRadius =
      BorderRadius.vertical(top: Radius.circular(radiusSheetTop));

  // --- Alturas ----------------------------------------------------------------

  static const double buttonHeight = 48;
  static const double inputHeight = 52;
  static const double appBarHeight = 56;
  static const double bottomNavHeight = 64;
  static const double fabSize = 56;
  static const double tileMinHeight = 56;
  static const double tileMaxHeight = 64;

  // --- Accesibilidad ----------------------------------------------------------

  static const double touchTarget = 48;

  // --- Bordes -----------------------------------------------------------------

  static const double strokeWidth = 1;
}
