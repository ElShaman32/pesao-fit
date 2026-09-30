import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_card.dart';
import '../../../../shared/widgets/pesao_input.dart';
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
        // El router detecta needsOnboarding=false y redirige al dashboard.
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        title: Text(
          l10n.gymDiscoveryTitle,
          style: AppTypography.title.copyWith(color: AppColors.textPrimary),
        ),
      ),
      body: Column(
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
                  prefixIcon: const Icon(Icons.search),
                  onChanged: controller.search,
                  enabled: !state.isJoining,
                ),
              ],
            ),
          ),
          Expanded(child: _buildBody(context, state, controller)),
        ],
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    GymDiscoveryState state,
    GymDiscoveryController controller,
  ) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (state.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: AppColors.error, size: 48),
              const SizedBox(height: AppDimens.m),
              Text(
                'Algo no salió bien',
                style: AppTypography.title.copyWith(
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimens.s),
              Text(
                'Tranquilo, suele pasar. Inténtalo de nuevo.',
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    if (state.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.search_off_rounded,
                color: AppColors.textDisabled,
                size: 48,
              ),
              const SizedBox(height: AppDimens.m),
              Text(
                AppStrings.of(context).gymDiscoveryEmpty,
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppDimens.l),
      itemCount: state.gyms.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppDimens.m),
      itemBuilder: (context, index) {
        final gym = state.gyms[index];
        return _GymCard(
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
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusCard),
          ),
          title: Text(
            l10n.gymDiscoveryJoinTitle(gym.name),
            style: AppTypography.title.copyWith(color: AppColors.textPrimary),
          ),
          content: Text(
            l10n.gymDiscoveryJoinMessage,
            style: AppTypography.body.copyWith(color: AppColors.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                AppStrings.of(context).commonCancel,
                style: AppTypography.label.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            PesaoButton(
              label: l10n.gymDiscoveryJoinConfirm,
              isExpanded: false,
              loading: ref.read(gymDiscoveryControllerProvider).isJoining,
              onPressed: () {
                Navigator.of(dialogContext).pop();
                controller.joinGym(gym.id);
              },
            ),
          ],
        );
      },
    );
  }
}

/// Card de gimnasio en la lista de descubrimiento.
class _GymCard extends StatelessWidget {
  const _GymCard({
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

    return PesaoCard(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.l),
        child: Row(
          children: [
            // Ícono del gimnasio
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.fitness_center_rounded,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: AppDimens.m),

            // Nombre y ubicación
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    gym.name,
                    style: AppTypography.title.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (gym.locationLabel.isNotEmpty) ...[
                    const SizedBox(height: AppDimens.xs),
                    Text(
                      gym.locationLabel,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Botón unirse
            PesaoButton(
              label: l10n.gymDiscoveryJoin,
              variant: PesaoButtonVariant.secondary,
              isExpanded: false,
              loading: isJoining,
              onPressed: isJoining ? null : onJoin,
            ),
          ],
        ),
      ),
    );
  }
}
