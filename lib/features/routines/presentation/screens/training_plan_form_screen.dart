import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_input.dart';
import '../../../../shared/widgets/pesao_shell.dart';
import '../../../../shared/widgets/pesao_toast.dart';
import '../../domain/entities/training_plan.dart';
import '../providers/training_plans_controller.dart';

/// Formulario para crear o editar un plan de entrenamiento.
class TrainingPlanFormScreen extends ConsumerStatefulWidget {
  const TrainingPlanFormScreen({super.key, this.existingPlan});

  final TrainingPlan? existingPlan;

  @override
  ConsumerState<TrainingPlanFormScreen> createState() =>
      _TrainingPlanFormScreenState();
}

class _TrainingPlanFormScreenState
    extends ConsumerState<TrainingPlanFormScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedClientId;
  String? _selectedClientName;
  bool _isSubmitting = false;
  String? _nameError;
  String? _clientError;

  bool get _isEditing => widget.existingPlan != null;

  @override
  void initState() {
    super.initState();
    final plan = widget.existingPlan;
    if (plan != null) {
      _nameController.text = plan.name;
      _descriptionController.text = plan.description ?? '';
      _selectedClientId = plan.clientId;
      _selectedClientName = plan.clientName;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickClient() async {
    final client = Supabase.instance.client;
    final gymId = authProvider.userGymId;
    if (gymId == null) return;

    final response = await client
        .from('memberships')
        .select('user_id, profiles:user_id (full_name)')
        .eq('gym_id', gymId)
        .eq('role', 'client')
        .eq('is_active', true);

    if (!mounted) return;

    final selected = await showModalBottomSheet<Map<String, String>>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        final l10n = AppStrings.of(sheetContext);
        return Padding(
          padding: const EdgeInsets.all(AppDimens.l),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: const BoxDecoration(
                  color: AppColors.outline,
                  borderRadius: AppDimens.pillBorderRadius,
                ),
              ),
              const SizedBox(height: AppDimens.l),
              Text(
                l10n.trainingPlanFormClientLabel,
                style: AppTypography.headline.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimens.m),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 400),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: response.length,
                  itemBuilder: (context, index) {
                    final row = response[index];
                    final userId = row['user_id'] as String;
                    final profile = row['profiles'] as Map<String, dynamic>?;
                    final name = profile?['full_name'] as String? ?? 'Cliente';
                    return ListTile(
                      title: Text(name),
                      onTap: () => Navigator.of(
                        sheetContext,
                      ).pop({'id': userId, 'name': name}),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppDimens.l),
            ],
          ),
        );
      },
    );

    if (selected != null) {
      setState(() {
        _selectedClientId = selected['id'];
        _selectedClientName = selected['name'];
        _clientError = null;
      });
    }
  }

  Future<void> _submit() async {
    final l10n = AppStrings.of(context);
    final controller = ref.read(trainingPlansControllerProvider.notifier);

    setState(() {
      _nameError = null;
      _clientError = null;
    });

    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() => _nameError = l10n.trainingPlanFormNameError);
      return;
    }
    if (_selectedClientId == null) {
      setState(() => _clientError = l10n.trainingPlanFormClientError);
      return;
    }

    setState(() => _isSubmitting = true);

    final result = await controller.createPlan(
      clientId: _selectedClientId!,
      name: name,
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
    );

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    result.when(
      idle: () {},
      loading: () {},
      success: (plan) {
        showPesaoToast(
          context,
          message: l10n.trainingPlanCreatedSuccess,
          semanticLabel: l10n.trainingPlanCreatedSemantics,
          variant: PesaoToastVariant.success,
        );
        // Pop del form y push al editor de semanas.
        context.pop();
        context.pushNamed(
          RouteNames.trainerPlanEdit,
          pathParameters: {'planId': plan.id},
        );
      },
      failure: (error) {
        showPesaoToast(
          context,
          message: 'No se pudo crear el plan',
          semanticLabel: 'Error al crear plan',
          variant: PesaoToastVariant.error,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return PesaoShell(
      appBar: PesaoAppBar(
        title: _isEditing
            ? l10n.trainingPlanFormEditTitle
            : l10n.trainingPlanFormCreateTitle,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimens.l),
        children: [
          PesaoInput(
            label: l10n.trainingPlanFormNameLabel,
            hint: l10n.trainingPlanFormNameHint,
            prefixIcon: const Icon(Icons.assignment),
            controller: _nameController,
          ),
          if (_nameError != null)
            Padding(
              padding: const EdgeInsets.only(top: AppDimens.xs),
              child: Text(
                _nameError!,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.errorText,
                ),
              ),
            ),
          const SizedBox(height: AppDimens.m),
          PesaoInput(
            label: l10n.trainingPlanFormDescriptionLabel,
            hint: l10n.trainingPlanFormDescriptionHint,
            prefixIcon: const Icon(Icons.event_note_outlined),
            controller: _descriptionController,
          ),
          const SizedBox(height: AppDimens.l),
          Text(
            l10n.trainingPlanFormClientLabel,
            style: AppTypography.label.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppDimens.s),
          GestureDetector(
            onTap: _pickClient,
            child: Container(
              padding: const EdgeInsets.all(AppDimens.l),
              decoration: BoxDecoration(
                color: AppColors.surfaceHigh,
                borderRadius: AppDimens.cardBorderRadius,
                border: Border.all(color: AppColors.outline),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.person_outline_rounded,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppDimens.m),
                  Expanded(
                    child: Text(
                      _selectedClientName ?? 'Seleccionar cliente',
                      style: AppTypography.body.copyWith(
                        color: _selectedClientName != null
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
          if (_clientError != null)
            Padding(
              padding: const EdgeInsets.only(top: AppDimens.xs),
              child: Text(
                _clientError!,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.errorText,
                ),
              ),
            ),
          const SizedBox(height: AppDimens.xl),
          PesaoButton(
            label: _isSubmitting
                ? l10n.trainingPlanFormSubmitting
                : l10n.trainingPlanFormSubmit,
            variant: PesaoButtonVariant.primary,
            onPressed: _isSubmitting ? null : _submit,
          ),
        ],
      ),
    );
  }
}
