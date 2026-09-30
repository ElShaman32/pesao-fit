import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/providers/connectivity_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/offline_banner.dart';
import '../../../../shared/widgets/pesao_avatar.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_stat_card.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../domain/entities/nutritionist_dashboard_stats.dart';
import '../providers/nutritionist_dashboard_controller.dart';

/// Dashboard del nutricionista (tab Inicio del shell).
///
/// design-system.md §10: avatar+saludo, 3 StatCards (planes/clientes/consultas),
/// PrimaryCard "Planes por revisar", sección "Últimos planes".
class NutritionistHomeScreen extends ConsumerWidget {
  const NutritionistHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppStrings.of(context);
    final state = ref.watch(nutritionistDashboardControllerProvider);
    final controller = ref.read(
      nutritionistDashboardControllerProvider.notifier,
    );
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
                        name: authProvider.userFullName ?? 'Nutricionista',
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
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              if (isOnline == false)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(AppDimens.l),
                    child: OfflineBanner(),
                  ),
                ),
              if (state.isLoading && state.stats == null)
                const _NutriSkeletonSliver()
              else if (state.error != null && state.stats == null)
                _NutriErrorSliver(
                  title: l10n.nutriDashErrorTitle,
                  body: l10n.nutriDashErrorBody,
                  onRetry: controller.load,
                )
              else if (state.hasData)
                _NutriSuccessSliver(stats: state.stats!),
            ],
          ),
        ),
      ),
    );
  }

  String _greetingForHour(AppStrings l10n) {
    final hour = DateTime.now().hour;
    final name = authProvider.userFullName ?? 'doc';
    if (hour < 12) return l10n.greetingMorning(name);
    if (hour < 19) return l10n.greetingAfternoon(name);
    return l10n.greetingNight(name);
  }
}

class _NutriSkeletonSliver extends StatelessWidget {
  const _NutriSkeletonSliver();

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

class _NutriErrorSliver extends StatelessWidget {
  const _NutriErrorSliver({
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

class _NutriSuccessSliver extends StatelessWidget {
  const _NutriSuccessSliver({required this.stats});
  final NutritionistDashboardStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return SliverPadding(
      padding: const EdgeInsets.all(AppDimens.l),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          Row(
            children: [
              Expanded(
                child: PesaoStatCard(
                  label: l10n.nutriDashStatPlans,
                  value: stats.activePlansCount.toString(),
                  sub: l10n.nutriDashStatPlansSub,
                  icon: Icons.restaurant_menu_rounded,
                ),
              ),
              const SizedBox(width: AppDimens.s),
              Expanded(
                child: PesaoStatCard(
                  label: l10n.nutriDashStatClients,
                  value: stats.clientsWithPlanCount.toString(),
                  sub: l10n.nutriDashStatClientsSub,
                  icon: Icons.people_rounded,
                ),
              ),
              const SizedBox(width: AppDimens.s),
              Expanded(
                child: PesaoStatCard(
                  label: l10n.nutriDashStatConsults,
                  value: stats.consultsTodayCount.toString(),
                  sub: l10n.nutriDashStatConsultsSub,
                  icon: Icons.event_note_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.xl),
          _NutriPrimaryCard(stats: stats),
          const SizedBox(height: AppDimens.xl),
          SectionHeader(title: l10n.nutriDashRecentSection, onSeeAll: () {}),
          const SizedBox(height: AppDimens.m),
          if (stats.recentPlans.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppDimens.m),
              child: Text(
                l10n.nutriDashRecentEmpty,
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

class _NutriPrimaryCard extends StatelessWidget {
  const _NutriPrimaryCard({required this.stats});
  final NutritionistDashboardStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final hasPlans = stats.hasPlansToReview;

    return Container(
      padding: const EdgeInsets.all(AppDimens.l),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppDimens.cardBorderRadius,
        border: Border.all(color: AppColors.outline),
        boxShadow: hasPlans
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
                hasPlans
                    ? Icons.restaurant_menu_rounded
                    : Icons.check_circle_outline_rounded,
                color: hasPlans ? AppColors.primary : AppColors.success,
                size: 24,
              ),
              const SizedBox(width: AppDimens.s),
              Expanded(
                child: Text(
                  l10n.nutriDashPrimaryTitle,
                  style: AppTypography.title.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.m),
          Text(
            hasPlans
                ? l10n.nutriDashPrimaryBody(stats.activePlansCount)
                : l10n.nutriDashPrimaryCtaNone,
            style: AppTypography.body.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppDimens.m),
          Align(
            alignment: Alignment.centerRight,
            child: PesaoButton(
              label: hasPlans
                  ? l10n.nutriDashPrimaryCta
                  : l10n.nutriDashPrimaryCtaNone,
              variant: hasPlans
                  ? PesaoButtonVariant.primary
                  : PesaoButtonVariant.secondary,
              isExpanded: false,
              onPressed: hasPlans
                  ? () {}
                  : null, // Futuro: navegar a planes (F3)
            ),
          ),
        ],
      ),
    );
  }
}
