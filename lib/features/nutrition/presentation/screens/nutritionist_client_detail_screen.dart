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
import '../../../../shared/widgets/pesao_avatar.dart';
import '../../../../shared/widgets/pesao_badge.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_card.dart';
import '../../../../shared/widgets/pesao_list_tile.dart';
import '../../../../shared/widgets/pesao_stat_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/widgets/skeleton_loader.dart';
import '../../domain/entities/nutrition_plan.dart';
import '../../domain/enums/goal_type.dart';
import '../providers/nutrition_goals_controller.dart';
import '../providers/nutrition_plans_controller.dart';
import '../providers/nutritionist_clients_controller.dart';

/// Detalle del cliente: perfil + metas nutricionales + planes activos.
///
/// design-system.md §10: header con avatar + datos, StatCards de macros,
/// sección de planes activos, botones de acción.
class NutritionistClientDetailScreen extends ConsumerStatefulWidget {
  const NutritionistClientDetailScreen({super.key, required this.clientId});

  final String clientId;

  @override
  ConsumerState<NutritionistClientDetailScreen> createState() =>
      _NutritionistClientDetailScreenState();
}

class _NutritionistClientDetailScreenState
    extends ConsumerState<NutritionistClientDetailScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    // Cargar metas del cliente.
    ref
        .read(nutritionGoalsControllerProvider.notifier)
        .loadGoal(clientId: widget.clientId);

    // Cargar planes del cliente.
    ref
        .read(nutritionPlansControllerProvider.notifier)
        .loadClientPlans(widget.clientId);
  }

  @override
  void dispose() {
    // Limpiar planes del cliente al salir.
    ref.read(nutritionPlansControllerProvider.notifier).clearClientPlans();
    super.dispose();
  }

  void _goToSetGoals() {
    // Navegar a pantalla de fijar objetivos (F3 futuro).
    // Por ahora solo muestra un toast.
    // TODO: implementar pantalla de metas.
  }

  void _goToCreatePlan() {
    context.push(RouteNames.nutritionistPlanCreate);
  }

  void _goToPlanDetail(NutritionPlan plan) {
    context.push(
      RouteNames.nutritionistPlanEdit.replaceAll(':planId', plan.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final clientsState = ref.watch(nutritionistClientsControllerProvider);
    final goalsState = ref.watch(nutritionGoalsControllerProvider);
    final plansState = ref.watch(nutritionPlansControllerProvider);
    final connectivityAsync = ref.watch(connectivityProvider);
    final isOnline = connectivityAsync.value ?? true;

    // Buscar el cliente en la lista cargada.
    final client =
        clientsState.clients.where((c) => c.userId == widget.clientId).isEmpty
        ? null
        : clientsState.clients.where((c) => c.userId == widget.clientId).first;

    final isLoading = goalsState.isLoading || plansState.isLoadingDetail;
    final hasError =
        (goalsState.error != null || plansState.error != null) &&
        client == null;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PesaoAppBar(
        title: client?.fullName ?? l10n.nutritionistClientsTitle,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: AppColors.surface,
          onRefresh: () async => _loadData(),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // OfflineBanner.
              if (!isOnline)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(AppDimens.l),
                    child: OfflineBanner(),
                  ),
                ),

              // Contenido según estado.
              if (isLoading && client == null)
                const _ClientDetailSkeletonSliver()
              else if (hasError)
                SliverFillRemaining(
                  child: ErrorState(
                    title: l10n.errorGenericTitle,
                    body: l10n.errorGenericBody,
                    actionLabel: l10n.commonRetry,
                    onRetry: _loadData,
                  ),
                )
              else if (client != null)
                _ClientDetailContent(
                  client: client,
                  goalsState: goalsState,
                  clientPlans: plansState.clientPlans,
                  onSetGoals: _goToSetGoals,
                  onCreatePlan: _goToCreatePlan,
                  onPlanTap: _goToPlanDetail,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// CONTENIDO PRINCIPAL
// ============================================================================

class _ClientDetailContent extends StatelessWidget {
  const _ClientDetailContent({
    required this.client,
    required this.goalsState,
    required this.clientPlans,
    required this.onSetGoals,
    required this.onCreatePlan,
    required this.onPlanTap,
  });

  final NutritionistClient client;
  final NutritionGoalsState goalsState;
  final List<NutritionPlan> clientPlans;
  final VoidCallback onSetGoals;
  final VoidCallback onCreatePlan;
  final void Function(NutritionPlan) onPlanTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final goal = goalsState.activeGoal;

    return SliverPadding(
      padding: const EdgeInsets.all(AppDimens.l),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          // ── Header: avatar + nombre + email ─────────────────────
          Row(
            children: [
              PesaoAvatar(
                name: client.fullName,
                imageUrl: client.avatarUrl,
                size: 64,
              ),
              const SizedBox(width: AppDimens.l),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      client.fullName,
                      style: AppTypography.title.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      client.email,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (client.lastLogDate != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        l10n.nutritionLastLog(_formatDate(client.lastLogDate!)),
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.xl),

          // ── Sección: Metas nutricionales ────────────────────────
          SectionHeader(title: l10n.nutritionSetGoals),
          const SizedBox(height: AppDimens.m),

          if (goalsState.isLoading)
            const SkeletonLoader(child: SizedBox(height: 120))
          else if (goal == null)
            // Sin metas definidas.
            PesaoCard(
              child: Column(
                children: [
                  Text(
                    l10n.nutritionNoPlanYet,
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppDimens.m),
                  PesaoButton(
                    label: l10n.nutritionSetGoals,
                    icon: AppIcons.add,
                    variant: PesaoButtonVariant.primary,
                    isExpanded: false,
                    onPressed: onSetGoals,
                  ),
                ],
              ),
            )
          else
            // Metas activas: 4 StatCards + badge de tipo.
            Column(
              children: [
                // Badge del tipo de objetivo.
                Align(
                  alignment: Alignment.centerLeft,
                  child: PesaoBadge(
                    label: _goalTypeLabel(context, goal.goalType),
                    variant: _goalTypeBadgeVariant(goal.goalType),
                  ),
                ),
                const SizedBox(height: AppDimens.m),
                // Grid de 4 macros.
                Row(
                  children: [
                    Expanded(
                      child: PesaoStatCard(
                        label: l10n.macroCalories,
                        value: '${goal.targetCaloriesKcal.round()}',
                        sub: 'kcal',
                        icon: AppIcons.nutrition,
                      ),
                    ),
                    const SizedBox(width: AppDimens.s),
                    Expanded(
                      child: PesaoStatCard(
                        label: l10n.macroProtein,
                        value: '${goal.targetProteinG.round()}',
                        sub: 'g',
                        icon: AppIcons.protein,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimens.s),
                Row(
                  children: [
                    Expanded(
                      child: PesaoStatCard(
                        label: l10n.macroCarbs,
                        value: '${goal.targetCarbsG.round()}',
                        sub: 'g',
                        icon: AppIcons.carbs,
                      ),
                    ),
                    const SizedBox(width: AppDimens.s),
                    Expanded(
                      child: PesaoStatCard(
                        label: l10n.macroFats,
                        value: '${goal.targetFatsG.round()}',
                        sub: 'g',
                        icon: AppIcons.fats,
                      ),
                    ),
                  ],
                ),
              ],
            ),

          const SizedBox(height: AppDimens.xl),

          // ── Sección: Planes activos ─────────────────────────────
          SectionHeader(title: l10n.nutritionPlansTitle),
          const SizedBox(height: AppDimens.m),

          if (clientPlans.isEmpty)
            // Sin planes.
            EmptyState(
              icon: AppIcons.plans,
              title: l10n.nutritionPlansEmptyTitle,
              body: l10n.nutritionPlansEmptyBody,
            )
          else
            // Lista de planes.
            Column(
              children: [
                for (final plan in clientPlans)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppDimens.s),
                    child: PesaoListTile(
                      title: plan.name,
                      subtitle: l10n.nutritionistPlansCount(1),
                      leading: const CircleAvatar(
                        backgroundColor: AppColors.surfaceHigh,
                        child: Icon(
                          AppIcons.plans,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                      trailing: const Icon(
                        AppIcons.chevronRight,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                      onTap: () => onPlanTap(plan),
                    ),
                  ),
              ],
            ),

          const SizedBox(height: AppDimens.xl),

          // ── Botón: Crear nuevo plan ─────────────────────────────
          PesaoButton(
            label: l10n.nutritionPlanCreate,
            icon: AppIcons.add,
            variant: PesaoButtonVariant.primary,
            isExpanded: true,
            onPressed: onCreatePlan,
          ),

          const SizedBox(height: AppDimens.xxl),
        ]),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'ene',
      'feb',
      'mar',
      'abr',
      'may',
      'jun',
      'jul',
      'ago',
      'sep',
      'oct',
      'nov',
      'dic',
    ];
    return '${date.day} ${months[date.month - 1]}';
  }

  String _goalTypeLabel(BuildContext context, GoalType type) {
    final l10n = AppStrings.of(context);
    return switch (type) {
      GoalType.lose => l10n.goalTypeLose,
      GoalType.maintain => l10n.goalTypeMaintain,
      GoalType.gain => l10n.goalTypeGain,
    };
  }

  PesaoBadgeVariant _goalTypeBadgeVariant(GoalType type) {
    return switch (type) {
      GoalType.lose => PesaoBadgeVariant.warning,
      GoalType.maintain => PesaoBadgeVariant.brand,
      GoalType.gain => PesaoBadgeVariant.success,
    };
  }
}

// ============================================================================
// SKELETON
// ============================================================================

class _ClientDetailSkeletonSliver extends StatelessWidget {
  const _ClientDetailSkeletonSliver();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: SkeletonLoader(
        child: Padding(
          padding: EdgeInsets.all(AppDimens.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header.
              Row(
                children: [
                  SkeletonBox(width: 64, height: 64),
                  SizedBox(width: AppDimens.l),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonBox(width: 150, height: 16),
                        SizedBox(height: 8),
                        SkeletonBox(width: 200, height: 12),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppDimens.xl),
              // Metas.
              SkeletonBox(height: 24),
              SizedBox(height: AppDimens.m),
              Row(
                children: [
                  Expanded(child: SkeletonBox(height: 80)),
                  SizedBox(width: AppDimens.s),
                  Expanded(child: SkeletonBox(height: 80)),
                ],
              ),
              SizedBox(height: AppDimens.s),
              Row(
                children: [
                  Expanded(child: SkeletonBox(height: 80)),
                  SizedBox(width: AppDimens.s),
                  Expanded(child: SkeletonBox(height: 80)),
                ],
              ),
              SizedBox(height: AppDimens.xl),
              // Planes.
              SkeletonBox(height: 24),
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
