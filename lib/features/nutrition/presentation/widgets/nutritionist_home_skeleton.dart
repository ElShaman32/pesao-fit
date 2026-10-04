import 'package:flutter/material.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/skeleton_loader.dart';

/// Skeleton del dashboard del nutricionista.
/// Replica el layout real: saludo + 2 filas de 2 StatCards + sección.
class NutritionistHomeSkeleton extends StatelessWidget {
  const NutritionistHomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      semanticLabel: AppStrings.of(context).commonLoading,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimens.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppDimens.l),

            // Saludo.
            Row(
              children: [
                SkeletonCircle(size: 40),
                SizedBox(width: AppDimens.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonLine(width: 80, height: 10),
                      SizedBox(height: AppDimens.xs),
                      SkeletonLine(width: 160, height: 16),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimens.xl),

            // Fila 1: 2 StatCards.
            Row(
              children: [
                Expanded(child: SkeletonCard(height: 120)),
                SizedBox(width: AppDimens.m),
                Expanded(child: SkeletonCard(height: 120)),
              ],
            ),
            SizedBox(height: AppDimens.m),

            // Fila 2: 2 StatCards.
            Row(
              children: [
                Expanded(child: SkeletonCard(height: 120)),
                SizedBox(width: AppDimens.m),
                Expanded(child: SkeletonCard(height: 120)),
              ],
            ),
            SizedBox(height: AppDimens.xl),

            // Sección secundaria.
            SkeletonLine(width: 140, height: 16),
            SizedBox(height: AppDimens.m),
            SkeletonCard(height: 80),
          ],
        ),
      ),
    );
  }
}
