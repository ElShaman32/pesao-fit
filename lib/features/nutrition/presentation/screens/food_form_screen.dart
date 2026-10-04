import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/connectivity_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/offline_banner.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_input.dart';
import '../../../../shared/widgets/pesao_toast.dart';
import '../providers/foods_controller.dart';

/// Formulario para crear un alimento personalizado del gym.
class FoodFormScreen extends ConsumerStatefulWidget {
  const FoodFormScreen({super.key});

  @override
  ConsumerState<FoodFormScreen> createState() => _FoodFormScreenState();
}

class _FoodFormScreenState extends ConsumerState<FoodFormScreen> {
  // Controladores.
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _servingSizeController = TextEditingController(text: '100');
  final _servingUnitController = TextEditingController(text: 'g');
  final _caloriesController = TextEditingController();
  final _proteinController = TextEditingController();
  final _carbsController = TextEditingController();
  final _fatsController = TextEditingController();
  final _fiberController = TextEditingController();
  final _sugarController = TextEditingController();
  final _sodiumController = TextEditingController();

  // Errores por campo (null = sin error).
  String? _nameError;
  String? _servingSizeError;
  String? _caloriesError;
  String? _proteinError;
  String? _carbsError;
  String? _fatsError;

  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _barcodeController.dispose();
    _servingSizeController.dispose();
    _servingUnitController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatsController.dispose();
    _fiberController.dispose();
    _sugarController.dispose();
    _sodiumController.dispose();
    super.dispose();
  }

  /// Limpia errores cuando el usuario escribe en un campo.
  void _clearErrorsOnType(String Function() _) {
    setState(() {
      _nameError = null;
      _servingSizeError = null;
      _caloriesError = null;
      _proteinError = null;
      _carbsError = null;
      _fatsError = null;
    });
  }

  /// Valida todos los campos requeridos.
  bool _validate() {
    final l10n = AppStrings.of(context);
    bool isValid = true;

    // Nombre: requerido.
    if (_nameController.text.trim().isEmpty) {
      _nameError = l10n.foodFormValidationError;
      isValid = false;
    }

    // Serving size: número positivo.
    final servingSize = double.tryParse(_servingSizeController.text.trim());
    if (servingSize == null || servingSize <= 0) {
      _servingSizeError = l10n.foodFormValidationError;
      isValid = false;
    }

    // Calories: número >= 0.
    final calories = double.tryParse(_caloriesController.text.trim());
    if (calories == null || calories < 0) {
      _caloriesError = l10n.foodFormValidationError;
      isValid = false;
    }

    // Proteínas: número >= 0.
    final protein = double.tryParse(_proteinController.text.trim());
    if (protein == null || protein < 0) {
      _proteinError = l10n.foodFormValidationError;
      isValid = false;
    }

    // Carbos: número >= 0.
    final carbs = double.tryParse(_carbsController.text.trim());
    if (carbs == null || carbs < 0) {
      _carbsError = l10n.foodFormValidationError;
      isValid = false;
    }

    // Grasas: número >= 0.
    final fats = double.tryParse(_fatsController.text.trim());
    if (fats == null || fats < 0) {
      _fatsError = l10n.foodFormValidationError;
      isValid = false;
    }

    setState(() {});
    return isValid;
  }

  Future<void> _submit() async {
    if (!_validate()) return;

    setState(() => _isSubmitting = true);

    final l10n = AppStrings.of(context);

    final result = await ref
        .read(foodsControllerProvider.notifier)
        .createFood(
          name: _nameController.text.trim(),
          brand: _brandController.text.trim().isEmpty
              ? null
              : _brandController.text.trim(),
          barcode: _barcodeController.text.trim().isEmpty
              ? null
              : _barcodeController.text.trim(),
          servingSize: double.parse(_servingSizeController.text.trim()),
          servingUnit: _servingUnitController.text.trim(),
          caloriesKcal: double.parse(_caloriesController.text.trim()),
          proteinG: double.parse(_proteinController.text.trim()),
          carbsG: double.parse(_carbsController.text.trim()),
          fatsG: double.parse(_fatsController.text.trim()),
          fiberG: _fiberController.text.trim().isEmpty
              ? null
              : double.tryParse(_fiberController.text.trim()),
          sugarG: _sugarController.text.trim().isEmpty
              ? null
              : double.tryParse(_sugarController.text.trim()),
          sodiumMg: _sodiumController.text.trim().isEmpty
              ? null
              : double.tryParse(_sodiumController.text.trim()),
        );

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    result.when(
      idle: () {},
      loading: () {},
      success: (_) {
        showPesaoToast(
          context,
          message: l10n.foodFormSaveSuccess,
          semanticLabel: l10n.foodFormSaveSuccess,
          variant: PesaoToastVariant.success,
        );
        context.pop();
      },
      failure: (error) {
        showPesaoToast(
          context,
          message: l10n.foodFormSaveError,
          semanticLabel: l10n.foodFormSaveError,
          variant: PesaoToastVariant.error,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final connectivityAsync = ref.watch(connectivityProvider);
    final isOnline = connectivityAsync.value ?? true;

    return Scaffold(
      appBar: PesaoAppBar(title: l10n.foodFormTitle),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isOnline) ...[
              const OfflineBanner(),
              const SizedBox(height: AppDimens.m),
            ],

            // Nombre.
            PesaoInput(
              label: l10n.foodFormNameLabel,
              hint: l10n.foodFormNameHint,
              controller: _nameController,
              errorText: _nameError,
              onChanged: (_) => _clearErrorsOnType(() => _nameController.text),
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: AppDimens.m),

            // Marca.
            PesaoInput(
              label: l10n.foodFormBrandLabel,
              hint: l10n.foodFormBrandHint,
              controller: _brandController,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: AppDimens.m),

            // Barcode.
            PesaoInput(
              label: 'Código de barras (opcional)',
              controller: _barcodeController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: AppDimens.l),

            // Sección: Porción de referencia.
            Text(
              l10n.foodFormServingLabel,
              style: AppTypography.title.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(height: AppDimens.m),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: PesaoInput(
                    label: 'Cantidad',
                    controller: _servingSizeController,
                    errorText: _servingSizeError,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: (_) =>
                        _clearErrorsOnType(() => _servingSizeController.text),
                  ),
                ),
                const SizedBox(width: AppDimens.m),
                Expanded(
                  flex: 1,
                  child: PesaoInput(
                    label: 'Unidad',
                    controller: _servingUnitController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.l),

            // Sección: Macronutrientes.
            Text(
              'Macronutrientes',
              style: AppTypography.title.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(height: AppDimens.m),

            // Calorías.
            PesaoInput(
              label: l10n.foodFormCaloriesLabel,
              controller: _caloriesController,
              errorText: _caloriesError,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (_) =>
                  _clearErrorsOnType(() => _caloriesController.text),
            ),
            const SizedBox(height: AppDimens.m),

            // Proteínas, Carbs, Grasas en fila.
            Row(
              children: [
                Expanded(
                  child: PesaoInput(
                    label: l10n.foodFormProteinLabel,
                    controller: _proteinController,
                    errorText: _proteinError,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: (_) =>
                        _clearErrorsOnType(() => _proteinController.text),
                  ),
                ),
                const SizedBox(width: AppDimens.s),
                Expanded(
                  child: PesaoInput(
                    label: l10n.foodFormCarbsLabel,
                    controller: _carbsController,
                    errorText: _carbsError,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: (_) =>
                        _clearErrorsOnType(() => _carbsController.text),
                  ),
                ),
                const SizedBox(width: AppDimens.s),
                Expanded(
                  child: PesaoInput(
                    label: l10n.foodFormFatsLabel,
                    controller: _fatsController,
                    errorText: _fatsError,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: (_) =>
                        _clearErrorsOnType(() => _fatsController.text),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.m),

            // Fibra, Azúcar, Sodio (opcionales, sin validación).
            Row(
              children: [
                Expanded(
                  child: PesaoInput(
                    label: l10n.foodFormFiberLabel,
                    controller: _fiberController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                ),
                const SizedBox(width: AppDimens.s),
                Expanded(
                  child: PesaoInput(
                    label: l10n.foodFormSugarLabel,
                    controller: _sugarController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                ),
                const SizedBox(width: AppDimens.s),
                Expanded(
                  child: PesaoInput(
                    label: l10n.foodFormSodiumLabel,
                    controller: _sodiumController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.xxl),

            // Botón guardar.
            PesaoButton(
              label: l10n.foodFormSaveSuccess.replaceAll(' ✅', ''),
              loading: _isSubmitting,
              onPressed: _isSubmitting ? null : _submit,
            ),
            const SizedBox(height: AppDimens.xxl),
          ],
        ),
      ),
    );
  }
}
