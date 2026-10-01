import 'package:flutter/material.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../shared/widgets/pesao_badge.dart';
import '../../domain/entities/payment.dart';

/// Badge semántico para estado de pago.
class PaymentStatusBadge extends StatelessWidget {
  const PaymentStatusBadge({super.key, required this.status});

  final PaymentStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    final String label;
    final PesaoBadgeVariant variant;

    switch (status) {
      case PaymentStatus.pending:
        label = l10n.paymentStatusPending;
        variant = PesaoBadgeVariant.warning;
      case PaymentStatus.verified:
        label = l10n.paymentStatusVerified;
        variant = PesaoBadgeVariant.success;
      case PaymentStatus.rejected:
        label = l10n.paymentStatusRejected;
        variant = PesaoBadgeVariant.error;
    }

    return PesaoBadge(label: label, variant: variant);
  }
}
