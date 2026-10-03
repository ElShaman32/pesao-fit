import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_typography.dart';
import '../widgets/pesao_button.dart';

/// Bottom sheet de descanso con anillo countdown (design-system.md §8).
/// Anillo primary, botón +1min, vibración al terminar.
class RestTimerSheet extends StatefulWidget {
  const RestTimerSheet({super.key, required this.initialSeconds});

  final int initialSeconds;

  /// Muestra el sheet. Devuelve true al terminar o saltar.
  static Future<bool?> show(BuildContext context, {required int seconds}) {
    return showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      isDismissible: true,
      builder: (_) => RestTimerSheet(initialSeconds: seconds),
    );
  }

  @override
  State<RestTimerSheet> createState() => _RestTimerSheetState();
}

class _RestTimerSheetState extends State<RestTimerSheet> {
  late int _totalMs;
  late int _endTimeMs;
  Timer? _timer;
  bool _isDone = false;

  @override
  void initState() {
    super.initState();
    _totalMs = widget.initialSeconds * 1000;
    _endTimeMs = DateTime.now().millisecondsSinceEpoch + _totalMs;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      final remaining = _endTimeMs - DateTime.now().millisecondsSinceEpoch;
      if (remaining <= 0) {
        _onComplete();
      } else if (mounted) {
        setState(() {});
      }
    });
  }

  void _onComplete() {
    _timer?.cancel();
    if (!mounted) return;
    setState(() => _isDone = true);
    HapticFeedback.heavyImpact();
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) Navigator.of(context).pop(true);
    });
  }

  void _addMinute() {
    _endTimeMs += 60000;
    _totalMs += 60000;
    if (_isDone) {
      _isDone = false;
      _startTimer();
    }
    setState(() {});
  }

  int get _remainingMs {
    final r = _endTimeMs - DateTime.now().millisecondsSinceEpoch;
    return r < 0 ? 0 : r;
  }

  double get _progress {
    if (_totalMs <= 0) return 0;
    return (_remainingMs / _totalMs).clamp(0.0, 1.0);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final remainingSeconds = (_remainingMs / 1000).ceil();
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(AppDimens.l),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: const BoxDecoration(
              color: AppColors.outline,
              borderRadius: AppDimens.pillBorderRadius,
            ),
          ),
          const SizedBox(height: AppDimens.l),
          Text(
            _isDone ? l10n.workoutRestDone : l10n.workoutRestTitle,
            style: AppTypography.headline.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimens.xs),
          Text(
            l10n.workoutRestSubtitle,
            style: AppTypography.body.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimens.xl),
          // Anillo countdown con glow primary.
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  blurRadius: 24,
                ),
              ],
            ),
            child: CustomPaint(
              painter: _CountdownRingPainter(progress: _isDone ? 0 : _progress),
              child: Center(
                child: _isDone
                    ? const Icon(
                        Icons.check_rounded,
                        size: 48,
                        color: AppColors.success,
                      )
                    : Text(
                        '${minutes.toString().padLeft(2, '0')}:'
                        '${seconds.toString().padLeft(2, '0')}',
                        style: AppTypography.numberL.copyWith(
                          color: AppColors.textPrimary,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: AppDimens.xl),
          if (!_isDone) ...[
            PesaoButton(
              label: l10n.workoutRestAddMinute,
              variant: PesaoButtonVariant.secondary,
              onPressed: _addMinute,
            ),
            const SizedBox(height: AppDimens.s),
            PesaoButton(
              label: l10n.workoutRestSkip,
              variant: PesaoButtonVariant.ghost,
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ],
      ),
    );
  }
}

class _CountdownRingPainter extends CustomPainter {
  _CountdownRingPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;

    final bgPaint = Paint()
      ..color = AppColors.surfaceHigh
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    if (progress > 0) {
      final progressPaint = Paint()
        ..color = AppColors.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        2 * math.pi * progress,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CountdownRingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
