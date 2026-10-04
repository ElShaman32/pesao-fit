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
import '../../../../shared/widgets/pesao_search_bar.dart';
import '../../../../shared/widgets/skeleton_loader.dart';
import '../../domain/entities/client_overview.dart';
import '../providers/clients_providers.dart';
import '../widgets/client_limit_card.dart';
import '../widgets/client_member_tile.dart';

/// Pantalla de lista de clientes del dueño.
class ClientsListScreen extends ConsumerStatefulWidget {
  const ClientsListScreen({super.key});

  @override
  ConsumerState<ClientsListScreen> createState() => _ClientsListScreenState();
}

class _ClientsListScreenState extends ConsumerState<ClientsListScreen> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(ownerClientsControllerProvider.notifier).load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final clientsResult = ref.watch(ownerClientsControllerProvider);
    final connectivityAsync = ref.watch(connectivityProvider);
    final isOnline = connectivityAsync.value ?? true;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PesaoAppBar(title: l10n.clientsScreenTitle),
      body: SafeArea(
        child: Column(
          children: [
            if (!isOnline) const OfflineBanner(),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimens.l,
                AppDimens.m,
                AppDimens.l,
                0,
              ),
              child: PesaoSearchBar(
                hintText: l10n.clientsSearchHint,
                onChanged: (value) {
                  setState(() => _searchQuery = value.toLowerCase());
                },
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                color: AppColors.primary,
                backgroundColor: AppColors.surface,
                onRefresh: () =>
                    ref.read(ownerClientsControllerProvider.notifier).load(),
                child: clientsResult.when(
                  idle: () => const _LoadingState(),
                  loading: () => const _LoadingState(),
                  success: (overview) => _buildSuccess(overview),
                  failure: (error) {
                    final errorMessage = error
                        .toString()
                        .replaceAll('UnknownException(cause: ', '')
                        .replaceAll(')', '');
                    return _scrollable(
                      ErrorState(
                        title: l10n.clientsErrorTitle,
                        body: '${l10n.clientsErrorBody}\n\n$errorMessage',
                        onRetry: () => ref
                            .read(ownerClientsControllerProvider.notifier)
                            .load(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
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

  Widget _buildSuccess(ClientOverview overview) {
    final l10n = AppStrings.of(context);

    final filteredMembers = _searchQuery.isEmpty
        ? overview.members
        : overview.members
              .where((m) => m.fullName.toLowerCase().contains(_searchQuery))
              .toList();

    if (overview.members.isEmpty) {
      return _scrollable(
        EmptyState(
          title: l10n.clientsEmptyTitle,
          body: l10n.clientsEmptyBody,
          icon: AppIcons.clientsOutline,
        ),
      );
    }

    if (filteredMembers.isEmpty) {
      return _scrollable(
        EmptyState(
          title: l10n.clientsEmptyTitle,
          body: l10n.clientsSearchHint,
          icon: Icons.search_off_rounded, // TODO: promover a AppIcons.
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(AppDimens.l),
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        ClientLimitCard(
          clientCount: overview.clientCount,
          clientLimit: overview.clientLimit,
        ),
        const SizedBox(height: AppDimens.l),
        ...filteredMembers.map((member) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppDimens.s),
            child: ClientMemberTile(
              member: member,
              onTap: () {
                context.pushNamed(
                  RouteNames.ownerClientDetail,
                  pathParameters: {'membershipId': member.id},
                );
              },
            ),
          );
        }),
      ],
    );
  }
}

// ============================================================================
// LOADING
// ============================================================================

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppDimens.l),
      child: SkeletonLoader(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SkeletonBox(height: 100),
            SizedBox(height: AppDimens.l),
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
