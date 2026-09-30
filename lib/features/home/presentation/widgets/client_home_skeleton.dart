import 'package:flutter/material.dart';

import '../../../../../core/theme/app_dimens.dart';
import '../../../../../shared/widgets/skeleton_loader.dart';

/// Skeleton que REPLICA el layout real del Inicio del cliente.
class ClientHomeSkeleton extends StatelessWidget {
  const ClientHomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppDimens.l),
          SkeletonLine(width: 180, height: 14),
          SizedBox(height: AppDimens.xs),
          SkeletonLine(width: 120, height: 12),
          SizedBox(height: AppDimens.xl),
          Row(
            children: [
              Expanded(child: SkeletonCard(height: 96)),
              SizedBox(width: AppDimens.m),
              Expanded(child: SkeletonCard(height: 96)),
            ],
          ),
          SizedBox(height: AppDimens.m),
          Row(
            children: [
              Expanded(child: SkeletonCard(height: 96)),
              SizedBox(width: AppDimens.m),
              Expanded(child: SkeletonCard(height: 96)),
            ],
          ),
          SizedBox(height: AppDimens.xl),
          SkeletonCard(height: 120),
          SizedBox(height: AppDimens.xl),
          SkeletonLine(width: 160, height: 14),
          SizedBox(height: AppDimens.m),
          SkeletonListTile(),
          SizedBox(height: AppDimens.m),
          SkeletonListTile(),
        ],
      ),
    );
  }
}
