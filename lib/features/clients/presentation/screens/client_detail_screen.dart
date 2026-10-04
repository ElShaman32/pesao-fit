import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/connectivity_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/client_member.dart';
import '../../../../shared/widgets/confirm_dialog.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/offline_banner.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_avatar.dart';
import '../../../../shared/widgets/pesao_badge.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_card.dart';
import '../../../../shared/widgets/pesao_toast.dart';
import '../../../../shared/widgets/skeleton_loader.dart';
import '../../../memberships/presentation/widgets/assign_plan_sheet.dart';
import '../providers/clients_providers.dart';

/// Pantalla de detalle de cliente.
class ClientDetailScreen extends ConsumerWidget {
  const ClientDetailScreen({super.key, required this.membershipId});

  final String membershipId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppStrings.of(context);
    final clientAsync = ref.watch(clientDetailProvider(membershipId));
    final connectivityAsync = ref.watch(connectivityProvider);
    final isOnline = connectivityAsync.value ?? true;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PesaoAppBar(title: l10n.clientDetailTitle),
      body: SafeArea(
        child: Column(
          children: [
            if (!isOnline) const OfflineBanner(),
            Expanded(
              child: clientAsync.when(
                data: (client) =>
                    _ClientDetailContent(client: client, isOnline: isOnline),
                loading: () => const _ClientDetailSkeleton(),
                error: (error, _) => ErrorState(
                  title: l10n.clientsErrorTitle,
                  body: l10n.clientsErrorBody,
                  onRetry: () =>
                      ref.invalidate(clientDetailProvider(membershipId)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// CONTENT
// ============================================================================

class _ClientDetailContent extends ConsumerWidget {
  const _ClientDetailContent({required this.client, required this.isOnline});

  final ClientMember client;
  final bool isOnline;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppStrings.of(context);

    return ListView(
      padding: const EdgeInsets.all(AppDimens.l),
      children: [
        // Header con avatar y nombre.
        Center(
          child: Column(
            children: [
              PesaoAvatar(
                imageUrl: client.avatarUrl,
                name: client.fullName,
                size: 80,
              ),
              const SizedBox(height: AppDimens.m),
              Text(
                client.fullName,
                style: AppTypography.headline.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimens.s),
              PesaoBadge(
                label: client.isActive
                    ? l10n.clientDetailStatusActive
                    : l10n.clientDetailStatusInactive,
                variant: client.isActive
                    ? PesaoBadgeVariant.success
                    : PesaoBadgeVariant.warning,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppDimens.xl),

        // Card de información.
        PesaoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InfoRow(
                label: l10n.clientAddEmailLabel,
                value: client.email ?? '—',
              ),
              const SizedBox(height: AppDimens.m),
              _InfoRow(
                label: l10n.ownerAppPhoneLabel,
                value: client.phone ?? '—',
              ),
              const SizedBox(height: AppDimens.m),
              _InfoRow(
                label: l10n.clientDetailJoined,
                value: DateFormat.yMMMMd('es_VE').format(client.joinedAt),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppDimens.xl),

        // Plan del cliente.
        Text(
          l10n.ownerClientPlanSection,
          style: AppTypography.title.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: AppDimens.m),
        PesaoButton(
          label: l10n.assignPlanAssignCta,
          variant: PesaoButtonVariant.secondary,
          icon: AppIcons.plans,
          onPressed: () async {
            final result = await showAssignPlanSheet(
              context,
              userId: client.userId,
              gymId: client.gymId,
            );
            if (result && context.mounted) {
              // Refrescar si es necesario.
            }
          },
        ),
        const SizedBox(height: AppDimens.m),
        PesaoButton(
          label: client.isActive
              ? l10n.clientDetailDeactivate
              : l10n.clientDetailActivate,
          variant: client.isActive
              ? PesaoButtonVariant.danger
              : PesaoButtonVariant.primary,
          onPressed: isOnline
              ? () => _confirmToggleActive(
                  context,
                  ref,
                  client.id,
                  client.isActive,
                )
              : null,
        ),
      ],
    );
  }

  Future<void> _confirmToggleActive(
    BuildContext context,
    WidgetRef ref,
    String membershipId,
    bool isActive,
  ) async {
    final l10n = AppStrings.of(context);

    final confirmed = await showConfirmDialog(
      context: context,
      title: isActive
          ? l10n.clientDetailDeactivateConfirmTitle
          : l10n.clientDetailActivateConfirmTitle,
      message: isActive
          ? l10n.clientDetailDeactivateConfirmBody
          : l10n.clientDetailActivateConfirmBody,
      confirmLabel: isActive
          ? l10n.clientDetailDeactivate
          : l10n.clientDetailActivate,
      cancelLabel: l10n.commonCancel,
      isDestructive: isActive,
    );

    if (confirmed && context.mounted) {
      try {
        await ref
            .read(ownerClientsControllerProvider.notifier)
            .setClientActive(membershipId, !isActive);

        ref.invalidate(clientDetailProvider(membershipId));

        if (context.mounted) {
          showPesaoToast(
            context,
            message: isActive
                ? l10n.clientDeactivatedSuccess
                : l10n.clientActivatedSuccess,
            semanticLabel: isActive
                ? 'Cliente desactivado' // TODO: mover a AppStrings.
                : 'Cliente activado', // TODO: mover a AppStrings.
            variant: PesaoToastVariant.success,
          );
        }
      } catch (_) {
        if (context.mounted) {
          showPesaoToast(
            context,
            message: l10n.staffActionError,
            semanticLabel: l10n.staffActionError,
            variant: PesaoToastVariant.error,
          );
        }
      }
    }
  }
}

// ============================================================================
// INFO ROW
// ============================================================================

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.label.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTypography.body.copyWith(color: AppColors.textPrimary),
        ),
      ],
    );
  }
}

// ============================================================================
// SKELETON
// ============================================================================

class _ClientDetailSkeleton extends StatelessWidget {
  const _ClientDetailSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppDimens.l),
      child: SkeletonLoader(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SkeletonBox(height: 120),
            SizedBox(height: AppDimens.xl),
            SkeletonBox(height: 160),
            SizedBox(height: AppDimens.xl),
            SkeletonBox(height: 48),
            SizedBox(height: AppDimens.m),
            SkeletonBox(height: 48),
          ],
        ),
      ),
    );
  }
}
