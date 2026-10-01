import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/gym/presentation/screens/staff_list_screen.dart';
import '../../../features/home/presentation/screens/owner_home_screen.dart';
import '../../../shared/widgets/pesao_bottom_nav.dart';
import '../../l10n/app_strings.dart';
import '../../providers/fab_config.dart';
import '../../theme/app_icons.dart';
import '../route_names.dart';
import 'shell_scaffold.dart';

final GlobalKey<NavigatorState> _ownerHomeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'ownerHome');
final GlobalKey<NavigatorState> _ownerClientsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'ownerClients');
final GlobalKey<NavigatorState> _ownerPaymentsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'ownerPayments');
final GlobalKey<NavigatorState> _ownerProfileNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'ownerProfile');

/// Controlador del FAB del dueño. Se accede desde cualquier pantalla del shell.
final ownerFabController = OwnerFabController(
  defaultConfig: const FabConfig(
    icon: Icons.add_rounded,
    semanticLabel: 'Agregar cliente',
  ),
);

/// Shell del rol DUEÑO.
StatefulShellRoute buildOwnerShell() {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      final strings = AppStrings.of(context);

      return ListenableBuilder(
        listenable: ownerFabController,
        builder: (context, _) {
          final fab = ownerFabController.current;

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
            fabIcon: fab.icon,
            fabSemanticLabel: fab.semanticLabel,
            onFabPressed: fab.onPressed ?? () {},
          );
        },
      );
    },
    branches: [
      StatefulShellBranch(
        navigatorKey: _ownerHomeNavigatorKey,
        routes: [
          GoRoute(
            path: RouteNames.ownerHome,
            name: RouteNames.ownerHome,
            builder: (context, state) => const OwnerHomeScreen(),
          ),
          GoRoute(
            path: RouteNames.ownerStaff,
            name: RouteNames.ownerStaff,
            builder: (context, state) => const StaffListScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _ownerClientsNavigatorKey,
        routes: [
          GoRoute(
            path: RouteNames.ownerClients,
            name: RouteNames.ownerClients,
            builder: (context, state) => ShellPlaceholderScreen(
              title: AppStrings.of(context).tabClients,
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _ownerPaymentsNavigatorKey,
        routes: [
          GoRoute(
            path: RouteNames.ownerPayments,
            name: RouteNames.ownerPayments,
            builder: (context, state) => ShellPlaceholderScreen(
              title: AppStrings.of(context).tabPayments,
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _ownerProfileNavigatorKey,
        routes: [
          GoRoute(
            path: RouteNames.ownerProfile,
            name: RouteNames.ownerProfile,
            builder: (context, state) => ShellPlaceholderScreen(
              title: AppStrings.of(context).tabProfile,
            ),
          ),
        ],
      ),
    ],
  );
}
