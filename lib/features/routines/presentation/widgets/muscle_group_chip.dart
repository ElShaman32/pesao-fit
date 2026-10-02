import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/exercise.dart';

/// Chip con el nombre del grupo muscular localizado.
class MuscleGroupChip extends StatelessWidget {
  final MuscleGroup group;
  final bool compact;

  const MuscleGroupChip({super.key, required this.group, this.compact = false});

  String _label(BuildContext context) {
    // Usamos el nombre localizado desde el ARB si existe, o el dbValue.
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? AppDimens.s : AppDimens.m,
        vertical: compact ? 2 : AppDimens.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.12),
        borderRadius: AppDimens.pillBorderRadius,
      ),
      child: Text(
        _label(context),
        style: AppTypography.label.copyWith(
          color: AppColors.primaryText,
          fontSize: compact ? 10 : null,
        ),
      ),
    );
  }
}
