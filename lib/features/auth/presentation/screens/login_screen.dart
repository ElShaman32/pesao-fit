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
import '../providers/login_controller.dart';

/// Pantalla de login de PESAO FIT.
///
/// Implementa los 5 estados (idle, loading, success, failure, offline)
/// y mapea errores de [AuthRepository] a microcopy venezolano usando
/// exclusivamente componentes del kit Pesao* (convenciones.md §3).
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final state = ref.watch(loginControllerProvider);
    final controller = ref.read(loginControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48),

              // Logo + títulos
              Text(
                'PESAO',
                textAlign: TextAlign.center,
                style: AppTypography.display.copyWith(
                  color: AppColors.primary,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.loginTitle,
                textAlign: TextAlign.center,
                style: AppTypography.title.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.loginSubtitle,
                textAlign: TextAlign.center,
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 48),

              // Email
              PesaoInput(
                controller: _emailController,
                label: l10n.loginEmailLabel,
                hint: l10n.loginEmailHint,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(Icons.email_outlined),
                onChanged: controller.setEmail,
                enabled: !state.isSubmitting,
              ),
              const SizedBox(height: AppDimens.m),

              // Password
              PesaoInput(
                controller: _passwordController,
                label: l10n.loginPasswordLabel,
                hint: l10n.loginPasswordHint,
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) {
                  if (state.isValid) controller.submit();
                },
                prefixIcon: const Icon(Icons.lock_outline),
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
              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: state.isSubmitting
                      ? null
                      : () => context.go(RouteNames.forgotPassword),
                  child: Text(
                    l10n.loginForgot,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Error box (visible cuando state.error != null)
              if (state.error != null) ...[
                _ErrorBox(message: _mapErrorToText(l10n, state.error!)),
                const SizedBox(height: 16),
              ],

              // Submit button
              PesaoButton(
                label: l10n.loginSubmit,
                onPressed: state.isValid ? controller.submit : null,
                loading: state.isSubmitting,
              ),
              const SizedBox(height: 32),

              // Sign up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.loginNoAccount,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  TextButton(
                    onPressed: state.isSubmitting
                        ? null
                        : () => context.go(RouteNames.register),
                    child: Text(
                      l10n.loginSignUp,
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
      case 'auth/credenciales-invalidas':
        return l10n.loginErrorInvalid;
      case 'auth/email-sin-confirmar':
        return l10n.loginErrorEmailUnconfirmed;
      default:
        return l10n.loginErrorGeneric;
    }
  }
}

/// Caja de error con ícono, usada en LoginScreen.
/// Widget privado: vive solo en este archivo.
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
