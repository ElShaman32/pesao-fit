import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/connectivity_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/offline_banner.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_bottom_sheet.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_card.dart';
import '../../../../shared/widgets/pesao_list_tile.dart';
import '../../../../shared/widgets/pesao_toast.dart';
import '../../../../shared/widgets/skeleton_loader.dart';
import '../../domain/entities/nutrition_plan_day.dart';
import '../../domain/entities/nutrition_plan_meal.dart';
import '../../domain/repositories/nutrition_plan_repository.dart';
import '../providers/meal_templates_controller.dart';
import '../providers/nutrition_plans_controller.dart';

/// Editor de días del plan nutricional.
///
/// Muestra la lista de días del plan con sus comidas asignadas.
/// Permite agregar/eliminar días, agregar comidas (plantillas),
/// y duplicar días.
class NutritionistPlanDaysScreen extends ConsumerStatefulWidget {
  const NutritionistPlanDaysScreen({super.key, required this.planId});

  final String planId;

  @override
  ConsumerState<NutritionistPlanDaysScreen> createState() =>
      _NutritionistPlanDaysScreenState();
}

class _NutritionistPlanDaysScreenState
    extends ConsumerState<NutritionistPlanDaysScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  void _loadData() {
    Future.microtask(() {
      if (!mounted) return;
      ref
          .read(nutritionPlansControllerProvider.notifier)
          .loadDetail(widget.planId);

      ref.read(mealTemplatesControllerProvider.notifier).load();
    });
  }

  /// Agrega un nuevo día al plan.
  Future<void> _addDay() async {
    final controller = ref.read(nutritionPlansControllerProvider.notifier);
    final state = ref.read(nutritionPlansControllerProvider);
    final detail = state.selectedPlanDetail;

    if (detail == null) return;

    // Calcular el siguiente número de día.
    final maxDay = detail.days.isEmpty
        ? 0
        : detail.days
              .map((d) => d.day.dayNumber)
              .reduce((a, b) => a > b ? a : b);
    final nextDayNumber = maxDay + 1;

    final success = await controller.addDay(
      planId: widget.planId,
      dayNumber: nextDayNumber,
    );

    if (!mounted) return;

    if (success) {
      final l10n = AppStrings.of(context);
      showPesaoToast(
        context,
        message: l10n.foodFormSaveSuccess,
        semanticLabel: l10n.foodFormSaveSuccess.replaceAll('✅', ''),
        variant: PesaoToastVariant.success,
      );
    }
  }

  /// Elimina un día del plan.
  Future<void> _deleteDay(NutritionPlanDay day) async {
    final controller = ref.read(nutritionPlansControllerProvider.notifier);
    await controller.deleteDay(day.id);
  }

  /// Duplica un día del plan.
  Future<void> _duplicateDay(NutritionPlanDay day) async {
    final controller = ref.read(nutritionPlansControllerProvider.notifier);
    final state = ref.read(nutritionPlansControllerProvider);
    final detail = state.selectedPlanDetail;

    if (detail == null) return;

    // Calcular el siguiente número de día.
    final maxDay = detail.days.isEmpty
        ? 0
        : detail.days
              .map((d) => d.day.dayNumber)
              .reduce((a, b) => a > b ? a : b);

    await controller.duplicateDay(
      sourceDayId: day.id,
      targetPlanId: widget.planId,
      targetDayNumber: maxDay + 1,
    );
  }

  /// Abre el selector de plantillas para agregar una comida a un día.
  Future<void> _showMealTemplateSelector(NutritionPlanDay day) async {
    final templatesState = ref.read(mealTemplatesControllerProvider);
    final templates = templatesState.templates;

    if (templates.isEmpty) {
      final l10n = AppStrings.of(context);
      showPesaoToast(
        context,
        message: l10n.nutritionPlansEmptyTitle,
        semanticLabel: l10n.nutritionPlansEmptyTitle,
        variant: PesaoToastVariant.warning,
      );
      return;
    }

    final l10n = AppStrings.of(context);

    final selectedTemplateId = await showPesaoBottomSheet<String>(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PesaoBottomSheetHeader(title: l10n.nutritionPlansTitle),
          for (final template in templates)
            PesaoListTile(
              title: template.name,
              subtitle: '${template.totalCaloriesKcal.round()} kcal',
              onTap: () => Navigator.of(context).pop(template.id),
            ),
        ],
      ),
    );

    if (selectedTemplateId != null) {
      final controller = ref.read(nutritionPlansControllerProvider.notifier);

      // Calcular el siguiente orden de comida.
      final state = ref.read(nutritionPlansControllerProvider);
      final detail = state.selectedPlanDetail;
      final dayWithMeals = detail?.days
          .where((d) => d.day.id == day.id)
          .firstOrNull;
      final nextOrder = (dayWithMeals?.meals.length ?? 0);

      await controller.addMealToDay(
        planDayId: day.id,
        mealTemplateId: selectedTemplateId,
        mealOrder: nextOrder,
      );
    }
  }

  /// Elimina una comida del día.
  Future<void> _removeMeal(NutritionPlanMeal meal) async {
    final controller = ref.read(nutritionPlansControllerProvider.notifier);
    await controller.removeMealFromDay(meal.id);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final state = ref.watch(nutritionPlansControllerProvider);
    final connectivityAsync = ref.watch(connectivityProvider);
    final isOnline = connectivityAsync.value ?? true;

    final detail = state.selectedPlanDetail;
    final isLoading = state.isLoadingDetail;
    final hasError = state.error != null && detail == null;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PesaoAppBar(title: detail?.plan.name ?? l10n.nutritionPlansTitle),
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
              if (isLoading && detail == null)
                const _PlanDaysSkeletonSliver()
              else if (hasError)
                SliverFillRemaining(
                  child: ErrorState(
                    title: l10n.errorGenericTitle,
                    body: l10n.errorGenericBody,
                    actionLabel: l10n.commonRetry,
                    onRetry: _loadData,
                  ),
                )
              else if (detail != null)
                _PlanDaysContent(
                  detail: detail,
                  onAddDay: _addDay,
                  onDeleteDay: _deleteDay,
                  onDuplicateDay: _duplicateDay,
                  onAddMeal: _showMealTemplateSelector,
                  onRemoveMeal: _removeMeal,
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

class _PlanDaysContent extends StatelessWidget {
  const _PlanDaysContent({
    required this.detail,
    required this.onAddDay,
    required this.onDeleteDay,
    required this.onDuplicateDay,
    required this.onAddMeal,
    required this.onRemoveMeal,
  });

  final NutritionPlanWithDays detail;
  final VoidCallback onAddDay;
  final void Function(NutritionPlanDay) onDeleteDay;
  final void Function(NutritionPlanDay) onDuplicateDay;
  final void Function(NutritionPlanDay) onAddMeal;
  final void Function(NutritionPlanMeal) onRemoveMeal;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return SliverPadding(
      padding: const EdgeInsets.all(AppDimens.l),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          // Info del plan.
          PesaoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detail.plan.name,
                  style: AppTypography.title.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppDimens.xs),
                Text(
                  '${detail.plan.durationDays} días · '
                  '${detail.plan.targetCaloriesKcal.round()} kcal/día',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.xl),

          // Lista de días.
          if (detail.days.isEmpty)
            EmptyState(
              icon: AppIcons.calendar,
              title: l10n.nutritionPlansEmptyTitle,
              body: l10n.nutritionPlansEmptyBody,
            )
          else
            for (final dayWithMeals in detail.days)
              _DayCard(
                dayWithMeals: dayWithMeals,
                onDelete: () => onDeleteDay(dayWithMeals.day),
                onDuplicate: () => onDuplicateDay(dayWithMeals.day),
                onAddMeal: () => onAddMeal(dayWithMeals.day),
                onRemoveMeal: onRemoveMeal,
              ),

          const SizedBox(height: AppDimens.l),

          // Botón agregar día.
          PesaoButton(
            label: l10n
                .trainingPlanAddWeek, // Reutilizo "Agregar semana" como "Agregar día"
            icon: AppIcons.add,
            variant: PesaoButtonVariant.primary,
            isExpanded: true,
            onPressed: onAddDay,
          ),

          const SizedBox(height: AppDimens.xxl),
        ]),
      ),
    );
  }
}

// ============================================================================
// CARD DE DÍA
// ============================================================================

class _DayCard extends StatelessWidget {
  const _DayCard({
    required this.dayWithMeals,
    required this.onDelete,
    required this.onDuplicate,
    required this.onAddMeal,
    required this.onRemoveMeal,
  });

  final NutritionPlanDayWithMeals dayWithMeals;
  final VoidCallback onDelete;
  final VoidCallback onDuplicate;
  final VoidCallback onAddMeal;
  final void Function(NutritionPlanMeal) onRemoveMeal;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final day = dayWithMeals.day;
    final meals = dayWithMeals.meals;

    // Título del día: usar dayName si existe, sino "Día N".
    final dayTitle = day.dayName ?? 'Día ${day.dayNumber}';

    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.l),
      child: PesaoCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header del día.
            Row(
              children: [
                Expanded(
                  child: Text(
                    dayTitle,
                    style: AppTypography.title.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                // Botón duplicar.
                IconButton(
                  icon: const Icon(
                    AppIcons.clipboard,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: onDuplicate,
                  tooltip: l10n.trainingPlanDuplicateWeek,
                ),
                // Botón eliminar.
                IconButton(
                  icon: const Icon(
                    AppIcons.delete,
                    size: 20,
                    color: AppColors.error,
                  ),
                  onPressed: onDelete,
                ),
              ],
            ),
            const SizedBox(height: AppDimens.m),

            // Lista de comidas del día.
            if (meals.isEmpty)
              Text(
                l10n.trainingPlanDayEmpty,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              )
            else
              for (final meal in meals)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppDimens.s),
                  child: PesaoListTile(
                    title: 'Comida ${meal.mealOrder + 1}',
                    subtitle: 'Plantilla asignada',
                    trailing: IconButton(
                      icon: const Icon(
                        AppIcons.close,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: () => onRemoveMeal(meal),
                    ),
                  ),
                ),

            const SizedBox(height: AppDimens.m),

            // Botón agregar comida.
            PesaoButton(
              label: l10n.trainingPlanDayAssign,
              icon: AppIcons.add,
              variant: PesaoButtonVariant.secondary,
              isExpanded: true,
              onPressed: onAddMeal,
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// SKELETON
// ============================================================================

class _PlanDaysSkeletonSliver extends StatelessWidget {
  const _PlanDaysSkeletonSliver();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: SkeletonLoader(
        child: Padding(
          padding: EdgeInsets.all(AppDimens.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info del plan.
              SkeletonBox(height: 80),
              SizedBox(height: AppDimens.xl),
              // Días.
              SkeletonBox(height: 160),
              SizedBox(height: AppDimens.l),
              SkeletonBox(height: 160),
              SizedBox(height: AppDimens.l),
              SkeletonBox(height: 160),
            ],
          ),
        ),
      ),
    );
  }
}
