import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_typography.dart';

/// Item del bottom nav.
class PesaoBottomNavItem {
  const PesaoBottomNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
  });

  final IconData icon;
  final IconData? activeIcon;
  final String label;
}

/// Bottom nav oficial de PESAO FIT.
///
/// Reglas:
/// - Siempre 4 tabs.
/// - Tab activo: primaryText + dot.
/// - Reserva espacio central para el FAB contextual.
class PesaoBottomNav extends StatelessWidget {
  const PesaoBottomNav({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
    this.hasCenterFab = false,
  }) : assert(items.length == 4, 'PesaoBottomNav requiere 4 tabs.');

  final List<PesaoBottomNavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final bool hasCenterFab;

  Widget _item({
    required int index,
    required PesaoBottomNavItem item,
    required bool selected,
  }) {
    return Expanded(
      child: _PesaoBottomNavItemView(
        item: item,
        selected: selected,
        onTap: () => onSelected(index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> rowChildren;

    if (hasCenterFab) {
      rowChildren = [
        _item(index: 0, item: items[0], selected: selectedIndex == 0),
        _item(index: 1, item: items[1], selected: selectedIndex == 1),
        const SizedBox(width: AppDimens.fabSize + AppDimens.xl),
        _item(index: 2, item: items[2], selected: selectedIndex == 2),
        _item(index: 3, item: items[3], selected: selectedIndex == 3),
      ];
    } else {
      rowChildren = List.generate(
        items.length,
        (index) => _item(
          index: index,
          item: items[index],
          selected: selectedIndex == index,
        ),
      );
    }

    return SafeArea(
      top: false,
      child: Container(
        height: AppDimens.bottomNavHeight,
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(
            top: BorderSide(
              color: AppColors.outline,
              width: AppDimens.strokeWidth,
            ),
          ),
        ),
        child: Row(children: rowChildren),
      ),
    );
  }
}

class _PesaoBottomNavItemView extends StatelessWidget {
  const _PesaoBottomNavItemView({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final PesaoBottomNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final icon =
        selected && item.activeIcon != null ? item.activeIcon! : item.icon;

    final color = selected ? AppColors.primaryText : AppColors.textSecondary;

    return Semantics(
      selected: selected,
      label: item.label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          height: AppDimens.bottomNavHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: color),
              const SizedBox(height: 2),
              Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.label.copyWith(color: color),
              ),
              const SizedBox(height: 2),
              selected
                  ? Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  )
                  : const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
