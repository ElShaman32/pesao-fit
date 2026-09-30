import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_typography.dart';

/// Variantes del botón según design-system.md §7.
enum PesaoButtonVariant {
  primary,
  secondary,
  ghost,
  danger,
}

/// Botón oficial de PESAO FIT.
///
/// Reglas visuales:
/// - Altura 48.
/// - Radio 12.
/// - Estados: enabled / disabled / loading-shimmer.
/// - Nunca se usa un botón Material crudo en pantallas.
class PesaoButton extends StatefulWidget {
  const PesaoButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = PesaoButtonVariant.primary,
    this.icon,
    this.loading = false,
    this.isExpanded = true,
  });

  /// Texto del botón. Debe venir desde AppStrings.
  final String label;

  /// Acción principal. Si es null, el botón queda deshabilitado.
  final VoidCallback? onPressed;

  /// Variante visual.
  final PesaoButtonVariant variant;

  /// Ícono opcional a la izquierda del texto.
  final IconData? icon;

  /// Estado de carga: muestra shimmer suave y bloquea el tap.
  final bool loading;

  /// Si es true, ocupa todo el ancho disponible.
  final bool isExpanded;

  @override
  State<PesaoButton> createState() => _PesaoButtonState();
}

class _PesaoButtonState extends State<PesaoButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _opacity = Tween<double>(begin: 0.45, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (widget.loading) {
      _controller.repeat(reverse: true);
    } else {
      _controller.value = 1;
    }
  }

  @override
  void didUpdateWidget(covariant PesaoButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.loading && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    }

    if (!widget.loading && _controller.isAnimating) {
      _controller.stop();
      _controller.value = 1;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _enabled => widget.onPressed != null && !widget.loading;

  Color get _backgroundColor {
    if (!_enabled) {
      return widget.variant == PesaoButtonVariant.ghost
          ? Colors.transparent
          : AppColors.surfaceHigh;
    }

    switch (widget.variant) {
      case PesaoButtonVariant.primary:
        return AppColors.primary;
      case PesaoButtonVariant.secondary:
        return AppColors.surfaceHigh;
      case PesaoButtonVariant.ghost:
        return Colors.transparent;
      case PesaoButtonVariant.danger:
        return AppColors.error;
    }
  }

  Color get _foregroundColor {
    if (!_enabled) {
      return AppColors.textDisabled;
    }

    switch (widget.variant) {
      case PesaoButtonVariant.primary:
        return AppColors.onPrimary;
      case PesaoButtonVariant.secondary:
        return AppColors.textPrimary;
      case PesaoButtonVariant.ghost:
        return AppColors.primaryText;
      case PesaoButtonVariant.danger:
        return AppColors.onPrimary;
    }
  }

  Border? get _border {
    if (widget.variant == PesaoButtonVariant.secondary) {
      return Border.all(
        color: AppColors.outline,
        width: AppDimens.strokeWidth,
      );
    }

    if (!_enabled && widget.variant != PesaoButtonVariant.ghost) {
      return Border.all(
        color: AppColors.outline,
        width: AppDimens.strokeWidth,
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final foreground = _foregroundColor;

    Widget content = Row(
      mainAxisSize:
          widget.isExpanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null) ...[
          Icon(
            widget.icon,
            size: 20,
            color: foreground,
          ),
          const SizedBox(width: AppDimens.s),
        ],
        Flexible(
          child: Text(
            widget.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.label.copyWith(color: foreground),
          ),
        ),
      ],
    );

    if (widget.loading) {
      content = FadeTransition(
        opacity: _opacity,
        child: content,
      );
    }

    return Semantics(
      button: true,
      enabled: _enabled,
      label: widget.label,
      child: MouseRegion(
        cursor: _enabled
            ? SystemMouseCursors.click
            : MouseCursor.defer,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _enabled ? widget.onPressed : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            height: AppDimens.buttonHeight,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.xl,
            ),
            decoration: BoxDecoration(
              color: _backgroundColor,
              borderRadius: AppDimens.buttonBorderRadius,
              border: _border,
            ),
            child: content,
          ),
        ),
      ),
    );
  }
}
