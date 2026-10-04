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
import '../../../../shared/widgets/pesao_card.dart';
import '../../../../shared/widgets/pesao_icon_button.dart';
import '../../../../shared/widgets/pesao_stat_card.dart';
import '../../../../shared/widgets/skeleton_loader.dart';
import '../../../nutrition/presentation/providers/nutritionist_dashboard_controller.dart';
import '../../domain/entities/nutritionist_stats.dart';

/// Dashboard del nutricionista (tab Inicio del shell).
///
/// Mismo esqueleto canónico que OwnerHomeScreen:
/// avatar + saludo + campana → StatCards → PrimaryCard → secciones.
class NutritionistHomeScreen extends ConsumerWidget {
  const NutritionistHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppStrings.of(context);
    final state = ref.watch(nutritionistDashboardControllerProvider);
    final connectivityAsync = ref.watch(connectivityProvider);
    final isOnline = connectivityAsync.value ?? true;
    final greeting = _greetingForHour(l10n);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: AppColors.surface,
          onRefresh: () =>
              ref.read(nutritionistDashboardControllerProvider.notifier).load(),
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
              if (state.isLoading && state.value == null)
                const _NutritionistSkeletonSliver()
              else if (state.hasError && state.value == null)
                SliverFillRemaining(
                  child: ErrorState(
                    onRetry: () =>
                        ref.invalidate(nutritionistDashboardControllerProvider),
                  ),
                )
              else if (state.value != null)
                _NutritionistSuccessSliver(stats: state.value!),
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

// ============================================================================
// SKELETON
// ============================================================================

class _NutritionistSkeletonSliver extends StatelessWidget {
  const _NutritionistSkeletonSliver();

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

class _NutritionistSuccessSliver extends StatelessWidget {
  const _NutritionistSuccessSliver({required this.stats});
  final NutritionistStats stats;

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
                  icon: AppIcons.clientsOutline,
                  label: l10n.tabClients,
                  value: stats.totalClients.toString(),
                  onTap: () => context.go(RouteNames.nutritionistClients),
                ),
              ),
              const SizedBox(width: AppDimens.s),
              Expanded(
                child: PesaoStatCard(
                  // TODO: agregar token AppIcons para "menú nutrición".
                  icon: Icons.restaurant_menu_rounded,
                  label: l10n.nutritionPlansTitle,
                  value: stats.activePlans.toString(),
                  onTap: () => context.go(RouteNames.nutritionistPlans),
                ),
              ),
              const SizedBox(width: AppDimens.s),
              Expanded(
                child: PesaoStatCard(
                  // TODO: agregar token AppIcons para "alimento".
                  icon: Icons.lunch_dining_rounded,
                  label: l10n.foodFavoritesTitle,
                  value: stats.totalFoods.toString(),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.xl),

          // PrimaryCard.
          _NutritionistPrimaryCard(stats: stats),
          const SizedBox(height: AppDimens.xl),

          // Sección clientes (vacío por ahora).
          EmptyState(
            icon: AppIcons.clientsOutline,
            title: l10n.nutritionistClientsTitle,
            body: l10n.nutritionistClientsEmptyBody,
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

class _NutritionistPrimaryCard extends StatelessWidget {
  const _NutritionistPrimaryCard({required this.stats});
  final NutritionistStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final hasClientsWithoutPlan = stats.hasClientsWithoutPlan;

    return PesaoCard(
      glow: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                hasClientsWithoutPlan
                    ? Icons.playlist_add_rounded
                    : AppIcons.success,
                color: hasClientsWithoutPlan
                    ? AppColors.primary
                    : AppColors.success,
                size: 24,
              ),
              const SizedBox(width: AppDimens.s),
              Expanded(
                child: Text(
                  hasClientsWithoutPlan
                      ? l10n.nutritionPlanCreate
                      : l10n.nutritionPlansTitle,
                  style: AppTypography.title.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.m),
          Text(
            hasClientsWithoutPlan
                ? l10n.nutritionistClientsCount(stats.clientsWithoutPlan)
                : l10n.nutritionPlansEmptyBody,
            style: AppTypography.body.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
