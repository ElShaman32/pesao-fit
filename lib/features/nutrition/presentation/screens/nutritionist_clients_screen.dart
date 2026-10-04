import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/connectivity_provider.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/offline_banner.dart';
import '../../../../shared/widgets/pesao_avatar.dart';
import '../../../../shared/widgets/pesao_list_tile.dart';
import '../../../../shared/widgets/pesao_search_bar.dart';
import '../../../../shared/widgets/skeleton_loader.dart';
import '../providers/nutritionist_clients_controller.dart';

/// Lista de clientes asignados al nutricionista.
///
/// design-system.md §11: 5 estados obligatorios.
/// Catálogo de widgets: PesaoSearchBar + PesaoListTile + EmptyState.
class NutritionistClientsScreen extends ConsumerStatefulWidget {
  const NutritionistClientsScreen({super.key});

  @override
  ConsumerState<NutritionistClientsScreen> createState() =>
      _NutritionistClientsScreenState();
}

class _NutritionistClientsScreenState
    extends ConsumerState<NutritionistClientsScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final state = ref.watch(nutritionistClientsControllerProvider);
    final controller = ref.read(nutritionistClientsControllerProvider.notifier);
    final connectivityAsync = ref.watch(connectivityProvider);
    final isOnline = connectivityAsync.value ?? true;

    // Filtrar clientes por búsqueda local.
    final filteredClients = _searchQuery.isEmpty
        ? state.clients
        : state.clients.where((c) {
            final name = c.fullName.toLowerCase();
            final email = c.email.toLowerCase();
            final query = _searchQuery.toLowerCase();
            return name.contains(query) || email.contains(query);
          }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: AppColors.surface,
          onRefresh: controller.load,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // Título de pantalla.
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppDimens.l,
                    AppDimens.l,
                    AppDimens.l,
                    0,
                  ),
                  child: Text(
                    l10n.nutritionistClientsTitle,
                    style: AppTypography.headline.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),

              // Buscador.
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimens.l),
                  child: PesaoSearchBar(
                    controller: _searchController,
                    hintText: l10n.clientsSearchHint,
                    onChanged: (value) {
                      setState(() => _searchQuery = value);
                    },
                  ),
                ),
              ),

              // OfflineBanner.
              if (!isOnline)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppDimens.l),
                    child: OfflineBanner(),
                  ),
                ),

              // Contenido según estado.
              if (state.isLoading && state.clients.isEmpty)
                const _ClientsSkeletonSliver()
              else if (state.error != null && state.clients.isEmpty)
                SliverFillRemaining(
                  child: ErrorState(
                    title: l10n.errorGenericTitle,
                    body: l10n.errorGenericBody,
                    actionLabel: l10n.commonRetry,
                    onRetry: controller.load,
                  ),
                )
              else if (filteredClients.isEmpty && _searchQuery.isNotEmpty)
                // Búsqueda sin resultados.
                SliverFillRemaining(
                  child: EmptyState(
                    icon: AppIcons.search,
                    title: l10n.foodSearchEmptyTitle,
                    body: l10n.foodSearchEmptyBody,
                  ),
                )
              else if (filteredClients.isEmpty)
                // Sin clientes asignados.
                SliverFillRemaining(
                  child: EmptyState(
                    icon: AppIcons.clients,
                    title: l10n.nutritionistClientsEmptyTitle,
                    body: l10n.nutritionistClientsEmptyBody,
                  ),
                )
              else
                // Lista de clientes.
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimens.l),
                  sliver: SliverList.builder(
                    itemCount: filteredClients.length,
                    itemBuilder: (context, index) {
                      final client = filteredClients[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppDimens.s),
                        child: PesaoListTile(
                          title: client.fullName,
                          subtitle: client.activePlansCount > 0
                              ? l10n.nutritionistPlansCount(
                                  client.activePlansCount,
                                )
                              : l10n.nutritionNoPlanYet,
                          leading: PesaoAvatar(
                            name: client.fullName,
                            imageUrl: client.avatarUrl,
                            size: 40,
                          ),
                          trailing: const Icon(
                            AppIcons.chevronRight,
                            color: AppColors.textSecondary,
                            size: 20,
                          ),
                          onTap: () {
                            context.push(
                              RouteNames.nutritionistClientDetail.replaceAll(
                                ':clientId',
                                client.userId,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),

              // Espacio inferior para el FAB.
              const SliverToBoxAdapter(child: SizedBox(height: AppDimens.xxxl)),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// SKELETON
// ============================================================================

class _ClientsSkeletonSliver extends StatelessWidget {
  const _ClientsSkeletonSliver();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: SkeletonLoader(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimens.l),
          child: Column(
            children: [
              SkeletonListTile(hasSubtitle: true),
              SizedBox(height: AppDimens.s),
              SkeletonListTile(hasSubtitle: true),
              SizedBox(height: AppDimens.s),
              SkeletonListTile(hasSubtitle: true),
              SizedBox(height: AppDimens.s),
              SkeletonListTile(hasSubtitle: true),
              SizedBox(height: AppDimens.s),
              SkeletonListTile(hasSubtitle: true),
            ],
          ),
        ),
      ),
    );
  }
}
