import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/connectivity_provider.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/offline_banner.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_chip.dart';
import '../../../../shared/widgets/skeleton_loader.dart';
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

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PesaoAppBar(title: l10n.paymentsScreenTitle),
      body: SafeArea(
        child: Column(
          children: [
            if (!isOnline) const OfflineBanner(),
            _FilterRow(
              selected: state.filter,
              onSelected: controller.setFilter,
            ),
            Expanded(
              child: RefreshIndicator(
                color: AppColors.primary,
                backgroundColor: AppColors.surface,
                onRefresh: () async {
                  if (isOnline) {
                    await controller.load();
                  }
                },
                child: _buildContent(context, state, controller, isOnline),
              ),
            ),
          ],
        ),
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
      return _scrollable(
        EmptyState(
          title: l10n.paymentsOfflineEmpty,
          body: l10n.offlineBannerSemantics,
          icon: AppIcons.offline,
        ),
      );
    }

    if (state.error != null && !state.hasData) {
      return _scrollable(
        ErrorState(
          title: l10n.paymentsErrorTitle,
          body: '${l10n.paymentsErrorBody}\n\n${state.error}',
          onRetry: controller.load,
        ),
      );
    }

    final payments = state.filteredPayments;

    if (payments.isEmpty) {
      return _scrollable(_EmptyByFilter(filter: state.filter));
    }

    return ListView.separated(
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
    );
  }

  /// Envuelve estados no-scrollables en un ListView para que
  /// RefreshIndicator funcione con pull-to-refresh.
  Widget _scrollable(Widget child) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: child,
        ),
      ],
    );
  }
}

// ============================================================================
// FILTER ROW
// ============================================================================

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
            child: PesaoChip(
              label: label,
              selected: isSelected,
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

// ============================================================================
// EMPTY BY FILTER
// ============================================================================

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
          icon: AppIcons.payments,
        );
      case PaymentFilter.verified:
        return EmptyState(
          title: l10n.paymentsEmptyVerifiedTitle,
          body: l10n.paymentsEmptyVerifiedBody,
          icon: AppIcons.success,
        );
      case PaymentFilter.rejected:
        return EmptyState(
          title: l10n.paymentsEmptyRejectedTitle,
          body: l10n.paymentsEmptyRejectedBody,
          icon: Icons.cancel_outlined, // TODO: promover a AppIcons.
        );
    }
  }
}

// ============================================================================
// SKELETON
// ============================================================================

/// Skeleton de pagos.
class _PaymentsSkeleton extends StatelessWidget {
  const _PaymentsSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppDimens.l),
      child: SkeletonLoader(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SkeletonBox(height: 72),
            SizedBox(height: AppDimens.s),
            SkeletonBox(height: 72),
            SizedBox(height: AppDimens.s),
            SkeletonBox(height: 72),
            SizedBox(height: AppDimens.s),
            SkeletonBox(height: 72),
          ],
        ),
      ),
    );
  }
}
