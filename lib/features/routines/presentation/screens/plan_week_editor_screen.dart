import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/confirm_dialog.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_card.dart';
import '../../../../shared/widgets/pesao_shell.dart';
import '../../../../shared/widgets/pesao_toast.dart';
import '../../domain/entities/training_plan.dart';
import '../../domain/entities/training_plan_day.dart';
import '../../domain/entities/training_plan_week.dart';
import '../providers/training_plans_controller.dart';
import 'day_assignment_sheet.dart';

/// Editor semanal del plan de entrenamiento.
/// Muestra las semanas del plan y permite asignar rutinas a cada día.
class PlanWeekEditorScreen extends ConsumerStatefulWidget {
  const PlanWeekEditorScreen({super.key, required this.planId});

  final String planId;

  @override
  ConsumerState<PlanWeekEditorScreen> createState() =>
      _PlanWeekEditorScreenState();
}

class _PlanWeekEditorScreenState extends ConsumerState<PlanWeekEditorScreen> {
  TrainingPlan? _plan;
  bool _isLoading = true;
  int _selectedWeekIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadPlan();
  }

  Future<void> _loadPlan() async {
    setState(() => _isLoading = true);
    final repository = ref.read(trainingPlansRepositoryProvider);
    final result = await repository.getPlan(planId: widget.planId);

    result.when(
      idle: () {},
      loading: () {},
      success: (plan) {
        if (!mounted) return;
        setState(() {
          _plan = plan;
          _selectedWeekIndex = plan.currentWeek - 1;
          if (_selectedWeekIndex < 0) _selectedWeekIndex = 0;
          if (_selectedWeekIndex >= plan.weeks.length) {
            _selectedWeekIndex = plan.weeks.isEmpty ? 0 : plan.weeks.length - 1;
          }
          _isLoading = false;
        });
      },
      failure: (error) {
        if (!mounted) return;
        setState(() => _isLoading = false);
        showPesaoToast(
          context,
          message: 'No se pudo cargar el plan',
          semanticLabel: 'Error al cargar',
          variant: PesaoToastVariant.error,
        );
      },
    );
  }

  Future<void> _addWeek() async {
    if (_plan == null) return;
    final repository = ref.read(trainingPlansRepositoryProvider);
    final nextWeekNumber = _plan!.weeks.length + 1;

    final result = await repository.addWeek(
      planId: _plan!.id,
      weekNumber: nextWeekNumber,
    );

    await result.when(
      idle: () {},
      loading: () {},
      success: (_) => _loadPlan(),
      failure: (error) {
        final l10n = AppStrings.of(context);
        final msg = error.toString();
        if (msg.contains('week-limit-reached')) {
          showPesaoToast(
            context,
            message: l10n.trainingPlanWeekLimitBody(8),
            semanticLabel: l10n.trainingPlanWeekLimitTitle,
            variant: PesaoToastVariant.warning,
          );
        } else {
          showPesaoToast(
            context,
            message: 'No se pudo agregar la semana',
            semanticLabel: 'Error',
            variant: PesaoToastVariant.error,
          );
        }
      },
    );
  }

  Future<void> _duplicateWeek(TrainingPlanWeek week) async {
    if (_plan == null) return;
    final repository = ref.read(trainingPlansRepositoryProvider);
    final newWeekNumber = _plan!.weeks.length + 1;

    final result = await repository.duplicateWeek(
      weekId: week.id,
      newWeekNumber: newWeekNumber,
    );

    await result.when(
      idle: () {},
      loading: () {},
      success: (_) => _loadPlan(),
      failure: (error) {
        final l10n = AppStrings.of(context);
        final msg = error.toString();
        if (msg.contains('duplicate-locked')) {
          showPesaoToast(
            context,
            message: l10n.trainingPlanDuplicateLockedBody,
            semanticLabel: l10n.trainingPlanDuplicateLockedTitle,
            variant: PesaoToastVariant.warning,
          );
        } else if (msg.contains('week-limit-reached')) {
          showPesaoToast(
            context,
            message: l10n.trainingPlanWeekLimitBody(8),
            semanticLabel: l10n.trainingPlanWeekLimitTitle,
            variant: PesaoToastVariant.warning,
          );
        } else {
          showPesaoToast(
            context,
            message: 'No se pudo duplicar',
            semanticLabel: 'Error',
            variant: PesaoToastVariant.error,
          );
        }
      },
    );
  }

  Future<void> _deleteWeek(TrainingPlanWeek week) async {
    final l10n = AppStrings.of(context);
    final confirmed = await showConfirmDialog(
      context: context,
      title: l10n.trainingPlanDeleteWeek,
      message: '¿Eliminar la semana ${week.weekNumber}?',
      confirmLabel: l10n.trainingPlanDeleteWeek,
      cancelLabel: l10n.commonCancel,
      isDestructive: true,
    );

    if (!confirmed || !mounted) return;

    final repository = ref.read(trainingPlansRepositoryProvider);
    final result = await repository.deleteWeek(weekId: week.id);

    await result.when(
      idle: () {},
      loading: () {},
      success: (_) => _loadPlan(),
      failure: (_) {
        showPesaoToast(
          context,
          message: 'No se pudo eliminar',
          semanticLabel: 'Error',
          variant: PesaoToastVariant.error,
        );
      },
    );
  }

  Future<void> _assignDay(TrainingPlanWeek week, int dayOfWeek) async {
    final result = await showDayAssignmentSheet(
      context,
      weekId: week.id,
      dayOfWeek: dayOfWeek,
      ref: ref,
    );

    if (result == true) {
      await _loadPlan();
    }
  }

  String _dayLabel(BuildContext context, int dayOfWeek) {
    final l10n = AppStrings.of(context);
    return switch (dayOfWeek) {
      1 => l10n.dayMonday,
      2 => l10n.dayTuesday,
      3 => l10n.dayWednesday,
      4 => l10n.dayThursday,
      5 => l10n.dayFriday,
      6 => l10n.daySaturday,
      7 => l10n.daySunday,
      _ => '',
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return PesaoShell(
      appBar: PesaoAppBar(title: _plan?.name ?? 'Plan'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _plan == null
          ? const Center(child: Text('Plan no encontrado'))
          : Column(
              children: [
                // Selector de semanas.
                if (_plan!.weeks.isNotEmpty)
                  SizedBox(
                    height: 48,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.l,
                        vertical: AppDimens.s,
                      ),
                      itemCount: _plan!.weeks.length + 1,
                      separatorBuilder: (_, _) =>
                          const SizedBox(width: AppDimens.xs),
                      itemBuilder: (context, index) {
                        // Botón de agregar semana.
                        if (index == _plan!.weeks.length) {
                          return GestureDetector(
                            onTap: _addWeek,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppDimens.m,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: AppDimens.pillBorderRadius,
                                border: Border.all(color: AppColors.outline),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.add_rounded, size: 18),
                                  SizedBox(width: 4),
                                  Text('+'),
                                ],
                              ),
                            ),
                          );
                        }

                        final week = _plan!.weeks[index];
                        final isSelected = index == _selectedWeekIndex;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedWeekIndex = index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppDimens.m,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary.withValues(alpha: 0.12)
                                  : AppColors.surfaceHigh,
                              borderRadius: AppDimens.pillBorderRadius,
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.outline,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              l10n.trainingPlanWeekLabel(week.weekNumber),
                              style: AppTypography.label.copyWith(
                                color: isSelected
                                    ? AppColors.primaryText
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                // Contenido de la semana seleccionada.
                Expanded(
                  child: _plan!.weeks.isEmpty
                      ? _EmptyWeekState(onAdd: _addWeek)
                      : _WeekContent(
                          week: _plan!.weeks[_selectedWeekIndex],
                          dayLabel: _dayLabel,
                          onAssignDay: _assignDay,
                          onDuplicate: () =>
                              _duplicateWeek(_plan!.weeks[_selectedWeekIndex]),
                          onDelete: () =>
                              _deleteWeek(_plan!.weeks[_selectedWeekIndex]),
                        ),
                ),
              ],
            ),
    );
  }
}

class _EmptyWeekState extends StatelessWidget {
  final VoidCallback onAdd;

  const _EmptyWeekState({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.calendar_month_rounded,
            size: 64,
            color: AppColors.textDisabled,
          ),
          const SizedBox(height: AppDimens.l),
          Text(
            'Sin semanas',
            style: AppTypography.title.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppDimens.s),
          Text(
            'Agrega la primera semana para empezar a planificar',
            style: AppTypography.body.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimens.xl),
          PesaoButton(
            label: l10n.trainingPlanAddWeek,
            isExpanded: false,
            onPressed: onAdd,
          ),
        ],
      ),
    );
  }
}

class _WeekContent extends StatelessWidget {
  final TrainingPlanWeek week;
  final String Function(BuildContext, int) dayLabel;
  final void Function(TrainingPlanWeek, int) onAssignDay;
  final VoidCallback onDuplicate;
  final VoidCallback onDelete;

  const _WeekContent({
    required this.week,
    required this.dayLabel,
    required this.onAssignDay,
    required this.onDuplicate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return ListView(
      padding: const EdgeInsets.all(AppDimens.l),
      children: [
        // Acciones de la semana.
        Row(
          children: [
            if (week.name != null)
              Expanded(
                child: Text(
                  week.name!,
                  style: AppTypography.title.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            PesaoButton(
              label: l10n.trainingPlanDuplicateWeek,
              variant: PesaoButtonVariant.secondary,
              isExpanded: false,
              onPressed: onDuplicate,
            ),
            const SizedBox(width: AppDimens.s),
            IconButton(
              icon: const Icon(
                Icons.delete_outline_rounded,
                color: AppColors.error,
              ),
              onPressed: onDelete,
            ),
          ],
        ),
        const SizedBox(height: AppDimens.m),

        // Días de la semana.
        ...List.generate(7, (index) {
          final dayOfWeek = index + 1;
          final day = week.days
              .where((d) => d.dayOfWeek == dayOfWeek)
              .firstOrNull;

          return Padding(
            padding: const EdgeInsets.only(bottom: AppDimens.s),
            child: _DayCard(
              dayLabel: dayLabel(context, dayOfWeek),
              day: day,
              onTap: () => onAssignDay(week, dayOfWeek),
            ),
          );
        }),
      ],
    );
  }
}

class _DayCard extends StatelessWidget {
  final String dayLabel;
  final TrainingPlanDay? day;
  final VoidCallback onTap;

  const _DayCard({
    required this.dayLabel,
    required this.day,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    final String subtitle;
    final Color subtitleColor;

    if (day == null) {
      subtitle = l10n.trainingPlanDayEmpty;
      subtitleColor = AppColors.textDisabled;
    } else if (day!.isRestDay) {
      subtitle = l10n.trainingPlanDayRest;
      subtitleColor = AppColors.textSecondary;
    } else if (day!.hasRoutine) {
      final count = day!.exerciseCount;
      subtitle = count != null
          ? '${day!.routineName} · $count ejercicios'
          : day!.routineName ?? '';
      subtitleColor = AppColors.textPrimary;
    } else {
      subtitle = l10n.trainingPlanDayEmpty;
      subtitleColor = AppColors.textDisabled;
    }

    return GestureDetector(
      onTap: onTap,
      child: PesaoCard(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.l),
          child: Row(
            children: [
              SizedBox(
                width: 90,
                child: Text(
                  dayLabel,
                  style: AppTypography.label.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  subtitle,
                  style: AppTypography.body.copyWith(color: subtitleColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textSecondary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
