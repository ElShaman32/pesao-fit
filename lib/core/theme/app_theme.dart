import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_dimens.dart';
import 'app_typography.dart';

/// Tema global "Dark Athletic Luxe" (ADR-010).
///
/// - SIEMPRE oscuro: no existe tema claro.
/// - dynamicColor (Material You) está DESHABILITADO: el ColorScheme se
///   construye explícitamente desde tokens, nunca con ColorScheme.fromSeed.
/// - [oled] cambia el fondo a negro puro (ADR-029).
/// - [brandPrimary] permite marca blanca limitada (ADR-030): SOLO cambia el
///   primario; semánticos (success/warning/error) y tipografías quedan fijos.
abstract final class AppTheme {
  /// Construye el ThemeData oscuro de la app.
  static ThemeData build({bool oled = false, Color? brandPrimary}) {
    final Color screenBackground =
        oled ? AppColors.oledBackground : AppColors.background;
    final Color brand = brandPrimary ?? AppColors.primary;

    final ColorScheme colorScheme = ColorScheme.dark(
      primary: brand,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.surfaceHigh,
      onPrimaryContainer: AppColors.primaryText,
      secondary: AppColors.primaryText,
      onSecondary: AppColors.background,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      surfaceContainerHighest: AppColors.surfaceHigh,
      onSurfaceVariant: AppColors.textSecondary,
      outline: AppColors.outline,
      outlineVariant: AppColors.outline,
      error: AppColors.error,
      onError: AppColors.onPrimary,
    );

    final TextTheme textTheme = _buildTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      fontFamily: AppTypography.manropeFamily,
      scaffoldBackgroundColor: screenBackground,
      canvasColor: screenBackground,
      cardColor: AppColors.surface,
      dividerColor: AppColors.outline,
      primaryColor: brand,
      disabledColor: AppColors.textDisabled,
      highlightColor: brand.withValues(alpha: 0.08),
      splashColor: brand.withValues(alpha: 0.12),
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        toolbarHeight: AppDimens.appBarHeight,
        foregroundColor: AppColors.textPrimary,
        titleTextStyle: AppTypography.title,
        iconTheme: IconThemeData(color: AppColors.textPrimary, size: 24),
        actionsIconTheme: IconThemeData(color: AppColors.textPrimary, size: 24),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: brand,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
        highlightElevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        disabledElevation: 0,
        iconSize: 24,
        shape: const CircleBorder(),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primaryText,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: AppTypography.label,
        unselectedLabelStyle: AppTypography.label,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        height: AppDimens.bottomNavHeight,
        indicatorColor: brand.withValues(alpha: 0.15),
        labelTextStyle: const WidgetStatePropertyAll<TextStyle>(
          AppTypography.label,
        ),
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
          (states) => IconThemeData(
            size: 24,
            color:
                states.contains(WidgetState.selected)
                    ? AppColors.primaryText
                    : AppColors.textSecondary,
          ),
        ),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.primaryText,
        unselectedLabelColor: AppColors.textSecondary,
        indicatorColor: brand,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceHigh,
        selectedColor: brand,
        secondarySelectedColor: brand,
        disabledColor: AppColors.surface,
        labelStyle: AppTypography.label,
        secondaryLabelStyle: AppTypography.label.copyWith(
          color: AppColors.onPrimary,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.m,
          vertical: AppDimens.s,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: AppDimens.pillBorderRadius,
        ),
        side: BorderSide.none,
      ),
      cardTheme: const CardThemeData(
        color: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: AppDimens.cardBorderRadius,
          side: BorderSide(color: AppColors.outline),
        ),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: AppTypography.title,
        contentTextStyle: AppTypography.body,
        shape: RoundedRectangleBorder(borderRadius: AppDimens.cardBorderRadius),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        showDragHandle: false,
        shape: RoundedRectangleBorder(
          borderRadius: AppDimens.sheetTopBorderRadius,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surfaceHigh,
        contentTextStyle: AppTypography.bodySmall.copyWith(
          color: AppColors.textPrimary,
        ),
        actionTextColor: AppColors.primaryText,
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: AppDimens.buttonBorderRadius,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.outline,
        thickness: AppDimens.strokeWidth,
        space: AppDimens.strokeWidth,
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: AppColors.textSecondary,
        textColor: AppColors.textPrimary,
        tileColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimens.radiusButton),
          ),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: brand,
        linearTrackColor: AppColors.surfaceHigh,
        circularTrackColor: AppColors.surfaceHigh,
        refreshBackgroundColor: AppColors.surface,
      ),
      inputDecorationTheme: _buildInputDecorationTheme(brand),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: _buttonStyle(background: brand, foreground: AppColors.onPrimary),
      ),
      textButtonTheme: TextButtonThemeData(
        style: _buttonStyle(
          background: Colors.transparent,
          foreground: AppColors.primaryText,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: _buttonStyle(
          background: Colors.transparent,
          foreground: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.outline),
        ),
      ),
    );
  }

  /// Mapea los estilos del design system a los slots de Material TextTheme
  /// para que cualquier widget nativo herede la tipografía correcta.
  static TextTheme _buildTextTheme() {
    return TextTheme(
      displayLarge: AppTypography.display.copyWith(fontSize: 40),
      displayMedium: AppTypography.display,
      displaySmall: AppTypography.display.copyWith(fontSize: 28),
      headlineLarge: AppTypography.headline.copyWith(fontSize: 28),
      headlineMedium: AppTypography.headline,
      headlineSmall: AppTypography.headline.copyWith(fontSize: 20),
      titleLarge: AppTypography.title,
      titleMedium: AppTypography.title.copyWith(fontSize: 16),
      titleSmall: AppTypography.body.copyWith(fontWeight: FontWeight.w700),
      bodyLarge: AppTypography.body.copyWith(fontSize: 16),
      bodyMedium: AppTypography.body,
      bodySmall: AppTypography.bodySmall,
      labelLarge: AppTypography.label.copyWith(fontSize: 14),
      labelMedium: AppTypography.label,
      labelSmall: AppTypography.overline,
    );
  }

  /// Inputs Material (h52, radio 12, relleno surfaceHigh) como fallback.
  /// En pantallas reales se usa PesaoInput del kit.
  static InputDecorationTheme _buildInputDecorationTheme(Color brand) {
    const BorderRadius radius = AppDimens.inputBorderRadius;
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceHigh,
      isDense: true,
      alignLabelWithHint: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: AppDimens.l),
      labelStyle: AppTypography.bodySmall,
      floatingLabelStyle: AppTypography.label.copyWith(
        color: AppColors.primaryText,
      ),
      hintStyle: AppTypography.bodySmall.copyWith(
        color: AppColors.textDisabled,
      ),
      helperStyle: AppTypography.bodySmall.copyWith(
        color: AppColors.textSecondary,
      ),
      errorStyle: AppTypography.bodySmall.copyWith(color: AppColors.errorText),
      prefixIconColor: AppColors.textSecondary,
      suffixIconColor: AppColors.textSecondary,
      border: const OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: AppColors.outline),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: AppColors.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: brand, width: 1.5),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: AppColors.error, width: 1.5),
      ),
    );
  }

  /// Estilo base de botones Material (h48, radio 12) como fallback.
  /// En pantallas reales se usa PesaoButton del kit.
  static ButtonStyle _buttonStyle({
    required Color background,
    required Color foreground,
    Color disabledBackground = AppColors.surfaceHigh,
    BorderSide? side,
  }) {
    return ButtonStyle(
      textStyle: const WidgetStatePropertyAll<TextStyle>(AppTypography.label),
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (states) =>
            states.contains(WidgetState.disabled)
                ? disabledBackground
                : background,
      ),
      foregroundColor: WidgetStateProperty.resolveWith<Color>(
        (states) =>
            states.contains(WidgetState.disabled)
                ? AppColors.textDisabled
                : foreground,
      ),
      overlayColor: WidgetStatePropertyAll<Color>(
        foreground.withValues(alpha: 0.08),
      ),
      elevation: const WidgetStatePropertyAll<double>(0),
      minimumSize: const WidgetStatePropertyAll<Size>(
        Size(0, AppDimens.buttonHeight),
      ),
      padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
        EdgeInsets.symmetric(horizontal: AppDimens.xl),
      ),
      shape: WidgetStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusButton),
        ),
      ),
      side: side == null ? null : WidgetStatePropertyAll<BorderSide>(side),
    );
  }
}
