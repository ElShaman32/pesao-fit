import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pesao_button.dart';

/// Pantalla de espera tras enviar la solicitud KYC.
///
/// Informa al dueño que su solicitud está en revisión manual
/// y que será contactado en 24-48h (ADR-036).
class ApplicationPendingScreen extends ConsumerWidget {
  const ApplicationPendingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppStrings.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimens.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Ícono de éxito
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.hourglass_top_rounded,
                    color: AppColors.primary,
                    size: 48,
                  ),
                ),
                const SizedBox(height: AppDimens.xl),

                // Título
                Text(
                  l10n.ownerAppSuccessTitle,
                  textAlign: TextAlign.center,
                  style: AppTypography.title.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppDimens.m),

                // Mensaje
                Text(
                  l10n.ownerAppSuccessMessage,
                  textAlign: TextAlign.center,
                  style: AppTypography.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppDimens.xxxl),

                // Botón volver
                PesaoButton(
                  label: l10n.ownerAppSuccessBack,
                  variant: PesaoButtonVariant.secondary,
                  onPressed: () => context.go(RouteNames.onboarding),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
