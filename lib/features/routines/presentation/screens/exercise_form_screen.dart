import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_input.dart';
import '../../../../shared/widgets/pesao_shell.dart';
import '../../../../shared/widgets/pesao_toast.dart';
import '../../domain/entities/exercise.dart';
import '../providers/exercises_controller.dart';

/// Formulario para crear un ejercicio personalizado del gimnasio.
class ExerciseFormScreen extends ConsumerStatefulWidget {
  const ExerciseFormScreen({super.key});

  @override
  ConsumerState<ExerciseFormScreen> createState() => _ExerciseFormScreenState();
}

class _ExerciseFormScreenState extends ConsumerState<ExerciseFormScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  MuscleGroup _selectedGroup = MuscleGroup.fullBody;
  bool _isSubmitting = false;
  String? _nameError;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppStrings.of(context);
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      setState(() => _nameError = l10n.exerciseFormNameError);
      return;
    }

    setState(() {
      _isSubmitting = true;
      _nameError = null;
    });

    final controller = ref.read(exercisesControllerProvider.notifier);
    final result = await controller.createExercise(
      name: name,
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      muscleGroup: _selectedGroup,
    );

    if (!mounted) return;

    result.when(
      idle: () {},
      loading: () {},
      success: (_) {
        showPesaoToast(
          context,
          message: l10n.exerciseCreatedSuccess,
          semanticLabel: l10n.exerciseCreatedSemantics,
          variant: PesaoToastVariant.success,
        );
        Navigator.of(context).pop(true);
      },
      failure: (error) {
        showPesaoToast(
          context,
          message: 'No se pudo crear el ejercicio',
          semanticLabel: 'Error al crear ejercicio',
          variant: PesaoToastVariant.error,
        );
      },
    );

    if (mounted) {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return PesaoShell(
      appBar: PesaoAppBar(title: l10n.exerciseFormCreateTitle),
      body: ListView(
        padding: const EdgeInsets.all(AppDimens.l),
        children: [
          // Nombre.
          PesaoInput(
            label: l10n.exerciseFormNameLabel,
            hint: l10n.exerciseFormNameHint,
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

          // Descripción.
          PesaoInput(
            label: l10n.exerciseFormDescriptionLabel,
            hint: l10n.exerciseFormDescriptionHint,
            controller: _descriptionController,
          ),
          const SizedBox(height: AppDimens.l),

          // Selector de grupo muscular.
          Text(
            l10n.exerciseFormMuscleGroupLabel,
            style: AppTypography.label.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppDimens.s),
          Wrap(
            spacing: AppDimens.s,
            runSpacing: AppDimens.s,
            children: MuscleGroup.values.map((group) {
              final isSelected = _selectedGroup == group;
              return GestureDetector(
                onTap: () => setState(() => _selectedGroup = group),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.m,
                    vertical: AppDimens.s,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.12)
                        : AppColors.surfaceHigh,
                    borderRadius: AppDimens.pillBorderRadius,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.outline,
                    ),
                  ),
                  child: Text(
                    _muscleLabel(group),
                    style: AppTypography.label.copyWith(
                      color: isSelected
                          ? AppColors.primaryText
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: AppDimens.xl),

          // Submit.
          PesaoButton(
            label: _isSubmitting
                ? l10n.exerciseFormSubmitting
                : l10n.exerciseFormSubmit,
            variant: PesaoButtonVariant.primary,
            onPressed: _isSubmitting ? null : _submit,
          ),
        ],
      ),
    );
  }

  String _muscleLabel(MuscleGroup group) {
    final labels = {
      MuscleGroup.chest: 'Pecho',
      MuscleGroup.back: 'Espalda',
      MuscleGroup.shoulders: 'Hombros',
      MuscleGroup.biceps: 'Bíceps',
      MuscleGroup.triceps: 'Tríceps',
      MuscleGroup.legs: 'Piernas',
      MuscleGroup.glutes: 'Glúteos',
      MuscleGroup.core: 'Core',
      MuscleGroup.cardio: 'Cardio',
      MuscleGroup.fullBody: 'Full body',
    };
    return labels[group] ?? group.name;
  }
}
