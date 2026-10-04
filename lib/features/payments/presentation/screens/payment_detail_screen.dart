import 'package:cached_network_image/cached_network_image.dart';
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
import '../../../../shared/widgets/pesao_bottom_sheet.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_card.dart';
import '../../../../shared/widgets/pesao_info_row.dart';
import '../../../../shared/widgets/pesao_input.dart';
import '../../../../shared/widgets/pesao_toast.dart';
import '../../../../shared/widgets/skeleton_loader.dart';
import '../../domain/entities/payment.dart';
import '../providers/payments_providers.dart';
import '../widgets/payment_status_badge.dart';

/// Detalle de un pago.
class PaymentDetailScreen extends ConsumerStatefulWidget {
  const PaymentDetailScreen({super.key, required this.paymentId});

  final String paymentId;

  @override
  ConsumerState<PaymentDetailScreen> createState() =>
      _PaymentDetailScreenState();
}

class _PaymentDetailScreenState extends ConsumerState<PaymentDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final state = ref.watch(ownerPaymentsControllerProvider);
    final controller = ref.read(ownerPaymentsControllerProvider.notifier);

    final connectivityAsync = ref.watch(connectivityProvider);
    final isOnline = connectivityAsync.value ?? true;

    Payment? payment;
    for (final item in state.payments) {
      if (item.id == widget.paymentId) {
        payment = item;
        break;
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PesaoAppBar(title: l10n.paymentDetailTitle),
      body: SafeArea(
        child: Column(
          children: [
            if (!isOnline) const OfflineBanner(),
            Expanded(
              child: payment == null
                  ? _buildMissingPayment(state, controller, l10n)
                  : _buildContent(
                      context,
                      payment,
                      state,
                      controller,
                      isOnline,
                      l10n,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissingPayment(
    PaymentsState state,
    OwnerPaymentsController controller,
    AppStrings l10n,
  ) {
    if (state.isLoading) {
      return const Padding(
        padding: EdgeInsets.all(AppDimens.l),
        child: SkeletonLoader(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SkeletonBox(height: 72),
              SizedBox(height: AppDimens.l),
              SkeletonBox(height: 240),
              SizedBox(height: AppDimens.l),
              SkeletonBox(height: 200),
            ],
          ),
        ),
      );
    }

    return ErrorState(
      title: l10n.paymentsErrorTitle,
      body: l10n.paymentsErrorBody,
      onRetry: controller.load,
    );
  }

  Widget _buildContent(
    BuildContext context,
    Payment payment,
    PaymentsState state,
    OwnerPaymentsController controller,
    bool isOnline,
    AppStrings l10n,
  ) {
    final isPending = payment.status == PaymentStatus.pending;
    final canAct = isOnline && !state.isActing;
    final dateLabel = DateFormat.yMMMMd(
      'es_VE',
    ).add_jm().format(payment.createdAt);

    return ListView(
      padding: const EdgeInsets.all(AppDimens.l),
      children: [
        // Cliente.
        Row(
          children: [
            PesaoAvatar(
              imageUrl: payment.payerAvatarUrl,
              name: payment.payerName ?? 'Cliente',
              size: 56,
            ),
            const SizedBox(width: AppDimens.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    payment.payerName ?? 'Cliente',
                    style: AppTypography.title.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppDimens.xs),
                  PaymentStatusBadge(status: payment.status),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimens.xl),

        // Comprobante.
        Text(
          l10n.paymentDetailReceipt,
          style: AppTypography.title.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: AppDimens.m),
        ClipRRect(
          borderRadius: AppDimens.cardBorderRadius,
          child: CachedNetworkImage(
            imageUrl: payment.receiptUrl,
            fit: BoxFit.contain,
            placeholder: (context, url) => Container(
              height: 240,
              color: AppColors.surfaceHigh,
              alignment: Alignment.center,
              child: const SkeletonLoader(child: SkeletonBox(height: 240)),
            ),
            errorWidget: (context, url, error) => Container(
              height: 240,
              color: AppColors.surfaceHigh,
              alignment: Alignment.center,
              child: const Icon(
                Icons.broken_image_rounded, // TODO: promover a AppIcons.
                color: AppColors.textSecondary,
                size: 48,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppDimens.xl),

        // Datos del pago.
        PesaoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PesaoInfoRow(
                label: l10n.paymentDetailAmountUsd,
                value: '\$${payment.amountUsd.toStringAsFixed(2)}',
              ),
              const SizedBox(height: AppDimens.m),
              PesaoInfoRow(
                label: l10n.paymentDetailAmountBs,
                value: 'Bs. ${payment.amountBs.toStringAsFixed(2)}',
              ),
              const SizedBox(height: AppDimens.m),
              PesaoInfoRow(
                label: l10n.paymentDetailRate,
                value: 'Bs. ${payment.rateUsed.toStringAsFixed(2)}',
              ),
              const SizedBox(height: AppDimens.m),
              PesaoInfoRow(label: l10n.paymentDetailDate, value: dateLabel),
              if (payment.status == PaymentStatus.rejected &&
                  payment.rejectedReason != null) ...[
                const SizedBox(height: AppDimens.m),
                PesaoInfoRow(
                  label: l10n.paymentRejectReasonLabel,
                  value: payment.rejectedReason!,
                ),
              ],
            ],
          ),
        ),

        // Acciones solo para pagos pendientes.
        if (isPending) ...[
          const SizedBox(height: AppDimens.xl),
          PesaoButton(
            label: l10n.paymentDetailApprove,
            variant: PesaoButtonVariant.primary,
            loading: state.isActing,
            onPressed: canAct
                ? () => _approvePayment(controller, payment, l10n)
                : null,
          ),
          const SizedBox(height: AppDimens.m),
          PesaoButton(
            label: l10n.paymentDetailReject,
            variant: PesaoButtonVariant.danger,
            onPressed: canAct
                ? () => _rejectPayment(controller, payment, l10n)
                : null,
          ),
        ],
      ],
    );
  }

  Future<void> _approvePayment(
    OwnerPaymentsController controller,
    Payment payment,
    AppStrings l10n,
  ) async {
    final confirmed = await showConfirmDialog(
      context: context,
      title: l10n.paymentApproveConfirmTitle,
      message: l10n.paymentApproveConfirmBody,
      confirmLabel: l10n.paymentDetailApprove,
      cancelLabel: l10n.commonCancel,
      isDestructive: false,
    );

    if (!confirmed || !mounted) return;

    final result = await controller.approvePayment(payment.id);

    if (!mounted) return;

    result.when(
      idle: () {},
      loading: () {},
      success: (_) {
        showPesaoToast(
          context,
          message: l10n.paymentApprovedSuccess,
          semanticLabel: l10n.paymentApprovedSemantics,
          variant: PesaoToastVariant.success,
        );
        Navigator.of(context).pop();
      },
      failure: (_) {
        showPesaoToast(
          context,
          message: l10n.paymentActionError,
          semanticLabel: l10n.paymentActionError,
          variant: PesaoToastVariant.error,
        );
      },
    );
  }

  Future<void> _rejectPayment(
    OwnerPaymentsController controller,
    Payment payment,
    AppStrings l10n,
  ) async {
    final reason = await _showRejectSheet(l10n);
    if (reason == null || !mounted) return;

    final result = await controller.rejectPayment(payment.id, reason);

    if (!mounted) return;

    result.when(
      idle: () {},
      loading: () {},
      success: (_) {
        showPesaoToast(
          context,
          message: l10n.paymentRejectedSuccess,
          semanticLabel: l10n.paymentRejectedSemantics,
          variant: PesaoToastVariant.success,
        );
        Navigator.of(context).pop();
      },
      failure: (_) {
        showPesaoToast(
          context,
          message: l10n.paymentActionError,
          semanticLabel: l10n.paymentActionError,
          variant: PesaoToastVariant.error,
        );
      },
    );
  }

  Future<String?> _showRejectSheet(AppStrings l10n) async {
    final reasonController = TextEditingController();

    final result = await showPesaoBottomSheet<String>(
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
              PesaoBottomSheetHeader(title: l10n.paymentRejectDialogTitle),
              const SizedBox(height: AppDimens.s),
              Text(
                l10n.paymentRejectDialogBody,
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppDimens.l),
              PesaoInput(
                label: l10n.paymentRejectReasonLabel,
                hint: l10n.paymentRejectReasonHint,
                controller: reasonController,
              ),
              const SizedBox(height: AppDimens.l),
              PesaoButton(
                label: l10n.paymentDetailReject,
                variant: PesaoButtonVariant.danger,
                onPressed: () {
                  final text = reasonController.text.trim();
                  if (text.isEmpty) return;
                  Navigator.of(sheetContext).pop(text);
                },
              ),
              const SizedBox(height: AppDimens.s),
              PesaoButton(
                label: l10n.commonCancel,
                variant: PesaoButtonVariant.ghost,
                onPressed: () => Navigator.of(sheetContext).pop(),
              ),
            ],
          ),
        );
      },
    );

    return result;
  }
}
