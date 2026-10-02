import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_input.dart';
import '../providers/routines_controller.dart';
import '../providers/training_plans_controller.dart';

/// Muestra un sheet para asignar una rutina a un día del plan.
/// Devuelve true si se guardó correctamente.
Future<bool?> showDayAssignmentSheet(
  BuildContext context, {
  required String weekId,
  required int dayOfWeek,
  required WidgetRef ref,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) =>
        _DayAssignmentSheet(weekId: weekId, dayOfWeek: dayOfWeek, ref: ref),
  );
}

class _DayAssignmentSheet extends ConsumerStatefulWidget {
  final String weekId;
  final int dayOfWeek;
  final WidgetRef ref;

  const _DayAssignmentSheet({
    required this.weekId,
    required this.dayOfWeek,
    required this.ref,
  });

  @override
  ConsumerState<_DayAssignmentSheet> createState() =>
      _DayAssignmentSheetState();
}

class _DayAssignmentSheetState extends ConsumerState<_DayAssignmentSheet> {
  String? _selectedRoutineId;
  bool _isRestDay = false;
  final _notesController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  String get _dayLabel {
    final l10n = AppStrings.of(context);
    return switch (widget.dayOfWeek) {
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

  Future<void> _save() async {
    setState(() => _isSaving = true);

    final repository = ref.read(trainingPlansRepositoryProvider);
    final result = await repository.assignDay(
      weekId: widget.weekId,
      dayOfWeek: widget.dayOfWeek,
      routineId: _isRestDay ? null : _selectedRoutineId,
      isRestDay: _isRestDay,
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
    );

    if (!mounted) return;
    setState(() => _isSaving = false);

    result.when(
      idle: () {},
      loading: () {},
      success: (_) => Navigator.of(context).pop(true),
      failure: (_) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Error al guardar')));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final routinesAsync = ref.watch(routinesControllerProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
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
                      '$_dayLabel — ${l10n.trainingPlanDayAssign}',
                      style: AppTypography.headline.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimens.m),

              // Opción descanso.
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.l),
                child: GestureDetector(
                  onTap: () => setState(() {
                    _isRestDay = !_isRestDay;
                    if (_isRestDay) {
                      _selectedRoutineId = null;
                    }
                  }),
                  child: Container(
                    padding: const EdgeInsets.all(AppDimens.l),
                    decoration: BoxDecoration(
                      color: _isRestDay
                          ? AppColors.warning.withValues(alpha: 0.12)
                          : AppColors.surfaceHigh,
                      borderRadius: AppDimens.cardBorderRadius,
                      border: Border.all(
                        color: _isRestDay
                            ? AppColors.warning
                            : AppColors.outline,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.bed_rounded,
                          color: _isRestDay
                              ? AppColors.warningText
                              : AppColors.textSecondary,
                        ),
                        const SizedBox(width: AppDimens.m),
                        Expanded(
                          child: Text(
                            l10n.trainingPlanDayRest,
                            style: AppTypography.body.copyWith(
                              color: _isRestDay
                                  ? AppColors.warningText
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ),
                        Icon(
                          _isRestDay
                              ? Icons.check_circle_rounded
                              : Icons.radio_button_unchecked_rounded,
                          color: _isRestDay
                              ? AppColors.warning
                              : AppColors.textDisabled,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppDimens.m),

              // Lista de rutinas.
              Expanded(
                child: routinesAsync.when(
                  data: (routines) {
                    if (routines.isEmpty) {
                      return Center(
                        child: Text(
                          l10n.routinesEmptyTitle,
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
                      ),
                      itemCount: routines.length,
                      itemBuilder: (context, index) {
                        final routine = routines[index];
                        final isSelected = _selectedRoutineId == routine.id;
                        return GestureDetector(
                          onTap: () => setState(() {
                            _selectedRoutineId = routine.id;
                            _isRestDay = false;
                          }),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: AppDimens.xs),
                            padding: const EdgeInsets.all(AppDimens.m),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary.withValues(alpha: 0.12)
                                  : AppColors.surfaceHigh,
                              borderRadius: AppDimens.cardBorderRadius,
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.outline,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    routine.name,
                                    style: AppTypography.body.copyWith(
                                      color: isSelected
                                          ? AppColors.primaryText
                                          : AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  const Icon(
                                    Icons.check_circle_rounded,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (_, _) => const SizedBox.shrink(),
                ),
              ),

              // Notas.
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.l),
                child: PesaoInput(
                  label: l10n.trainingPlanDayNotes,
                  hint: l10n.trainingPlanDayNotesHint,
                  controller: _notesController,
                ),
              ),
              const SizedBox(height: AppDimens.m),

              // Guardar.
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppDimens.l,
                  0,
                  AppDimens.l,
                  AppDimens.l,
                ),
                child: PesaoButton(
                  label: _isSaving ? 'Guardando...' : 'Guardar',
                  variant: PesaoButtonVariant.primary,
                  onPressed: _isSaving ? null : _save,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
