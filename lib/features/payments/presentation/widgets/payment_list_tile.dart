import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pesao_avatar.dart';
import '../../../../shared/widgets/pesao_list_tile.dart';
import '../../domain/entities/payment.dart';
import 'payment_status_badge.dart';

/// Tile para mostrar un pago en la lista del dueño.
class PaymentListTile extends StatelessWidget {
  const PaymentListTile({super.key, required this.payment, this.onTap});

  final Payment payment;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dateLabel = DateFormat.yMMMd('es_VE').format(payment.createdAt);
    final amountLabel = '\$${payment.amountUsd.toStringAsFixed(2)}';

    return PesaoListTile(
      leading: PesaoAvatar(
        imageUrl: payment.payerAvatarUrl,
        name: payment.payerName ?? 'Cliente',
        size: 48,
      ),
      title: payment.payerName ?? 'Cliente',
      subtitle: dateLabel,
      trailing: SizedBox(
        width: 120,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              amountLabel,
              style: AppTypography.title.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(height: AppDimens.xs),
            PaymentStatusBadge(status: payment.status),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
