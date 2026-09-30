import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/admin/presentation/screens/admin_home_screen.dart';
import '../../../features/admin/presentation/screens/applications_list_screen.dart';
import '../../../shared/widgets/pesao_bottom_nav.dart';
import '../../l10n/app_strings.dart';
import '../../theme/app_icons.dart';
import '../route_names.dart';
import 'shell_scaffold.dart';

final GlobalKey<NavigatorState> _adminHomeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'adminHome');
final GlobalKey<NavigatorState> _adminGymsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'adminGyms');
final GlobalKey<NavigatorState> _adminPaymentsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'adminPayments');
final GlobalKey<NavigatorState> _adminProfileNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'adminProfile');

/// Shell del rol SUPERADMIN (Leonel).
StatefulShellRoute buildAdminShell() {
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
          PesaoBottomNavItem(
            icon: AppIcons.gymsOutline,
            activeIcon: AppIcons.gyms,
            label: strings.tabGyms,
          ),
          PesaoBottomNavItem(
            icon: AppIcons.paymentsOutline,
            activeIcon: AppIcons.payments,
            label: strings.tabPayments,
          ),
          PesaoBottomNavItem(
            icon: AppIcons.profileOutline,
            activeIcon: AppIcons.profile,
            label: strings.tabProfile,
          ),
        ],
        fabIcon: AppIcons.add,
        fabSemanticLabel: strings.fabAddGym,
        onFabPressed: () {},
      );
    },
    branches: [
      StatefulShellBranch(
        navigatorKey: _adminHomeNavigatorKey,
        routes: [
          GoRoute(
            path: RouteNames.adminHome,
            name: RouteNames.adminHome,
            builder: (context, state) => const AdminHomeScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _adminGymsNavigatorKey,
        routes: [
          GoRoute(
            path: RouteNames.adminGyms,
            name: RouteNames.adminGyms,
            builder: (context, state) => const ApplicationsListScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _adminPaymentsNavigatorKey,
        routes: [
          GoRoute(
            path: RouteNames.adminPayments,
            name: RouteNames.adminPayments,
            builder: (context, state) => ShellPlaceholderScreen(
              title: AppStrings.of(context).tabPayments,
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _adminProfileNavigatorKey,
        routes: [
          GoRoute(
            path: RouteNames.adminProfile,
            name: RouteNames.adminProfile,
            builder: (context, state) => ShellPlaceholderScreen(
              title: AppStrings.of(context).tabProfile,
            ),
          ),
        ],
      ),
    ],
  );
}
