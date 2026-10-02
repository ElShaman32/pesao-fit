import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/connectivity_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/offline_banner.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_input.dart';
import '../../../../shared/widgets/pesao_shell.dart';
import '../../domain/entities/exercise.dart';
import '../providers/exercises_controller.dart';
import '../widgets/exercise_list_tile.dart';

/// Lista de ejercicios (globales + personalizados).
class ExercisesListScreen extends ConsumerStatefulWidget {
  const ExercisesListScreen({super.key});

  @override
  ConsumerState<ExercisesListScreen> createState() =>
      _ExercisesListScreenState();
}

class _ExercisesListScreenState extends ConsumerState<ExercisesListScreen> {
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
    final connectivityAsync = ref.watch(connectivityProvider);
    final isOnline = connectivityAsync.value ?? true;

    return PesaoShell(
      appBar: PesaoAppBar(title: l10n.exercisesScreenTitle),
      body: Column(
        children: [
          if (!isOnline) const OfflineBanner(),

          // Search.
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppDimens.l,
              AppDimens.m,
              AppDimens.l,
              0,
            ),
            child: PesaoInput(
              hint: l10n.exercisesSearchHint,
              prefixIcon: const Icon(Icons.search_rounded),
              controller: _searchController,
              onChanged: (v) => setState(() => _searchQuery = v.toLowerCase()),
            ),
          ),
          const SizedBox(height: AppDimens.m),

          // Filtros por grupo muscular.
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.l),
              itemCount: MuscleGroup.values.length + 1,
              separatorBuilder: (_, _) => const SizedBox(width: AppDimens.xs),
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

          // Lista.
          Expanded(
            child: exercisesAsync.when(
              data: (exercises) {
                final filtered = exercises.where((e) {
                  final matchesSearch =
                      _searchQuery.isEmpty ||
                      e.name.toLowerCase().contains(_searchQuery);
                  final matchesGroup =
                      _selectedGroup == null || e.muscleGroup == _selectedGroup;
                  return matchesSearch && matchesGroup;
                }).toList();

                if (filtered.isEmpty) {
                  return EmptyState(
                    title: l10n.exercisesEmptyTitle,
                    body: l10n.exercisesEmptyBody,
                    icon: Icons.fitness_center_rounded,
                  );
                }

                return RefreshIndicator(
                  color: AppColors.primary,
                  backgroundColor: AppColors.surface,
                  onRefresh: () =>
                      ref.read(exercisesControllerProvider.notifier).load(),
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.l,
                      vertical: AppDimens.s,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      return ExerciseListTile(exercise: filtered[index]);
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => ErrorState(
                title: l10n.exercisesErrorTitle,
                body: l10n.exercisesErrorBody,
                onRetry: () =>
                    ref.read(exercisesControllerProvider.notifier).load(),
              ),
            ),
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
