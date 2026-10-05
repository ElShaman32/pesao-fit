import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_bottom_sheet.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_list_tile.dart';
import '../../../../shared/widgets/pesao_search_bar.dart';
import '../../../../shared/widgets/pesao_toast.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../domain/entities/food.dart';
import '../../domain/entities/food_log_item.dart';
import '../../domain/enums/meal_type.dart';
import '../providers/client_nutrition_controller.dart';
import '../providers/foods_controller.dart';

/// Pantalla para registrar comidas del día.
class ClientFoodLogScreen extends ConsumerStatefulWidget {
  const ClientFoodLogScreen({super.key});

  @override
  ConsumerState<ClientFoodLogScreen> createState() =>
      _ClientFoodLogScreenState();
}

class _ClientFoodLogScreenState extends ConsumerState<ClientFoodLogScreen> {
  @override
  void initState() {
    super.initState();
    // Asegurar que los alimentos estén cargados para el buscador
    Future.microtask(() {
      if (!mounted) return;
      ref.read(foodsControllerProvider.notifier).load();
    });
  }

  Future<void> _showFoodSearch(MealType mealType) async {
    final foodsState = ref.read(foodsControllerProvider);
    final searchController = TextEditingController();
    List<Food> filteredFoods = foodsState.foods;
    final l10n = AppStrings.of(context);

    await showPesaoBottomSheet<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) {
          return Padding(
            padding: const EdgeInsets.all(AppDimens.l),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PesaoBottomSheetHeader(title: l10n.foodSearchHint),
                const SizedBox(height: AppDimens.m),
                PesaoSearchBar(
                  controller: searchController,
                  hintText: l10n.foodSearchHint,
                  onChanged: (value) {
                    setSheetState(() {
                      filteredFoods = value.isEmpty
                          ? foodsState.foods
                          : foodsState.foods
                                .where(
                                  (f) => f.name.toLowerCase().contains(
                                    value.toLowerCase(),
                                  ),
                                )
                                .toList();
                    });
                  },
                ),
                const SizedBox(height: AppDimens.m),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredFoods.length,
                    itemBuilder: (context, index) {
                      final food = filteredFoods[index];
                      return PesaoListTile(
                        title: food.name,
                        subtitle:
                            '${food.caloriesKcal.round()} kcal / ${food.servingSize.round()}${food.servingUnit}',
                        onTap: () {
                          Navigator.of(context).pop();
                          _addFood(food, mealType);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _addFood(Food food, MealType mealType) async {
    final controller = ref.read(clientNutritionControllerProvider.notifier);
    await controller.addFoodToLog(
      foodId: food.id,
      mealType: mealType,
      quantity: food.servingSize, // Por defecto 1 porción
    );

    if (!mounted) return;
    showPesaoToast(
      context,
      message: AppStrings.of(context).foodAddSuccess,
      semanticLabel: 'Comida registrada',
      variant: PesaoToastVariant.success,
    );
  }

  String _getMealTypeName(MealType type, AppStrings l10n) {
    return switch (type) {
      MealType.breakfast => l10n.foodLogBreakfast,
      MealType.lunch => l10n.foodLogLunch,
      MealType.dinner => l10n.foodLogDinner,
      _ => l10n.foodLogSnack,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final state = ref.watch(clientNutritionControllerProvider);

    // Agrupar items por tipo de comida
    final itemsByMeal = <MealType, List<FoodLogItem>>{};
    for (final item in state.dailyItems) {
      itemsByMeal.putIfAbsent(item.mealType, () => []).add(item);
    }

    final mealTypesToShow = [
      MealType.breakfast,
      MealType.lunch,
      MealType.dinner,
      MealType.morningSnack,
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const PesaoAppBar(title: 'Comidas de hoy'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppDimens.l),
          children: [
            for (final mealType in mealTypesToShow)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(title: _getMealTypeName(mealType, l10n)),
                  const SizedBox(height: AppDimens.s),

                  if (itemsByMeal[mealType]?.isEmpty ?? true)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppDimens.m),
                      child: Text(
                        'Sin registros',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textDisabled,
                        ),
                      ),
                    )
                  else
                    Column(
                      children: [
                        for (final item in itemsByMeal[mealType]!)
                          Padding(
                            padding: const EdgeInsets.only(bottom: AppDimens.s),
                            child: PesaoListTile(
                              title:
                                  'Alimento', // TODO: Join con nombre del food en F3 futuro
                              subtitle:
                                  '${item.quantity.round()}g · ${item.caloriesKcal.round()} kcal',
                              trailing: IconButton(
                                icon: const Icon(
                                  AppIcons.close,
                                  color: AppColors.error,
                                  size: 20,
                                ),
                                onPressed: () {
                                  ref
                                      .read(
                                        clientNutritionControllerProvider
                                            .notifier,
                                      )
                                      .removeFoodFromLog(item.id);
                                },
                              ),
                            ),
                          ),
                      ],
                    ),

                  PesaoButton(
                    label: 'Agregar',
                    icon: AppIcons.add,
                    variant: PesaoButtonVariant.secondary,
                    isExpanded: true,
                    onPressed: () => _showFoodSearch(mealType),
                  ),
                  const SizedBox(height: AppDimens.xl),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
