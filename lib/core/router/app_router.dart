import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/admin/presentation/screens/application_detail_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/onboarding/presentation/screens/application_pending_screen.dart';
import '../../features/onboarding/presentation/screens/gym_discovery_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/onboarding/presentation/screens/owner_application_screen.dart';
import '../../features/onboarding/presentation/screens/role_selector_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../providers/auth_provider.dart';
import '../theme/app_colors.dart';
import 'route_names.dart';
import 'shells/admin_shell.dart';
import 'shells/client_shell.dart';
import 'shells/nutritionist_shell.dart';
import 'shells/owner_shell.dart';
import 'shells/trainer_shell.dart';

/// Devuelve la ruta de inicio según el rol del usuario.
String _homeForRole(UserRole? role) {
  switch (role) {
    case UserRole.client:
      return RouteNames.clientHome;
    case UserRole.trainer:
      return RouteNames.trainerHome;
    case UserRole.owner:
      return RouteNames.ownerHome;
    case UserRole.nutritionist:
      return RouteNames.nutritionistHome;
    case UserRole.admin:
      return RouteNames.adminHome;
    case null:
      return RouteNames.roleSelector;
  }
}

/// GoRouter principal con redirect basado en autenticación.
///
/// Usa [refreshListenable] para que el router re-evalúe el redirect
/// cada vez que [authProvider] notifica cambios (login/logout).
final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.splash,
  debugLogDiagnostics: true,
  refreshListenable: authProvider,
  redirect: (context, state) {
    final isLoggedIn = authProvider.isLoggedIn;
    final currentPath = state.uri.path;

    // 🛡️ SPLASH: NO REDIRIGIR. El splash maneja su propia navegación.
    if (currentPath == RouteNames.splash) return null;

    // Rutas públicas (sin auth).
    const publicRoutes = [
      RouteNames.onboarding,
      RouteNames.roleSelector,
      RouteNames.terms,
      RouteNames.login,
      RouteNames.register,
      RouteNames.forgotPassword,
    ];

    // Rutas del flujo de onboarding (para logueados sin rol aún).
    const onboardingFlowRoutes = [
      RouteNames.onboarding,
      RouteNames.roleSelector,
      RouteNames.ownerApplication,
      RouteNames.gymDiscovery,
      RouteNames.applicationPending,
    ];

    // NO LOGUEADO.
    if (!isLoggedIn) {
      if (publicRoutes.contains(currentPath)) return null;
      return RouteNames.roleSelector;
    }

    // LOGUEADO SIN ROL (registrado pero sin completar onboarding).
    if (authProvider.needsOnboarding) {
      if (onboardingFlowRoutes.contains(currentPath)) return null;
      if (currentPath == RouteNames.terms) return null;
      return RouteNames.roleSelector;
    }

    // LOGUEADO CON ROL: si está en ruta pública o de onboarding, ir a su shell.
    if (publicRoutes.contains(currentPath) ||
        onboardingFlowRoutes.contains(currentPath)) {
      return _homeForRole(authProvider.userRole);
    }

    return null;
  },
  routes: [
    // --- Rutas públicas (sin auth) ---
    GoRoute(
      path: RouteNames.splash,
      name: RouteNames.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RouteNames.onboarding,
      name: RouteNames.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: RouteNames.roleSelector,
      name: RouteNames.roleSelector,
      builder: (context, state) => const RoleSelectorScreen(),
    ),
    GoRoute(
      path: RouteNames.applicationPending,
      name: RouteNames.applicationPending,
      builder: (context, state) => const ApplicationPendingScreen(),
    ),
    GoRoute(
      path: RouteNames.ownerApplication,
      name: RouteNames.ownerApplication,
      builder: (context, state) => const OwnerApplicationScreen(),
    ),
    GoRoute(
      path: RouteNames.terms,
      name: RouteNames.terms,
      builder: (context, state) =>
          const _PlaceholderScreen(title: 'Términos', subtitle: 'FASE 1'),
    ),
    GoRoute(
      path: RouteNames.login,
      name: RouteNames.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RouteNames.register,
      name: RouteNames.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: RouteNames.forgotPassword,
      name: RouteNames.forgotPassword,
      builder: (context, state) => const _PlaceholderScreen(
        title: 'Recuperar contraseña',
        subtitle: 'FASE 1',
      ),
    ),
    GoRoute(
      path: RouteNames.gymDiscovery,
      name: RouteNames.gymDiscovery,
      builder: (context, state) => const GymDiscoveryScreen(),
    ),
    GoRoute(
      path: RouteNames.gymDetail,
      name: RouteNames.gymDetail,
      builder: (context, state) {
        final gymId = state.pathParameters['gymId']!;
        return _PlaceholderScreen(
          title: 'Detalle gimnasio',
          subtitle: 'ID: $gymId (FASE 1)',
        );
      },
    ),

    // --- Shells autenticados (por rol) ---
    buildClientShell(),
    buildTrainerShell(),
    buildOwnerShell(),
    buildNutritionistShell(),
    buildAdminShell(),

    // --- Panel superadmin: revisión de solicitudes KYC ---
    GoRoute(
      path: '/admin/applications/:appId',
      builder: (context, state) {
        final appId = state.pathParameters['appId']!;
        return ApplicationDetailScreen(applicationId: appId);
      },
    ),
  ],
);

/// Placeholder temporal hasta que se construya la pantalla real.
class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.title, required this.subtitle});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
