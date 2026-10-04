import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/image_picker_field.dart';
import '../../../../shared/widgets/pesao_bottom_sheet.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_input.dart';
import '../../../../shared/widgets/pesao_toast.dart';
import '../../../../shared/widgets/skeleton_loader.dart';
import '../../domain/entities/upload_payment_request.dart';
import '../providers/client_payments_controller.dart';

/// Muestra el sheet de subida de pago desde cualquier contexto.
///
/// Devuelve `true` si el pago se subió con éxito (para que el caller
/// pueda refrescar sus listas).
Future<bool> showUploadPaymentSheet(BuildContext context) async {
  final result = await showPesaoBottomSheet<bool>(
    context: context,
    builder: (_) => const _UploadPaymentSheet(),
  );
  return result ?? false;
}

class _UploadPaymentSheet extends ConsumerStatefulWidget {
  const _UploadPaymentSheet();

  @override
  ConsumerState<_UploadPaymentSheet> createState() =>
      _UploadPaymentSheetState();
}

class _UploadPaymentSheetState extends ConsumerState<_UploadPaymentSheet> {
  final _amountBsController = TextEditingController();
  final _amountUsdController = TextEditingController();

  Uint8List? _imageBytes;
  double? _rate;
  bool _rateLoaded = false;

  String? _amountBsError;
  String? _imageError;

  @override
  void initState() {
    super.initState();
    _loadRate();
  }

  Future<void> _loadRate() async {
    final rate = await ref
        .read(clientPaymentUploadControllerProvider.notifier)
        .getCurrentRate();

    if (mounted) {
      setState(() {
        _rate = rate;
        _rateLoaded = true;
      });
    }
  }

  @override
  void dispose() {
    _amountBsController.dispose();
    _amountUsdController.dispose();
    super.dispose();
  }

  void _onAmountBsChanged(String value) {
    final bs = double.tryParse(value.replaceAll(',', '.'));
    final rate = _rate;

    if (bs == null || bs <= 0 || rate == null || rate <= 0) {
      _amountUsdController.text = '';
      return;
    }

    final usd = bs / rate;
    _amountUsdController.text = usd.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final state = ref.watch(clientPaymentUploadControllerProvider);
    final controller = ref.read(clientPaymentUploadControllerProvider.notifier);

    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const PesaoBottomSheetHeader(),
            const SizedBox(height: AppDimens.s),

            // Header.
            Text(
              l10n.uploadPaymentTitle,
              style: AppTypography.headline.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimens.xs),
            Text(
              l10n.uploadPaymentSubtitle,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimens.l),

            // Sin tasa configurada.
            if (_rateLoaded && _rate == null) ...[
              const _NoRateWarning(),
              const SizedBox(height: AppDimens.l),
              PesaoButton(
                label: l10n.commonClose,
                variant: PesaoButtonVariant.secondary,
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ] else if (!_rateLoaded) ...[
              const SkeletonLoader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SkeletonBox(height: 52),
                    SizedBox(height: AppDimens.m),
                    SkeletonBox(height: 52),
                    SizedBox(height: AppDimens.l),
                    SkeletonBox(height: 200),
                  ],
                ),
              ),
              const SizedBox(height: AppDimens.l),
            ] else ...[
              // Monto Bs.
              PesaoInput(
                label: l10n.uploadPaymentAmountBsLabel,
                hint: l10n.uploadPaymentAmountBsHint,
                prefixIcon: const Icon(Icons.account_balance_wallet),
                controller: _amountBsController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                ],
                onChanged: _onAmountBsChanged,
                errorText: _amountBsError,
              ),
              const SizedBox(height: AppDimens.m),

              // Monto USD calculado.
              PesaoInput(
                label: l10n.uploadPaymentAmountUsdLabel,
                hint: l10n.uploadPaymentAmountUsdHint,
                prefixIcon: const Icon(Icons.paid),

                controller: _amountUsdController,
                enabled: false,
              ),
              const SizedBox(height: AppDimens.xs),
              Text(
                '${l10n.uploadPaymentRateLabel}: Bs. ${_rate!.toStringAsFixed(2)}',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppDimens.l),

              // Imagen del comprobante.
              ImagePickerField(
                imageBytes: _imageBytes,
                pickLabel: l10n.uploadPaymentPickImage,
                replaceLabel: l10n.uploadPaymentReplaceImage,
                error: _imageError,
                onImagePicked: (bytes) {
                  setState(() {
                    _imageBytes = bytes;
                    _imageError = null;
                  });
                },
              ),
              const SizedBox(height: AppDimens.xl),

              // Botón submit.
              PesaoButton(
                label: l10n.uploadPaymentSubmit,
                variant: PesaoButtonVariant.primary,
                loading: state.isUploading,
                onPressed: () => _submit(controller, l10n),
              ),
            ],
            const SizedBox(height: AppDimens.l),
          ],
        ),
      ),
    );
  }

  Future<void> _submit(
    ClientPaymentUploadController controller,
    AppStrings l10n,
  ) async {
    setState(() {
      _amountBsError = null;
      _imageError = null;
    });

    final bsText = _amountBsController.text.replaceAll(',', '.');
    final amountBs = double.tryParse(bsText);

    if (amountBs == null || amountBs <= 0) {
      setState(() {
        _amountBsError = l10n.uploadPaymentAmountBsError;
      });
      return;
    }

    if (_imageBytes == null) {
      setState(() {
        _imageError = l10n.uploadPaymentPickImageError;
      });
      return;
    }

    final gymId = authProvider.userGymId;
    final rate = _rate;

    if (gymId == null || rate == null || rate <= 0) return;

    final amountUsd = amountBs / rate;

    final request = UploadPaymentRequest(
      gymId: gymId,
      amountBs: amountBs,
      amountUsd: amountUsd,
      rateUsed: rate,
      receiptBytes: _imageBytes!,
    );

    final result = await controller.upload(request);

    if (!mounted) return;

    result.when(
      idle: () {},
      loading: () {},
      success: (_) {
        showPesaoToast(
          context,
          message: l10n.uploadPaymentSuccessTitle,
          semanticLabel: l10n.uploadPaymentSuccessSemantics,
          variant: PesaoToastVariant.success,
        );
        Navigator.of(context).pop(true);
      },
      failure: (error) {
        showPesaoToast(
          context,
          message: error.toString(),
          semanticLabel: l10n.uploadPaymentErrorSemantics,
          variant: PesaoToastVariant.error,
        );
      },
    );
  }
}

// ============================================================================
// NO RATE WARNING
// ============================================================================

/// Caja de advertencia cuando no hay tasa configurada (P2: se queda custom).
class _NoRateWarning extends StatelessWidget {
  const _NoRateWarning();

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    return Container(
      padding: const EdgeInsets.all(AppDimens.l),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.1),
        borderRadius: AppDimens.cardBorderRadius,
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                AppIcons.warning,
                color: AppColors.warningText,
                size: 20,
              ),
              const SizedBox(width: AppDimens.s),
              Expanded(
                child: Text(
                  l10n.uploadPaymentNoRateTitle,
                  style: AppTypography.title.copyWith(
                    color: AppColors.warningText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.s),
          Text(
            l10n.uploadPaymentNoRateBody,
            style: AppTypography.body.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
