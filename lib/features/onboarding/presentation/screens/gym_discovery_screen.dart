import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/confirm_dialog.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/error_state.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_input.dart';
import '../../../../shared/widgets/pesao_list_tile.dart';
import '../../../../shared/widgets/skeleton_loader.dart';
import '../../domain/entities/gym.dart';
import '../providers/gym_discovery_controller.dart';

/// Pantalla de descubrimiento de gimnasios para clientes (ADR-013).
///
/// El cliente busca su gimnasio y solicita unirse. Al confirmar,
/// se crea la membresía y es redirigido a su dashboard.
class GymDiscoveryScreen extends ConsumerStatefulWidget {
  const GymDiscoveryScreen({super.key});

  @override
  ConsumerState<GymDiscoveryScreen> createState() => _GymDiscoveryScreenState();
}

class _GymDiscoveryScreenState extends ConsumerState<GymDiscoveryScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final state = ref.watch(gymDiscoveryControllerProvider);
    final controller = ref.read(gymDiscoveryControllerProvider.notifier);

    // Al unirse con éxito, refrescar auth para que el router redirija.
    ref.listen(gymDiscoveryControllerProvider, (previous, next) {
      final justJoined = next.hasJoined && !(previous?.hasJoined ?? false);
      if (justJoined) {
        authProvider.refresh();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PesaoAppBar(title: l10n.gymDiscoveryTitle),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimens.l,
                0,
                AppDimens.l,
                AppDimens.m,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.gymDiscoverySubtitle,
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppDimens.m),
                  PesaoInput(
                    controller: _searchController,
                    hint: l10n.gymDiscoverySearchHint,
                    prefixIcon: const Icon(AppIcons.search),
                    onChanged: controller.search,
                    enabled: !state.isJoining,
                  ),
                ],
              ),
            ),
            Expanded(child: _buildBody(context, state, controller)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    GymDiscoveryState state,
    GymDiscoveryController controller,
  ) {
    if (state.isLoading) {
      return const _GymDiscoverySkeleton();
    }

    if (state.error != null) {
      return ErrorState(
        title: 'Algo no salió bien', // TODO: mover a AppStrings.
        body:
            'Tranquilo, suele pasar. Inténtalo de nuevo.', // TODO: mover a AppStrings.
        onRetry: () => controller.search(_searchController.text),
      );
    }

    if (state.isEmpty) {
      return EmptyState(
        icon: Icons.search_off_rounded, // TODO: promover a AppIcons.
        body: AppStrings.of(context).gymDiscoveryEmpty,
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppDimens.l),
      itemCount: state.gyms.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppDimens.m),
      itemBuilder: (context, index) {
        final gym = state.gyms[index];
        return _GymTile(
          gym: gym,
          isJoining: state.isJoining,
          onJoin: () => _showJoinDialog(gym, controller),
        );
      },
    );
  }

  Future<void> _showJoinDialog(
    Gym gym,
    GymDiscoveryController controller,
  ) async {
    final l10n = AppStrings.of(context);

    final confirmed = await showConfirmDialog(
      context: context,
      title: l10n.gymDiscoveryJoinTitle(gym.name),
      message: l10n.gymDiscoveryJoinMessage,
      confirmLabel: l10n.gymDiscoveryJoinConfirm,
      cancelLabel: l10n.commonCancel,
    );

    if (confirmed && mounted) {
      await controller.joinGym(gym.id);
    }
  }
}

// ============================================================================
// GYM TILE
// ============================================================================

/// Tile de gimnasio en la lista de descubrimiento.
class _GymTile extends StatelessWidget {
  const _GymTile({
    required this.gym,
    required this.isJoining,
    required this.onJoin,
  });

  final Gym gym;
  final bool isJoining;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return PesaoListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        child: const Icon(AppIcons.routine, color: AppColors.primary, size: 24),
      ),
      title: gym.name,
      subtitle: gym.locationLabel.isNotEmpty ? gym.locationLabel : null,
      trailing: PesaoButton(
        label: l10n.gymDiscoveryJoin,
        variant: PesaoButtonVariant.secondary,
        isExpanded: false,
        loading: isJoining,
        onPressed: isJoining ? null : onJoin,
      ),
    );
  }
}

// ============================================================================
// SKELETON
// ============================================================================

class _GymDiscoverySkeleton extends StatelessWidget {
  const _GymDiscoverySkeleton();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppDimens.l),
      child: SkeletonLoader(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SkeletonBox(height: 72),
            SizedBox(height: AppDimens.m),
            SkeletonBox(height: 72),
            SizedBox(height: AppDimens.m),
            SkeletonBox(height: 72),
          ],
        ),
      ),
    );
  }
}
