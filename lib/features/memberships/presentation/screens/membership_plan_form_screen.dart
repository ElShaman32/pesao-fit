import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/result.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_input.dart';
import '../../../../shared/widgets/pesao_shell.dart';
import '../../../../shared/widgets/pesao_toast.dart';
import '../../domain/entities/gym_membership_plan.dart';
import '../providers/membership_plans_controller.dart';

/// Formulario para crear o editar un plan de membresía.
class MembershipPlanFormScreen extends ConsumerStatefulWidget {
  const MembershipPlanFormScreen({super.key, this.existingPlan});

  /// Si se pasa un plan existente, se edita. Si no, se crea.
  final GymMembershipPlan? existingPlan;

  @override
  ConsumerState<MembershipPlanFormScreen> createState() =>
      _MembershipPlanFormScreenState();
}

class _MembershipPlanFormScreenState
    extends ConsumerState<MembershipPlanFormScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _durationController = TextEditingController();

  bool _includesTrainer = false;
  bool _includesNutritionist = false;
  bool _isSubmitting = false;

  String? _nameError;
  String? _priceError;
  String? _durationError;

  bool get _isEditing => widget.existingPlan != null;

  @override
  void initState() {
    super.initState();
    final plan = widget.existingPlan;
    if (plan != null) {
      _nameController.text = plan.name;
      _descriptionController.text = plan.description ?? '';
      _priceController.text = plan.priceUsd.toStringAsFixed(2);
      _durationController.text = plan.durationDays.toString();
      _includesTrainer = plan.includesTrainer;
      _includesNutritionist = plan.includesNutritionist;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return PesaoShell(
      appBar: PesaoAppBar(
        title: _isEditing ? l10n.planFormEditTitle : l10n.planFormCreateTitle,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimens.l),
        children: [
          // Nombre.
          PesaoInput(
            label: l10n.planFormNameLabel,
            hint: l10n.planFormNameHint,
            prefixIcon: const Icon(Icons.checklist_rounded),
            controller: _nameController,
          ),
          if (_nameError != null) _ErrorText(text: _nameError!),
          const SizedBox(height: AppDimens.m),

          // Descripción.
          PesaoInput(
            label: l10n.planFormDescriptionLabel,
            hint: l10n.planFormDescriptionHint,
            prefixIcon: const Icon(Icons.event_note_outlined),
            controller: _descriptionController,
          ),
          const SizedBox(height: AppDimens.m),

          // Precio USD.
          PesaoInput(
            label: l10n.planFormPriceLabel,
            hint: l10n.planFormPriceHint,
            prefixIcon: const Icon(Icons.attach_money_rounded),
            controller: _priceController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
            ],
          ),
          if (_priceError != null) _ErrorText(text: _priceError!),
          const SizedBox(height: AppDimens.m),

          // Duración.
          PesaoInput(
            label: l10n.planFormDurationLabel,
            hint: l10n.planFormDurationHint,
            prefixIcon: const Icon(Icons.schedule),
            controller: _durationController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          if (_durationError != null) _ErrorText(text: _durationError!),
          const SizedBox(height: AppDimens.l),

          // Toggles de inclusión.
          _ToggleRow(
            label: l10n.planFormIncludesTrainer,
            icon: Icons.fitness_center_rounded,
            value: _includesTrainer,
            onChanged: (v) => setState(() => _includesTrainer = v),
          ),
          const SizedBox(height: AppDimens.s),
          _ToggleRow(
            label: l10n.planFormIncludesNutritionist,
            icon: Icons.restaurant_rounded,
            value: _includesNutritionist,
            onChanged: (v) => setState(() => _includesNutritionist = v),
          ),
          const SizedBox(height: AppDimens.xl),

          // Submit.
          PesaoButton(
            label: _isSubmitting
                ? l10n.planFormSubmitting
                : l10n.planFormSubmit,
            variant: PesaoButtonVariant.primary,
            onPressed: _isSubmitting ? null : _submit,
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final l10n = AppStrings.of(context);
    final controller = ref.read(membershipPlansControllerProvider.notifier);

    setState(() {
      _nameError = null;
      _priceError = null;
      _durationError = null;
    });

    final name = _nameController.text.trim();
    final priceText = _priceController.text.replaceAll(',', '.');
    final price = double.tryParse(priceText);
    final duration = int.tryParse(_durationController.text);

    if (name.isEmpty) {
      setState(() => _nameError = l10n.planFormNameError);
      return;
    }
    if (price == null || price <= 0) {
      setState(() => _priceError = l10n.planFormPriceError);
      return;
    }
    if (duration == null || duration < 1) {
      setState(() => _durationError = l10n.planFormDurationError);
      return;
    }

    setState(() => _isSubmitting = true);

    Result<GymMembershipPlan> result;

    if (_isEditing) {
      final updated = widget.existingPlan!.copyWith(
        name: name,
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        priceUsd: price,
        durationDays: duration,
        includesTrainer: _includesTrainer,
        includesNutritionist: _includesNutritionist,
      );
      result = await controller.updatePlan(updated);
    } else {
      result = await controller.createPlan(
        name: name,
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        priceUsd: price,
        durationDays: duration,
        includesTrainer: _includesTrainer,
        includesNutritionist: _includesNutritionist,
      );
    }

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    result.when(
      idle: () {},
      loading: () {},
      success: (_) {
        showPesaoToast(
          context,
          message: _isEditing
              ? l10n.planUpdatedSuccess
              : l10n.planCreatedSuccess,
          semanticLabel: _isEditing
              ? l10n.planUpdatedSemantics
              : l10n.planCreatedSemantics,
          variant: PesaoToastVariant.success,
        );
        Navigator.of(context).pop(true);
      },
      failure: (error) {
        final msg = error.toString();
        if (msg.contains('plan_limit_reached')) {
          showPesaoToast(
            context,
            message: l10n.planLimitReachedBody,
            semanticLabel: l10n.planLimitReachedTitle,
            variant: PesaoToastVariant.warning,
          );
        } else {
          showPesaoToast(
            context,
            message: l10n.paymentActionError,
            semanticLabel: l10n.paymentActionError,
            variant: PesaoToastVariant.error,
          );
        }
      },
    );
  }
}

class _ErrorText extends StatelessWidget {
  final String text;
  const _ErrorText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppDimens.xs),
      child: Text(
        text,
        style: AppTypography.bodySmall.copyWith(color: AppColors.errorText),
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleRow({
    required this.label,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.l,
          vertical: AppDimens.m,
        ),
        decoration: BoxDecoration(
          color: value
              ? AppColors.primary.withValues(alpha: 0.08)
              : AppColors.surface,
          borderRadius: AppDimens.cardBorderRadius,
          border: Border.all(
            color: value ? AppColors.primary : AppColors.outline,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: value ? AppColors.primaryText : AppColors.textSecondary,
            ),
            const SizedBox(width: AppDimens.m),
            Expanded(
              child: Text(
                label,
                style: AppTypography.body.copyWith(
                  color: value
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                ),
              ),
            ),
            Icon(
              value
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked_rounded,
              size: 20,
              color: value ? AppColors.success : AppColors.textDisabled,
            ),
          ],
        ),
      ),
    );
  }
}
