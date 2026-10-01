import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/connectivity_provider.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/offline_banner.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_search_bar.dart';
import '../../../../shared/widgets/pesao_shell.dart';
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

    return PesaoShell(
      appBar: PesaoAppBar(title: l10n.clientsScreenTitle),
      body: Column(
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
            child: clientsResult.when(
              idle: () => const Center(child: CircularProgressIndicator()),
              loading: () => const _LoadingState(),
              success: (overview) => _buildSuccess(overview, isOnline),
              failure: (error) {
                final errorMessage = error
                    .toString()
                    .replaceAll('UnknownException(cause: ', '')
                    .replaceAll(')', '');
                return ErrorState(
                  title: l10n.clientsErrorTitle,
                  body: '${l10n.clientsErrorBody}\n\n$errorMessage',
                  onRetry: () =>
                      ref.read(ownerClientsControllerProvider.notifier).load(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccess(ClientOverview overview, bool isOnline) {
    final l10n = AppStrings.of(context);

    // Filtrar por búsqueda.
    final filteredMembers = _searchQuery.isEmpty
        ? overview.members
        : overview.members
              .where((m) => m.fullName.toLowerCase().contains(_searchQuery))
              .toList();

    if (overview.members.isEmpty) {
      return EmptyState(
        title: l10n.clientsEmptyTitle,
        body: l10n.clientsEmptyBody,
        icon: Icons.people_outline_rounded,
      );
    }

    if (filteredMembers.isEmpty) {
      return EmptyState(
        title: l10n.clientsEmptyTitle,
        body: l10n.clientsSearchHint,
        icon: Icons.search_off_rounded,
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(ownerClientsControllerProvider.notifier).load(),
      color: AppColors.primary,
      child: ListView(
        padding: const EdgeInsets.all(AppDimens.l),
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
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppDimens.l),
      child: Column(
        children: [
          _SkeletonBox(height: 100),
          SizedBox(height: AppDimens.l),
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
