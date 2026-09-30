import 'package:flutter/material.dart';

/// Sombras y glows del design system (design-system.md §5).
///
/// REGLA: la profundidad NO se logra con sombras negras pesadas, sino con
/// borde outline + superficie más clara (AppColors.outline / surfaceHigh).
/// El glow primario es el único permitido y SOLO va en FAB, card primaria
/// y anillos. Prohibido BackdropFilter/shaders.
abstract final class AppShadows {
  /// Primary al 20% (0x33 == 51/255 ≈ 20%).
  static const Color _primaryGlowColor = Color(0x338B5CF6);

  /// Glow primario: blur 24, spread 0. Solo FAB, card primaria y anillos.
  static const BoxShadow primaryGlow = BoxShadow(
    color: _primaryGlowColor,
    blurRadius: 24,
    spreadRadius: 0,
  );
}
