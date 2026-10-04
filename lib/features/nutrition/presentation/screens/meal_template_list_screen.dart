import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/connectivity_provider.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/offline_banner.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_list_tile.dart';
import '../../../../shared/widgets/skeleton_loader.dart';
import '../../domain/entities/meal_template.dart';
import '../../domain/enums/meal_type.dart';
import '../providers/meal_templates_controller.dart';

/// Lista de plantillas de comida del nutricionista.
///
/// design-system.md §11: 5 estados obligatorios.
/// El shell no tiene branch para templates, así que el botón de crear
/// está dentro de la pantalla.
class MealTemplateListScreen extends ConsumerStatefulWidget {
  const MealTemplateListScreen({super.key});

  @override
  ConsumerState<MealTemplateListScreen> createState() =>
      _MealTemplateListScreenState();
}

class _MealTemplateListScreenState
    extends ConsumerState<MealTemplateListScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    ref.read(mealTemplatesControllerProvider.notifier).load();
  }

  void _goToCreate() {
    context.push(RouteNames.nutritionistTemplateCreate);
  }

  void _goToEdit(MealTemplate template) {
    context.push(
      RouteNames.nutritionistTemplateEdit.replaceAll(
        ':templateId',
        template.id,
      ),
    );
  }

  /// Retorna el ícono según el tipo de comida.
  IconData _mealTypeIcon(MealType type) {
    return switch (type) {
      MealType.breakfast => AppIcons.nutrition,
      MealType.lunch => AppIcons.nutrition,
      MealType.dinner => AppIcons.nutrition,
      MealType.morningSnack => AppIcons.nutritionOutline,
      MealType.afternoonSnack => AppIcons.nutritionOutline,
      MealType.preWorkout => AppIcons.nutritionOutline,
      MealType.postWorkout => AppIcons.nutritionOutline,
    };
  }

  /// Retorna el label del tipo de comida.
  String _mealTypeLabel(BuildContext context, MealType type) {
    final l10n = AppStrings.of(context);
    return switch (type) {
      MealType.breakfast => l10n.foodLogBreakfast,
      MealType.lunch => l10n.foodLogLunch,
      MealType.dinner => l10n.foodLogDinner,
      MealType.morningSnack => l10n.foodLogSnack,
      MealType.afternoonSnack => l10n.foodLogSnack,
      MealType.preWorkout => l10n.foodLogSnack,
      MealType.postWorkout => l10n.foodLogSnack,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final state = ref.watch(mealTemplatesControllerProvider);
    final connectivityAsync = ref.watch(connectivityProvider);
    final isOnline = connectivityAsync.value ?? true;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PesaoAppBar(title: l10n.nutritionistTemplatesTitle),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: AppColors.surface,
          onRefresh: () async => _loadData(),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // Botón crear plantilla.
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimens.l),
                  child: PesaoButton(
                    label: l10n.mealTemplateFormTitle,
                    icon: AppIcons.add,
                    variant: PesaoButtonVariant.primary,
                    isExpanded: true,
                    onPressed: _goToCreate,
                  ),
                ),
              ),

              // OfflineBanner.
              if (!isOnline)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppDimens.l),
                    child: OfflineBanner(),
                  ),
                ),

              // Contenido según estado.
              if (state.isLoading && state.templates.isEmpty)
                const _TemplatesSkeletonSliver()
              else if (state.error != null && state.templates.isEmpty)
                SliverFillRemaining(
                  child: ErrorState(
                    title: l10n.errorGenericTitle,
                    body: l10n.errorGenericBody,
                    actionLabel: l10n.commonRetry,
                    onRetry: _loadData,
                  ),
                )
              else if (state.templates.isEmpty)
                // Sin plantillas.
                SliverFillRemaining(
                  child: EmptyState(
                    icon: AppIcons.nutrition,
                    title: l10n.nutritionPlansEmptyTitle,
                    body: l10n.nutritionPlansEmptyBody,
                  ),
                )
              else
                // Lista de plantillas.
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimens.l),
                  sliver: SliverList.builder(
                    itemCount: state.templates.length,
                    itemBuilder: (context, index) {
                      final template = state.templates[index];
                      return _TemplateTile(
                        template: template,
                        mealTypeLabel: _mealTypeLabel(
                          context,
                          template.mealType,
                        ),
                        icon: _mealTypeIcon(template.mealType),
                        onTap: () => _goToEdit(template),
                      );
                    },
                  ),
                ),

              // Espacio inferior.
              const SliverToBoxAdapter(child: SizedBox(height: AppDimens.xxxl)),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// TILE DE PLANTILLA
// ============================================================================

class _TemplateTile extends StatelessWidget {
  const _TemplateTile({
    required this.template,
    required this.mealTypeLabel,
    required this.icon,
    required this.onTap,
  });

  final MealTemplate template;
  final String mealTypeLabel;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // Subtítulo: tipo de comida + kcal totales.
    final subtitle =
        '$mealTypeLabel · ${template.totalCaloriesKcal.round()} kcal';

    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.s),
      child: PesaoListTile(
        title: template.name,
        subtitle: subtitle,
        leading: CircleAvatar(
          backgroundColor: AppColors.surfaceHigh,
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        trailing: const Icon(
          AppIcons.chevronRight,
          color: AppColors.textSecondary,
          size: 20,
        ),
        onTap: onTap,
      ),
    );
  }
}

// ============================================================================
// SKELETON
// ============================================================================

class _TemplatesSkeletonSliver extends StatelessWidget {
  const _TemplatesSkeletonSliver();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: SkeletonLoader(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimens.l),
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
