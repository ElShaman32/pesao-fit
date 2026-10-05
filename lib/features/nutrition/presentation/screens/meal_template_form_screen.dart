import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_bottom_sheet.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_input.dart';
import '../../../../shared/widgets/pesao_list_tile.dart';
import '../../../../shared/widgets/pesao_search_bar.dart';
import '../../../../shared/widgets/pesao_toast.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/widgets/skeleton_loader.dart';
import '../../domain/entities/food.dart';
import '../../domain/entities/meal_template.dart';
import '../../domain/entities/meal_template_food.dart';
import '../../domain/enums/meal_type.dart';
import '../providers/foods_controller.dart';
import '../providers/meal_templates_controller.dart';

/// Formulario para crear o editar una plantilla de comida.
///
/// Modo crear: nombre + tipo → crea plantilla vacía → navega a edición.
/// Modo editar: nombre + tipo + lista de alimentos con agregar/eliminar.
class MealTemplateFormScreen extends ConsumerStatefulWidget {
  const MealTemplateFormScreen({super.key, this.templateId});

  /// Si es null → modo crear. Si tiene valor → modo editar.
  final String? templateId;

  @override
  ConsumerState<MealTemplateFormScreen> createState() =>
      _MealTemplateFormScreenState();
}

class _MealTemplateFormScreenState
    extends ConsumerState<MealTemplateFormScreen> {
  final _nameController = TextEditingController();
  final Map<String, String?> _errors = {};

  MealType _selectedMealType = MealType.breakfast;
  bool _isSubmitting = false;
  bool _isEditMode = false;
  MealTemplate? _existingTemplate;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.templateId != null;

    // Posponer llamadas a providers hasta después del build.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      // Cargar alimentos para el buscador.
      Future.microtask(() {
        if (!mounted) return;
        ref.read(foodsControllerProvider.notifier).load();
      });

      if (_isEditMode) {
        Future.microtask(_loadTemplate);
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  /// Carga la plantilla existente para modo edición.
  void _loadTemplate() {
    ref
        .read(mealTemplatesControllerProvider.notifier)
        .loadDetail(widget.templateId!);
  }

  void _populateFields(MealTemplate template) {
    setState(() {
      _existingTemplate = template;
      _nameController.text = template.name;
      _selectedMealType = template.mealType;
    });
  }

  /// Abre el selector de tipo de comida.
  Future<void> _showMealTypeSelector() async {
    final l10n = AppStrings.of(context);

    final selected = await showPesaoBottomSheet<MealType>(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const PesaoBottomSheetHeader(title: 'Tipo de comida'),
          _MealTypeOption(
            type: MealType.breakfast,
            label: l10n.foodLogBreakfast,
            onTap: () => Navigator.of(context).pop(MealType.breakfast),
          ),
          _MealTypeOption(
            type: MealType.lunch,
            label: l10n.foodLogLunch,
            onTap: () => Navigator.of(context).pop(MealType.lunch),
          ),
          _MealTypeOption(
            type: MealType.dinner,
            label: l10n.foodLogDinner,
            onTap: () => Navigator.of(context).pop(MealType.dinner),
          ),
          _MealTypeOption(
            type: MealType.morningSnack,
            label: 'Merienda de la mañana',
            onTap: () => Navigator.of(context).pop(MealType.morningSnack),
          ),
          _MealTypeOption(
            type: MealType.afternoonSnack,
            label: 'Merienda de la tarde',
            onTap: () => Navigator.of(context).pop(MealType.afternoonSnack),
          ),
        ],
      ),
    );

    if (selected != null) {
      setState(() => _selectedMealType = selected);
    }
  }

  /// Valida los campos básicos.
  bool _validate() {
    final l10n = AppStrings.of(context);
    _errors.clear();

    if (_nameController.text.trim().isEmpty) {
      _errors['name'] = l10n.foodFormValidationError;
    }

    setState(() {});
    return _errors.isEmpty;
  }

  /// Crea o actualiza la plantilla.
  Future<void> _submit() async {
    final l10n = AppStrings.of(context);

    if (!_validate()) {
      showPesaoToast(
        context,
        message: l10n.foodFormValidationError,
        semanticLabel: l10n.foodFormValidationError,
        variant: PesaoToastVariant.warning,
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final controller = ref.read(mealTemplatesControllerProvider.notifier);
    final gymId = authProvider.userGymId;
    final nutritionistId = authProvider.userId;

    if (gymId == null || nutritionistId == null) {
      setState(() => _isSubmitting = false);
      return;
    }

    if (_isEditMode && _existingTemplate != null) {
      // Modo editar: actualizar nombre y tipo.
      final updated = _existingTemplate!.copyWith(
        name: _nameController.text.trim(),
        mealType: _selectedMealType,
      );
      final success = await controller.updateTemplate(updated);

      if (!mounted) return;
      setState(() => _isSubmitting = false);

      if (success) {
        showPesaoToast(
          context,
          message: l10n.foodFormSaveSuccess,
          semanticLabel: l10n.foodFormSaveSuccess.replaceAll('✅', ''),
          variant: PesaoToastVariant.success,
        );
        context.pop();
      }
    } else {
      // Modo crear: crear plantilla vacía y navegar a edición.
      final template = MealTemplate(
        id: '',
        gymId: gymId,
        nutritionistId: nutritionistId,
        name: _nameController.text.trim(),
        mealType: _selectedMealType,
        totalCaloriesKcal: 0,
        totalProteinG: 0,
        totalCarbsG: 0,
        totalFatsG: 0,
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final created = await controller.createTemplate(template);

      if (!mounted) return;
      setState(() => _isSubmitting = false);

      if (created != null) {
        showPesaoToast(
          context,
          message: l10n.foodFormSaveSuccess,
          semanticLabel: l10n.foodFormSaveSuccess.replaceAll('✅', ''),
          variant: PesaoToastVariant.success,
        );
        // Navegar al modo edición para agregar alimentos.
        context.pop();
        await context.push(
          RouteNames.nutritionistTemplateEdit.replaceAll(
            ':templateId',
            created.id,
          ),
        );
      }
    }
  }

  /// Abre el buscador de alimentos para agregar a la plantilla.
  Future<void> _showFoodSearch() async {
    final templateId = widget.templateId;
    if (templateId == null) return;

    final l10n = AppStrings.of(context);
    final foodsState = ref.read(foodsControllerProvider);
    final searchController = TextEditingController();
    List<Food> filteredFoods = foodsState.foods;

    await showPesaoBottomSheet<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                        unawaited(_addFoodToTemplate(food));
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Agrega un alimento a la plantilla (modo edición).
  Future<void> _addFoodToTemplate(Food food) async {
    final controller = ref.read(mealTemplatesControllerProvider.notifier);
    final templateId = widget.templateId;
    if (templateId == null) return;

    await controller.addFoodToTemplate(
      templateId: templateId,
      foodId: food.id,
      quantity: food.servingSize,
      orderIndex: 0,
    );
  }

  /// Elimina un alimento de la plantilla.
  Future<void> _removeFood(String templateFoodId) async {
    final controller = ref.read(mealTemplatesControllerProvider.notifier);
    await controller.removeFoodFromTemplate(templateFoodId);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final templatesState = ref.watch(mealTemplatesControllerProvider);

    // En modo edición, obtener el detalle cargado.
    final templateDetail = _isEditMode ? templatesState.selectedTemplate : null;
    final templateFoods = _isEditMode
        ? templatesState.selectedFoods
        : <MealTemplateFood>[];
    final isLoadingDetail = _isEditMode && templatesState.isLoadingDetail;

    // Si el detalle se cargó y no hemos popularizado aún, hacerlo.
    if (_isEditMode && templateDetail != null && _existingTemplate == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _populateFields(templateDetail);
      });
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PesaoAppBar(
        title: _isEditMode
            ? l10n.mealTemplateFormTitle
            : l10n.mealTemplateFormTitle,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppDimens.l),
          children: [
            // Nombre de la plantilla.
            PesaoInput(
              controller: _nameController,
              label: l10n.foodFormNameLabel,
              hint: l10n.mealTemplateFormTitle,
              prefixIcon: const Icon(Icons.note),
              textCapitalization: TextCapitalization.sentences,
              errorText: _errors['name'],
            ),
            const SizedBox(height: AppDimens.l),

            // Selector de tipo de comida.
            Text(
              l10n.foodLogBreakfast,
              style: AppTypography.label.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(height: AppDimens.xs),
            InkWell(
              onTap: _showMealTypeSelector,
              borderRadius: AppDimens.inputBorderRadius,
              child: Container(
                height: AppDimens.inputHeight,
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.l),
                decoration: BoxDecoration(
                  color: AppColors.surfaceHigh,
                  borderRadius: AppDimens.inputBorderRadius,
                  border: Border.all(color: AppColors.outline),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _mealTypeLabel(context, _selectedMealType),
                        style: AppTypography.body.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const Icon(
                      AppIcons.chevronRight,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppDimens.xl),

            // Solo en modo edición: lista de alimentos.
            if (_isEditMode) ...[
              SectionHeader(title: l10n.foodFormTitle),
              const SizedBox(height: AppDimens.m),

              if (isLoadingDetail)
                const SkeletonLoader(child: SizedBox(height: 120))
              else if (templateFoods.isEmpty)
                Text(
                  l10n.foodSearchEmptyTitle,
                  style: AppTypography.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                )
              else
                Column(
                  children: [
                    for (final tf in templateFoods)
                      _TemplateFoodTile(
                        templateFood: tf,
                        onRemove: () => _removeFood(tf.id),
                      ),
                  ],
                ),

              const SizedBox(height: AppDimens.m),

              // Botón agregar alimento.
              PesaoButton(
                label: l10n.foodSearchHint,
                icon: AppIcons.add,
                variant: PesaoButtonVariant.secondary,
                isExpanded: true,
                onPressed: _showFoodSearch,
              ),

              const SizedBox(height: AppDimens.l),

              // Totales de la plantilla.
              if (templateDetail != null)
                _TemplateTotalsCard(template: templateDetail),
            ],

            const SizedBox(height: AppDimens.xxl),

            // Botón guardar.
            PesaoButton(
              label: l10n.commonSave,
              onPressed: _isSubmitting ? null : _submit,
              loading: _isSubmitting,
              variant: PesaoButtonVariant.primary,
            ),

            const SizedBox(height: AppDimens.xxl),
          ],
        ),
      ),
    );
  }

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
}

// ============================================================================
// OPCIÓN DE TIPO DE COMIDA (para el bottom sheet)
// ============================================================================

class _MealTypeOption extends StatelessWidget {
  const _MealTypeOption({
    required this.type,
    required this.label,
    required this.onTap,
  });

  final MealType type;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PesaoListTile(title: label, onTap: onTap);
  }
}

// ============================================================================
// TILE DE ALIMENTO EN LA PLANTILLA
// ============================================================================

class _TemplateFoodTile extends StatelessWidget {
  const _TemplateFoodTile({required this.templateFood, required this.onRemove});

  final MealTemplateFood templateFood;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.s),
      child: PesaoListTile(
        title: 'Alimento #${templateFood.orderIndex + 1}',
        subtitle: '${templateFood.quantity.round()}g',
        trailing: IconButton(
          icon: const Icon(AppIcons.delete, color: AppColors.error, size: 20),
          onPressed: onRemove,
        ),
      ),
    );
  }
}

// ============================================================================
// CARD DE TOTALES
// ============================================================================

class _TemplateTotalsCard extends StatelessWidget {
  const _TemplateTotalsCard({required this.template});

  final MealTemplate template;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return Container(
      padding: const EdgeInsets.all(AppDimens.l),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppDimens.cardBorderRadius,
        border: Border.all(color: AppColors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.macroCalories,
            style: AppTypography.title.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppDimens.m),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _MacroValue(
                label: l10n.macroCalories,
                value: '${template.totalCaloriesKcal.round()}',
                unit: 'kcal',
              ),
              _MacroValue(
                label: l10n.macroProtein,
                value: '${template.totalProteinG.round()}',
                unit: 'g',
              ),
              _MacroValue(
                label: l10n.macroCarbs,
                value: '${template.totalCarbsG.round()}',
                unit: 'g',
              ),
              _MacroValue(
                label: l10n.macroFats,
                value: '${template.totalFatsG.round()}',
                unit: 'g',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MacroValue extends StatelessWidget {
  const _MacroValue({
    required this.label,
    required this.value,
    required this.unit,
  });

  final String label;
  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.title.copyWith(color: AppColors.primary),
        ),
        Text(
          unit,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
