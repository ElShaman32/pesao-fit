import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/home/presentation/screens/nutritionist_home_screen.dart';
import '../../../features/nutrition/presentation/screens/food_form_screen.dart';
import '../../../features/nutrition/presentation/screens/nutritionist_clients_screen.dart';
import '../../../shared/widgets/pesao_bottom_nav.dart';
import '../../l10n/app_strings.dart';
import '../../theme/app_icons.dart';
import '../route_names.dart';
import 'shell_scaffold.dart';

final GlobalKey<NavigatorState> _nutritionistHomeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'nutritionistHome');
final GlobalKey<NavigatorState> _nutritionistClientsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'nutritionistClients');
final GlobalKey<NavigatorState> _nutritionistPlansNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'nutritionistPlans');
final GlobalKey<NavigatorState> _nutritionistFoodsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'nutritionistFoods');
final GlobalKey<NavigatorState> _nutritionistProfileNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'nutritionistProfile');

/// Configuración del FAB según la ruta actual del nutricionista (ADR-045).
_FabConfig _fabForRoute(BuildContext context, GoRouterState state) {
  final location = state.uri.path;
  final strings = AppStrings.of(context);

  // En la lista de planes: crear nuevo plan.
  if (location == RouteNames.nutritionistPlans) {
    return _FabConfig(
      icon: Icons.add_rounded,
      semanticLabel: strings.nutritionPlanCreate,
      onPressed: () => context.push(RouteNames.nutritionistPlanCreate),
    );
  }

  // En la lista de clientes: sin acción (los agrega el dueño).
  if (location == RouteNames.nutritionistClients) {
    return const _FabConfig(icon: Icons.add_rounded, semanticLabel: '');
  }

  // Default: FAB visible pero sin acción.
  return const _FabConfig(icon: Icons.add_rounded, semanticLabel: '');
}

/// Config inmutable del FAB para el shell.
class _FabConfig {
  final IconData icon;
  final String semanticLabel;
  final VoidCallback? onPressed;

  const _FabConfig({
    required this.icon,
    required this.semanticLabel,
    this.onPressed,
  });
}

/// Shell del rol NUTRICIONISTA.
StatefulShellRoute buildNutritionistShell() {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      final strings = AppStrings.of(context);
      final fab = _fabForRoute(context, state);

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
            builder: (context, state) => const NutritionistClientsScreen(),
            routes: [
              GoRoute(
                path: ':clientId',
                name: RouteNames.nutritionistClientDetail,
                builder: (context, state) {
                  // TODO F3-B: ClientNutritionDetailScreen
                  return const Scaffold(
                    body: Center(child: Text('Detalle cliente (F3-B)')),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _nutritionistPlansNavigatorKey,
        routes: [
          GoRoute(
            path: RouteNames.nutritionistPlans,
            name: RouteNames.nutritionistPlans,
            builder: (context, state) => ShellPlaceholderScreen(
              title: AppStrings.of(context).nutritionPlansTitle,
            ),
            // Dentro de la branch de plans, agrega estas sub-rutas:
            routes: [
              GoRoute(
                path: 'create',
                name: RouteNames.nutritionistPlanCreate,
                builder: (context, state) {
                  return const Scaffold(
                    body: Center(child: Text('Crear plan (F3-B)')),
                  );
                },
              ),
              GoRoute(
                path: ':planId',
                name: RouteNames.nutritionistPlanEdit,
                builder: (context, state) {
                  return const Scaffold(
                    body: Center(child: Text('Editar plan (F3-B)')),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _nutritionistFoodsNavigatorKey,
        routes: [
          GoRoute(
            path: '/nutritionist/foods',
            name: 'nutritionistFoods',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('Lista de alimentos (F3-B)')),
            ),
            routes: [
              GoRoute(
                path: 'create',
                name: RouteNames.nutritionistFoodCreate,
                builder: (context, state) => const FoodFormScreen(),
              ),
              GoRoute(
                path: ':foodId',
                name: RouteNames.nutritionistFoodEdit,
                builder: (context, state) {
                  return const Scaffold(
                    body: Center(child: Text('Editar alimento (F3-B)')),
                  );
                },
              ),
            ],
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
