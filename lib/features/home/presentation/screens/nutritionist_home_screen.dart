import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/providers/connectivity_provider.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/offline_banner.dart';
import '../../../../shared/widgets/pesao_avatar.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_card.dart';
import '../../../../shared/widgets/pesao_icon_button.dart';
import '../../../../shared/widgets/pesao_stat_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/widgets/skeleton_loader.dart';
import '../../domain/entities/nutritionist_dashboard_stats.dart';
import '../providers/nutritionist_dashboard_controller.dart';

/// Dashboard del nutricionista (tab Inicio del shell).
///
/// design-system.md §10: avatar+saludo, 3 StatCards (planes/clientes/consultas),
/// PrimaryCard "Planes por revisar", sección "Últimos planes".
class NutritionistHomeScreen extends ConsumerWidget {
  const NutritionistHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppStrings.of(context);
    final state = ref.watch(nutritionistDashboardControllerProvider);
    final controller = ref.read(
      nutritionistDashboardControllerProvider.notifier,
    );
    final connectivityAsync = ref.watch(connectivityProvider);
    final isOnline = connectivityAsync.value ?? true;
    final greeting = _greetingForHour(l10n);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: AppColors.surface,
          onRefresh: controller.load,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // Fila superior: avatar + saludo + campana.
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppDimens.l,
                    AppDimens.l,
                    AppDimens.l,
                    0,
                  ),
                  child: Row(
                    children: [
                      PesaoAvatar(
                        name: authProvider.userFullName ?? 'Nutricionista',
                        imageUrl: authProvider.avatarUrl,
                        size: 44,
                      ),
                      const SizedBox(width: AppDimens.m),
                      Expanded(
                        child: Text(
                          greeting,
                          style: AppTypography.title.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      PesaoIconButton(
                        icon: AppIcons.notificationsOutline,
                        semanticLabel: l10n.notificationsLabel,
                        onPressed: () {
                          // Placeholder: notificaciones en F4.
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // OfflineBanner.
              if (!isOnline)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(AppDimens.l),
                    child: OfflineBanner(),
                  ),
                ),

              // Contenido según estado.
              if (state.isLoading && state.stats == null)
                const _NutriSkeletonSliver()
              else if (state.error != null && state.stats == null)
                SliverFillRemaining(
                  child: ErrorState(
                    title: l10n.nutriDashErrorTitle,
                    body: l10n.nutriDashErrorBody,
                    actionLabel: l10n.commonRetry,
                    onRetry: controller.load,
                  ),
                )
              else if (state.hasData)
                _NutriSuccessSliver(stats: state.stats!),
            ],
          ),
        ),
      ),
    );
  }

  String _greetingForHour(AppStrings l10n) {
    final hour = DateTime.now().hour;
    final name = authProvider.userFullName ?? 'doc';
    if (hour < 12) return l10n.greetingMorning(name);
    if (hour < 19) return l10n.greetingAfternoon(name);
    return l10n.greetingNight(name);
  }
}

// ============================================================================
// SKELETON
// ============================================================================

class _NutriSkeletonSliver extends StatelessWidget {
  const _NutriSkeletonSliver();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: SkeletonLoader(
        child: Padding(
          padding: EdgeInsets.all(AppDimens.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(child: SkeletonBox(height: 110)),
                  SizedBox(width: AppDimens.s),
                  Expanded(child: SkeletonBox(height: 110)),
                  SizedBox(width: AppDimens.s),
                  Expanded(child: SkeletonBox(height: 110)),
                ],
              ),
              SizedBox(height: AppDimens.xl),
              SkeletonBox(height: 160),
              SizedBox(height: AppDimens.xl),
              SkeletonBox(height: 24),
              SizedBox(height: AppDimens.m),
              SkeletonBox(height: 72),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// SUCCESS
// ============================================================================

class _NutriSuccessSliver extends StatelessWidget {
  const _NutriSuccessSliver({required this.stats});
  final NutritionistDashboardStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return SliverPadding(
      padding: const EdgeInsets.all(AppDimens.l),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          // StatCards tappables.
          Row(
            children: [
              Expanded(
                child: PesaoStatCard(
                  label: l10n.nutriDashStatPlans,
                  value: stats.activePlansCount.toString(),
                  sub: l10n.nutriDashStatPlansSub,
                  // TODO: promover a AppIcons.nutritionMenu.
                  icon: Icons.restaurant_menu_rounded,
                  onTap: () => context.go(RouteNames.nutritionistPlans),
                ),
              ),
              const SizedBox(width: AppDimens.s),
              Expanded(
                child: PesaoStatCard(
                  label: l10n.nutriDashStatClients,
                  value: stats.clientsWithPlanCount.toString(),
                  sub: l10n.nutriDashStatClientsSub,
                  icon: AppIcons.clients,
                  onTap: () => context.go(RouteNames.nutritionistClients),
                ),
              ),
              const SizedBox(width: AppDimens.s),
              Expanded(
                child: PesaoStatCard(
                  label: l10n.nutriDashStatConsults,
                  value: stats.consultsTodayCount.toString(),
                  sub: l10n.nutriDashStatConsultsSub,
                  icon: AppIcons.calendar,
                  // Sin onTap: no hay pantalla de consultas aún.
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.xl),

          // PrimaryCard.
          _NutriPrimaryCard(stats: stats),
          const SizedBox(height: AppDimens.xl),

          // Últimos planes.
          SectionHeader(
            title: l10n.nutriDashRecentSection,
            onSeeAll: () {
              // Futuro: vista completa de planes (F3).
            },
          ),
          const SizedBox(height: AppDimens.m),
          if (stats.recentPlans.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppDimens.m),
              child: Text(
                l10n.nutriDashRecentEmpty,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          const SizedBox(height: AppDimens.xxl),
        ]),
      ),
    );
  }
}

// ============================================================================
// PRIMARY CARD
// ============================================================================

class _NutriPrimaryCard extends StatelessWidget {
  const _NutriPrimaryCard({required this.stats});
  final NutritionistDashboardStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final hasPlans = stats.hasPlansToReview;

    return PesaoCard(
      glow: hasPlans,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                hasPlans
                    // TODO: promover a AppIcons.nutritionMenu.
                    ? Icons.restaurant_menu_rounded
                    : AppIcons.success,
                color: hasPlans ? AppColors.primary : AppColors.success,
                size: 24,
              ),
              const SizedBox(width: AppDimens.s),
              Expanded(
                child: Text(
                  l10n.nutriDashPrimaryTitle,
                  style: AppTypography.title.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.m),
          Text(
            hasPlans
                ? l10n.nutriDashPrimaryBody(stats.activePlansCount)
                : l10n.nutriDashPrimaryCtaNone,
            style: AppTypography.body.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppDimens.m),
          Align(
            alignment: Alignment.centerRight,
            child: PesaoButton(
              label: hasPlans
                  ? l10n.nutriDashPrimaryCta
                  : l10n.nutriDashPrimaryCtaNone,
              variant: hasPlans
                  ? PesaoButtonVariant.primary
                  : PesaoButtonVariant.secondary,
              isExpanded: false,
              onPressed: hasPlans
                  ? () {
                      // Futuro: navegar a planes (F3).
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
