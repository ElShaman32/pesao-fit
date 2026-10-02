import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/home/presentation/screens/trainer_home_screen.dart';
import '../../../features/routines/presentation/screens/exercise_form_screen.dart';
import '../../../features/routines/presentation/screens/exercises_list_screen.dart';
import '../../../features/routines/presentation/screens/plan_week_editor_screen.dart';
import '../../../features/routines/presentation/screens/routine_form_screen.dart';
import '../../../features/routines/presentation/screens/routines_list_screen.dart';
import '../../../features/routines/presentation/screens/training_plan_form_screen.dart';
import '../../../features/routines/presentation/screens/training_plans_list_screen.dart';
import '../../../shared/widgets/pesao_bottom_nav.dart';
import '../../l10n/app_strings.dart';
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

/// Configuración del FAB para una ruta del entrenador.
class _TrainerFabConfig {
  final IconData icon;
  final String semanticLabel;
  final VoidCallback? onPressed;

  const _TrainerFabConfig({
    required this.icon,
    required this.semanticLabel,
    this.onPressed,
  });
}

/// Deriva el FAB según la ruta visible.
_TrainerFabConfig _trainerFabForRoute(String path, BuildContext context) {
  final strings = AppStrings.of(context);

  // Lista de planes (tab Rutinas): nuevo plan.
  if (path == RouteNames.trainerRoutines) {
    return _TrainerFabConfig(
      icon: Icons.add_rounded,
      semanticLabel: strings.fabCreatePlan,
      onPressed: () => context.push(RouteNames.trainerPlanForm),
    );
  }

  // Crear/editar plan: sin acción.
  if (path == RouteNames.trainerPlanForm ||
      path.startsWith('${RouteNames.trainerRoutines}/plan/')) {
    return _TrainerFabConfig(
      icon: Icons.add_rounded,
      semanticLabel: strings.fabCreatePlan,
      onPressed: null,
    );
  }

  // Plantillas de rutina: nueva rutina.
  if (path == RouteNames.trainerRoutineTemplates) {
    return _TrainerFabConfig(
      icon: Icons.add_rounded,
      semanticLabel: strings.fabCreateRoutine,
      onPressed: () => context.push(RouteNames.trainerRoutineCreate),
    );
  }
  // Default: nueva rutina.
  return _TrainerFabConfig(
    icon: Icons.add_rounded,
    semanticLabel: strings.fabCreateRoutine,
    onPressed: null,
  );
}

/// Shell del rol ENTRENADOR.
StatefulShellRoute buildTrainerShell() {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      final strings = AppStrings.of(context);
      final fab = _trainerFabForRoute(state.uri.path, context);

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
          PesaoBottomNavItem(icon: AppIcons.routine, label: strings.tabRoutine),
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
            builder: (context, state) => const TrainingPlansListScreen(),
            routes: [
              GoRoute(
                path: 'plan-create',
                name: RouteNames.trainerPlanForm,
                builder: (context, state) => const TrainingPlanFormScreen(),
              ),
              GoRoute(
                path: 'plan/:planId',
                name: RouteNames.trainerPlanEdit,
                builder: (context, state) {
                  final planId = state.pathParameters['planId']!;
                  return PlanWeekEditorScreen(planId: planId);
                },
              ),
              GoRoute(
                path: 'templates',
                name: RouteNames.trainerRoutineTemplates,
                builder: (context, state) => const RoutinesListScreen(),
                routes: [
                  GoRoute(
                    path: 'create',
                    name: RouteNames.trainerRoutineCreate,
                    builder: (context, state) => const RoutineFormScreen(),
                  ),
                  GoRoute(
                    path: ':routineId',
                    name: RouteNames.trainerRoutineEdit,
                    builder: (context, state) {
                      final routineId = state.pathParameters['routineId']!;
                      return RoutineFormScreen(routineId: routineId);
                    },
                  ),
                ],
              ),
            ],
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
          GoRoute(
            path: RouteNames.trainerExercises,
            name: RouteNames.trainerExercises,
            builder: (context, state) => const ExercisesListScreen(),
            routes: [
              GoRoute(
                path: 'create',
                name: RouteNames.trainerExerciseCreate,
                builder: (context, state) => const ExerciseFormScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
