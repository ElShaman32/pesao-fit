import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/connectivity_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../shared/widgets/confirm_dialog.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/offline_banner.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_toast.dart';
import '../../../../shared/widgets/skeleton_loader.dart';
import '../../domain/entities/staff_member.dart';
import '../../domain/entities/staff_overview.dart';
import '../providers/staff_providers.dart';
import '../widgets/staff_limit_card.dart';
import '../widgets/staff_member_tile.dart';

class StaffListScreen extends ConsumerStatefulWidget {
  const StaffListScreen({super.key});

  @override
  ConsumerState<StaffListScreen> createState() => _StaffListScreenState();
}

class _StaffListScreenState extends ConsumerState<StaffListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(ownerStaffControllerProvider.notifier).load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final staffResult = ref.watch(ownerStaffControllerProvider);
    final connectivityAsync = ref.watch(connectivityProvider);
    final isOnline = connectivityAsync.value ?? true;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PesaoAppBar(title: strings.staffScreenTitle),
      body: SafeArea(
        child: Column(
          children: [
            if (!isOnline) const OfflineBanner(),
            Expanded(
              child: RefreshIndicator(
                color: AppColors.primary,
                backgroundColor: AppColors.surface,
                onRefresh: () =>
                    ref.read(ownerStaffControllerProvider.notifier).load(),
                child: staffResult.when(
                  idle: () => const _LoadingState(),
                  loading: () => const _LoadingState(),
                  success: (overview) =>
                      _buildSuccess(overview, isOnline, strings),
                  failure: (error) => _scrollable(
                    ErrorState(
                      title: strings.staffErrorTitle,
                      body: strings.staffErrorBody,
                      onRetry: () => ref
                          .read(ownerStaffControllerProvider.notifier)
                          .load(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Envuelve estados no-scrollables en un ListView para que
  /// RefreshIndicator funcione con pull-to-refresh.
  Widget _scrollable(Widget child) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: child,
        ),
      ],
    );
  }

  Widget _buildSuccess(
    StaffOverview overview,
    bool isOnline,
    AppStrings strings,
  ) {
    if (overview.members.isEmpty) {
      return _scrollable(
        EmptyState(
          title: strings.staffEmptyTitle,
          body: strings.staffEmptyBody,
          icon: AppIcons.clientsOutline,
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(AppDimens.l),
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        StaffLimitCard(
          staffCount: overview.staffCount,
          staffLimit: overview.staffLimit,
        ),
        const SizedBox(height: AppDimens.l),
        ...overview.members.map((member) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppDimens.s),
            child: StaffMemberTile(
              member: member,
              onToggleActive: isOnline
                  ? () => _confirmToggleActive(member, strings)
                  : null,
            ),
          );
        }),
      ],
    );
  }

  Future<void> _confirmToggleActive(
    StaffMember member,
    AppStrings strings,
  ) async {
    final confirmed = await showConfirmDialog(
      context: context,
      title: member.isActive
          ? strings.staffDeactivateConfirmTitle
          : strings.staffActivateConfirmTitle,
      message: member.isActive
          ? strings.staffDeactivateConfirmBody
          : strings.staffActivateConfirmBody,
      confirmLabel: member.isActive
          ? strings.staffActionDeactivate
          : strings.staffActionActivate,
      cancelLabel: strings.commonCancel,
      isDestructive: member.isActive,
    );

    if (confirmed && mounted) {
      try {
        await ref
            .read(ownerStaffControllerProvider.notifier)
            .setStaffActive(member.id, !member.isActive);

        if (mounted) {
          showPesaoToast(
            context,
            message: member.isActive
                ? strings.staffDeactivatedSuccess
                : strings.staffActivatedSuccess,
            semanticLabel: member.isActive
                ? 'Miembro desactivado' // TODO: mover a AppStrings.
                : 'Miembro activado', // TODO: mover a AppStrings.
            variant: PesaoToastVariant.success,
          );
        }
      } catch (_) {
        if (mounted) {
          showPesaoToast(
            context,
            message: strings.staffActionError,
            semanticLabel:
                'Error al completar la acción', // TODO: mover a AppStrings.
            variant: PesaoToastVariant.error,
          );
        }
      }
    }
  }
}

// ============================================================================
// LOADING
// ============================================================================

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppDimens.l),
      child: SkeletonLoader(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SkeletonBox(height: 100),
            SizedBox(height: AppDimens.l),
            SkeletonBox(height: 72),
            SizedBox(height: AppDimens.s),
            SkeletonBox(height: 72),
          ],
        ),
      ),
    );
  }
}
