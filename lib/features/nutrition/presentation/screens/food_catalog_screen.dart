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
import '../../../../shared/widgets/pesao_list_tile.dart';
import '../../../../shared/widgets/pesao_search_bar.dart';
import '../../../../shared/widgets/skeleton_loader.dart';
import '../../domain/entities/food.dart';
import '../providers/foods_controller.dart';

/// Catálogo de alimentos del gimnasio (global + personalizados).
///
/// design-system.md §11: 5 estados obligatorios.
/// Catálogo de widgets: PesaoSearchBar + PesaoListTile + EmptyState.
class FoodCatalogScreen extends ConsumerStatefulWidget {
  const FoodCatalogScreen({super.key});

  @override
  ConsumerState<FoodCatalogScreen> createState() => _FoodCatalogScreenState();
}

class _FoodCatalogScreenState extends ConsumerState<FoodCatalogScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _goToCreate() {
    context.push(RouteNames.nutritionistFoodCreate);
  }

  void _goToEdit(Food food) {
    context.push(
      RouteNames.nutritionistFoodEdit.replaceAll(':foodId', food.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final state = ref.watch(foodsControllerProvider);
    final controller = ref.read(foodsControllerProvider.notifier);
    final connectivityAsync = ref.watch(connectivityProvider);
    final isOnline = connectivityAsync.value ?? true;

    // Búsqueda local sobre la lista ya cargada.
    final filteredFoods = _searchQuery.isEmpty
        ? state.foods
        : state.foods.where((f) {
            final name = f.name.toLowerCase();
            final brand = (f.brand ?? '').toLowerCase();
            final query = _searchQuery.toLowerCase();
            return name.contains(query) || brand.contains(query);
          }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PesaoAppBar(title: l10n.nutritionistStatsFoods),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: AppColors.surface,
          onRefresh: controller.load,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // Buscador + botón agregar.
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimens.l),
                  child: Column(
                    children: [
                      PesaoSearchBar(
                        controller: _searchController,
                        hintText: l10n.foodSearchHint,
                        onChanged: (value) {
                          setState(() => _searchQuery = value);
                        },
                      ),
                      const SizedBox(height: AppDimens.m),
                      // Botón "Agregar alimento" dentro de la pantalla
                      // (el shell no tiene FAB para esta ruta).
                      PesaoButton(
                        label: l10n.foodFormTitle,
                        icon: AppIcons.add,
                        variant: PesaoButtonVariant.primary,
                        isExpanded: true,
                        onPressed: _goToCreate,
                      ),
                    ],
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
              if (state.isLoading && state.foods.isEmpty)
                const _FoodsSkeletonSliver()
              else if (state.error != null && state.foods.isEmpty)
                SliverFillRemaining(
                  child: ErrorState(
                    title: l10n.errorGenericTitle,
                    body: l10n.errorGenericBody,
                    actionLabel: l10n.commonRetry,
                    onRetry: controller.load,
                  ),
                )
              else if (filteredFoods.isEmpty && _searchQuery.isNotEmpty)
                // Búsqueda sin resultados.
                SliverFillRemaining(
                  child: EmptyState(
                    icon: AppIcons.search,
                    title: l10n.foodSearchEmptyTitle,
                    body: l10n.foodSearchEmptyBody,
                  ),
                )
              else if (filteredFoods.isEmpty)
                // Catálogo vacío.
                SliverFillRemaining(
                  child: EmptyState(
                    icon: AppIcons.nutrition,
                    title: l10n.nutritionPlansEmptyTitle,
                    body: l10n.nutritionPlansEmptyBody,
                  ),
                )
              else
                // Lista de alimentos.
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimens.l),
                  sliver: SliverList.builder(
                    itemCount: filteredFoods.length,
                    itemBuilder: (context, index) {
                      final food = filteredFoods[index];
                      return _FoodTile(
                        food: food,
                        onTap: () => _goToEdit(food),
                      );
                    },
                  ),
                ),

              // Espacio inferior para evitar que el último tile quede
              // tapado por el FAB del shell (aunque aquí no hay FAB).
              const SliverToBoxAdapter(child: SizedBox(height: AppDimens.xxxl)),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// TILE DE ALIMENTO
// ============================================================================

class _FoodTile extends StatelessWidget {
  const _FoodTile({required this.food, required this.onTap});

  final Food food;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    // Subtítulo: marca + kcal por porción.
    final subtitle = StringBuffer();
    if (food.brand != null && food.brand!.isNotEmpty) {
      subtitle.write(food.brand);
      subtitle.write(' · ');
    }
    subtitle.write(
      '${food.caloriesKcal.round()} kcal / ${food.servingSize.round()}${food.servingUnit}',
    );

    // Badge "Biblioteca" o "Del gym".
    final badgeLabel = food.isGlobal
        ? l10n.exercisesGlobalBadge
        : l10n.exercisesCustomBadge;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.s),
      child: PesaoListTile(
        title: food.name,
        subtitle: subtitle.toString(),
        leading: const CircleAvatar(
          backgroundColor: AppColors.surfaceHigh,
          child: Icon(AppIcons.nutrition, color: AppColors.primary, size: 20),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              badgeLabel,
              style: AppTypography.label.copyWith(
                color: food.isGlobal
                    ? AppColors.primaryText
                    : AppColors.successText,
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

class _FoodsSkeletonSliver extends StatelessWidget {
  const _FoodsSkeletonSliver();

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
              SizedBox(height: AppDimens.s),
              SkeletonListTile(hasSubtitle: true),
            ],
          ),
        ),
      ),
    );
  }
}
