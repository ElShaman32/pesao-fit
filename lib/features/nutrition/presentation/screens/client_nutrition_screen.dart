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
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_card.dart';
import '../../../../shared/widgets/pesao_list_tile.dart';
import '../../../../shared/widgets/pesao_stat_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/widgets/skeleton_loader.dart';
import '../providers/client_nutrition_controller.dart';

/// Vista principal de nutrición para el cliente.
/// Muestra plan activo, metas vs. consumido, y acceso al registro diario.
class ClientNutritionScreen extends ConsumerStatefulWidget {
  const ClientNutritionScreen({super.key});

  @override
  ConsumerState<ClientNutritionScreen> createState() =>
      _ClientNutritionScreenState();
}

class _ClientNutritionScreenState extends ConsumerState<ClientNutritionScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      ref.read(clientNutritionControllerProvider.notifier).load();
    });
  }

  void _goToFoodLog() {
    context.push(RouteNames.clientNutritionLog);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final state = ref.watch(clientNutritionControllerProvider);
    final controller = ref.read(clientNutritionControllerProvider.notifier);
    final connectivityAsync = ref.watch(connectivityProvider);
    final isOnline = connectivityAsync.value ?? true;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PesaoAppBar(title: l10n.tabNutrition),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: AppColors.surface,
          onRefresh: () async => controller.load(),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              if (!isOnline)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(AppDimens.l),
                    child: OfflineBanner(),
                  ),
                ),

              if (state.isLoading && !state.hasPlan)
                const _NutritionSkeletonSliver()
              else if (state.error != null && !state.hasPlan)
                SliverFillRemaining(
                  child: ErrorState(
                    title: l10n.errorGenericTitle,
                    body: l10n.errorGenericBody,
                    actionLabel: l10n.commonRetry,
                    onRetry: () => controller.load(),
                  ),
                )
              else if (!state.hasPlan)
                SliverFillRemaining(
                  child: EmptyState(
                    icon: AppIcons.nutrition,
                    title: l10n.nutritionPlansEmptyTitle,
                    body: l10n.nutritionPlansEmptyBody,
                  ),
                )
              else
                _NutritionSuccessSliver(state: state, onGoToLog: _goToFoodLog),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// SUCCESS VIEW
// ============================================================================

class _NutritionSuccessSliver extends StatelessWidget {
  const _NutritionSuccessSliver({required this.state, required this.onGoToLog});

  final ClientNutritionState state;
  final VoidCallback onGoToLog;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final plan = state.activePlan!;
    final goal = state.activeGoal;

    return SliverPadding(
      padding: const EdgeInsets.all(AppDimens.l),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          // Nombre del plan
          PesaoCard(
            primaryTint: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan.name,
                  style: AppTypography.title.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppDimens.xs),
                Text(
                  '${plan.durationDays} días · ${plan.targetCaloriesKcal.round()} kcal/día',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.xl),

          // Metas vs Consumido (Grid 2x2)
          SectionHeader(title: l10n.macroCalories),
          const SizedBox(height: AppDimens.m),
          Row(
            children: [
              Expanded(
                child: PesaoStatCard(
                  icon: AppIcons.kcal,
                  label: l10n.macroCalories,
                  value: '${state.totalCaloriesConsumed.round()}',
                  sub: goal != null
                      ? '/ ${goal.targetCaloriesKcal.round()} kcal'
                      : 'kcal',
                ),
              ),
              const SizedBox(width: AppDimens.s),
              Expanded(
                child: PesaoStatCard(
                  icon: AppIcons.protein,
                  label: l10n.macroProtein,
                  value: '${state.totalProteinConsumed.round()}',
                  sub: goal != null
                      ? '/ ${goal.targetProteinG.round()} g'
                      : 'g',
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.s),
          Row(
            children: [
              Expanded(
                child: PesaoStatCard(
                  icon: AppIcons.carbs,
                  label: l10n.macroCarbs,
                  value: '${state.totalCarbsConsumed.round()}',
                  sub: goal != null ? '/ ${goal.targetCarbsG.round()} g' : 'g',
                ),
              ),
              const SizedBox(width: AppDimens.s),
              Expanded(
                child: PesaoStatCard(
                  icon: AppIcons.fats,
                  label: l10n.macroFats,
                  value: '${state.totalFatsConsumed.round()}',
                  sub: goal != null ? '/ ${goal.targetFatsG.round()} g' : 'g',
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.xl),

          // Resumen del día
          const SectionHeader(title: 'Comidas de hoy'),
          const SizedBox(height: AppDimens.m),

          if (state.dailyItems.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppDimens.l),
              child: Text(
                'Aún no has registrado comidas hoy. ¡Ánimo! 💪',
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            )
          else
            Column(
              children: [
                for (final item in state.dailyItems.take(3)) // Mostrar max 3
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppDimens.s),
                    child: PesaoListTile(
                      title: 'Comida registrada',
                      subtitle:
                          '${item.quantity.round()}g · ${item.caloriesKcal.round()} kcal',
                      leading: const Icon(
                        AppIcons.nutrition,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                if (state.dailyItems.length > 3)
                  Text(
                    '...y ${state.dailyItems.length - 3} más',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),

          const SizedBox(height: AppDimens.xl),

          // CTA para ir al log
          PesaoButton(
            label: 'Registrar comida',
            icon: AppIcons.add,
            variant: PesaoButtonVariant.primary,
            isExpanded: true,
            onPressed: onGoToLog,
          ),

          const SizedBox(height: AppDimens.xxl),
        ]),
      ),
    );
  }
}

// ============================================================================
// SKELETON
// ============================================================================

class _NutritionSkeletonSliver extends StatelessWidget {
  const _NutritionSkeletonSliver();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: SkeletonLoader(
        child: Padding(
          padding: EdgeInsets.all(AppDimens.l),
          child: Column(
            children: [
              SkeletonCard(height: 80),
              SizedBox(height: AppDimens.xl),
              Row(
                children: [
                  Expanded(child: SkeletonCard(height: 90)),
                  SizedBox(width: AppDimens.s),
                  Expanded(child: SkeletonCard(height: 90)),
                ],
              ),
              SizedBox(height: AppDimens.s),
              Row(
                children: [
                  Expanded(child: SkeletonCard(height: 90)),
                  SizedBox(width: AppDimens.s),
                  Expanded(child: SkeletonCard(height: 90)),
                ],
              ),
              SizedBox(height: AppDimens.xl),
              SkeletonLine(width: 120, height: 16),
              SizedBox(height: AppDimens.m),
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
