import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/home/presentation/screens/nutritionist_home_screen.dart';
import '../../../shared/widgets/pesao_bottom_nav.dart';
import '../../l10n/app_strings.dart';
import '../../providers/fab_config.dart';
import '../../theme/app_icons.dart';
import '../route_names.dart';
import 'shell_scaffold.dart';

final GlobalKey<NavigatorState> _nutritionistHomeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'nutritionistHome');
final GlobalKey<NavigatorState> _nutritionistClientsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'nutritionistClients');
final GlobalKey<NavigatorState> _nutritionistPlansNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'nutritionistPlans');
final GlobalKey<NavigatorState> _nutritionistProfileNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'nutritionistProfile');

/// Controlador del FAB del dueño. Se accede desde cualquier pantalla del shell.
final nutritionistFabController = OwnerFabController(
  defaultConfig: const FabConfig(
    icon: Icons.add_rounded,
    semanticLabel: 'Agregar cliente',
  ),
);

/// Shell del rol NUTRICIONISTA.
StatefulShellRoute buildNutritionistShell() {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      final strings = AppStrings.of(context);

      return ListenableBuilder(
        listenable: nutritionistFabController,
        builder: (context, _) {
          final fab = nutritionistFabController.current;

          return RoleShellScaffold(
            navigationShell: navigationShell,
            items: [
              PesaoBottomNavItem(
                icon: AppIcons.homeOutline,
                activeIcon: AppIcons.home,
                label: strings.tabHome,
              ),
              PesaoBottomNavItem(
                icon: AppIcons.clientsOutline,
                activeIcon: AppIcons.clients,
                label: strings.tabClients,
              ),
              PesaoBottomNavItem(
                icon: AppIcons.plansOutline,
                activeIcon: AppIcons.plans,
                label: strings.tabPlans,
              ),
              PesaoBottomNavItem(
                icon: AppIcons.profileOutline,
                activeIcon: AppIcons.profile,
                label: strings.tabProfile,
              ),
            ],
            fabIcon: fab.icon,
            fabSemanticLabel: fab.semanticLabel,
            onFabPressed: fab.onPressed ?? () {},
          );
        },
      );
    },
    branches: [
      StatefulShellBranch(
        navigatorKey: _nutritionistHomeNavigatorKey,
        routes: [
          GoRoute(
            path: RouteNames.nutritionistHome,
            name: RouteNames.nutritionistHome,
            builder: (context, state) => const NutritionistHomeScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _nutritionistClientsNavigatorKey,
        routes: [
          GoRoute(
            path: RouteNames.nutritionistClients,
            name: RouteNames.nutritionistClients,
            builder: (context, state) => ShellPlaceholderScreen(
              title: AppStrings.of(context).tabClients,
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _nutritionistPlansNavigatorKey,
        routes: [
          GoRoute(
            path: RouteNames.nutritionistPlans,
            name: RouteNames.nutritionistPlans,
            builder: (context, state) =>
                ShellPlaceholderScreen(title: AppStrings.of(context).tabPlans),
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _nutritionistProfileNavigatorKey,
        routes: [
          GoRoute(
            path: RouteNames.nutritionistProfile,
            name: RouteNames.nutritionistProfile,
            builder: (context, state) => ShellPlaceholderScreen(
              title: AppStrings.of(context).tabProfile,
            ),
          ),
        ],
      ),
    ],
  );
}
