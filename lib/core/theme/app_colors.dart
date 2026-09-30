import 'dart:ui';

/// Tokens de color del design system "Dark Athletic Luxe".
/// Fuente única de verdad visual: design-system.md §2.
///
/// SEMÁNTICA INNEGOCIABLE (ADR-022):
/// - [primary] -> marca y ACCIÓN: FAB, tab activo, pills, anillos, glows.
/// - [success] -> SOLO éxito: racha, pago verificado, set completado, sync OK.
///   El verde NUNCA es una acción genérica.
/// - [warning] -> alertas: pago por vencer, señal débil, macro grasas.
/// - [error]   -> errores y acciones destructivas.
///
/// NOTA: se usa lowerCamelCase (no UPPER_SNAKE_CASE) para que los nombres
/// coincidan 1:1 con los tokens del design-system.md. Decisión registrada.
abstract final class AppColors {
  // --- Superficies ----------------------------------------------------------

  /// Fondo principal de la app (OLED opcional: [oledBackground]).
  static const Color background = Color(0xFF0B0B10);

  /// Fondo puro para modo OLED (ahorro de batería en gama media). ADR-029.
  static const Color oledBackground = Color(0xFF000000);

  /// Cards y bottom sheets.
  static const Color surface = Color(0xFF16161D);

  /// Inputs y tiles elevados.
  static const Color surfaceHigh = Color(0xFF1E1E28);

  /// Bordes de cards. Equivale a rgba(139,92,246,0.15): 0x26 == 38/255 ≈ 15%.
  static const Color outline = Color(0x268B5CF6);

  // --- Marca / acción -------------------------------------------------------

  /// Morado de marca: FAB, tab activo, pills, anillos, glows.
  static const Color primary = Color(0xFF8B5CF6);

  /// Morado apto para TEXTO pequeño sobre fondo oscuro (contraste AA).
  static const Color primaryText = Color(0xFFA78BFA);

  /// Texto/ícono sobre [primary].
  static const Color onPrimary = Color(0xFFFFFFFF);

  // --- Éxito (SOLO éxito) ---------------------------------------------------

  static const Color success = Color(0xFF22C55E);
  static const Color successText = Color(0xFF4ADE80);
  static const Color onSuccess = Color(0xFF0B0B10);

  // --- Alertas --------------------------------------------------------------

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningText = Color(0xFFFBBF24);

  // --- Errores --------------------------------------------------------------

  static const Color error = Color(0xFFEF4444);
  static const Color errorText = Color(0xFFF87171);

  // --- Texto ----------------------------------------------------------------

  static const Color textPrimary = Color(0xFFF4F4F5);
  static const Color textSecondary = Color(0xFFA1A1AA);
  static const Color textDisabled = Color(0xFF52525B);

  // --- Anillo de macros -----------------------------------------------------

  static const Color macroProtein = Color(0xFF8B5CF6); // = primary
  static const Color macroCarbs = Color(0xFF22C55E); // = success
  static const Color macroFats = Color(0xFFF59E0B); // = warning
}
