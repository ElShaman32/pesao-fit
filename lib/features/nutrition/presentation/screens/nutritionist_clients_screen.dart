import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/connectivity_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/offline_banner.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_input.dart';
import '../../../../shared/widgets/pesao_shell.dart';
import '../../domain/entities/nutrition_client.dart';
import '../providers/nutritionist_clients_controller.dart';
import '../widgets/nutritionist_client_tile.dart';

/// Lista de clientes del nutricionista.
/// Tab "Clientes" del shell del nutricionista.
///
/// Estados: idle | loading (skeleton) | success | failure | offline.
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
    final clientsAsync = ref.watch(nutritionistClientsControllerProvider);
    final connectivityAsync = ref.watch(connectivityProvider);
    final isOnline = connectivityAsync.value ?? true;

    return PesaoShell(
      appBar: PesaoAppBar(title: l10n.nutritionistClientsTitle),
      body: Column(
        children: [
          if (!isOnline) const OfflineBanner(),

          // Buscador.
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppDimens.l,
              AppDimens.m,
              AppDimens.l,
              0,
            ),
            child: PesaoInput(
              hint: l10n.foodSearchHint,
              prefixIcon: const Icon(Icons.search_rounded),
              controller: _searchController,
              onChanged: (v) => setState(() => _searchQuery = v.toLowerCase()),
            ),
          ),
          const SizedBox(height: AppDimens.m),

          // Lista de clientes.
          Expanded(
            child: clientsAsync.when(
              data: (clients) {
                final filtered = _filterClients(clients);

                if (filtered.isEmpty) {
                  return EmptyState(
                    title: clients.isEmpty
                        ? l10n.nutritionistClientsEmptyTitle
                        : l10n.foodSearchEmptyTitle,
                    body: clients.isEmpty
                        ? l10n.nutritionistClientsEmptyBody
                        : l10n.foodSearchEmptyBody,
                    icon: Icons.people_outline_rounded,
                  );
                }

                return RefreshIndicator(
                  color: AppColors.primary,
                  backgroundColor: AppColors.surface,
                  onRefresh: () => ref
                      .read(nutritionistClientsControllerProvider.notifier)
                      .load(),
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.l,
                      vertical: AppDimens.s,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppDimens.s),
                        child: NutritionistClientTile(client: filtered[index]),
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => ErrorState(
                title: l10n.exercisesErrorTitle,
                body: l10n.exercisesErrorBody,
                onRetry: () => ref
                    .read(nutritionistClientsControllerProvider.notifier)
                    .load(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Filtra clientes por nombre o email (case-insensitive).
  List<NutritionClient> _filterClients(List<NutritionClient> clients) {
    if (_searchQuery.isEmpty) return clients;
    return clients.where((c) {
      final matchesName = c.fullName.toLowerCase().contains(_searchQuery);
      final matchesEmail =
          c.email?.toLowerCase().contains(_searchQuery) ?? false;
      return matchesName || matchesEmail;
    }).toList();
  }
}
