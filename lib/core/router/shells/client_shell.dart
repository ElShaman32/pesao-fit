import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/home/presentation/screens/client_home_screen.dart';
import '../../../features/payments/presentation/screens/upload_payment_sheet.dart';
import '../../../shared/widgets/pesao_bottom_nav.dart';
import '../../l10n/app_strings.dart';
import '../../theme/app_icons.dart';
import '../route_names.dart';
import 'shell_scaffold.dart';

/// Claves estables para los navigators de cada tab del shell cliente.
final GlobalKey<NavigatorState> _clientHomeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'clientHome');
final GlobalKey<NavigatorState> _clientRoutineNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'clientRoutine');
final GlobalKey<NavigatorState> _clientNutritionNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'clientNutrition');
final GlobalKey<NavigatorState> _clientProfileNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'clientProfile');

/// Configuración del FAB para una ruta del cliente.
class _ClientFabConfig {
  final IconData icon;
  final String semanticLabel;
  final VoidCallback? onPressed;

  const _ClientFabConfig({
    required this.icon,
    required this.semanticLabel,
    this.onPressed,
  });
}

/// Deriva el FAB según la ruta visible.
_ClientFabConfig _clientFabForRoute(String path, BuildContext context) {
  final strings = AppStrings.of(context);

  // Dashboard del cliente: por ahora abre el sheet de subida de pago.
  // En F2, esto cambiará a "Registrar ejercicio".
  if (path == RouteNames.clientHome) {
    return _ClientFabConfig(
      icon: Icons.upload_file_rounded,
      semanticLabel: strings.clientDashUploadFab,
      onPressed: () async {
        await showUploadPaymentSheet(context);
      },
    );
  }

  // Rutina (futuro F2): registrar ejercicio.
  if (path == RouteNames.clientRoutine) {
    return _ClientFabConfig(
      icon: AppIcons.add,
      semanticLabel: strings.fabRegisterExercise,
      onPressed: () {
        // Futuro: abrir sheet de registro de ejercicio.
      },
    );
  }

  // Nutrición (futuro F3): registrar comida.
  if (path == RouteNames.clientNutrition) {
    return _ClientFabConfig(
      icon: AppIcons.add,
      semanticLabel: 'Registrar comida',
      onPressed: () {
        // Futuro: abrir sheet de registro de comida.
      },
    );
  }

  // Perfil: sin acción directa.
  if (path == RouteNames.clientProfile) {
    return _ClientFabConfig(
      icon: AppIcons.add,
      semanticLabel: strings.fabRegisterExercise,
      onPressed: null,
    );
  }

  // Default: registrar ejercicio.
  return _ClientFabConfig(
    icon: AppIcons.add,
    semanticLabel: strings.fabRegisterExercise,
    onPressed: null,
  );
}

/// Shell del rol CLIENTE.
StatefulShellRoute buildClientShell() {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      final strings = AppStrings.of(context);
      final fab = _clientFabForRoute(state.uri.path, context);

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
        fabIcon: fab.icon,
        fabSemanticLabel: fab.semanticLabel,
        onFabPressed: fab.onPressed ?? () {},
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
