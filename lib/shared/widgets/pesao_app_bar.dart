import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/theme/app_typography.dart';

/// AppBar oficial de PESAO FIT.
///
/// Reglas visuales:
/// - Transparente.
/// - Sin elevación.
/// - Altura 56.
/// - Título con tipografía title.
class PesaoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PesaoAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.bottom,
  });

  /// Texto del título. Debe venir desde AppStrings.
  final String? title;

  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize {
    final bottomHeight = bottom?.preferredSize.height ?? 0;
    return Size.fromHeight(AppDimens.appBarHeight + bottomHeight);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: AppDimens.appBarHeight,
      centerTitle: false,
      automaticallyImplyLeading: leading == null,
      leading: leading,
      title: title != null
          ? Text(
              title!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.title,
            )
          : null,
      titleTextStyle: AppTypography.title,
      actions: actions,
      bottom: bottom,
      foregroundColor: AppColors.textPrimary,
      iconTheme: const IconThemeData(
        color: AppColors.textPrimary,
        size: 24,
      ),
      actionsIconTheme: const IconThemeData(
        color: AppColors.textPrimary,
        size: 24,
      ),
    );
  }
}
