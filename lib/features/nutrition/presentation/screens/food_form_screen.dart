import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_input.dart';
import '../../../../shared/widgets/pesao_toast.dart';
import '../../domain/entities/food.dart';
import '../providers/foods_controller.dart';

/// Formulario para crear o editar un alimento del catálogo.
///
/// design-system.md §11: formulario con validaciones suaves.
/// Validación manual (PesaoInput no tiene validator).
class FoodFormScreen extends ConsumerStatefulWidget {
  const FoodFormScreen({super.key, this.foodId});

  /// Si es null → modo crear. Si tiene valor → modo editar.
  final String? foodId;

  @override
  ConsumerState<FoodFormScreen> createState() => _FoodFormScreenState();
}

class _FoodFormScreenState extends ConsumerState<FoodFormScreen> {
  // Controllers de campos.
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _servingController = TextEditingController(text: '100');
  final _caloriesController = TextEditingController();
  final _proteinController = TextEditingController();
  final _carbsController = TextEditingController();
  final _fatsController = TextEditingController();
  final _fiberController = TextEditingController();
  final _sugarController = TextEditingController();
  final _sodiumController = TextEditingController();

  // Errores de validación por campo.
  final Map<String, String?> _errors = {};

  bool _isSubmitting = false;
  bool _isEditMode = false;
  Food? _existingFood;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.foodId != null;
    if (_isEditMode) {
      _loadFood();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _servingController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatsController.dispose();
    _fiberController.dispose();
    _sugarController.dispose();
    _sodiumController.dispose();
    super.dispose();
  }

  /// Carga el alimento existente para modo edición.
  Future<void> _loadFood() async {
    final state = ref.read(foodsControllerProvider);

    // Buscar en la lista cargada (si ya está).
    final food = state.foods.where((f) => f.id == widget.foodId).isEmpty
        ? null
        : state.foods.where((f) => f.id == widget.foodId).first;

    if (food != null) {
      _populateFields(food);
    }
  }

  void _populateFields(Food food) {
    setState(() {
      _existingFood = food;
      _nameController.text = food.name;
      _brandController.text = food.brand ?? '';
      _servingController.text = food.servingSize.toString();
      _caloriesController.text = food.caloriesKcal.toString();
      _proteinController.text = food.proteinG.toString();
      _carbsController.text = food.carbsG.toString();
      _fatsController.text = food.fatsG.toString();
      _fiberController.text = food.fiberG?.toString() ?? '';
      _sugarController.text = food.sugarG?.toString() ?? '';
      _sodiumController.text = food.sodiumMg?.toString() ?? '';
    });
  }

  /// Valida todos los campos. Retorna true si todos son válidos.
  bool _validate() {
    final l10n = AppStrings.of(context);
    _errors.clear();

    // Nombre requerido.
    if (_nameController.text.trim().isEmpty) {
      _errors['name'] = l10n.foodFormValidationError;
    }

    // Porción requerida.
    final serving = double.tryParse(_servingController.text);
    if (serving == null || serving <= 0) {
      _errors['serving'] = l10n.foodFormValidationError;
    }

    // Calorías requeridas.
    final calories = double.tryParse(_caloriesController.text);
    if (calories == null || calories < 0) {
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

    // Opcionales: solo validar si tienen valor.
    if (_fiberController.text.isNotEmpty) {
      final fiber = double.tryParse(_fiberController.text);
      if (fiber == null || fiber < 0) {
        _errors['fiber'] = l10n.foodFormValidationError;
      }
    }

    if (_sugarController.text.isNotEmpty) {
      final sugar = double.tryParse(_sugarController.text);
      if (sugar == null || sugar < 0) {
        _errors['sugar'] = l10n.foodFormValidationError;
      }
    }

    if (_sodiumController.text.isNotEmpty) {
      final sodium = double.tryParse(_sodiumController.text);
      if (sodium == null || sodium < 0) {
        _errors['sodium'] = l10n.foodFormValidationError;
      }
    }

    setState(() {});
    return _errors.isEmpty;
  }

  /// Valida y guarda el alimento.
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

    final controller = ref.read(foodsControllerProvider.notifier);
    final gymId = authProvider.userGymId;
    final userId = authProvider.userId;

    if (gymId == null || userId == null) {
      setState(() => _isSubmitting = false);
      return;
    }

    // Construir entidad Food desde los campos.
    final food = Food(
      id: _isEditMode ? widget.foodId! : '',
      gymId: gymId,
      name: _nameController.text.trim(),
      brand: _brandController.text.trim().isEmpty
          ? null
          : _brandController.text.trim(),
      servingSize: double.tryParse(_servingController.text) ?? 100,
      servingUnit: 'g',
      caloriesKcal: double.tryParse(_caloriesController.text) ?? 0,
      proteinG: double.tryParse(_proteinController.text) ?? 0,
      carbsG: double.tryParse(_carbsController.text) ?? 0,
      fatsG: double.tryParse(_fatsController.text) ?? 0,
      fiberG: double.tryParse(_fiberController.text),
      sugarG: double.tryParse(_sugarController.text),
      sodiumMg: double.tryParse(_sodiumController.text),
      isVerified: false,
      isSystem: false,
      createdBy: userId,
      source: 'local',
      isActive: true,
      createdAt: _existingFood?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final success = _isEditMode
        ? await controller.updateFood(food)
        : await controller.createFood(food);

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
        title: _isEditMode ? l10n.foodFormEditTitle : l10n.foodFormTitle,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppDimens.l),
          children: [
            // Nombre (requerido).
            PesaoInput(
              controller: _nameController,
              label: l10n.foodFormNameLabel,
              hint: l10n.foodFormNameHint,
              textCapitalization: TextCapitalization.sentences,
              errorText: _errors['name'],
            ),
            const SizedBox(height: AppDimens.l),

            // Marca (opcional).
            PesaoInput(
              controller: _brandController,
              label: l10n.foodFormBrandLabel,
              hint: l10n.foodFormBrandHint,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: AppDimens.l),

            // Porción de referencia.
            PesaoInput(
              controller: _servingController,
              label: l10n.foodFormServingLabel,
              hint: l10n.foodServingDefault,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              errorText: _errors['serving'],
            ),
            const SizedBox(height: AppDimens.xl),

            // Sección de macros.
            Text(
              l10n.macroCalories,
              style: AppTypography.title.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(height: AppDimens.m),

            // Calorías (requerido).
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

            // Proteínas (requerido).
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

            // Carbohidratos (requerido).
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

            // Grasas (requerido).
            PesaoInput(
              controller: _fatsController,
              label: l10n.foodFormFatsLabel,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              errorText: _errors['fats'],
            ),
            const SizedBox(height: AppDimens.xl),

            // Sección de opcionales.
            Text(
              l10n.foodFormOptionalSection,
              style: AppTypography.title.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(height: AppDimens.m),

            // Fibra (opcional).
            PesaoInput(
              controller: _fiberController,
              label: l10n.foodFormFiberLabel,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              errorText: _errors['fiber'],
            ),
            const SizedBox(height: AppDimens.l),

            // Azúcar (opcional).
            PesaoInput(
              controller: _sugarController,
              label: l10n.foodFormSugarLabel,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              errorText: _errors['sugar'],
            ),
            const SizedBox(height: AppDimens.l),

            // Sodio (opcional).
            PesaoInput(
              controller: _sodiumController,
              label: l10n.foodFormSodiumLabel,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              errorText: _errors['sodium'],
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
