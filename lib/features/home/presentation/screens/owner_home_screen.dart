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
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_card.dart';
import '../../../../shared/widgets/pesao_stat_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../gym/presentation/providers/staff_providers.dart';
import '../../../memberships/presentation/providers/membership_plans_controller.dart';
import '../../domain/entities/owner_dashboard_stats.dart';
import '../providers/owner_dashboard_controller.dart';

/// Dashboard del dueño (tab Inicio del shell).
///
/// design-system.md §10: avatar+saludo, 3 StatCards, PrimaryCard,
/// Resumen de Mi Equipo, sección "Últimos clientes".
class OwnerHomeScreen extends ConsumerWidget {
  const OwnerHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppStrings.of(context);
    final state = ref.watch(ownerDashboardControllerProvider);
    final controller = ref.read(ownerDashboardControllerProvider.notifier);
    final connectivity = ref.watch(connectivityProvider);
    final isOnline = connectivity is bool ? connectivity : true;
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
              // AppBar
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
                        name: authProvider.userFullName ?? 'Dueño',
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
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),

              // OfflineBanner
              if (isOnline == false)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(AppDimens.l),
                    child: OfflineBanner(),
                  ),
                ),

              // Contenido según estado
              if (state.isLoading && state.stats == null)
                const _OwnerSkeletonSliver()
              else if (state.error != null && state.stats == null)
                _OwnerErrorSliver(
                  title: l10n.ownerDashErrorTitle,
                  body: l10n.ownerDashErrorBody,
                  onRetry: controller.load,
                )
              else if (state.hasData)
                _OwnerSuccessSliver(stats: state.stats!),
            ],
          ),
        ),
      ),
    );
  }

  String _greetingForHour(AppStrings l10n) {
    final hour = DateTime.now().hour;
    final name = authProvider.userFullName ?? 'campeón';
    if (hour < 12) return l10n.greetingMorning(name);
    if (hour < 19) return l10n.greetingAfternoon(name);
    return l10n.greetingNight(name);
  }
}

class _OwnerSkeletonSliver extends StatelessWidget {
  const _OwnerSkeletonSliver();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(AppDimens.l),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
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
          const _SkeletonBox(height: 160),
          const SizedBox(height: AppDimens.xl),
          const _SkeletonBox(height: 80),
          const SizedBox(height: AppDimens.xl),
          const _SkeletonBox(height: 80),
          const SizedBox(height: AppDimens.xl),
          const _SkeletonBox(height: 24),
          const SizedBox(height: AppDimens.m),
          const _SkeletonBox(height: 72),
          const SizedBox(height: AppDimens.s),
          const _SkeletonBox(height: 72),
        ]),
      ),
    );
  }
}

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

class _OwnerErrorSliver extends StatelessWidget {
  const _OwnerErrorSliver({
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

class _OwnerSuccessSliver extends StatelessWidget {
  const _OwnerSuccessSliver({required this.stats});
  final OwnerDashboardStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return SliverPadding(
      padding: const EdgeInsets.all(AppDimens.l),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          // StatCards
          Row(
            children: [
              Expanded(
                child: PesaoStatCard(
                  label: l10n.ownerDashStatClients,
                  value: stats.activeClientsCount.toString(),
                  sub: l10n.ownerDashStatClientsSub,
                  icon: Icons.people_rounded,
                ),
              ),
              const SizedBox(width: AppDimens.s),
              Expanded(
                child: PesaoStatCard(
                  label: l10n.ownerDashStatPayments,
                  value: stats.pendingPaymentsCount.toString(),
                  sub: l10n.ownerDashStatPaymentsSub,
                  icon: Icons.receipt_long_rounded,
                ),
              ),
              const SizedBox(width: AppDimens.s),
              Expanded(
                child: PesaoStatCard(
                  label: l10n.ownerDashStatIncome,
                  value: stats.monthlyIncomeBs.toStringAsFixed(0),
                  sub: l10n.ownerDashStatIncomeSub,
                  icon: Icons.payments_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.xl),

          // PrimaryCard
          _OwnerPrimaryCard(stats: stats),
          const SizedBox(height: AppDimens.xl),

          // === NUEVO: Resumen de Mi Equipo ===
          const _OwnerStaffSummaryCard(),
          const SizedBox(height: AppDimens.xl),

          // === NUEVO: Resumen de Planes del Gimnasio ===
          const _OwnerPlansSummaryCard(),
          const SizedBox(height: AppDimens.xl),

          // Sección últimos clientes
          SectionHeader(
            title: l10n.ownerDashRecentSection,
            onSeeAll: () => context.go(RouteNames.ownerClients),
          ),
          const SizedBox(height: AppDimens.m),
          if (stats.recentClients.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppDimens.m),
              child: Text(
                l10n.ownerDashRecentEmpty,
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

class _OwnerPrimaryCard extends StatelessWidget {
  const _OwnerPrimaryCard({required this.stats});
  final OwnerDashboardStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final hasPending = stats.hasPendingPayments;

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
                    ? Icons.receipt_long_rounded
                    : Icons.check_circle_outline_rounded,
                color: hasPending ? AppColors.primary : AppColors.success,
                size: 24,
              ),
              const SizedBox(width: AppDimens.s),
              Expanded(
                child: Text(
                  l10n.ownerDashPrimaryTitle,
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
                ? l10n.ownerDashPrimaryBody(stats.pendingPaymentsCount)
                : l10n.ownerDashPrimaryCtaNone,
            style: AppTypography.body.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppDimens.m),
          Align(
            alignment: Alignment.centerRight,
            child: PesaoButton(
              label: hasPending
                  ? l10n.ownerDashPrimaryCta
                  : l10n.ownerDashPrimaryCtaNone,
              variant: hasPending
                  ? PesaoButtonVariant.primary
                  : PesaoButtonVariant.secondary,
              isExpanded: false,
              onPressed: hasPending
                  ? () => context.go(RouteNames.ownerPayments)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// WIDGETS AUXILIARES PARA STAFF EN DASHBOARD
// ============================================================================

class _OwnerStaffSummaryCard extends ConsumerWidget {
  const _OwnerStaffSummaryCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppStrings.of(context);
    final staffResult = ref.watch(ownerStaffControllerProvider);

    return staffResult.when(
      idle: () => const SizedBox.shrink(),
      loading: () => const _StaffSummarySkeleton(),
      success: (overview) {
        final limitText = overview.isUnlimited
            ? '∞'
            : overview.staffLimit.toString();
        final subtitle = '${overview.staffCount} de $limitText miembros';

        return PesaoCard(
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.l),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppDimens.m),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: AppDimens.cardBorderRadius,
                  ),
                  child: const Icon(
                    Icons.people_rounded,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppDimens.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.staffScreenTitle,
                        style: AppTypography.title.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                PesaoButton(
                  label: l10n.commonSeeAll,
                  variant: PesaoButtonVariant.secondary,
                  isExpanded: false,
                  onPressed: () => context.push(RouteNames.ownerStaff),
                ),
              ],
            ),
          ),
        );
      },
      failure: (_) =>
          const SizedBox.shrink(), // Fallo silencioso para no bloquear el dashboard
    );
  }
}

class _StaffSummarySkeleton extends StatelessWidget {
  const _StaffSummarySkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppDimens.cardBorderRadius,
        border: Border.all(color: AppColors.outline),
      ),
    );
  }
}
// ============================================================================
// WIDGET AUXILIAR PARA PLANES EN DASHBOARD
// ============================================================================

/// Card resumen de "Planes del gimnasio" en el dashboard del dueño.
///
/// Muestra el conteo de planes activos y ofrece navegación a la lista completa.
class _OwnerPlansSummaryCard extends ConsumerWidget {
  const _OwnerPlansSummaryCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppStrings.of(context);
    final plansAsync = ref.watch(membershipPlansControllerProvider);

    return plansAsync.when(
      data: (plans) {
        final activeCount = plans.where((p) => p.isActive).length;
        final totalCount = plans.length;

        return PesaoCard(
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.l),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppDimens.m),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: AppDimens.cardBorderRadius,
                  ),
                  child: const Icon(
                    Icons.playlist_add_rounded,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppDimens.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.plansScreenTitle,
                        style: AppTypography.title.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$activeCount ${totalCount == 1 ? "plan activo" : "planes activos"}',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                PesaoButton(
                  label: l10n.commonSeeAll,
                  variant: PesaoButtonVariant.secondary,
                  isExpanded: false,
                  onPressed: () => context.push(RouteNames.ownerPlans),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const _PlansSummarySkeleton(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}

class _PlansSummarySkeleton extends StatelessWidget {
  const _PlansSummarySkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppDimens.cardBorderRadius,
        border: Border.all(color: AppColors.outline),
      ),
    );
  }
}
