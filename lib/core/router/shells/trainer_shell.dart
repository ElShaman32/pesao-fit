import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/home/presentation/screens/trainer_home_screen.dart';
import '../../../shared/widgets/pesao_bottom_nav.dart';
import '../../l10n/app_strings.dart';
import '../../providers/fab_config.dart';
import '../../theme/app_icons.dart';
import '../route_names.dart';
import 'shell_scaffold.dart';

final GlobalKey<NavigatorState> _trainerHomeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'trainerHome');
final GlobalKey<NavigatorState> _trainerClientsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'trainerClients');
final GlobalKey<NavigatorState> _trainerRoutinesNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'trainerRoutines');
final GlobalKey<NavigatorState> _trainerProfileNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'trainerProfile');

/// Controlador del FAB del dueño. Se accede desde cualquier pantalla del shell.
final trainerFabController = PesaoFabController(
  defaultConfig: const FabConfig(
    icon: Icons.add_rounded,
    semanticLabel: 'Nueva Rutina',
  ),
);

/// Shell del rol ENTRENADOR.
StatefulShellRoute buildTrainerShell() {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      final strings = AppStrings.of(context);

      return ListenableBuilder(
        listenable: trainerFabController,
        builder: (context, _) {
          final fab = trainerFabController.current;

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
                icon: AppIcons.routine,
                label: strings.tabRoutine,
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
        navigatorKey: _trainerHomeNavigatorKey,
        routes: [
          GoRoute(
            path: RouteNames.trainerHome,
            name: RouteNames.trainerHome,
            builder: (context, state) => const TrainerHomeScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _trainerClientsNavigatorKey,
        routes: [
          GoRoute(
            path: RouteNames.trainerClients,
            name: RouteNames.trainerClients,
            builder: (context, state) => ShellPlaceholderScreen(
              title: AppStrings.of(context).tabClients,
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _trainerRoutinesNavigatorKey,
        routes: [
          GoRoute(
            path: RouteNames.trainerRoutines,
            name: RouteNames.trainerRoutines,
            builder: (context, state) => ShellPlaceholderScreen(
              title: AppStrings.of(context).tabRoutine,
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _trainerProfileNavigatorKey,
        routes: [
          GoRoute(
            path: RouteNames.trainerProfile,
            name: RouteNames.trainerProfile,
            builder: (context, state) => ShellPlaceholderScreen(
              title: AppStrings.of(context).tabProfile,
            ),
          ),
        ],
      ),
    ],
  );
}
