import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/clients/presentation/screens/client_add_screen.dart';
import '../../../features/clients/presentation/screens/client_detail_screen.dart';
import '../../../features/clients/presentation/screens/clients_list_screen.dart';
import '../../../features/gym/presentation/screens/staff_add_screen.dart';
import '../../../features/gym/presentation/screens/staff_list_screen.dart';
import '../../../features/home/presentation/screens/owner_home_screen.dart';
import '../../../features/memberships/presentation/screens/membership_plan_form_screen.dart';
import '../../../features/memberships/presentation/screens/membership_plans_screen.dart';
import '../../../features/payments/presentation/screens/payment_detail_screen.dart';
import '../../../features/payments/presentation/screens/payments_list_screen.dart';
import '../../../shared/widgets/pesao_bottom_nav.dart';
import '../../l10n/app_strings.dart';
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

/// Configuración del FAB para una ruta del owner.
class _OwnerFabConfig {
  final IconData icon;
  final String semanticLabel;
  final VoidCallback? onPressed;

  const _OwnerFabConfig({
    required this.icon,
    required this.semanticLabel,
    this.onPressed,
  });
}

/// Deriva el FAB según la ruta visible.
_OwnerFabConfig _ownerFabForRoute(String path, BuildContext context) {
  final strings = AppStrings.of(context);

  // Staff list: agregar staff.
  if (path == RouteNames.ownerStaff) {
    return _OwnerFabConfig(
      icon: Icons.person_add_rounded,
      semanticLabel: strings.fabAddStaff,
      onPressed: () => context.push(RouteNames.ownerStaffAdd),
    );
  }

  // Staff add: sin acción.
  if (path == RouteNames.ownerStaffAdd) {
    return _OwnerFabConfig(
      icon: AppIcons.add,
      semanticLabel: strings.fabAddClient,
      onPressed: null,
    );
  }

  // Clients list: agregar cliente.
  if (path == RouteNames.ownerClients) {
    return _OwnerFabConfig(
      icon: Icons.person_add_rounded,
      semanticLabel: strings.fabAddClient,
      onPressed: () => context.push(RouteNames.ownerClientAdd),
    );
  }

  // Client add: sin acción.
  if (path == RouteNames.ownerClientAdd) {
    return _OwnerFabConfig(
      icon: AppIcons.add,
      semanticLabel: strings.fabAddClient,
      onPressed: null,
    );
  }

  // Client detail: sin acción.
  if (path.startsWith('${RouteNames.ownerClients}/')) {
    return _OwnerFabConfig(
      icon: AppIcons.add,
      semanticLabel: strings.fabAddClient,
      onPressed: null,
    );
  }

  // Pagos: por ahora sin acción directa.
  if (path == RouteNames.ownerPayments) {
    return _OwnerFabConfig(
      icon: AppIcons.add,
      semanticLabel: strings.paymentsFabRegister,
      onPressed: null,
    );
  }

  // Detalle de pago: sin acción directa.
  if (path.startsWith('${RouteNames.ownerPayments}/')) {
    return _OwnerFabConfig(
      icon: AppIcons.add,
      semanticLabel: strings.paymentsFabRegister,
      onPressed: null,
    );
  }

  // Planes del gimnasio.
  if (path == RouteNames.ownerPlans) {
    return _OwnerFabConfig(
      icon: Icons.playlist_add_rounded,
      semanticLabel: strings.fabCreatePlan,
      onPressed: () => context.pushNamed(RouteNames.ownerPlanCreate),
    );
  }

  // Default: agregar cliente.
  return _OwnerFabConfig(
    icon: AppIcons.add,
    semanticLabel: strings.fabAddClient,
    onPressed: () {
      // Futuro: navegar a agregar cliente desde dashboard.
    },
  );
}

/// Shell del rol DUEÑO.
StatefulShellRoute buildOwnerShell() {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      final strings = AppStrings.of(context);
      final fab = _ownerFabForRoute(state.uri.path, context);

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
          GoRoute(
            path: RouteNames.ownerStaffAdd,
            name: RouteNames.ownerStaffAdd,
            builder: (context, state) => const StaffAddScreen(),
          ),
          GoRoute(
            path: RouteNames.ownerPlans,
            name: RouteNames.ownerPlans,
            builder: (context, state) => const MembershipPlansScreen(),
          ),
          GoRoute(
            path: RouteNames.ownerPlanCreate,
            name: RouteNames.ownerPlanCreate,
            builder: (context, state) => const MembershipPlanFormScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _ownerClientsNavigatorKey,
        routes: [
          GoRoute(
            path: RouteNames.ownerClients,
            name: RouteNames.ownerClients,
            builder: (context, state) => const ClientsListScreen(),
            routes: [
              GoRoute(
                path: 'add',
                name: RouteNames.ownerClientAdd,
                builder: (context, state) => const ClientAddScreen(),
              ),
              GoRoute(
                path: ':membershipId',
                name: RouteNames.ownerClientDetail,
                builder: (context, state) {
                  final membershipId = state.pathParameters['membershipId']!;
                  return ClientDetailScreen(membershipId: membershipId);
                },
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _ownerPaymentsNavigatorKey,
        routes: [
          GoRoute(
            path: RouteNames.ownerPayments,
            name: RouteNames.ownerPayments,
            builder: (context, state) => const PaymentsListScreen(),
            routes: [
              GoRoute(
                path: 'paymentId',
                name: RouteNames.ownerPaymentDetail,
                builder: (context, state) {
                  final paymentId = state.pathParameters['paymentId']!;
                  return PaymentDetailScreen(paymentId: paymentId);
                },
              ),
            ],
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
