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
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/offline_banner.dart';
import '../../../../shared/widgets/pesao_avatar.dart';
import '../../../../shared/widgets/pesao_badge.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_card.dart';
import '../../../../shared/widgets/pesao_icon_button.dart';
import '../../../../shared/widgets/pesao_list_tile.dart';
import '../../../../shared/widgets/pesao_stat_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/widgets/skeleton_loader.dart';
import '../../domain/entities/admin_dashboard_stats.dart';
import '../providers/admin_dashboard_controller.dart';

/// Dashboard del superadmin (tab Inicio del shell).
///
/// Mismo esqueleto canónico que las demás homes de rol.
class AdminHomeScreen extends ConsumerWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppStrings.of(context);
    final state = ref.watch(adminDashboardControllerProvider);
    final controller = ref.read(adminDashboardControllerProvider.notifier);

    final connectivity = ref.watch(connectivityProvider);
    final isOnline = connectivity.value ?? true;

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
                        name: authProvider.userFullName ?? 'Admin',
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
                          // Placeholder: notificaciones llegan en F4 Monetización.
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
                const _AdminSkeletonSliver()
              else if (state.error != null && state.stats == null)
                SliverFillRemaining(
                  child: ErrorState(
                    title: l10n.adminDashErrorTitle,
                    body: l10n.adminDashErrorBody,
                    actionLabel: l10n.commonRetry,
                    onRetry: controller.load,
                  ),
                )
              else if (state.isEmpty)
                SliverFillRemaining(
                  child: EmptyState(
                    icon: Icons.dashboard_outlined,
                    title: l10n.adminDashEmptyTitle,
                    body: l10n.adminDashEmptyBody,
                  ),
                )
              else if (state.hasData)
                _AdminSuccessSliver(stats: state.stats!),
            ],
          ),
        ),
      ),
    );
  }

  String _greetingForHour(AppStrings l10n) {
    final hour = DateTime.now().hour;
    final name = authProvider.userFullName ?? 'Admin';
    if (hour < 12) return l10n.greetingMorning(name);
    if (hour < 19) return l10n.greetingAfternoon(name);
    return l10n.greetingNight(name);
  }
}

// ============================================================================
// SKELETON
// ============================================================================

class _AdminSkeletonSliver extends StatelessWidget {
  const _AdminSkeletonSliver();

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
              SkeletonBox(height: 180),
              SizedBox(height: AppDimens.xl),
              SkeletonBox(height: 24),
              SizedBox(height: AppDimens.m),
              SkeletonBox(height: 72),
              SizedBox(height: AppDimens.s),
              SkeletonBox(height: 72),
              SizedBox(height: AppDimens.s),
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

class _AdminSuccessSliver extends StatelessWidget {
  const _AdminSuccessSliver({required this.stats});

  final AdminDashboardStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return SliverPadding(
      padding: const EdgeInsets.all(AppDimens.l),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          _StatsRow(stats: stats),
          const SizedBox(height: AppDimens.xl),
          _AdminPrimaryCard(stats: stats),
          const SizedBox(height: AppDimens.xl),
          SectionHeader(
            title: l10n.adminDashRecentSection,
            onSeeAll: () {
              // Futuro: navega a vista de todos los gimnasios (F1 Avanzado).
            },
          ),
          const SizedBox(height: AppDimens.m),
          if (stats.recentlyApprovedGyms.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppDimens.m),
              child: Text(
                l10n.adminDashRecentEmpty,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            )
          else
            ...stats.recentlyApprovedGyms.map(
              (gym) => Padding(
                padding: const EdgeInsets.only(bottom: AppDimens.s),
                child: _RecentGymTile(gym: gym),
              ),
            ),
          const SizedBox(height: AppDimens.xxl),
        ]),
      ),
    );
  }
}

// ============================================================================
// STATS ROW
// ============================================================================

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.stats});

  final AdminDashboardStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return Row(
      children: [
        Expanded(
          child: PesaoStatCard(
            label: l10n.adminDashStatGyms,
            value: stats.activeGymsCount.toString(),
            sub: l10n.adminDashStatGymsSub,
            icon: AppIcons.gyms,
            onTap: () => context.go(RouteNames.adminGyms),
          ),
        ),
        const SizedBox(width: AppDimens.s),
        Expanded(
          child: PesaoStatCard(
            label: l10n.adminDashStatPending,
            value: stats.pendingApplicationsCount.toString(),
            sub: l10n.adminDashStatPendingSub,
            icon: Icons.hourglass_top_rounded, // TODO: promover a AppIcons.
            footer: stats.hasPending
                ? const PesaoBadge(
                    label: 'Revisar',
                    variant: PesaoBadgeVariant.warning,
                  )
                : null,
            onTap: () => context.go(RouteNames.adminGyms),
          ),
        ),
        const SizedBox(width: AppDimens.s),
        Expanded(
          child: PesaoStatCard(
            label: l10n.adminDashStatSubs,
            value: stats.activeSubscriptionsCount.toString(),
            sub: l10n.adminDashStatSubsSub,
            icon: Icons.card_membership_rounded, // TODO: promover a AppIcons.
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// PRIMARY CARD
// ============================================================================

class _AdminPrimaryCard extends StatelessWidget {
  const _AdminPrimaryCard({required this.stats});

  final AdminDashboardStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final hasPending = stats.hasPending;

    return PesaoCard(
      glow: hasPending,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                hasPending
                    ? Icons
                          .pending_actions_rounded // TODO: promover a AppIcons.
                    : AppIcons.success,
                color: hasPending ? AppColors.primary : AppColors.success,
                size: 24,
              ),
              const SizedBox(width: AppDimens.s),
              Expanded(
                child: Text(
                  l10n.adminDashPrimaryTitle,
                  style: AppTypography.title.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.m),
          Text(
            hasPending
                ? l10n.adminDashPrimaryBody(stats.pendingApplicationsCount)
                : l10n.adminDashPrimaryCtaNone,
            style: AppTypography.body.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppDimens.m),
          Align(
            alignment: Alignment.centerRight,
            child: PesaoButton(
              label: hasPending
                  ? l10n.adminDashPrimaryCta
                  : l10n.adminDashPrimaryCtaNone,
              variant: hasPending
                  ? PesaoButtonVariant.primary
                  : PesaoButtonVariant.secondary,
              isExpanded: false,
              onPressed: hasPending
                  ? () => context.go(RouteNames.adminGyms)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// RECENT GYM TILE
// ============================================================================

class _RecentGymTile extends StatelessWidget {
  const _RecentGymTile({required this.gym});

  final RecentGym gym;

  @override
  Widget build(BuildContext context) {
    return PesaoListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.success.withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        child: const Icon(AppIcons.success, color: AppColors.success, size: 20),
      ),
      title: gym.name,
      subtitle: gym.locationLabel,
    );
  }
}
