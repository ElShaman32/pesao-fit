import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_input.dart';
import '../../../onboarding/presentation/widgets/legal_summary_sheet.dart';
import '../providers/register_controller.dart';

/// Pantalla de registro de PESAO FIT.
///
/// Implementa los 5 estados (idle, loading, success, failure, offline)
/// y mapea errores de [AuthRepository] a microcopy venezolano.
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _termsAccepted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final state = ref.watch(registerControllerProvider);
    final controller = ref.read(registerControllerProvider.notifier);
    // Navegar tras registro exitoso según el rol elegido en onboarding.
    ref.listen(registerControllerProvider, (previous, next) {
      final wasSubmitting = previous?.isSubmitting ?? false;
      final justSucceeded =
          wasSubmitting && !next.isSubmitting && next.error == null;
      if (justSucceeded) {
        final role = GoRouterState.of(context).uri.queryParameters['role'];
        if (role == 'owner') {
          context.go(RouteNames.ownerApplication);
        } else {
          context.go(RouteNames.gymDiscovery);
        }
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),

              // Título + subtítulo
              Text(
                l10n.registerTitle,
                textAlign: TextAlign.center,
                style: AppTypography.title.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.registerSubtitle,
                textAlign: TextAlign.center,
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),

              // Full name
              PesaoInput(
                controller: _nameController,
                label: l10n.registerFullNameLabel,
                hint: l10n.registerFullNameHint,
                prefixIcon: const Icon(Icons.person_outline),
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                onChanged: controller.setFullName,
                enabled: !state.isSubmitting,
              ),
              const SizedBox(height: AppDimens.m),

              // Email
              PesaoInput(
                controller: _emailController,
                label: l10n.loginEmailLabel,
                hint: l10n.loginEmailHint,
                prefixIcon: const Icon(Icons.email_outlined),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: controller.setEmail,
                enabled: !state.isSubmitting,
              ),
              const SizedBox(height: AppDimens.m),

              // Password
              PesaoInput(
                controller: _passwordController,
                label: l10n.registerPasswordLabel,
                hint: l10n.registerPasswordHint,
                prefixIcon: const Icon(Icons.lock_outline),
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.next,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
                onChanged: controller.setPassword,
                enabled: !state.isSubmitting,
              ),
              const SizedBox(height: AppDimens.m),

              // Confirm password
              PesaoInput(
                controller: _confirmPasswordController,
                label: l10n.registerConfirmPasswordLabel,
                hint: l10n.registerConfirmPasswordHint,
                prefixIcon: const Icon(Icons.lock_outline),
                obscureText: _obscureConfirm,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) {
                  if (state.isValid) controller.submit();
                },
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirm
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () {
                    setState(() => _obscureConfirm = !_obscureConfirm);
                  },
                ),
                onChanged: controller.setConfirmPassword,
                enabled: !state.isSubmitting,
              ),
              const SizedBox(height: 24),

              // Error box
              if (state.error != null) ...[
                _ErrorBox(message: _mapErrorToText(l10n, state.error!)),
                const SizedBox(height: 16),
              ],

              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _termsAccepted,
                    onChanged: (value) {
                      setState(() => _termsAccepted = value ?? false);
                    },
                    activeColor: AppColors.primary,
                    checkColor: AppColors.onPrimary,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: GestureDetector(
                        onTap: () => LegalSummarySheet.showTerms(context),
                        child: Text(
                          l10n.registerTermsCheckbox,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Modificar el botón de submit para que esté disabled si no acepta términos:
              // ✅ CORRECTO (usando las variables existentes)
              PesaoButton(
                label: l10n.registerSubmit,
                onPressed: (state.isSubmitting || !_termsAccepted)
                    ? null
                    : controller.submit,
                loading: state.isSubmitting,
              ),
              const SizedBox(height: 32),

              // Sign in link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.registerHasAccount,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  TextButton(
                    onPressed: state.isSubmitting
                        ? null
                        : () => context.go(RouteNames.login),
                    child: Text(
                      l10n.registerSignIn,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Mapea código de error a microcopy venezolano usando [AppStrings].
  String _mapErrorToText(AppStrings l10n, String code) {
    switch (code) {
      case 'auth/email-ya-registrado':
        return l10n.registerErrorEmailExists;
      case 'auth/password-debil':
        return l10n.registerErrorWeakPassword;
      default:
        return l10n.registerErrorGeneric;
    }
  }
}

/// Caja de error con ícono, usada en RegisterScreen.
class _ErrorBox extends StatelessWidget {
  const _ErrorBox({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error_outline, color: AppColors.error, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: AppTypography.bodySmall.copyWith(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
