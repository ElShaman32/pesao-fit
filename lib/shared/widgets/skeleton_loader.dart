import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';

/// SkeletonLoader oficial de PESAO FIT.
///
/// Reglas:
/// - Shimmer suave con tinte morado.
/// - Sin spinners clásicos.
/// - Debe replicar el layout real de la pantalla.
/// - Se usa junto a primitives: [SkeletonBox], [SkeletonLine],
///   [SkeletonCircle], [SkeletonCard], [SkeletonListTile].
class SkeletonLoader extends StatefulWidget {
  const SkeletonLoader({
    super.key,
    required this.child,
    this.semanticLabel,
    this.duration = const Duration(milliseconds: 1200),
  });

  final Widget child;

  /// Label de accesibilidad para anunciar carga.
  /// Debe venir desde AppStrings, por ejemplo commonLoading.
  final String? semanticLabel;

  final Duration duration;

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();

  /// Obtiene la animación del SkeletonLoader más cercano.
  /// Si no existe, devuelve una animación estática.
  static Animation<double> of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<_SkeletonScope>();

    if (scope == null) {
      return const AlwaysStoppedAnimation<double>(0.5);
    }

    return scope.animation;
  }
}

class _SkeletonLoaderState extends State<SkeletonLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant SkeletonLoader oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scopedChild = _SkeletonScope(
      animation: _controller,
      child: widget.child,
    );

    if (widget.semanticLabel != null) {
      return Semantics(
        label: widget.semanticLabel,
        liveRegion: true,
        child: ExcludeSemantics(
          child: scopedChild,
        ),
      );
    }

    return ExcludeSemantics(
      child: scopedChild,
    );
  }
}

class _SkeletonScope extends InheritedWidget {
  const _SkeletonScope({
    required this.animation,
    required super.child,
  });

  final Animation<double> animation;

  @override
  bool updateShouldNotify(_SkeletonScope oldWidget) {
    return animation != oldWidget.animation;
  }
}

/// Caja base para skeletons.
class SkeletonBox extends StatelessWidget {
  const SkeletonBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius = AppDimens.cardBorderRadius,
    this.shape = BoxShape.rectangle,
  });

  final double? width;
  final double? height;
  final BorderRadius borderRadius;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    final animation = SkeletonLoader.of(context);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final stop = animation.value.clamp(0.08, 0.92);

        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: shape == BoxShape.circle ? null : borderRadius,
            shape: shape,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.surfaceHigh,
                AppColors.primary.withValues(alpha: 0.14),
                AppColors.surfaceHigh,
              ],
              stops: [
                0.0,
                stop,
                1.0,
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Línea de texto simulada.
class SkeletonLine extends StatelessWidget {
  const SkeletonLine({
    super.key,
    required this.width,
    this.height = 12,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SkeletonBox(
      width: width,
      height: height,
      borderRadius: AppDimens.pillBorderRadius,
    );
  }
}

/// Avatar o círculo simulado.
class SkeletonCircle extends StatelessWidget {
  const SkeletonCircle({
    super.key,
    this.size = 40,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return SkeletonBox(
      width: size,
      height: size,
      shape: BoxShape.circle,
    );
  }
}

/// Card simulada.
class SkeletonCard extends StatelessWidget {
  const SkeletonCard({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return SkeletonBox(
      height: height,
      borderRadius: AppDimens.cardBorderRadius,
    );
  }
}

/// Tile simulado con avatar y líneas.
class SkeletonListTile extends StatelessWidget {
  const SkeletonListTile({
    super.key,
    this.hasSubtitle = true,
  });

  final bool hasSubtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SkeletonCircle(size: 40),
        const SizedBox(width: AppDimens.m),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SkeletonLine(width: double.infinity),
              if (hasSubtitle) ...[
                const SizedBox(height: AppDimens.s),
                const SkeletonLine(width: 120),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
