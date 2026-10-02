import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/pesao_badge.dart';
import '../../../../shared/widgets/pesao_list_tile.dart';
import '../../domain/entities/exercise.dart';
import 'muscle_group_chip.dart';

/// Tile para mostrar un ejercicio en listas.
class ExerciseListTile extends StatelessWidget {
  final Exercise exercise;
  final VoidCallback? onTap;

  const ExerciseListTile({super.key, required this.exercise, this.onTap});

  @override
  Widget build(BuildContext context) {
    return PesaoListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.12),
          borderRadius: AppDimens.cardBorderRadius,
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.fitness_center_rounded,
          color: AppColors.primaryText,
          size: 24,
        ),
      ),
      title: exercise.name,
      subtitle: exercise.description,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MuscleGroupChip(group: exercise.muscleGroup, compact: true),
          if (exercise.isGlobal) ...[
            const SizedBox(width: AppDimens.xs),
            const PesaoBadge(label: 'Base', variant: PesaoBadgeVariant.success),
          ],
        ],
      ),
      onTap: onTap,
    );
  }
}
