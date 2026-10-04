import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_bottom_sheet.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_input.dart';
import '../../../../shared/widgets/pesao_list_tile.dart';
import '../../../../shared/widgets/pesao_toast.dart';
import '../../domain/entities/nutrition_plan.dart';
import '../providers/nutrition_plans_controller.dart';
import '../providers/nutritionist_clients_controller.dart';

/// Formulario para crear o editar un plan nutricional.
///
/// Modo crear: sin planId.
/// Modo editar: con planId, carga los datos existentes.
class NutritionistPlanFormScreen extends ConsumerStatefulWidget {
  const NutritionistPlanFormScreen({super.key, this.planId});

  /// Si es null → modo crear. Si tiene valor → modo editar.
  final String? planId;

  @override
  ConsumerState<NutritionistPlanFormScreen> createState() =>
      _NutritionistPlanFormScreenState();
}

class _NutritionistPlanFormScreenState
    extends ConsumerState<NutritionistPlanFormScreen> {
  // Controllers de campos.
  final _nameController = TextEditingController();
  final _durationController = TextEditingController(text: '7');
  final _caloriesController = TextEditingController();
  final _proteinController = TextEditingController();
  final _carbsController = TextEditingController();
  final _fatsController = TextEditingController();
  final _notesController = TextEditingController();

  // Estado local.
  final Map<String, String?> _errors = {};
  String? _selectedClientId;
  String? _selectedClientName;
  bool _isSubmitting = false;
  bool _isEditMode = false;
  NutritionPlan? _existingPlan;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.planId != null;

    // Cargar clientes para el selector.
    ref.read(nutritionistClientsControllerProvider.notifier).load();

    if (_isEditMode) {
      _loadPlan();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _durationController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  /// Carga el plan existente para modo edición.
  void _loadPlan() {
    final state = ref.read(nutritionPlansControllerProvider);
    final plan = state.plans.where((p) => p.id == widget.planId).isEmpty
        ? null
        : state.plans.where((p) => p.id == widget.planId).first;

    if (plan != null) {
      _populateFields(plan);
    }
  }

  void _populateFields(NutritionPlan plan) {
    setState(() {
      _existingPlan = plan;
      _nameController.text = plan.name;
      _selectedClientId = plan.clientId;
      _durationController.text = plan.durationDays.toString();
      _caloriesController.text = plan.targetCaloriesKcal.toString();
      _proteinController.text = plan.targetProteinG.toString();
      _carbsController.text = plan.targetCarbsG.toString();
      _fatsController.text = plan.targetFatsG.toString();
      _notesController.text = plan.notes ?? '';

      // Resolver nombre del cliente.
      _resolveClientName(plan.clientId);
    });
  }

  void _resolveClientName(String clientId) {
    final clientsState = ref.read(nutritionistClientsControllerProvider);
    final matchingClients = clientsState.clients.where(
      (c) => c.userId == clientId,
    );
    final client = matchingClients.isEmpty ? null : matchingClients.first;
    _selectedClientName = client?.fullName ?? 'Cliente';
  }

  /// Abre el bottom sheet para seleccionar cliente.
  Future<void> _showClientSelector() async {
    final clientsState = ref.read(nutritionistClientsControllerProvider);
    final clients = clientsState.clients;

    if (clients.isEmpty) {
      final l10n = AppStrings.of(context);
      showPesaoToast(
        context,
        message: l10n.nutritionistClientsEmptyTitle,
        semanticLabel: l10n.nutritionistClientsEmptyTitle,
        variant: PesaoToastVariant.warning,
      );
      return;
    }

    final selected = await showPesaoBottomSheet<String>(
      context: context,
      builder: (sheetContext) => SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PesaoBottomSheetHeader(
              title: AppStrings.of(context).nutritionistClientsTitle,
            ),
            for (final client in clients)
              PesaoListTile(
                title: client.fullName,
                subtitle: client.email,
                onTap: () => Navigator.of(sheetContext).pop(client.userId),
              ),
          ],
        ),
      ),
    );

    if (selected == null) return;

    final selectedClient = clients.where((client) => client.userId == selected);
    final client = selectedClient.isEmpty ? null : selectedClient.first;

    if (!mounted || client == null) return;

    setState(() {
      _selectedClientId = selected;
      _selectedClientName = client.fullName;
    });
  }

  /// Valida todos los campos.
  bool _validate() {
    final l10n = AppStrings.of(context);
    _errors.clear();

    // Nombre requerido.
    if (_nameController.text.trim().isEmpty) {
      _errors['name'] = l10n.foodFormValidationError;
    }

    // Cliente requerido.
    if (_selectedClientId == null) {
      _errors['client'] = l10n.foodFormValidationError;
    }

    // Duración requerida.
    final duration = int.tryParse(_durationController.text);
    if (duration == null || duration <= 0) {
      _errors['duration'] = l10n.foodFormValidationError;
    }

    // Calorías requeridas.
    final calories = double.tryParse(_caloriesController.text);
    if (calories == null || calories <= 0) {
      _errors['calories'] = l10n.foodFormValidationError;
    }

    // Proteínas requeridas.
    final protein = double.tryParse(_proteinController.text);
    if (protein == null || protein < 0) {
      _errors['protein'] = l10n.foodFormValidationError;
    }

    // Carbs requeridas.
    final carbs = double.tryParse(_carbsController.text);
    if (carbs == null || carbs < 0) {
      _errors['carbs'] = l10n.foodFormValidationError;
    }

    // Fats requeridas.
    final fats = double.tryParse(_fatsController.text);
    if (fats == null || fats < 0) {
      _errors['fats'] = l10n.foodFormValidationError;
    }

    setState(() {});
    return _errors.isEmpty;
  }

  /// Valida y guarda el plan.
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

    final controller = ref.read(nutritionPlansControllerProvider.notifier);
    final gymId = authProvider.userGymId;
    final nutritionistId = authProvider.userId;

    if (gymId == null || nutritionistId == null || _selectedClientId == null) {
      setState(() => _isSubmitting = false);
      return;
    }

    // Construir entidad NutritionPlan.
    final plan = NutritionPlan(
      id: _isEditMode ? widget.planId! : '',
      gymId: gymId,
      clientId: _selectedClientId!,
      nutritionistId: nutritionistId,
      name: _nameController.text.trim(),
      goal: null, // Se maneja en F3 futuro con el goal type.
      targetCaloriesKcal: double.tryParse(_caloriesController.text) ?? 2000,
      targetProteinG: double.tryParse(_proteinController.text) ?? 150,
      targetCarbsG: double.tryParse(_carbsController.text) ?? 200,
      targetFatsG: double.tryParse(_fatsController.text) ?? 65,
      durationDays: int.tryParse(_durationController.text) ?? 7,
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
      isActive: true,
      createdAt: _existingPlan?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final result = _isEditMode
        ? await controller.updatePlan(plan)
        : await controller.createPlan(plan);

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    final success = result != null;
    if (success) {
      showPesaoToast(
        context,
        message: l10n.foodFormSaveSuccess,
        semanticLabel: l10n.foodFormSaveSuccess.replaceAll('✅', ''),
        variant: PesaoToastVariant.success,
      );
      context.pop();
    } else {
      showPesaoToast(
        context,
        message: l10n.foodFormSaveError,
        semanticLabel: l10n.foodFormSaveError,
        variant: PesaoToastVariant.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PesaoAppBar(
        title: _isEditMode ? l10n.nutritionPlanEdit : l10n.nutritionPlanCreate,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppDimens.l),
          children: [
            // Nombre del plan.
            PesaoInput(
              controller: _nameController,
              label: l10n.nutritionPlanName,
              hint: l10n.nutritionPlanName,
              textCapitalization: TextCapitalization.sentences,
              errorText: _errors['name'],
            ),
            const SizedBox(height: AppDimens.l),

            // Selector de cliente.
            Text(
              l10n.nutritionistClientsTitle,
              style: AppTypography.label.copyWith(
                color: _errors['client'] != null
                    ? AppColors.errorText
                    : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimens.xs),
            InkWell(
              onTap: _showClientSelector,
              borderRadius: AppDimens.inputBorderRadius,
              child: Container(
                height: AppDimens.inputHeight,
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.l),
                decoration: BoxDecoration(
                  color: AppColors.surfaceHigh,
                  borderRadius: AppDimens.inputBorderRadius,
                  border: Border.all(
                    color: _errors['client'] != null
                        ? AppColors.error
                        : AppColors.outline,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedClientName ?? l10n.nutritionistClientsTitle,
                        style: AppTypography.body.copyWith(
                          color: _selectedClientName != null
                              ? AppColors.textPrimary
                              : AppColors.textDisabled,
                        ),
                      ),
                    ),
                    const Icon(
                      AppIcons.chevronDown,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            if (_errors['client'] != null) ...[
              const SizedBox(height: AppDimens.xs),
              Text(
                _errors['client']!,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.errorText,
                ),
              ),
            ],
            const SizedBox(height: AppDimens.l),

            // Duración en días.
            PesaoInput(
              controller: _durationController,
              label: l10n.nutritionPlanDays,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              errorText: _errors['duration'],
            ),
            const SizedBox(height: AppDimens.xl),

            // Sección: Metas macro.
            Text(
              l10n.macroCalories,
              style: AppTypography.title.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(height: AppDimens.m),

            // Calorías.
            PesaoInput(
              controller: _caloriesController,
              label: l10n.foodFormCaloriesLabel,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              errorText: _errors['calories'],
            ),
            const SizedBox(height: AppDimens.l),

            // Proteínas.
            PesaoInput(
              controller: _proteinController,
              label: l10n.foodFormProteinLabel,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              errorText: _errors['protein'],
            ),
            const SizedBox(height: AppDimens.l),

            // Carbohidratos.
            PesaoInput(
              controller: _carbsController,
              label: l10n.foodFormCarbsLabel,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              errorText: _errors['carbs'],
            ),
            const SizedBox(height: AppDimens.l),

            // Grasas.
            PesaoInput(
              controller: _fatsController,
              label: l10n.foodFormFatsLabel,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              errorText: _errors['fats'],
            ),
            const SizedBox(height: AppDimens.l),

            // Notas (opcional).
            PesaoInput(
              controller: _notesController,
              label: l10n.nutritionPlanNotes,
              textCapitalization: TextCapitalization.sentences,
            ),
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
}
