import 'package:fl_chart/fl_chart.dart';
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
import '../../domain/entities/workout_history_entry.dart';
import '../providers/workout_history_controller.dart';

/// Pantalla de historial de workouts del cliente.
class WorkoutHistoryScreen extends ConsumerWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppStrings.of(context);
    final historyAsync = ref.watch(workoutHistoryControllerProvider);
    final connectivityAsync = ref.watch(connectivityProvider);
    final isOnline = connectivityAsync.value ?? true;

    return PesaoShell(
      appBar: PesaoAppBar(title: l10n.workoutHistoryScreenTitle),
      body: Column(
        children: [
          if (!isOnline) const OfflineBanner(),
          Expanded(
            child: historyAsync.when(
              data: (entries) {
                if (entries.isEmpty) {
                  return EmptyState(
                    title: l10n.workoutHistoryEmptyTitle,
                    body: l10n.workoutHistoryEmptyBody,
                    icon: Icons.history_rounded,
                  );
                }
                return RefreshIndicator(
                  color: AppColors.primary,
                  backgroundColor: AppColors.surface,
                  onRefresh: () => ref
                      .read(workoutHistoryControllerProvider.notifier)
                      .load(),
                  child: ListView(
                    padding: const EdgeInsets.all(AppDimens.l),
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      _VolumeChart(entries: entries),
                      const SizedBox(height: AppDimens.xl),
                      ...entries.map(
                        (entry) => Padding(
                          padding: const EdgeInsets.only(bottom: AppDimens.s),
                          child: _HistoryCard(entry: entry),
                        ),
                      ),
                      const SizedBox(height: AppDimens.xxl),
                    ],
                  ),
                );
              },
              loading: () => const _HistorySkeleton(),
              error: (_, _) => ErrorState(
                title: l10n.workoutHistoryErrorTitle,
                body: l10n.workoutHistoryErrorBody,
                onRetry: () =>
                    ref.read(workoutHistoryControllerProvider.notifier).load(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Gráfico de volumen semanal (sets completados por día).
class _VolumeChart extends StatelessWidget {
  final List<WorkoutHistoryEntry> entries;

  const _VolumeChart({required this.entries});

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    // Agrupar por día (últimos 7 días).
    final now = DateTime.now();
    final last7Days = List.generate(7, (i) {
      final date = now.subtract(Duration(days: 6 - i));
      return DateTime(date.year, date.month, date.day);
    });

    final spots = <FlSpot>[];
    for (var i = 0; i < last7Days.length; i++) {
      final day = last7Days[i];
      final dayEntries = entries.where((e) {
        final eDate = DateTime(
          e.startedAt.year,
          e.startedAt.month,
          e.startedAt.day,
        );
        return eDate.isAtSameMomentAs(day);
      });
      final totalSets = dayEntries.fold<int>(
        0,
        (sum, e) => sum + e.completedSets,
      );
      spots.add(FlSpot(i.toDouble(), totalSets.toDouble()));
    }

    final maxY = spots.map((s) => s.y).reduce((a, b) => a > b ? a : b);
    final chartMaxY = maxY < 5 ? 10.0 : maxY + 2;

    return PesaoCard(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.workoutHistoryVolumeChart,
              style: AppTypography.title.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(height: AppDimens.xs),
            Text(
              l10n.workoutHistoryVolumeSub,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimens.l),
            SizedBox(
              height: 150,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final dayIndex = value.toInt();
                          if (dayIndex < 0 || dayIndex >= last7Days.length) {
                            return const SizedBox.shrink();
                          }
                          final day = last7Days[dayIndex];
                          final labels = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
                          final label = labels[day.weekday - 1];
                          return Text(
                            label,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: chartMaxY,
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: AppColors.primary,
                      barWidth: 3,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, bar, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: AppColors.onPrimary,
                            strokeWidth: 2,
                            strokeColor: AppColors.primary,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppColors.primary.withValues(alpha: 0.2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Card de un workout en el historial.
class _HistoryCard extends StatelessWidget {
  final WorkoutHistoryEntry entry;

  const _HistoryCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return PesaoCard(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    entry.routineName ?? 'Entreno',
                    style: AppTypography.title.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.success,
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: AppDimens.s),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_rounded,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: AppDimens.xs),
                Text(
                  l10n.workoutHistoryDate(
                    entry.startedAt.day,
                    entry.startedAt.month,
                    entry.startedAt.year,
                  ),
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: AppDimens.m),
                const Icon(
                  Icons.timer_outlined,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: AppDimens.xs),
                Text(
                  l10n.workoutHistoryDuration(entry.durationMinutes),
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.xs),
            Text(
              l10n.workoutHistoryExercises(entry.exerciseCount),
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Skeleton que replica el layout del historial.
class _HistorySkeleton extends StatelessWidget {
  const _HistorySkeleton();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppDimens.l),
      child: Column(
        children: [
          _SkeletonBox(height: 200),
          SizedBox(height: AppDimens.xl),
          _SkeletonBox(height: 100),
          SizedBox(height: AppDimens.s),
          _SkeletonBox(height: 100),
          SizedBox(height: AppDimens.s),
          _SkeletonBox(height: 100),
        ],
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppDimens.cardBorderRadius,
        border: Border.all(color: AppColors.outline),
      ),
    );
  }
}
