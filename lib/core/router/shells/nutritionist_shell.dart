import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/home/presentation/screens/nutritionist_home_screen.dart';
import '../../../features/nutrition/presentation/screens/nutritionist_clients_screen.dart';
import '../../../features/nutrition/presentation/screens/nutritionist_client_detail_screen.dart';
import '../../../features/nutrition/presentation/screens/nutritionist_plans_screen.dart';
import '../../../features/nutrition/presentation/screens/nutritionist_plan_form_screen.dart';
import '../../../features/nutrition/presentation/screens/nutritionist_plan_days_screen.dart';
import '../../../features/nutrition/presentation/screens/food_catalog_screen.dart';
import '../../../features/nutrition/presentation/screens/food_form_screen.dart';
import '../../../features/nutrition/presentation/screens/meal_template_list_screen.dart';
import '../../../features/nutrition/presentation/screens/meal_template_form_screen.dart';
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
final GlobalKey<NavigatorState> _nutritionistProfileNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'nutritionistProfile');

/// Configuración del FAB para una ruta del nutricionista.
/// Patrón ADR-045 (FAB contextual).
class _NutritionistFabConfig {
  final IconData icon;
  final String semanticLabel;
  final VoidCallback? onPressed;
  final bool isVisible;

  const _NutritionistFabConfig({
    required this.icon,
    required this.semanticLabel,
    this.onPressed,
  }) : isVisible = true;

  const _NutritionistFabConfig.hidden()
    : icon = AppIcons.add,
      semanticLabel = '',
      onPressed = null,
      isVisible = false;
}

/// Deriva el FAB según la ruta visible.
_NutritionistFabConfig _nutritionistFabForRoute(
  String path,
  BuildContext context,
) {
  final strings = AppStrings.of(context);

  // ──────────────────────────────────────────────────────────────────
  // PROFILE → FAB oculto (no hay acción contextual en perfil)
  // ──────────────────────────────────────────────────────────────────
  if (path == RouteNames.nutritionistProfile) {
    return const _NutritionistFabConfig.hidden();
  }

  // ──────────────────────────────────────────────────────────────────
  // HOME → Crear plan
  // ──────────────────────────────────────────────────────────────────
  if (path == RouteNames.nutritionistHome) {
    return _NutritionistFabConfig(
      icon: AppIcons.nutritionMenu,
      semanticLabel: strings.fabNewPlan,
      onPressed: () => context.push(RouteNames.nutritionistPlanCreate),
    );
  }

  // ──────────────────────────────────────────────────────────────────
  // CLIENTS → Sin acción (el nutri no crea clientes, los asigna el owner)
  // ──────────────────────────────────────────────────────────────────
  if (path == RouteNames.nutritionistClients) {
    return _NutritionistFabConfig(
      icon: AppIcons.add,
      semanticLabel: strings.fabNewPlan,
      onPressed: null,
    );
  }

  // ──────────────────────────────────────────────────────────────────
  // CLIENT DETAIL → Sin acción
  // ──────────────────────────────────────────────────────────────────
  if (path.startsWith('${RouteNames.nutritionistClients}/')) {
    return _NutritionistFabConfig(
      icon: AppIcons.add,
      semanticLabel: strings.fabNewPlan,
      onPressed: null,
    );
  }

  // ──────────────────────────────────────────────────────────────────
  // PLANS (lista) → Crear plan
  // ──────────────────────────────────────────────────────────────────
  if (path == RouteNames.nutritionistPlans) {
    return _NutritionistFabConfig(
      icon: AppIcons.nutritionMenu,
      semanticLabel: strings.fabNewPlan,
      onPressed: () => context.push(RouteNames.nutritionistPlanCreate),
    );
  }

  // ──────────────────────────────────────────────────────────────────
  // PLAN CREATE/EDIT/DAYS → Sin acción (ya estás dentro del flujo)
  // ──────────────────────────────────────────────────────────────────
  if (path.startsWith('${RouteNames.nutritionistPlans}/') &&
      (path == RouteNames.nutritionistPlanCreate ||
          path.startsWith('${RouteNames.nutritionistPlans}/'))) {
    // Detectar si estamos en foods o templates (tienen sus propios FABs)
    if (path.startsWith('${RouteNames.nutritionistPlans}/foods')) {
      if (path == RouteNames.nutritionistFoods) {
        return _NutritionistFabConfig(
          icon: AppIcons.add,
          semanticLabel: strings.foodFormTitle,
          onPressed: () => context.push(RouteNames.nutritionistFoodCreate),
        );
      }
      // Food create/edit → sin acción
      return _NutritionistFabConfig(
        icon: AppIcons.add,
        semanticLabel: strings.foodFormTitle,
        onPressed: null,
      );
    }

    if (path.startsWith('${RouteNames.nutritionistPlans}/templates')) {
      if (path == RouteNames.nutritionistTemplates) {
        return _NutritionistFabConfig(
          icon: AppIcons.add,
          semanticLabel: strings.mealTemplateFormTitle,
          onPressed: () => context.push(RouteNames.nutritionistTemplateCreate),
        );
      }
      // Template create/edit → sin acción
      return _NutritionistFabConfig(
        icon: AppIcons.add,
        semanticLabel: strings.mealTemplateFormTitle,
        onPressed: null,
      );
    }

    // Plan create/edit/days → sin acción
    return _NutritionistFabConfig(
      icon: AppIcons.add,
      semanticLabel: strings.fabNewPlan,
      onPressed: null,
    );
  }

  // ──────────────────────────────────────────────────────────────────
  // DEFAULT → Crear plan (fallback seguro)
  // ──────────────────────────────────────────────────────────────────
  return _NutritionistFabConfig(
    icon: AppIcons.nutritionMenu,
    semanticLabel: strings.fabNewPlan,
    onPressed: () => context.push(RouteNames.nutritionistPlanCreate),
  );
}

/// Shell del rol NUTRICIONISTA.
/// design-system.md §9: 4 tabs → Inicio | Clientes | Planes | Perfil
StatefulShellRoute buildNutritionistShell() {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      final strings = AppStrings.of(context);
      final fab = _nutritionistFabForRoute(state.uri.path, context);

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
      // ── Branch HOME ──────────────────────────────────────────────
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
      // ── Branch CLIENTS ───────────────────────────────────────────
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
                  final clientId = state.pathParameters['clientId']!;
                  return NutritionistClientDetailScreen(clientId: clientId);
                },
              ),
            ],
          ),
        ],
      ),
      // ── Branch PLANS ─────────────────────────────────────────────
      // Incluye todas las herramientas del planificador:
      // plans, foods, templates, days
      StatefulShellBranch(
        navigatorKey: _nutritionistPlansNavigatorKey,
        routes: [
          GoRoute(
            path: RouteNames.nutritionistPlans,
            name: RouteNames.nutritionistPlans,
            builder: (context, state) => const NutritionistPlansScreen(),
            routes: [
              GoRoute(
                path: 'create',
                name: RouteNames.nutritionistPlanCreate,
                builder: (context, state) => const NutritionistPlanFormScreen(),
              ),
              GoRoute(
                path: ':planId',
                name: RouteNames.nutritionistPlanEdit,
                builder: (context, state) {
                  final planId = state.pathParameters['planId']!;
                  return NutritionistPlanFormScreen(planId: planId);
                },
                routes: [
                  GoRoute(
                    path: 'days',
                    name: RouteNames.nutritionistPlanDays,
                    builder: (context, state) {
                      final planId = state.pathParameters['planId']!;
                      return NutritionistPlanDaysScreen(planId: planId);
                    },
                  ),
                ],
              ),
              // Alimentos como sub-ruta de plans
              GoRoute(
                path: 'foods',
                name: RouteNames.nutritionistFoods,
                builder: (context, state) => const FoodCatalogScreen(),
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
                      final foodId = state.pathParameters['foodId']!;
                      return FoodFormScreen(foodId: foodId);
                    },
                  ),
                ],
              ),
              // Plantillas como sub-ruta de plans
              GoRoute(
                path: 'templates',
                name: RouteNames.nutritionistTemplates,
                builder: (context, state) => const MealTemplateListScreen(),
                routes: [
                  GoRoute(
                    path: 'create',
                    name: RouteNames.nutritionistTemplateCreate,
                    builder: (context, state) => const MealTemplateFormScreen(),
                  ),
                  GoRoute(
                    path: ':templateId',
                    name: RouteNames.nutritionistTemplateEdit,
                    builder: (context, state) {
                      final templateId = state.pathParameters['templateId']!;
                      return MealTemplateFormScreen(templateId: templateId);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      // ── Branch PROFILE ───────────────────────────────────────────
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
