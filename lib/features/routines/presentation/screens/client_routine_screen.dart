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
import '../../../../shared/widgets/pesao_card.dart';
import '../../../../shared/widgets/pesao_shell.dart';
import '../../domain/entities/training_plan.dart';
import '../../domain/entities/training_plan_day.dart';
import '../providers/client_training_plan_controller.dart';
import '../widgets/start_workout_button.dart';

/// Pantalla del plan de entrenamiento del cliente (tab Rutina).
class ClientRoutineScreen extends ConsumerWidget {
  const ClientRoutineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppStrings.of(context);
    final planAsync = ref.watch(clientTrainingPlanControllerProvider);
    final connectivityAsync = ref.watch(connectivityProvider);
    final isOnline = connectivityAsync.value ?? true;

    return PesaoShell(
      appBar: PesaoAppBar(title: l10n.trainingPlanClientViewTitle),
      body: Column(
        children: [
          if (!isOnline) const OfflineBanner(),
          Expanded(
            child: planAsync.when(
              data: (plan) {
                if (plan == null) {
                  return EmptyState(
                    title: l10n.trainingPlanClientEmptyTitle,
                    body: l10n.trainingPlanClientEmptyBody,
                    icon: Icons.calendar_month_rounded,
                  );
                }
                return _ClientPlanView(plan: plan);
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => ErrorState(
                title: l10n.trainingPlansErrorTitle,
                body: l10n.trainingPlansErrorBody,
                onRetry: () => ref
                    .read(clientTrainingPlanControllerProvider.notifier)
                    .load(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ClientPlanView extends ConsumerWidget {
  final TrainingPlan plan;

  const _ClientPlanView({required this.plan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppStrings.of(context);

    // Encontrar la semana actual.
    final currentWeek = plan.weeks
        .where((w) => w.weekNumber == plan.currentWeek)
        .firstOrNull;

    // Día actual de la semana (1=Lunes ... 7=Domingo).
    final today = DateTime.now().weekday;

    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: AppColors.surface,
      onRefresh: () =>
          ref.read(clientTrainingPlanControllerProvider.notifier).load(),
      child: ListView(
        padding: const EdgeInsets.all(AppDimens.l),
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          // Header del plan.
          PesaoCard(
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.l),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plan.name,
                    style: AppTypography.headline.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppDimens.s),
                  Text(
                    l10n.trainingPlanCurrentWeek(
                      plan.currentWeek,
                      plan.weeks.length,
                    ),
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppDimens.l),

          // Días de la semana actual.
          if (currentWeek != null)
            ...List.generate(7, (index) {
              final dayOfWeek = index + 1;
              final day = currentWeek.days
                  .where((d) => d.dayOfWeek == dayOfWeek)
                  .firstOrNull;
              final isToday = dayOfWeek == today;

              return Padding(
                padding: const EdgeInsets.only(bottom: AppDimens.s),
                child: _ClientDayCard(
                  dayLabel: _dayLabel(context, dayOfWeek),
                  day: day,
                  isToday: isToday,
                ),
              );
            })
          else
            Padding(
              padding: const EdgeInsets.all(AppDimens.xl),
              child: Text(
                'Semana ${plan.currentWeek} no encontrada',
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          const SizedBox(height: AppDimens.xxl),
        ],
      ),
    );
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
}

class _ClientDayCard extends StatelessWidget {
  final String dayLabel;
  final TrainingPlanDay? day;
  final bool isToday;

  const _ClientDayCard({
    required this.dayLabel,
    required this.day,
    required this.isToday,
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

    final showStart = isToday && day != null && day!.hasRoutine;

    return Container(
      padding: const EdgeInsets.all(AppDimens.l),
      decoration: BoxDecoration(
        color: isToday
            ? AppColors.primary.withValues(alpha: 0.08)
            : AppColors.surface,
        borderRadius: AppDimens.cardBorderRadius,
        border: Border.all(
          color: isToday ? AppColors.primary : AppColors.outline,
          width: isToday ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dayLabel,
                      style: AppTypography.label.copyWith(
                        color: isToday
                            ? AppColors.primaryText
                            : AppColors.textSecondary,
                      ),
                    ),
                    if (isToday)
                      Text(
                        l10n.trainingPlanClientToday,
                        style: AppTypography.label.copyWith(
                          color: AppColors.primaryText,
                          fontSize: 10,
                        ),
                      ),
                  ],
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
            ],
          ),
          if (showStart) ...[
            const SizedBox(height: AppDimens.m),
            Align(
              alignment: Alignment.centerRight,
              child: StartWorkoutButton(routineId: day!.routineId!),
            ),
          ],
        ],
      ),
    );
  }
}
