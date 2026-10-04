import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_icon_button.dart';
import '../../../../shared/widgets/pesao_input.dart';
import '../../../../shared/widgets/pesao_list_tile.dart';
import '../../../../shared/widgets/pesao_toast.dart';
import '../../domain/entities/create_client_request.dart';
import '../../domain/entities/client_invitation_result.dart';
import '../providers/clients_providers.dart';

/// Pantalla para agregar cliente manualmente.
class ClientAddScreen extends ConsumerStatefulWidget {
  const ClientAddScreen({super.key});

  @override
  ConsumerState<ClientAddScreen> createState() => _ClientAddScreenState();
}

class _ClientAddScreenState extends ConsumerState<ClientAddScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isSubmitting = false;
  ClientInvitationResult? _invitationResult;

  String? _nameError;
  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    _passwordController.text = const Uuid().v4().substring(0, 10);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PesaoAppBar(title: l10n.clientAddTitle),
      body: SafeArea(
        child: _invitationResult != null
            ? _SuccessView(
                result: _invitationResult!,
                onClose: () => Navigator.of(context).pop(),
              )
            : _FormView(
                nameController: _nameController,
                emailController: _emailController,
                passwordController: _passwordController,
                isSubmitting: _isSubmitting,
                onSubmit: _submit,
                nameError: _nameError,
                emailError: _emailError,
                passwordError: _passwordError,
                onRegeneratePassword: _regeneratePassword,
              ),
      ),
    );
  }

  void _regeneratePassword() {
    setState(() {
      _passwordController.text = const Uuid().v4().substring(0, 10);
      _passwordError = null;
    });
  }

  bool _isEmailValid(String email) {
    return email.contains('@') && email.contains('.') && email.length > 5;
  }

  Future<void> _submit() async {
    final l10n = AppStrings.of(context);

    final name = _nameController.text.trim();
    final email = _emailController.text.trim().toLowerCase();
    final password = _passwordController.text;

    final nameError = name.isEmpty ? l10n.clientAddNameError : null;
    final emailError = email.isEmpty
        ? l10n.clientAddEmailErrorEmpty
        : (!_isEmailValid(email) ? l10n.clientAddEmailErrorInvalid : null);
    final passwordError = password.length < 6
        ? l10n.clientAddPasswordError
        : null;

    setState(() {
      _nameError = nameError;
      _emailError = emailError;
      _passwordError = passwordError;
    });

    if (nameError != null || emailError != null || passwordError != null) {
      return;
    }

    setState(() => _isSubmitting = true);

    final gymId = authProvider.userGymId;
    if (gymId == null) {
      if (mounted) {
        showPesaoToast(
          context,
          message: l10n.clientAddNoGym,
          semanticLabel: l10n.clientAddNoGymSemantics,
          variant: PesaoToastVariant.error,
        );
      }
      setState(() => _isSubmitting = false);
      return;
    }

    final request = CreateClientRequest(
      gymId: gymId,
      fullName: name,
      email: email,
      tempPassword: password,
    );

    try {
      final result = await ref
          .read(ownerClientsControllerProvider.notifier)
          .addClient(request);

      if (result != null && mounted) {
        setState(() => _invitationResult = result);
      }
    } catch (_) {
      if (mounted) {
        showPesaoToast(
          context,
          message: l10n.staffActionError,
          semanticLabel: l10n.staffActionError,
          variant: PesaoToastVariant.error,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}

// ============================================================================
// FORM VIEW
// ============================================================================

class _FormView extends StatelessWidget {
  const _FormView({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.isSubmitting,
    required this.onSubmit,
    required this.nameError,
    required this.emailError,
    required this.passwordError,
    required this.onRegeneratePassword,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isSubmitting;
  final VoidCallback onSubmit;
  final String? nameError;
  final String? emailError;
  final String? passwordError;
  final VoidCallback onRegeneratePassword;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return ListView(
      padding: const EdgeInsets.all(AppDimens.l),
      children: [
        PesaoInput(
          label: l10n.clientAddNameLabel,
          hint: l10n.clientAddNameHint,
          prefixIcon: const Icon(Icons.person),
          controller: nameController,
          errorText: nameError,
        ),
        const SizedBox(height: AppDimens.m),
        PesaoInput(
          label: l10n.clientAddEmailLabel,
          hint: l10n.clientAddEmailHint,
          prefixIcon: const Icon(Icons.email),
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          errorText: emailError,
        ),
        const SizedBox(height: AppDimens.m),
        PesaoInput(
          label: l10n.clientAddPasswordLabel,
          hint: l10n.clientAddPasswordHint,
          prefixIcon: const Icon(Icons.lock),
          controller: passwordController,
          errorText: passwordError,
          suffixIcon: PesaoIconButton(
            icon: Icons.refresh_rounded, // TODO: promover a AppIcons.
            semanticLabel: l10n.clientAddPasswordRegenerate,
            onPressed: onRegeneratePassword,
          ),
        ),
        const SizedBox(height: AppDimens.xl),
        PesaoButton(
          label: l10n.clientAddSubmit,
          loading: isSubmitting,
          onPressed: onSubmit,
        ),
      ],
    );
  }
}

// ============================================================================
// SUCCESS VIEW
// ============================================================================

class _SuccessView extends StatelessWidget {
  const _SuccessView({required this.result, required this.onClose});

  final ClientInvitationResult result;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return ListView(
      padding: const EdgeInsets.all(AppDimens.l),
      children: [
        const SizedBox(height: AppDimens.l),
        const Icon(AppIcons.success, color: AppColors.success, size: 64),
        const SizedBox(height: AppDimens.l),
        Text(
          l10n.clientAddSuccessTitle,
          style: AppTypography.headline.copyWith(color: AppColors.textPrimary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimens.s),
        Text(
          l10n.clientAddSuccessBody,
          style: AppTypography.body.copyWith(color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimens.xl),
        _CredentialRow(
          label: l10n.clientAddCredentialEmail,
          value: result.email,
        ),
        const SizedBox(height: AppDimens.s),
        _CredentialRow(
          label: l10n.clientAddCredentialPassword,
          value: result.tempPassword,
          showCopyButton: true,
        ),
        const SizedBox(height: AppDimens.xl),
        PesaoButton(label: l10n.clientAddDone, onPressed: onClose),
      ],
    );
  }
}

// ============================================================================
// CREDENTIAL ROW
// ============================================================================

class _CredentialRow extends StatelessWidget {
  const _CredentialRow({
    required this.label,
    required this.value,
    this.showCopyButton = false,
  });

  final String label;
  final String value;
  final bool showCopyButton;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return PesaoListTile(
      title: value,
      subtitle: label,
      trailing: showCopyButton
          ? PesaoIconButton(
              icon: Icons.copy_rounded, // TODO: promover a AppIcons.
              iconColor: AppColors.primary,
              semanticLabel: l10n.clientAddCopyTooltip,
              onPressed: () {
                Clipboard.setData(ClipboardData(text: value));
                showPesaoToast(
                  context,
                  message: l10n.clientAddCopied,
                  semanticLabel: l10n.clientAddCopiedSemantics,
                  variant: PesaoToastVariant.success,
                );
              },
            )
          : null,
    );
  }
}
