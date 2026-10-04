import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_badge.dart';
import '../../../../shared/widgets/pesao_card.dart';
import '../../../../shared/widgets/skeleton_loader.dart';
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
      appBar: const PesaoAppBar(
        title: 'Solicitudes',
      ), // TODO: mover a AppStrings.
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

    // Loading: skeleton.
    if (state.isLoading) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppDimens.l),
        children: const [
          SkeletonLoader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SkeletonBox(height: 88),
                SizedBox(height: AppDimens.m),
                SkeletonBox(height: 88),
                SizedBox(height: AppDimens.m),
                SkeletonBox(height: 88),
              ],
            ),
          ),
        ],
      );
    }

    // Error.
    if (state.error != null) {
      return ErrorState(
        title: l10n.adminAppsError,
        onRetry: controller.loadPending,
      );
    }

    // Empty.
    if (state.isEmpty) {
      return EmptyState(
        icon: Icons.inbox_rounded, // TODO: promover a AppIcons.
        body: l10n.adminAppsEmpty,
      );
    }

    // Success.
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

// ============================================================================
// APPLICATION CARD
// ============================================================================

class _ApplicationCard extends StatelessWidget {
  const _ApplicationCard({required this.application, required this.onTap});

  final GymApplication application;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '${application.gymName}, ${application.locationLabel}',
      child: PesaoCard(
        onTap: onTap,
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
                AppIcons.gyms,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: AppDimens.m),

            // Nombre + ubicación + dueño.
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

            // Badge + flecha.
            const PesaoBadge(
              label: 'Pendiente',
              variant: PesaoBadgeVariant.warning,
            ),
            const SizedBox(width: AppDimens.s),
            const Icon(
              AppIcons.chevronRight,
              color: AppColors.textSecondary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
