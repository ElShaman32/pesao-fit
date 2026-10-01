import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/connectivity_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/confirm_dialog.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/offline_banner.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_avatar.dart';
import '../../../../shared/widgets/pesao_badge.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_card.dart';
import '../../../../shared/widgets/pesao_shell.dart';
import '../../../../shared/widgets/pesao_toast.dart';
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

    return PesaoShell(
      appBar: PesaoAppBar(title: l10n.clientDetailTitle),
      body: Column(
        children: [
          if (!isOnline) const OfflineBanner(),
          Expanded(
            child: clientAsync.when(
              data: (client) {
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
                      child: Padding(
                        padding: const EdgeInsets.all(AppDimens.l),
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
                              value: DateFormat.yMMMMd(
                                'es_VE',
                              ).format(client.joinedAt),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimens.xl),

                    // Botón activar/desactivar.
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
              },
              loading: () => const _LoadingState(),
              error: (error, _) {
                return ErrorState(
                  title: l10n.clientsErrorTitle,
                  body: l10n.clientsErrorBody,
                  onRetry: () =>
                      ref.invalidate(clientDetailProvider(membershipId)),
                );
              },
            ),
          ),
        ],
      ),
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

        // Invalidar detalle para refrescar.
        ref.invalidate(clientDetailProvider(membershipId));

        if (context.mounted) {
          showPesaoToast(
            context,
            message: isActive
                ? l10n.clientDeactivatedSuccess
                : l10n.clientActivatedSuccess,
            semanticLabel: isActive
                ? 'Cliente desactivado'
                : 'Cliente activado',
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

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppDimens.l),
      child: Column(
        children: [
          _SkeletonBox(height: 120),
          SizedBox(height: AppDimens.xl),
          _SkeletonBox(height: 160),
          SizedBox(height: AppDimens.xl),
          _SkeletonBox(height: 48),
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
