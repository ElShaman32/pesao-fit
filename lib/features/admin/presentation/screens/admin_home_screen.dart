import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/providers/connectivity_provider.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/offline_banner.dart';
import '../../../../shared/widgets/pesao_avatar.dart';
import '../../../../shared/widgets/pesao_badge.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_list_tile.dart';
import '../../../../shared/widgets/pesao_stat_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../domain/entities/admin_dashboard_stats.dart';
import '../providers/admin_dashboard_controller.dart';

/// Dashboard del superadmin (tab Inicio del shell).
///
/// Sigue design-system.md §10: AppBar con avatar + saludo,
/// fila de StatCards, PrimaryCard con CTA, y sección secundaria.
class AdminHomeScreen extends ConsumerWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppStrings.of(context);
    final state = ref.watch(adminDashboardControllerProvider);
    final controller = ref.read(adminDashboardControllerProvider.notifier);

    // connectivityProvider puede ser AsyncValue<bool>; resolvemos con fallback online.
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
              // === AppBar con avatar + saludo ===
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
                        name: authProvider.userFullName ?? 'Leonel',
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
                      IconButton(
                        icon: const Icon(
                          Icons.notifications_outlined,
                          color: AppColors.textSecondary,
                        ),
                        tooltip: l10n.notificationsLabel,
                        onPressed: () {
                          // Placeholder: notificaciones llegan en F4 Monetización.
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // === OfflineBanner (condicional) ===
              if (!isOnline)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(AppDimens.l),
                    child: OfflineBanner(),
                  ),
                ),

              // === Contenido principal según estado ===
              if (state.isLoading && state.stats == null)
                const _SkeletonSliver()
              else if (state.error != null && state.stats == null)
                _ErrorSliver(
                  title: l10n.adminDashErrorTitle,
                  body: l10n.adminDashErrorBody,
                  onRetry: controller.load,
                )
              else if (state.isEmpty)
                _EmptySliver(
                  title: l10n.adminDashEmptyTitle,
                  body: l10n.adminDashEmptyBody,
                )
              else if (state.hasData)
                _SuccessSliver(stats: state.stats!),
            ],
          ),
        ),
      ),
    );
  }

  /// Saludo por hora del día (mañana / tarde / noche).
  String _greetingForHour(AppStrings l10n) {
    final hour = DateTime.now().hour;
    final name = authProvider.userFullName ?? 'Leonel';
    if (hour < 12) return l10n.greetingMorning(name);
    if (hour < 19) return l10n.greetingAfternoon(name);
    return l10n.greetingNight(name);
  }
}

/// Sliver con skeleton que replica el layout real del dashboard.
/// Implementado con Container inline porque SkeletonLoader del kit
/// no acepta height directo.
class _SkeletonSliver extends StatelessWidget {
  const _SkeletonSliver();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(AppDimens.l),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          // Fila de 3 StatCards skeleton.
          const Row(
            children: [
              Expanded(child: _SkeletonBox(height: 110)),
              SizedBox(width: AppDimens.s),
              Expanded(child: _SkeletonBox(height: 110)),
              SizedBox(width: AppDimens.s),
              Expanded(child: _SkeletonBox(height: 110)),
            ],
          ),
          const SizedBox(height: AppDimens.xl),

          // PrimaryCard skeleton.
          const _SkeletonBox(height: 180),
          const SizedBox(height: AppDimens.xl),

          // SectionHeader skeleton.
          const _SkeletonBox(height: 24),
          const SizedBox(height: AppDimens.m),

          // Tiles de recientes skeleton.
          const _SkeletonBox(height: 72),
          const SizedBox(height: AppDimens.s),
          const _SkeletonBox(height: 72),
          const SizedBox(height: AppDimens.s),
          const _SkeletonBox(height: 72),
        ]),
      ),
    );
  }
}

/// Caja skeleton simple con shimmer estático (sin BackdropFilter, ADR-026).
class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppDimens.cardBorderRadius,
        border: Border.all(color: AppColors.outline),
      ),
    );
  }
}

/// Sliver de error con reintento.
class _ErrorSliver extends StatelessWidget {
  const _ErrorSliver({
    required this.title,
    required this.body,
    required this.onRetry,
  });

  final String title;
  final String body;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.xxl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: AppColors.error, size: 48),
              const SizedBox(height: AppDimens.m),
              Text(
                title,
                style: AppTypography.title.copyWith(
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimens.s),
              Text(
                body,
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimens.l),
              PesaoButton(
                label: AppStrings.of(context).commonRetry,
                isExpanded: false,
                onPressed: onRetry,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Sliver de estado vacío (cuando no hay datos en absoluto).
class _EmptySliver extends StatelessWidget {
  const _EmptySliver({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.xxl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.dashboard_outlined,
                color: AppColors.textDisabled,
                size: 48,
              ),
              const SizedBox(height: AppDimens.m),
              Text(
                title,
                style: AppTypography.title.copyWith(
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimens.s),
              Text(
                body,
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Sliver de éxito: StatCards + PrimaryCard + lista de recientes.
class _SuccessSliver extends StatelessWidget {
  const _SuccessSliver({required this.stats});

  final AdminDashboardStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return SliverPadding(
      padding: const EdgeInsets.all(AppDimens.l),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          // === Fila de StatCards ===
          _StatsRow(stats: stats),
          const SizedBox(height: AppDimens.xl),

          // === PrimaryCard con glow ===
          _PrimaryCard(stats: stats),
          const SizedBox(height: AppDimens.xl),

          // === Sección secundaria: últimos aprobados ===
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

/// Fila de 3 StatCards. value es String (formato del kit).
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
            icon: Icons.fitness_center_rounded,
          ),
        ),
        const SizedBox(width: AppDimens.s),
        Expanded(
          child: PesaoStatCard(
            label: l10n.adminDashStatPending,
            value: stats.pendingApplicationsCount.toString(),
            sub: l10n.adminDashStatPendingSub,
            icon: Icons.hourglass_top_rounded,
            // Resaltar con un badge si hay pendientes (usa footer del kit).
            footer: stats.hasPending
                ? const PesaoBadge(
                    label: 'Revisar',
                    variant: PesaoBadgeVariant.warning,
                  )
                : null,
          ),
        ),
        const SizedBox(width: AppDimens.s),
        Expanded(
          child: PesaoStatCard(
            label: l10n.adminDashStatSubs,
            value: stats.activeSubscriptionsCount.toString(),
            sub: l10n.adminDashStatSubsSub,
            icon: Icons.card_membership_rounded,
          ),
        ),
      ],
    );
  }
}

/// PrimaryCard con CTA que navega al tab de solicitudes (Gimnasios).
class _PrimaryCard extends StatelessWidget {
  const _PrimaryCard({required this.stats});

  final AdminDashboardStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final hasPending = stats.hasPending;

    return Container(
      padding: const EdgeInsets.all(AppDimens.l),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppDimens.cardBorderRadius,
        border: Border.all(color: AppColors.outline),
        boxShadow: hasPending
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  blurRadius: 24,
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                hasPending
                    ? Icons.pending_actions_rounded
                    : Icons.check_circle_outline_rounded,
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

/// Tile de gimnasio recientemente aprobado.
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
        child: const Icon(
          Icons.check_circle_rounded,
          color: AppColors.success,
          size: 20,
        ),
      ),
      title: gym.name,
      subtitle: gym.locationLabel,
    );
  }
}
