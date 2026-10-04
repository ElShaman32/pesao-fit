import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/confirm_dialog.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_bottom_sheet.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_card.dart';
import '../../../../shared/widgets/pesao_input.dart';
import '../../../../shared/widgets/pesao_toast.dart';
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
        appBar: PesaoAppBar(
          title: 'Solicitud', // TODO: mover a AppStrings.
        ),
        body: Center(
          child: Text(
            'No encontramos esta solicitud', // TODO: mover a AppStrings.
          ),
        ),
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
            // Sección: Datos del dueño.
            _SectionTitle(text: l10n.adminAppsOwnerSection),
            const SizedBox(height: AppDimens.m),
            PesaoCard(
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
            const SizedBox(height: AppDimens.xl),

            // Sección: Datos del gimnasio.
            _SectionTitle(text: l10n.adminAppsGymSection),
            const SizedBox(height: AppDimens.m),
            PesaoCard(
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
            const SizedBox(height: AppDimens.xxl),

            // Botones de acción.
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

  /// Confirmación de aprobación.
  Future<void> _confirmApprove(
    BuildContext context,
    GymApplication application,
    ApplicationsReviewController controller,
  ) async {
    final l10n = AppStrings.of(context);
    final confirmed = await showConfirmDialog(
      context: context,
      title: l10n.adminAppsApproveTitle(application.gymName),
      message: l10n.adminAppsApproveMessage,
      confirmLabel: l10n.adminAppsApprove,
      cancelLabel: 'Cancelar', // TODO: mover a AppStrings.
    );

    if (confirmed && context.mounted) {
      final ok = await controller.approve(application.id);
      if (context.mounted) {
        showPesaoToast(
          context,
          message: l10n.adminAppsApproveSuccess,
          semanticLabel: l10n.adminAppsApproveSuccess,
          variant: PesaoToastVariant.success,
        );
        if (ok) context.pop();
      }
    }
  }

  /// Rechazo con motivo vía bottom sheet.
  Future<void> _promptReject(
    BuildContext context,
    GymApplication application,
    ApplicationsReviewController controller,
  ) async {
    final l10n = AppStrings.of(context);
    final reasonController = TextEditingController();

    final reason = await showPesaoBottomSheet<String>(
      context: context,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: AppDimens.l,
            right: AppDimens.l,
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom + AppDimens.l,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PesaoBottomSheetHeader(title: l10n.adminAppsRejectTitle),
              const SizedBox(height: AppDimens.m),
              PesaoInput(
                controller: reasonController,
                label: l10n.adminAppsRejectReasonLabel,
                hint: l10n.adminAppsRejectReasonHint,
                prefixIcon: const Icon(Icons.block),
              ),
              const SizedBox(height: AppDimens.l),
              PesaoButton(
                label: l10n.adminAppsReject,
                variant: PesaoButtonVariant.danger,
                onPressed: () => Navigator.of(
                  sheetContext,
                ).pop(reasonController.text.trim()),
              ),
              const SizedBox(height: AppDimens.s),
              PesaoButton(
                label: 'Cancelar', // TODO: mover a AppStrings.
                variant: PesaoButtonVariant.ghost,
                onPressed: () => Navigator.of(sheetContext).pop(),
              ),
            ],
          ),
        );
      },
    );

    if (reason != null && reason.isNotEmpty && context.mounted) {
      final ok = await controller.reject(application.id, reason);
      if (context.mounted) {
        showPesaoToast(
          context,
          message: ok
              ? l10n.adminAppsRejectSuccess
              : l10n.adminAppsError, // TODO: confirmar key correcta
          semanticLabel: ok ? l10n.adminAppsRejectSuccess : l10n.adminAppsError,
          variant: ok ? PesaoToastVariant.warning : PesaoToastVariant.error,
        );
        if (ok) context.pop();
      }
    }
  }
}

// ============================================================================
// SECCIÓN TITLE
// ============================================================================

/// Título de sección usando `overline` del DS.
class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: AppTypography.overline.copyWith(color: AppColors.primaryText),
    );
  }
}

// ============================================================================
// INFO ROW
// ============================================================================

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
