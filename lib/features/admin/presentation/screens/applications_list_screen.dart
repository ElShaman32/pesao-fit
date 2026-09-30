import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_badge.dart';
import '../../../../shared/widgets/pesao_card.dart';
import '../../domain/entities/gym_application.dart';
import '../providers/applications_review_controller.dart';

/// Lista de solicitudes de gimnasio pendientes de revisión (ADR-036).
class ApplicationsListScreen extends ConsumerWidget {
  const ApplicationsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(applicationsReviewControllerProvider);
    final controller = ref.read(applicationsReviewControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const PesaoAppBar(title: 'Solicitudes'),
      body: RefreshIndicator(
        color: AppColors.primary,
        backgroundColor: AppColors.surface,
        onRefresh: controller.loadPending,
        child: _buildBody(context, state, controller),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    ApplicationsReviewState state,
    ApplicationsReviewController controller,
  ) {
    final l10n = AppStrings.of(context);

    // Loading: skeleton simple.
    if (state.isLoading) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppDimens.l),
        children: List.generate(
          3,
          (_) => const Padding(
            padding: EdgeInsets.only(bottom: AppDimens.m),
            child: _SkeletonCard(),
          ),
        ),
      );
    }

    // Error: estado de error con reintento.
    if (state.error != null) {
      return _CenterMessage(
        icon: Icons.error_outline,
        iconColor: AppColors.error,
        message: l10n.adminAppsError,
        actionLabel: 'Reintentar',
        onAction: controller.loadPending,
      );
    }

    // Empty: sin solicitudes pendientes.
    if (state.isEmpty) {
      return _CenterMessage(
        icon: Icons.inbox_rounded,
        iconColor: AppColors.textDisabled,
        message: l10n.adminAppsEmpty,
      );
    }

    // Success: lista de solicitudes.
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppDimens.l),
      itemCount: state.applications.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppDimens.m),
      itemBuilder: (context, index) {
        final application = state.applications[index];
        return _ApplicationCard(
          application: application,
          onTap: () => context.push('/admin/applications/${application.id}'),
        );
      },
    );
  }
}

/// Card resumen de una solicitud pendiente.
class _ApplicationCard extends StatelessWidget {
  const _ApplicationCard({required this.application, required this.onTap});

  final GymApplication application;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '${application.gymName}, ${application.locationLabel}',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: PesaoCard(
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.l),
            child: Row(
              children: [
                // Ícono del gimnasio.
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.fitness_center_rounded,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppDimens.m),

                // Nombre del gym + ubicación + dueño.
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        application.gymName,
                        style: AppTypography.title.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppDimens.xs),
                      Text(
                        application.locationLabel,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppDimens.xs),
                      Text(
                        application.ownerName,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textDisabled,
                        ),
                      ),
                    ],
                  ),
                ),

                // Badge pendiente + flecha.
                const PesaoBadge(
                  label: 'Pendiente',
                  variant: PesaoBadgeVariant.warning,
                ),
                const SizedBox(width: AppDimens.s),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.textSecondary,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Skeleton simple para el estado de carga.
class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppDimens.cardBorderRadius,
        border: Border.all(color: AppColors.outline),
      ),
    );
  }
}

/// Mensaje centrado reutilizable (empty / error).
class _CenterMessage extends StatelessWidget {
  const _CenterMessage({
    required this.icon,
    required this.iconColor,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final Color iconColor;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppDimens.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 48),
            const SizedBox(height: AppDimens.m),
            Text(
              message,
              style: AppTypography.body.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: AppDimens.l),
              TextButton(
                onPressed: onAction,
                child: Text(
                  actionLabel!,
                  style: AppTypography.label.copyWith(
                    color: AppColors.primaryText,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
