import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/home/presentation/screens/client_home_screen.dart';
import '../../../shared/widgets/pesao_bottom_nav.dart';
import '../../l10n/app_strings.dart';
import '../../theme/app_icons.dart';
import '../route_names.dart';
import 'shell_scaffold.dart';

/// Claves estables para los navigators de cada tab del shell cliente.
/// Se crean una sola vez y se reutilizan durante toda la vida de la app.
final GlobalKey<NavigatorState> _clientHomeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'clientHome');
final GlobalKey<NavigatorState> _clientRoutineNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'clientRoutine');
final GlobalKey<NavigatorState> _clientNutritionNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'clientNutrition');
final GlobalKey<NavigatorState> _clientProfileNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'clientProfile');

/// Shell del rol CLIENTE.
StatefulShellRoute buildClientShell() {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      final strings = AppStrings.of(context);

      return RoleShellScaffold(
        navigationShell: navigationShell,
        items: [
          PesaoBottomNavItem(
            icon: AppIcons.homeOutline,
            activeIcon: AppIcons.home,
            label: strings.tabHome,
          ),
          PesaoBottomNavItem(icon: AppIcons.routine, label: strings.tabRoutine),
          PesaoBottomNavItem(
            icon: AppIcons.nutritionOutline,
            activeIcon: AppIcons.nutrition,
            label: strings.tabNutrition,
          ),
          PesaoBottomNavItem(
            icon: AppIcons.profileOutline,
            activeIcon: AppIcons.profile,
            label: strings.tabProfile,
          ),
        ],
        fabIcon: AppIcons.add,
        fabSemanticLabel: strings.fabRegisterExercise,
        onFabPressed: () {},
      );
    },
    branches: [
      StatefulShellBranch(
        navigatorKey: _clientHomeNavigatorKey,
        routes: [
          GoRoute(
            path: RouteNames.clientHome,
            name: RouteNames.clientHome,
            builder: (context, state) => const ClientHomeScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _clientRoutineNavigatorKey,
        routes: [
          GoRoute(
            path: RouteNames.clientRoutine,
            name: RouteNames.clientRoutine,
            builder: (context, state) => ShellPlaceholderScreen(
              title: AppStrings.of(context).tabRoutine,
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _clientNutritionNavigatorKey,
        routes: [
          GoRoute(
            path: RouteNames.clientNutrition,
            name: RouteNames.clientNutrition,
            builder: (context, state) => ShellPlaceholderScreen(
              title: AppStrings.of(context).tabNutrition,
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _clientProfileNavigatorKey,
        routes: [
          GoRoute(
            path: RouteNames.clientProfile,
            name: RouteNames.clientProfile,
            builder: (context, state) => ShellPlaceholderScreen(
              title: AppStrings.of(context).tabProfile,
            ),
          ),
        ],
      ),
    ],
  );
}
