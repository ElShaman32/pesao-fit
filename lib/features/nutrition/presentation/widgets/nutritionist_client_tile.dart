import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pesao_avatar.dart';
import '../../../../shared/widgets/pesao_card.dart';
import '../../domain/entities/nutrition_client.dart';

/// Tile de un cliente en la lista del nutricionista.
/// Muestra avatar, nombre, email y fecha de membresía.
/// Al tocar navega al detalle nutricional del cliente.
class NutritionistClientTile extends StatelessWidget {
  final NutritionClient client;

  const NutritionistClientTile({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final memberSince = _formatDate(client.memberSince);

    return PesaoCard(
      onTap: () => context.push(
        RouteNames.nutritionistClientDetail.replaceFirst(
          ':clientId',
          client.userId,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.m),
        child: Row(
          children: [
            // Avatar con fallback a inicial.
            PesaoAvatar(
              imageUrl: client.avatarUrl,
              name: client.initial,
              size: 48,
            ),
            const SizedBox(width: AppDimens.m),

            // Nombre + email + membresía.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    client.fullName,
                    style: AppTypography.headline.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppDimens.xs),
                  if (client.email != null)
                    Text(
                      client.email!,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: AppDimens.xxl),
                  Text(
                    l10n.nutritionClientSince(memberSince),
                    style: AppTypography.label.copyWith(
                      color: AppColors.textDisabled,
                    ),
                  ),
                ],
              ),
            ),

            // Chevron.
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textDisabled,
              size: AppDimens.m,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}
