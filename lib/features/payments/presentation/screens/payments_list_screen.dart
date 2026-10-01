import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/connectivity_provider.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/offline_banner.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_shell.dart';
import '../providers/payments_providers.dart';
import '../widgets/payment_list_tile.dart';

/// Pantalla de pagos del dueño.
class PaymentsListScreen extends ConsumerStatefulWidget {
  const PaymentsListScreen({super.key});

  @override
  ConsumerState<PaymentsListScreen> createState() => _PaymentsListScreenState();
}

class _PaymentsListScreenState extends ConsumerState<PaymentsListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(ownerPaymentsControllerProvider.notifier).load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final state = ref.watch(ownerPaymentsControllerProvider);
    final controller = ref.read(ownerPaymentsControllerProvider.notifier);

    final connectivityAsync = ref.watch(connectivityProvider);
    final isOnline = connectivityAsync.value ?? true;

    return PesaoShell(
      appBar: PesaoAppBar(title: l10n.paymentsScreenTitle),
      body: Column(
        children: [
          if (!isOnline) const OfflineBanner(),
          _FilterRow(selected: state.filter, onSelected: controller.setFilter),
          Expanded(child: _buildContent(context, state, controller, isOnline)),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PaymentsState state,
    OwnerPaymentsController controller,
    bool isOnline,
  ) {
    final l10n = AppStrings.of(context);

    if (state.isLoading && !state.hasData) {
      return const _PaymentsSkeleton();
    }

    if (!isOnline && !state.hasData) {
      return EmptyState(
        title: l10n.paymentsOfflineEmpty,
        body: l10n.offlineBannerSemantics,
        icon: Icons.wifi_off_rounded,
      );
    }

    if (state.error != null && !state.hasData) {
      return ErrorState(
        title: l10n.paymentsErrorTitle,
        body: '${l10n.paymentsErrorBody}\n\n${state.error}',
        onRetry: controller.load,
      );
    }

    final payments = state.filteredPayments;

    if (payments.isEmpty) {
      return _EmptyByFilter(filter: state.filter);
    }

    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: AppColors.surface,
      onRefresh: () async {
        if (isOnline) {
          await controller.load();
        }
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(AppDimens.l),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: payments.length,
        separatorBuilder: (_, _) => const SizedBox(height: AppDimens.s),
        itemBuilder: (context, index) {
          final payment = payments[index];
          return PaymentListTile(
            payment: payment,
            onTap: () {
              context.pushNamed(
                RouteNames.ownerPaymentDetail,
                pathParameters: {'paymentId': payment.id},
              );
            },
          );
        },
      ),
    );
  }
}

/// Fila de filtros.
class _FilterRow extends StatelessWidget {
  const _FilterRow({required this.selected, required this.onSelected});

  final PaymentFilter selected;
  final ValueChanged<PaymentFilter> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(
        AppDimens.l,
        AppDimens.m,
        AppDimens.l,
        0,
      ),
      child: Row(
        children: PaymentFilter.values.map((filter) {
          final isSelected = filter == selected;
          final label = _filterLabel(context, filter);

          return Padding(
            padding: const EdgeInsets.only(right: AppDimens.s),
            child: _FilterChip(
              label: label,
              isSelected: isSelected,
              onTap: () => onSelected(filter),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _filterLabel(BuildContext context, PaymentFilter filter) {
    final l10n = AppStrings.of(context);

    switch (filter) {
      case PaymentFilter.pending:
        return l10n.paymentsFilterPending;
      case PaymentFilter.verified:
        return l10n.paymentsFilterVerified;
      case PaymentFilter.rejected:
        return l10n.paymentsFilterRejected;
    }
  }
}

/// Chip simple construido con tokens del design system.
class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.m,
          vertical: AppDimens.s,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.12)
              : AppColors.surface,
          borderRadius: AppDimens.pillBorderRadius,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.outline,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.label.copyWith(
            color: isSelected ? AppColors.primaryText : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

/// Estado vacío según filtro activo.
class _EmptyByFilter extends StatelessWidget {
  const _EmptyByFilter({required this.filter});

  final PaymentFilter filter;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    switch (filter) {
      case PaymentFilter.pending:
        return EmptyState(
          title: l10n.paymentsEmptyPendingTitle,
          body: l10n.paymentsEmptyPendingBody,
          icon: Icons.receipt_long_rounded,
        );
      case PaymentFilter.verified:
        return EmptyState(
          title: l10n.paymentsEmptyVerifiedTitle,
          body: l10n.paymentsEmptyVerifiedBody,
          icon: Icons.check_circle_outline_rounded,
        );
      case PaymentFilter.rejected:
        return EmptyState(
          title: l10n.paymentsEmptyRejectedTitle,
          body: l10n.paymentsEmptyRejectedBody,
          icon: Icons.cancel_outlined,
        );
    }
  }
}

/// Skeleton de pagos.
class _PaymentsSkeleton extends StatelessWidget {
  const _PaymentsSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppDimens.l),
      child: Column(
        children: [
          _SkeletonBox(height: 72),
          SizedBox(height: AppDimens.s),
          _SkeletonBox(height: 72),
          SizedBox(height: AppDimens.s),
          _SkeletonBox(height: 72),
          SizedBox(height: AppDimens.s),
          _SkeletonBox(height: 72),
        ],
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppDimens.cardBorderRadius,
        border: Border.all(color: AppColors.outline),
      ),
    );
  }
}
