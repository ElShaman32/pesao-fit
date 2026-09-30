import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_typography.dart';

/// WeekPills oficial de PESAO FIT.
///
/// Reglas:
/// - Selector L-D.
/// - Hoy = outline.
/// - Seleccionado = primary fill.
/// - Día cumplido = dot success.
/// - Los labels deben venir desde AppStrings en la pantalla.
class WeekPills extends StatelessWidget {
  const WeekPills({
    super.key,
    required this.dayLabels,
    required this.todayIndex,
    required this.selectedIndex,
    required this.onSelected,
    this.completedDays = const <int>{},
  });

  /// 7 labels cortos, por ejemplo: Lun, Mar, Mié, Jue, Vie, Sáb, Dom.
  final List<String> dayLabels;

  /// Índice de hoy (0 = lunes, 6 = domingo).
  final int todayIndex;

  /// Índice seleccionado.
  final int selectedIndex;

  /// Días completados. Solo para pintarse con dot success.
  final Set<int> completedDays;

  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    assert(
      dayLabels.length == 7,
      'WeekPills requiere exactamente 7 dayLabels.',
    );

    return Row(
      children: List.generate(
        7,
        (index) => Expanded(
          child: _WeekPill(
            label: dayLabels[index],
            selected: index == selectedIndex,
            today: index == todayIndex,
            completed: completedDays.contains(index),
            onTap: () => onSelected(index),
          ),
        ),
      ),
    );
  }
}

class _WeekPill extends StatelessWidget {
  const _WeekPill({
    required this.label,
    required this.selected,
    required this.today,
    required this.completed,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final bool today;
  final bool completed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color background;
    final Color foreground;
    final Color border;

    if (selected) {
      background = AppColors.primary;
      foreground = AppColors.onPrimary;
      border = AppColors.primary;
    } else if (today) {
      background = AppColors.surface;
      foreground = AppColors.primaryText;
      border = AppColors.primaryText;
    } else {
      background = AppColors.surfaceHigh;
      foreground = AppColors.textSecondary;
      border = AppColors.outline;
    }

    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          height: AppDimens.touchTarget,
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeOut,
              height: 40,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.m,
              ),
              decoration: BoxDecoration(
                color: background,
                borderRadius: AppDimens.pillBorderRadius,
                border: Border.all(
                  color: border,
                  width: selected || today
                      ? 1.5
                      : AppDimens.strokeWidth,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: AppTypography.label.copyWith(
                      color: foreground,
                    ),
                  ),
                  if (completed) ...[
                    const SizedBox(width: AppDimens.xs),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
