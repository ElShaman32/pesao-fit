import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pesao_fit/core/l10n/app_strings.dart';
import 'package:pesao_fit/core/providers/connectivity_provider.dart';
import 'package:pesao_fit/core/theme/app_colors.dart';
import 'package:pesao_fit/shared/widgets/confirm_dialog.dart';
import 'package:pesao_fit/shared/widgets/empty_state.dart';
import 'package:pesao_fit/shared/widgets/error_state.dart';
import 'package:pesao_fit/shared/widgets/offline_banner.dart';
import 'package:pesao_fit/shared/widgets/pesao_app_bar.dart';
import 'package:pesao_fit/shared/widgets/pesao_button.dart';
import 'package:pesao_fit/shared/widgets/pesao_toast.dart';
import 'package:pesao_fit/shared/widgets/skeleton_loader.dart';

import '../../domain/entities/staff_overview.dart';
import '../providers/staff_providers.dart';
import '../widgets/staff_limit_card.dart';
import '../widgets/staff_member_tile.dart';

/// Pantalla que muestra el equipo de staff del gimnasio del owner.
/// Maneja los 5 estados obligatorios: loading, error, empty, success, offline.
class StaffListScreen extends ConsumerStatefulWidget {
  const StaffListScreen({super.key});

  @override
  ConsumerState<StaffListScreen> createState() => _StaffListScreenState();
}

class _StaffListScreenState extends ConsumerState<StaffListScreen> {
  @override
  void initState() {
    super.initState();
    // Fuerza una carga inicial.
    Future.microtask(() {
      ref.read(ownerStaffControllerProvider.notifier).refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final staffAsync = ref.watch(ownerStaffControllerProvider);
    final connectivityAsync = ref.watch(connectivityProvider);
    final isOnline = connectivityAsync.value ?? true;

    return Scaffold(
      appBar: const PesaoAppBar(title: AppStrings.staffScreenTitle),
      body: Column(
        children: [
          if (!isOnline) const OfflineBanner(),
          Expanded(
            child: staffAsync.when(
              data: (overview) => _buildSuccess(overview, isOnline),
              loading: () => const _LoadingState(),
              error: (error, _) => _ErrorState(
                onRetry: () =>
                    ref.read(ownerStaffControllerProvider.notifier).refresh(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Estado de éxito: muestra la lista de staff y el límite.
  Widget _buildSuccess(StaffOverview overview, bool isOnline) {
    if (overview.members.isEmpty) {
      return EmptyState(
        title: AppStrings.staffEmptyTitle,
        description: AppStrings.staffEmptyBody,
        icon: Icons.people_outline,
      );
    }

    return RefreshIndicator(
      onRefresh: () =>
          ref.read(ownerStaffControllerProvider.notifier).refresh(),
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
                    ? () => _confirmToggleActive(member)
                    : null,
              ),
            );
          }),
        ],
      ),
    );
  }

  /// Diálogo de confirmación para activar/desactivar un miembro.
  Future<void> _confirmToggleActive(dynamic member) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDialog(
        title: member.isActive
            ? AppStrings.staffDeactivateConfirmTitle
            : AppStrings.staffActivateConfirmTitle,
        description: member.isActive
            ? AppStrings.staffDeactivateConfirmBody
            : AppStrings.staffActivateConfirmBody,
        confirmLabel: member.isActive
            ? AppStrings.staffActionDeactivate
            : AppStrings.staffActionActivate,
        cancelLabel: AppStrings.commonCancel,
        isDestructive: member.isActive,
      ),
    );

    if (confirmed == true && mounted) {
      try {
        await ref
            .read(ownerStaffControllerProvider.notifier)
            .setStaffActive(member.id, !member.isActive);

        if (mounted) {
          PesaoToast.show(
            context: context,
            message: member.isActive
                ? AppStrings.staffDeactivatedSuccess
                : AppStrings.staffActivatedSuccess,
            type: ToastType.success,
          );
        }
      } catch (e) {
        if (mounted) {
          PesaoToast.show(
            context: context,
            message: AppStrings.staffActionError,
            type: ToastType.error,
          );
        }
      }
    }
  }
}

/// Estado de carga: skeleton replicando el layout real.
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
          SkeletonLoader(child: SizedBox(height: 80, width: double.infinity)),
          SizedBox(height: 8),
          SkeletonLoader(child: SizedBox(height: 80, width: double.infinity)),
          SizedBox(height: 8),
          SkeletonLoader(child: SizedBox(height: 80, width: double.infinity)),
        ],
      ),
    );
  }
}

/// Estado de error: muestra el error y permite reintentar.
class _ErrorState extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorState({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return ErrorState(
      title: AppStrings.staffErrorTitle,
      description: AppStrings.staffErrorBody,
      onRetry: onRetry,
    );
  }
}
