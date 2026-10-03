import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/providers/connectivity_provider.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/offline_banner.dart';
import '../../../../shared/widgets/pesao_avatar.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_stat_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../memberships/presentation/widgets/subscription_card.dart';
import '../../../payments/presentation/screens/upload_payment_sheet.dart';
import '../../../routines/domain/entities/training_plan.dart';
import '../../../routines/domain/entities/training_plan_day.dart';
import '../../../routines/presentation/providers/client_training_plan_controller.dart';
import '../../../routines/presentation/widgets/start_workout_button.dart';
import '../../domain/entities/client_dashboard_stats.dart';
import '../providers/client_dashboard_controller.dart';

/// Dashboard del cliente (tab Inicio del shell).
///
/// Sigue design-system.md §10: AppBar con avatar + saludo,
/// 3 StatCards (kcal/racha/próximo), PrimaryCard con CTA,
/// y sección secundaria "Hoy".
class ClientHomeScreen extends ConsumerWidget {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppStrings.of(context);
    final state = ref.watch(clientDashboardControllerProvider);
    final controller = ref.read(clientDashboardControllerProvider.notifier);

    final connectivity = ref.watch(connectivityProvider);
    final isOnline = connectivity is bool ? connectivity : true;

    final greeting = _greetingForHour(l10n);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: AppColors.surface,
          onRefresh: controller.load,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // === AppBar con avatar + saludo + campana ===
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppDimens.l,
                    AppDimens.l,
                    AppDimens.l,
                    0,
                  ),
                  child: Row(
                    children: [
                      PesaoAvatar(
                        name: authProvider.userFullName ?? 'Cliente',
                        imageUrl: authProvider.avatarUrl,
                        size: 44,
                      ),
                      const SizedBox(width: AppDimens.m),
                      Expanded(
                        child: Text(
                          greeting,
                          style: AppTypography.title.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.notifications_outlined,
                          color: AppColors.textSecondary,
                        ),
                        tooltip: l10n.notificationsLabel,
                        onPressed: () {
                          // Placeholder: notificaciones en F4.
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // === OfflineBanner ===
              if (isOnline != true)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(AppDimens.l),
                    child: OfflineBanner(),
                  ),
                ),

              // === Contenido según estado ===
              if (state.isLoading && state.stats == null)
                const _SkeletonSliver()
              else if (state.error != null && state.stats == null)
                _ErrorSliver(
                  title: l10n.clientDashErrorTitle,
                  body: l10n.clientDashErrorBody,
                  onRetry: controller.load,
                )
              else if (state.hasData)
                _SuccessSliver(stats: state.stats!),
            ],
          ),
        ),
      ),
    );
  }

  String _greetingForHour(AppStrings l10n) {
    final hour = DateTime.now().hour;
    final name = authProvider.userFullName ?? 'campeón';
    if (hour < 12) return l10n.greetingMorning(name);
    if (hour < 19) return l10n.greetingAfternoon(name);
    return l10n.greetingNight(name);
  }
}

/// Skeleton que replica el layout real.
class _SkeletonSliver extends StatelessWidget {
  const _SkeletonSliver();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(AppDimens.l),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          const Row(
            children: [
              Expanded(child: _SkeletonBox(height: 110)),
              SizedBox(width: AppDimens.s),
              Expanded(child: _SkeletonBox(height: 110)),
              SizedBox(width: AppDimens.s),
              Expanded(child: _SkeletonBox(height: 110)),
            ],
          ),
          const SizedBox(height: AppDimens.xl),
          const _SkeletonBox(height: 160),
          const SizedBox(height: AppDimens.xl),
          const _SkeletonBox(height: 24),
          const SizedBox(height: AppDimens.m),
          const _SkeletonBox(height: 72),
          const SizedBox(height: AppDimens.s),
          const _SkeletonBox(height: 72),
        ]),
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

/// Estado error con reintento.
class _ErrorSliver extends StatelessWidget {
  const _ErrorSliver({
    required this.title,
    required this.body,
    required this.onRetry,
  });

  final String title;
  final String body;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.xxl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: AppColors.error, size: 48),
              const SizedBox(height: AppDimens.m),
              Text(
                title,
                style: AppTypography.title.copyWith(
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimens.s),
              Text(
                body,
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimens.l),
              PesaoButton(
                label: AppStrings.of(context).commonRetry,
                isExpanded: false,
                onPressed: onRetry,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Sliver de éxito.
class _SuccessSliver extends ConsumerWidget {
  const _SuccessSliver({required this.stats});

  final ClientDashboardStats stats;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppStrings.of(context);
    final planAsync = ref.watch(clientTrainingPlanControllerProvider);

    return SliverPadding(
      padding: const EdgeInsets.all(AppDimens.l),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          _StatsRow(stats: stats, planAsync: planAsync),
          const SizedBox(height: AppDimens.xl),
          SubscriptionCard(
            onPay: () async {
              await showUploadPaymentSheet(context);
            },
          ),
          const SizedBox(height: AppDimens.xl),
          _PrimaryCard(stats: stats, planAsync: planAsync),
          const SizedBox(height: AppDimens.xl),
          SectionHeader(
            title: l10n.clientDashTodaySection,
            onSeeAll: () {
              // Futuro: vista completa del día.
            },
          ),
          const SizedBox(height: AppDimens.m),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.m),
            child: Text(
              l10n.clientDashTodayEmpty,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: AppDimens.xxl),
        ]),
      ),
    );
  }
}

/// Fila de 3 StatCards.
class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.stats, required this.planAsync});

  final ClientDashboardStats stats;
  final AsyncValue<TrainingPlan?> planAsync;

  TrainingPlanDay? _todayRoutine(TrainingPlan? plan) {
    if (plan == null) return null;
    final currentWeek = plan.weeks
        .where((w) => w.weekNumber == plan.currentWeek)
        .firstOrNull;
    if (currentWeek == null) return null;
    final today = DateTime.now().weekday; // 1=Lunes ... 7=Domingo
    return currentWeek.days
        .where((d) => d.dayOfWeek == today && d.hasRoutine)
        .firstOrNull;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final plan = planAsync.value;
    final today = _todayRoutine(plan);
    final exerciseCount = today?.exerciseCount;

    return Row(
      children: [
        Expanded(
          child: PesaoStatCard(
            label: l10n.clientDashStatKcal,
            value: stats.kcalToday.toString(),
            sub: l10n.clientDashStatKcalSub,
            icon: Icons.local_fire_department_rounded,
          ),
        ),
        const SizedBox(width: AppDimens.s),
        Expanded(
          child: PesaoStatCard(
            label: l10n.clientDashStatStreak,
            value: stats.streakDays.toString(),
            sub: l10n.clientDashStatStreakSub,
            icon: Icons.bolt_rounded,
          ),
        ),
        const SizedBox(width: AppDimens.s),
        Expanded(
          child: PesaoStatCard(
            label: l10n.clientDashStatNext,
            value: today?.routineName ?? '—',
            sub: today != null && exerciseCount != null
                ? l10n.clientRoutineExerciseCount(exerciseCount)
                : l10n.clientDashStatNextSub,
            icon: Icons.event_note_rounded,
          ),
        ),
      ],
    );
  }
}

/// PrimaryCard con CTA.
class _PrimaryCard extends StatelessWidget {
  const _PrimaryCard({required this.stats, required this.planAsync});

  final ClientDashboardStats stats;
  final AsyncValue<TrainingPlan?> planAsync;

  TrainingPlanDay? _todayRoutine(TrainingPlan? plan) {
    if (plan == null) return null;
    final currentWeek = plan.weeks
        .where((w) => w.weekNumber == plan.currentWeek)
        .firstOrNull;
    if (currentWeek == null) return null;
    final today = DateTime.now().weekday;
    return currentWeek.days
        .where((d) => d.dayOfWeek == today && d.hasRoutine)
        .firstOrNull;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final plan = planAsync.value;
    final today = _todayRoutine(plan);
    final hasRoutine = today != null;
    final exerciseCount = today?.exerciseCount;

    return Container(
      padding: const EdgeInsets.all(AppDimens.l),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppDimens.cardBorderRadius,
        border: Border.all(color: AppColors.outline),
        boxShadow: hasRoutine
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  blurRadius: 24,
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                hasRoutine
                    ? Icons.fitness_center_rounded
                    : Icons.event_busy_rounded,
                color: hasRoutine ? AppColors.primary : AppColors.textDisabled,
                size: 24,
              ),
              const SizedBox(width: AppDimens.s),
              Expanded(
                child: Text(
                  l10n.clientDashPrimaryRoutineTitle,
                  style: AppTypography.title.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.m),
          Text(
            hasRoutine
                ? l10n.clientDashPrimaryRoutineBody(exerciseCount ?? 0)
                : l10n.clientRoutineEmptyBody,
            style: AppTypography.body.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppDimens.m),
          Row(
            children: [
              Expanded(
                child: PesaoButton(
                  label: hasRoutine
                      ? l10n.clientDashPrimaryRoutineCta
                      : l10n.clientDashPrimaryRoutineCtaNone,
                  variant: hasRoutine
                      ? PesaoButtonVariant.secondary
                      : PesaoButtonVariant.secondary,
                  isExpanded: false,
                  onPressed: hasRoutine
                      ? () => context.go(RouteNames.clientRoutine)
                      : null,
                ),
              ),
              if (hasRoutine) ...[
                const SizedBox(width: AppDimens.s),
                StartWorkoutButton(routineId: today.routineId!),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
