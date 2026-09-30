import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_card.dart';
import '../../../../shared/widgets/pesao_input.dart';
import '../../domain/entities/gym_application.dart';
import '../providers/applications_review_controller.dart';

/// Detalle de una solicitud con acciones de aprobar/rechazar (ADR-036).
class ApplicationDetailScreen extends ConsumerWidget {
  const ApplicationDetailScreen({super.key, required this.applicationId});

  final String applicationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppStrings.of(context);
    final state = ref.watch(applicationsReviewControllerProvider);
    final controller = ref.read(applicationsReviewControllerProvider.notifier);
    final application = controller.getById(applicationId);

    // Si no se encuentra la solicitud (edge case), mostrar error.
    if (application == null) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        appBar: PesaoAppBar(title: 'Solicitud'),
        body: Center(child: Text('No encontramos esta solicitud')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PesaoAppBar(title: application.gymName),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // === Sección: Datos del dueño ===
            _SectionTitle(text: l10n.adminAppsOwnerSection),
            const SizedBox(height: AppDimens.m),
            PesaoCard(
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.l),
                child: Column(
                  children: [
                    _InfoRow(label: 'Nombre', value: application.ownerName),
                    _InfoRow(
                      label: l10n.adminAppsFieldPhone,
                      value: application.ownerPhone,
                    ),
                    if (application.ownerDocument != null)
                      _InfoRow(
                        label: l10n.adminAppsFieldDocument,
                        value: application.ownerDocument!,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppDimens.xl),

            // === Sección: Datos del gimnasio ===
            _SectionTitle(text: l10n.adminAppsGymSection),
            const SizedBox(height: AppDimens.m),
            PesaoCard(
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.l),
                child: Column(
                  children: [
                    _InfoRow(label: 'Nombre', value: application.gymName),
                    _InfoRow(
                      label: l10n.adminAppsFieldAddress,
                      value: application.gymAddress,
                    ),
                    _InfoRow(
                      label: l10n.adminAppsFieldCity,
                      value: application.gymCity,
                    ),
                    _InfoRow(
                      label: l10n.adminAppsFieldState,
                      value: application.gymState,
                    ),
                    _InfoRow(
                      label: l10n.adminAppsFieldPhone,
                      value: application.gymPhone,
                    ),
                    if (application.gymRif != null)
                      _InfoRow(
                        label: l10n.adminAppsFieldRif,
                        value: application.gymRif!,
                      ),
                    if (application.gymInstagram != null)
                      _InfoRow(
                        label: l10n.adminAppsFieldInstagram,
                        value: application.gymInstagram!,
                      ),
                    if (application.gymDescription != null)
                      _InfoRow(
                        label: l10n.adminAppsFieldDescription,
                        value: application.gymDescription!,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppDimens.xxl),

            // === Botones de acción ===
            PesaoButton(
              label: l10n.adminAppsApprove,
              loading: state.isActing,
              onPressed: state.isActing
                  ? null
                  : () => _confirmApprove(context, application, controller),
            ),
            const SizedBox(height: AppDimens.m),
            PesaoButton(
              label: l10n.adminAppsReject,
              variant: PesaoButtonVariant.danger,
              loading: state.isActing,
              onPressed: state.isActing
                  ? null
                  : () => _promptReject(context, application, controller),
            ),
            const SizedBox(height: AppDimens.xxl),
          ],
        ),
      ),
    );
  }

  /// Diálogo de confirmación para aprobar.
  Future<void> _confirmApprove(
    BuildContext context,
    GymApplication application,
    ApplicationsReviewController controller,
  ) async {
    final l10n = AppStrings.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusCard),
          ),
          title: Text(
            l10n.adminAppsApproveTitle(application.gymName),
            style: AppTypography.title.copyWith(color: AppColors.textPrimary),
          ),
          content: Text(
            l10n.adminAppsApproveMessage,
            style: AppTypography.body.copyWith(color: AppColors.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(
                'Cancelar',
                style: AppTypography.label.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            PesaoButton(
              label: l10n.adminAppsApprove,
              isExpanded: false,
              onPressed: () => Navigator.of(dialogContext).pop(true),
            ),
          ],
        );
      },
    );

    if (confirmed == true && context.mounted) {
      final ok = await controller.approve(application.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.adminAppsApproveSuccess),
            backgroundColor: AppColors.success,
          ),
        );
        if (ok) context.pop();
      }
    }
  }

  /// Diálogo para rechazar con motivo.
  Future<void> _promptReject(
    BuildContext context,
    GymApplication application,
    ApplicationsReviewController controller,
  ) async {
    final l10n = AppStrings.of(context);
    final reasonController = TextEditingController();

    final reason = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusCard),
          ),
          title: Text(
            l10n.adminAppsRejectTitle,
            style: AppTypography.title.copyWith(color: AppColors.textPrimary),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PesaoInput(
                controller: reasonController,
                label: l10n.adminAppsRejectReasonLabel,
                hint: l10n.adminAppsRejectReasonHint,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(null),
              child: Text(
                'Cancelar',
                style: AppTypography.label.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            PesaoButton(
              label: l10n.adminAppsReject,
              variant: PesaoButtonVariant.danger,
              isExpanded: false,
              onPressed: () =>
                  Navigator.of(dialogContext).pop(reasonController.text.trim()),
            ),
          ],
        );
      },
    );

    if (reason != null && reason.isNotEmpty && context.mounted) {
      final ok = await controller.reject(application.id, reason);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.adminAppsRejectSuccess),
            backgroundColor: AppColors.error,
          ),
        );
        if (ok) context.pop();
      }
    }
  }
}

/// Título de sección.
class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: AppTypography.label.copyWith(
        color: AppColors.primaryText,
        letterSpacing: 1.5,
      ),
    );
  }
}

/// Fila de etiqueta + valor para mostrar datos.
class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTypography.body.copyWith(color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
