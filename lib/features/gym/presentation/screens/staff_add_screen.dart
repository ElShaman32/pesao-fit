import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_card.dart';
import '../../../../shared/widgets/pesao_input.dart';
import '../../../../shared/widgets/pesao_shell.dart';
import '../../../../shared/widgets/pesao_toast.dart';
import '../../domain/entities/create_staff_request.dart';
import '../../domain/entities/staff_invitation_result.dart';
import '../providers/staff_providers.dart';

/// Pantalla para invitar a un nuevo miembro del staff.
///
/// La validación se hace manualmente porque [PesaoInput] no usa
/// el sistema `validator` de Material Form.
class StaffAddScreen extends ConsumerStatefulWidget {
  const StaffAddScreen({super.key});

  @override
  ConsumerState<StaffAddScreen> createState() => _StaffAddScreenState();
}

class _StaffAddScreenState extends ConsumerState<StaffAddScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _selectedRole = 'trainer';
  bool _isSubmitting = false;
  StaffInvitationResult? _invitationResult;

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

    return PesaoShell(
      appBar: PesaoAppBar(title: l10n.staffAddTitle),
      body: _invitationResult != null
          ? _SuccessView(
              result: _invitationResult!,
              onClose: () => Navigator.of(context).pop(),
            )
          : _FormView(
              nameController: _nameController,
              emailController: _emailController,
              passwordController: _passwordController,
              selectedRole: _selectedRole,
              onRoleChanged: (role) => setState(() => _selectedRole = role),
              isSubmitting: _isSubmitting,
              onSubmit: _submit,
              nameError: _nameError,
              emailError: _emailError,
              passwordError: _passwordError,
              onRegeneratePassword: _regeneratePassword,
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

    final nameError = name.isEmpty ? l10n.staffAddNameError : null;
    final emailError = email.isEmpty
        ? l10n.staffAddEmailErrorEmpty
        : (!_isEmailValid(email) ? l10n.staffAddEmailErrorInvalid : null);
    final passwordError = password.length < 6
        ? l10n.staffAddPasswordError
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
          message: l10n.staffAddNoGym,
          semanticLabel: l10n.staffAddNoGymSemantics,
          variant: PesaoToastVariant.error,
        );
      }
      setState(() => _isSubmitting = false);
      return;
    }

    final request = CreateStaffRequest(
      gymId: gymId,
      fullName: name,
      email: email,
      role: _selectedRole,
      tempPassword: password,
    );

    try {
      final result = await ref
          .read(ownerStaffControllerProvider.notifier)
          .inviteStaff(request);

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

/// Vista del formulario de invitación.
class _FormView extends StatelessWidget {
  const _FormView({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.selectedRole,
    required this.onRoleChanged,
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
  final String selectedRole;
  final ValueChanged<String> onRoleChanged;
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
          label: l10n.staffAddNameLabel,
          hint: l10n.staffAddNameHint,
          controller: nameController,
        ),
        if (nameError != null) _InlineError(text: nameError!),
        const SizedBox(height: AppDimens.m),
        PesaoInput(
          label: l10n.staffAddEmailLabel,
          hint: l10n.staffAddEmailHint,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        if (emailError != null) _InlineError(text: emailError!),
        const SizedBox(height: AppDimens.m),
        Text(
          l10n.staffAddRoleLabel,
          style: AppTypography.label.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: AppDimens.s),
        Row(
          children: [
            Expanded(
              child: _RoleOption(
                label: l10n.staffRoleTrainer,
                isSelected: selectedRole == 'trainer',
                onTap: () => onRoleChanged('trainer'),
              ),
            ),
            const SizedBox(width: AppDimens.s),
            Expanded(
              child: _RoleOption(
                label: l10n.staffRoleNutritionist,
                isSelected: selectedRole == 'nutritionist',
                onTap: () => onRoleChanged('nutritionist'),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimens.m),
        PesaoInput(
          label: l10n.staffAddPasswordLabel,
          hint: l10n.staffAddPasswordHint,
          controller: passwordController,
          suffixIcon: IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: l10n.staffAddPasswordRegenerate,
            onPressed: onRegeneratePassword,
          ),
        ),
        if (passwordError != null) _InlineError(text: passwordError!),
        const SizedBox(height: AppDimens.xl),
        PesaoButton(
          label: isSubmitting ? l10n.staffAddSubmitting : l10n.staffAddSubmit,
          onPressed: isSubmitting ? null : onSubmit,
        ),
      ],
    );
  }
}

/// Texto de error suave debajo de un campo.
class _InlineError extends StatelessWidget {
  const _InlineError({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppDimens.xs),
      child: Text(
        text,
        style: AppTypography.bodySmall.copyWith(color: AppColors.errorText),
      ),
    );
  }
}

/// Opción seleccionable para el rol.
class _RoleOption extends StatelessWidget {
  const _RoleOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.m,
          vertical: AppDimens.m,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : AppColors.surface,
          borderRadius: AppDimens.cardBorderRadius,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.outline,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTypography.body.copyWith(
              color: isSelected ? AppColors.primary : AppColors.textPrimary,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

/// Vista de éxito: muestra las credenciales UNA VEZ.
class _SuccessView extends StatelessWidget {
  const _SuccessView({required this.result, required this.onClose});

  final StaffInvitationResult result;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return ListView(
      padding: const EdgeInsets.all(AppDimens.l),
      children: [
        const SizedBox(height: AppDimens.l),
        const Icon(
          Icons.check_circle_outline_rounded,
          color: AppColors.success,
          size: 64,
        ),
        const SizedBox(height: AppDimens.l),
        Text(
          l10n.staffAddSuccessTitle,
          style: AppTypography.headline.copyWith(color: AppColors.textPrimary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimens.s),
        Text(
          l10n.staffAddSuccessBody,
          style: AppTypography.body.copyWith(color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimens.xl),
        PesaoCard(
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.l),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CredentialRow(
                  label: l10n.staffAddCredentialEmail,
                  value: result.email,
                ),
                const SizedBox(height: AppDimens.m),
                _CredentialRow(
                  label: l10n.staffAddCredentialPassword,
                  value: result.tempPassword,
                  showCopyButton: true,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppDimens.xl),
        PesaoButton(label: l10n.staffAddDone, onPressed: onClose),
      ],
    );
  }
}

/// Fila de credencial con botón de copiar opcional.
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

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.label.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: AppTypography.body.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        if (showCopyButton)
          IconButton(
            icon: const Icon(Icons.copy_rounded),
            color: AppColors.primary,
            tooltip: l10n.staffAddCopyTooltip,
            onPressed: () {
              Clipboard.setData(ClipboardData(text: value));
              showPesaoToast(
                context,
                message: l10n.staffAddCopied,
                semanticLabel: l10n.staffAddCopiedSemantics,
                variant: PesaoToastVariant.success,
              );
            },
          ),
      ],
    );
  }
}
