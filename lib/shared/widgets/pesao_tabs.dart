import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_typography.dart';

/// Tabs oficiales de PESAO FIT.
///
/// Reglas:
/// - Tabs simples tipo pill.
/// - Seleccionado = primary fill.
/// - No seleccionado = surfaceHigh.
/// - Labels deben venir desde AppStrings.
class PesaoTabs extends StatelessWidget {
  const PesaoTabs({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    assert(
      tabs.length >= 2,
      'PesaoTabs requiere al menos 2 tabs.',
    );

    return Row(
      children: List.generate(
        tabs.length,
        (index) => Expanded(
          child: _PesaoTab(
            label: tabs[index],
            selected: index == selectedIndex,
            onTap: () => onChanged(index),
          ),
        ),
      ),
    );
  }
}

class _PesaoTab extends StatelessWidget {
  const _PesaoTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
              margin: const EdgeInsets.symmetric(
                horizontal: AppDimens.xs,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.l,
              ),
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.primary
                    : AppColors.surfaceHigh,
                borderRadius: AppDimens.pillBorderRadius,
                border: Border.all(
                  color: selected
                      ? AppColors.primary
                      : AppColors.outline,
                  width: AppDimens.strokeWidth,
                ),
              ),
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.label.copyWith(
                  color: selected
                      ? AppColors.onPrimary
                      : AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
