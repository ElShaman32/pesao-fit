import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/connectivity_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/offline_banner.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_shell.dart';
import '../../../../shared/widgets/skeleton_loader.dart';
import '../../domain/entities/staff_member.dart';
import '../../domain/entities/staff_overview.dart';
import '../providers/staff_providers.dart';
import '../widgets/staff_limit_card.dart';
import '../widgets/staff_member_tile.dart';
import '../../../../shared/widgets/confirm_dialog.dart';
import '../../../../shared/widgets/pesao_toast.dart';

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

    return PesaoShell(
      appBar: PesaoAppBar(title: strings.staffScreenTitle),
      body: Column(
        children: [
          if (!isOnline) const OfflineBanner(),
          Expanded(
            child: staffResult.when(
              idle: () => const Center(child: CircularProgressIndicator()),
              loading: () => const _LoadingState(),
              success: (overview) => _buildSuccess(overview, isOnline, strings),
              failure: (error) => ErrorState(
                title: strings.staffErrorTitle,
                body: strings.staffErrorBody,
                onRetry: () =>
                    ref.read(ownerStaffControllerProvider.notifier).load(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccess(
    StaffOverview overview,
    bool isOnline,
    AppStrings strings,
  ) {
    if (overview.members.isEmpty) {
      return EmptyState(
        title: strings.staffEmptyTitle,
        body: strings.staffEmptyBody,
        icon: Icons.people_outline,
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(ownerStaffControllerProvider.notifier).load(),
      color: AppColors.primary,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          StaffLimitCard(
            staffCount: overview.staffCount,
            staffLimit: overview.staffLimit,
          ),
          const SizedBox(height: 16),
          ...overview.members.map((member) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: StaffMemberTile(
                member: member,
                onToggleActive: isOnline
                    ? () => _confirmToggleActive(member, strings)
                    : null,
              ),
            );
          }),
        ],
      ),
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

    // CORRECCIÓN CLAVE: confirmed == true en lugar de solo confirmed
    if (confirmed == true && mounted) {
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
                ? 'Miembro desactivado'
                : 'Miembro activado',
            variant: PesaoToastVariant.success,
          );
        }
      } catch (_) {
        if (mounted) {
          showPesaoToast(
            context,
            message: strings.staffActionError,
            semanticLabel: 'Error al completar la acción',
            variant: PesaoToastVariant.error,
          );
        }
      }
    }
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          SkeletonLoader(child: SizedBox(height: 100, width: double.infinity)),
          SizedBox(height: 16),
          SkeletonLoader(child: SizedBox(height: 72, width: double.infinity)),
          SizedBox(height: 8),
          SkeletonLoader(child: SizedBox(height: 72, width: double.infinity)),
        ],
      ),
    );
  }
}
