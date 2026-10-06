import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pesao_toast.dart';

/// Pantalla de selección de rol (Dueño/Cliente/Trabajador).
///
/// Muestra 3 tarjetas flotantes con estilo "Dark Athletic Luxe".
/// Cada tarjeta navega al flujo de registro correspondiente.
class RoleSelectorScreen extends StatelessWidget {
  const RoleSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),

              // Título.
              Text(
                l10n.roleSelectorTitle,
                textAlign: TextAlign.center,
                style: AppTypography.headline.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),

              // Subtítulo.
              Text(
                l10n.roleSelectorSubtitle,
                textAlign: TextAlign.center,
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),

              // Card 1: Dueño de gimnasio.
              _RoleCard(
                icon: Icons.business,
                title: l10n.roleOwnerTitle,
                description: l10n.roleOwnerDescription,
                ctaLabel: l10n.roleOwnerCta,
                onTap: () => context.push('${RouteNames.register}?role=owner'),
              ),
              const SizedBox(height: 16),

              // Card 2: Cliente de gimnasio.
              _RoleCard(
                icon: Icons.fitness_center,
                title: l10n.roleClientTitle,
                description: l10n.roleClientDescription,
                ctaLabel: l10n.roleClientCta,
                onTap: () => context.push('${RouteNames.register}?role=client'),
              ),
              const SizedBox(height: 16),

              // Card 3: Trabajador (entrenador/nutricionista).
              _RoleCard(
                icon: Icons.sports_martial_arts,
                title: l10n.roleStaffTitle,
                description: l10n.roleStaffDescription,
                ctaLabel: l10n.roleStaffCta,
                onTap: () {
                  showPesaoToast(
                    context,
                    message: l10n.roleStaffToast,
                    semanticLabel: l10n.roleStaffToastSemantics,
                    variant: PesaoToastVariant.brand,
                  );
                },
              ),
              const SizedBox(height: 24),

              // Link a login para usuarios existentes.
              Center(
                child: TextButton(
                  onPressed: () => context.go(RouteNames.login),
                  child: Text(
                    'Ya tengo cuenta',
                    style: AppTypography.body.copyWith(
                      color: AppColors.primaryText,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

/// Card flotante con estilo "Dark Athletic Luxe".
class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String ctaLabel;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.ctaLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.outline, width: 1),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ícono.
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 28),
            ),
            const SizedBox(height: 16),

            // Título.
            Text(
              title,
              style: AppTypography.title.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(height: 8),

            // Descripción.
            Text(
              description,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),

            // CTA.
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                ctaLabel,
                style: AppTypography.label.copyWith(color: AppColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
