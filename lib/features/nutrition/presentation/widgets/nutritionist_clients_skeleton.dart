import 'package:flutter/material.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/skeleton_loader.dart';

/// Skeleton de la lista de clientes del nutricionista.
/// Replica el layout de NutritionistClientTile: avatar + 3 líneas + chevron.
class NutritionistClientsSkeleton extends StatelessWidget {
  const NutritionistClientsSkeleton({super.key, this.itemCount = 5});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      semanticLabel: AppStrings.of(context).commonLoading,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.l,
          vertical: AppDimens.s,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppDimens.s),
            child: Container(
              padding: const EdgeInsets.all(AppDimens.m),
              decoration: const BoxDecoration(
                color: AppColors.surfaceHigh,
                borderRadius: AppDimens.cardBorderRadius,
              ),
              child: const Row(
                children: [
                  SkeletonCircle(size: 48),
                  SizedBox(width: AppDimens.m),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonLine(width: 160, height: 14),
                        SizedBox(height: AppDimens.xs),
                        SkeletonLine(width: 200, height: 10),
                        SizedBox(height: AppDimens.xs),
                        SkeletonLine(width: 120, height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
