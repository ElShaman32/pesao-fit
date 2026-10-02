import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_typography.dart';

/// Fila de un set individual: número | kg | reps | check.
/// Check completo = verde éxito (design-system.md §8).
/// Acepta primitivos para vivir en shared/ sin depender de features.
class SetTracker extends StatelessWidget {
  const SetTracker({
    super.key,
    required this.setNumber,
    this.weightKg,
    this.reps,
    required this.completed,
    required this.onToggle,
    this.enabled = true,
  });

  final int setNumber;
  final double? weightKg;
  final int? reps;
  final bool completed;
  final VoidCallback onToggle;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final textColor = completed ? AppColors.successText : AppColors.textPrimary;
    final labelColor = completed
        ? AppColors.successText
        : AppColors.textSecondary;

    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDimens.xs),
        child: Row(
          children: [
            // Número de set.
            SizedBox(
              width: 32,
              child: Text(
                '$setNumber',
                textAlign: TextAlign.center,
                style: AppTypography.label.copyWith(
                  color: labelColor,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ),
            const SizedBox(width: AppDimens.m),
            // Peso.
            Expanded(
              child: Text(
                weightKg != null ? '${weightKg!.toStringAsFixed(1)} kg' : '—',
                style: AppTypography.body.copyWith(
                  color: textColor,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ),
            // Reps.
            Expanded(
              child: Text(
                reps != null ? '$reps reps' : '—',
                style: AppTypography.body.copyWith(
                  color: textColor,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ),
            // Check (touch target 48x48).
            GestureDetector(
              onTap: enabled ? onToggle : null,
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                width: 48,
                height: 48,
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: completed ? AppColors.success : Colors.transparent,
                      border: Border.all(
                        color: completed
                            ? AppColors.success
                            : AppColors.outline,
                        width: 2,
                      ),
                    ),
                    child: completed
                        ? const Icon(
                            Icons.check_rounded,
                            size: 18,
                            color: AppColors.onSuccess,
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
