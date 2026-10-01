import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/pesao_bottom_nav.dart';
import '../../../shared/widgets/pesao_fab.dart';
import '../../../shared/widgets/pesao_shell.dart';
import '../../theme/app_dimens.dart';
import '../../theme/app_typography.dart';

/// Scaffold común para los shells por rol.
///
/// Usa exclusivamente componentes Pesao*:
/// - PesaoShell
/// - PesaoBottomNav
/// - PesaoFab
class RoleShellScaffold extends StatelessWidget {
  const RoleShellScaffold({
    super.key,
    required this.navigationShell,
    required this.items,
    required this.fabIcon,
    required this.fabSemanticLabel,
    required this.onFabPressed,
  });

  final StatefulNavigationShell navigationShell;
  final List<PesaoBottomNavItem> items;
  final IconData fabIcon;
  final String fabSemanticLabel;
  final VoidCallback onFabPressed;

  @override
  Widget build(BuildContext context) {
    return PesaoShell(
      body: navigationShell,
      bottomNavigationBar: PesaoBottomNav(
        items: items,
        selectedIndex: navigationShell.currentIndex,
        onSelected: (index) => navigationShell.goBranch(index),
        hasCenterFab: true,
      ),
      floatingActionButton: PesaoFab(
        icon: fabIcon,
        semanticLabel: fabSemanticLabel,
        onPressed: onFabPressed,
      ),
    );
  }
}

/// Pantalla provisional para tabs mientras llega la pantalla real.
///
/// No es una pantalla final de feature; solo mantiene visible el shell
/// con componentes del kit y textos desde AppStrings.
class ShellPlaceholderScreen extends StatelessWidget {
  const ShellPlaceholderScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.l),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: AppTypography.headline,
        ),
      ),
    );
  }
}
