import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pesao_input.dart';
import '../../domain/entities/exercise.dart';
import '../providers/exercises_controller.dart';
import '../widgets/exercise_list_tile.dart';

/// Muestra un sheet para seleccionar un ejercicio de la biblioteca.
/// Devuelve el ejercicio seleccionado o null si se cancela.
Future<Exercise?> showExercisePickerSheet(BuildContext context) {
  return showModalBottomSheet<Exercise>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => const _ExercisePickerSheet(),
  );
}

class _ExercisePickerSheet extends ConsumerStatefulWidget {
  const _ExercisePickerSheet();

  @override
  ConsumerState<_ExercisePickerSheet> createState() =>
      _ExercisePickerSheetState();
}

class _ExercisePickerSheetState extends ConsumerState<_ExercisePickerSheet> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  MuscleGroup? _selectedGroup;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final exercisesAsync = ref.watch(exercisesControllerProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Handle + título.
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppDimens.l,
                  AppDimens.m,
                  AppDimens.l,
                  0,
                ),
                child: Column(
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
                      l10n.exercisesScreenTitle,
                      style: AppTypography.headline.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppDimens.m),
                    PesaoInput(
                      hint: l10n.exercisesSearchHint,
                      prefixIcon: const Icon(Icons.search_rounded),
                      controller: _searchController,
                      onChanged: (v) =>
                          setState(() => _searchQuery = v.toLowerCase()),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimens.m),

              // Chips de filtro por grupo muscular.
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: AppDimens.l),
                  itemCount: MuscleGroup.values.length + 1,
                  separatorBuilder: (_, _) =>
                      const SizedBox(width: AppDimens.xs),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      final isSelected = _selectedGroup == null;
                      return _FilterChip(
                        label: l10n.muscleGroupAll,
                        isSelected: isSelected,
                        onTap: () => setState(() => _selectedGroup = null),
                      );
                    }
                    final group = MuscleGroup.values[index - 1];
                    final isSelected = _selectedGroup == group;
                    return _FilterChip(
                      label: _muscleLabel(group),
                      isSelected: isSelected,
                      onTap: () => setState(() => _selectedGroup = group),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppDimens.m),

              // Lista de ejercicios.
              Expanded(
                child: exercisesAsync.when(
                  data: (exercises) {
                    final filtered = exercises.where((e) {
                      final matchesSearch =
                          _searchQuery.isEmpty ||
                          e.name.toLowerCase().contains(_searchQuery);
                      final matchesGroup =
                          _selectedGroup == null ||
                          e.muscleGroup == _selectedGroup;
                      return matchesSearch && matchesGroup;
                    }).toList();

                    if (filtered.isEmpty) {
                      return Center(
                        child: Text(
                          l10n.exercisesEmptyTitle,
                          style: AppTypography.body.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.l,
                        vertical: AppDimens.s,
                      ),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final exercise = filtered[index];
                        return ExerciseListTile(
                          exercise: exercise,
                          onTap: () => Navigator.of(context).pop(exercise),
                        );
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (_, _) => const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        );
      },
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

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.m,
          vertical: AppDimens.xs,
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
          label,
          style: AppTypography.label.copyWith(
            color: isSelected ? AppColors.primaryText : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
