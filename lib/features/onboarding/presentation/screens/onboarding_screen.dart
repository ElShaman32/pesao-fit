import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pesao_card.dart';

/// Pantalla de selección de rol (ADR-035, Opción B: rol ANTES del registro).
///
/// Es el punto de entrada público. Dos caminos:
/// - Sin sesión: lleva al registro pasando el rol como query param.
/// - Con sesión (registrado pero sin completar onboarding): lleva directo
///   al flujo del rol, sin re-registrar.
class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppStrings.of(context);
    final isLoggedIn = authProvider.isLoggedIn;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),

              // Logo
              Text(
                'PESAO',
                textAlign: TextAlign.center,
                style: AppTypography.display.copyWith(
                  color: AppColors.primary,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: AppDimens.m),

              // Título
              Text(
                l10n.onboardingTitle,
                textAlign: TextAlign.center,
                style: AppTypography.title.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimens.xs),

              // Subtítulo
              Text(
                l10n.onboardingSubtitle,
                textAlign: TextAlign.center,
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppDimens.xxxl),

              // Card: Soy dueño
              _RoleCard(
                icon: Icons.business_outlined,
                title: l10n.onboardingOwnerTitle,
                description: l10n.onboardingOwnerDescription,
                onTap: () => _selectRole(context, isLoggedIn, 'owner'),
              ),
              const SizedBox(height: AppDimens.m),

              // Card: Soy cliente
              _RoleCard(
                icon: Icons.fitness_center_outlined,
                title: l10n.onboardingClientTitle,
                description: l10n.onboardingClientDescription,
                onTap: () => _selectRole(context, isLoggedIn, 'client'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Navega según el estado de sesión y el rol elegido.
  void _selectRole(BuildContext context, bool isLoggedIn, String role) {
    if (isLoggedIn) {
      // Ya se registró antes; solo debe completar el flujo de su rol.
      if (role == 'owner') {
        context.go(RouteNames.ownerApplication);
      } else {
        context.go(RouteNames.gymDiscovery);
      }
    } else {
      // Usuario nuevo: primero el registro, llevando el rol como contexto.
      context.go('${RouteNames.register}?role=$role');
    }
  }
}

/// Card de selección de rol con ícono, título y descripción.
class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '$title. $description',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: PesaoCard(
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.l),
            child: Row(
              children: [
                // Ícono circular
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 28),
                ),
                const SizedBox(width: AppDimens.m),

                // Texto
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTypography.title.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppDimens.xs),
                      Text(
                        description,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Flecha
                const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.textSecondary,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
