import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/connectivity_provider.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/offline_banner.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_list_tile.dart';
import '../../../../shared/widgets/skeleton_loader.dart';
import '../../domain/entities/nutrition_plan.dart';
import '../providers/nutrition_plans_controller.dart';
import '../providers/nutritionist_clients_controller.dart';

/// Lista de planes nutricionales del nutricionista.
///
/// design-system.md §11: 5 estados obligatorios.
/// El FAB contextual del shell ya maneja la creación de nuevos planes.
class NutritionistPlansScreen extends ConsumerStatefulWidget {
  const NutritionistPlansScreen({super.key});

  @override
  ConsumerState<NutritionistPlansScreen> createState() =>
      _NutritionistPlansScreenState();
}

class _NutritionistPlansScreenState
    extends ConsumerState<NutritionistPlansScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    Future.microtask(() {
      if (!mounted) return;
      ref.read(nutritionPlansControllerProvider.notifier).load();
      ref.read(nutritionistClientsControllerProvider.notifier).load();
    });
  }

  void _goToCreate() {
    context.push(RouteNames.nutritionistPlanCreate);
  }

  void _goToPlanDetail(NutritionPlan plan) {
    context.push(
      RouteNames.nutritionistPlanEdit.replaceAll(':planId', plan.id),
    );
  }

  /// Resuelve el nombre del cliente desde la lista cargada.
  String _clientName(String clientId) {
    final clientsState = ref.read(nutritionistClientsControllerProvider);
    final client =
        clientsState.clients.where((c) => c.userId == clientId).isEmpty
        ? null
        : clientsState.clients.where((c) => c.userId == clientId).first;
    return client?.fullName ?? 'Cliente';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final state = ref.watch(nutritionPlansControllerProvider);
    final connectivityAsync = ref.watch(connectivityProvider);
    final isOnline = connectivityAsync.value ?? true;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: AppColors.surface,
          onRefresh: () async => _loadData(),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // Título de pantalla.
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppDimens.l,
                    AppDimens.l,
                    AppDimens.l,
                    0,
                  ),
                  child: Text(
                    l10n.nutritionPlansTitle,
                    style: AppTypography.headline.copyWith(
                      color: AppColors.textPrimary,
                    ),
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

              // Herramientas del nutricionista: Alimentos y Plantillas.
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppDimens.l,
                    0,
                    AppDimens.l,
                    AppDimens.m,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: PesaoButton(
                          label: l10n.nutritionistStatsFoods,
                          icon: AppIcons.nutrition,
                          variant: PesaoButtonVariant.secondary,
                          onPressed: () =>
                              context.push(RouteNames.nutritionistFoods),
                        ),
                      ),
                      const SizedBox(width: AppDimens.s),
                      Expanded(
                        child: PesaoButton(
                          label: l10n.nutritionistTemplatesTitle,
                          icon: AppIcons.plans,
                          variant: PesaoButtonVariant.secondary,
                          onPressed: () =>
                              context.push(RouteNames.nutritionistTemplates),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Contenido según estado.
              if (state.isLoading && state.plans.isEmpty)
                const _PlansSkeletonSliver()
              else if (state.error != null && state.plans.isEmpty)
                SliverFillRemaining(
                  child: ErrorState(
                    title: l10n.errorGenericTitle,
                    body: l10n.errorGenericBody,
                    actionLabel: l10n.commonRetry,
                    onRetry: _loadData,
                  ),
                )
              else if (state.plans.isEmpty)
                // Sin planes: EmptyState con CTA.
                SliverFillRemaining(
                  child: EmptyState(
                    icon: AppIcons.plans,
                    title: l10n.nutritionistPlansCount == 0
                        ? l10n.nutritionPlansEmptyTitle
                        : l10n.nutritionPlansEmptyTitle,
                    body: l10n.nutriDashRecentEmpty,
                    actionLabel: l10n.nutritionPlanCreate,
                    onAction: _goToCreate,
                  ),
                )
              else
                // Lista de planes.
                SliverPadding(
                  padding: const EdgeInsets.all(AppDimens.l),
                  sliver: SliverList.builder(
                    itemCount: state.plans.length,
                    itemBuilder: (context, index) {
                      final plan = state.plans[index];
                      return _PlanTile(
                        plan: plan,
                        clientName: _clientName(plan.clientId),
                        onTap: () => _goToPlanDetail(plan),
                      );
                    },
                  ),
                ),

              // Espacio inferior para el FAB del shell.
              const SliverToBoxAdapter(child: SizedBox(height: AppDimens.xxxl)),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// TILE DE PLAN
// ============================================================================

class _PlanTile extends StatelessWidget {
  const _PlanTile({
    required this.plan,
    required this.clientName,
    required this.onTap,
  });

  final NutritionPlan plan;
  final String clientName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    // Subtítulo: cliente + calorías objetivo.
    final subtitle =
        '$clientName · ${plan.targetCaloriesKcal.round()} kcal/día';

    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.s),
      child: PesaoListTile(
        title: plan.name,
        subtitle: subtitle,
        leading: const CircleAvatar(
          backgroundColor: AppColors.surfaceHigh,
          child: Icon(AppIcons.plans, color: AppColors.primary, size: 20),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Badge de estado.
            Text(
              plan.isActive ? l10n.planActiveBadge : l10n.planInactiveBadge,
              style: AppTypography.label.copyWith(
                color: plan.isActive
                    ? AppColors.successText
                    : AppColors.textDisabled,
              ),
            ),
            const SizedBox(height: 4),
            const Icon(
              AppIcons.chevronRight,
              color: AppColors.textSecondary,
              size: 20,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

// ============================================================================
// SKELETON
// ============================================================================

class _PlansSkeletonSliver extends StatelessWidget {
  const _PlansSkeletonSliver();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: SkeletonLoader(
        child: Padding(
          padding: EdgeInsets.all(AppDimens.l),
          child: Column(
            children: [
              SkeletonListTile(hasSubtitle: true),
              SizedBox(height: AppDimens.s),
              SkeletonListTile(hasSubtitle: true),
              SizedBox(height: AppDimens.s),
              SkeletonListTile(hasSubtitle: true),
              SizedBox(height: AppDimens.s),
              SkeletonListTile(hasSubtitle: true),
            ],
          ),
        ),
      ),
    );
  }
}
