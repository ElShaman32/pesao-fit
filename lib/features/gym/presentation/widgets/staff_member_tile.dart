import 'package:flutter/material.dart';
import 'package:pesao_fit/core/l10n/app_strings.dart';
import 'package:pesao_fit/core/theme/app_colors.dart';
import 'package:pesao_fit/shared/widgets/pesao_avatar.dart';
import 'package:pesao_fit/shared/widgets/pesao_badge.dart';
import 'package:pesao_fit/shared/widgets/pesao_list_tile.dart';

import '../../domain/entities/staff_member.dart';

/// Tile para mostrar un miembro del staff en la lista.
class StaffMemberTile extends StatelessWidget {
  final StaffMember member;
  final VoidCallback? onTap;
  final VoidCallback? onToggleActive;

  const StaffMemberTile({
    super.key,
    required this.member,
    this.onTap,
    this.onToggleActive,
  });

  @override
  Widget build(BuildContext context) {
    return PesaoListTile(
      leading: PesaoAvatar(imageUrl: member.avatarUrl, radius: 24),
      title: member.fullName,
      subtitle: _buildSubtitle(),
      trailing: _buildTrailing(context),
      onTap: onTap,
    );
  }

  /// Construye el subtítulo con el rol y el correo.
  String _buildSubtitle() {
    final roleLabel = member.role == 'trainer'
        ? AppStrings.staffRoleTrainer
        : AppStrings.staffRoleNutritionist;

    final email = member.email ?? '';
    return email.isNotEmpty ? '$roleLabel • $email' : roleLabel;
  }

  /// Construye el trailing con el badge de estado y el botón de toggle.
  Widget _buildTrailing(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PesaoBadge(
          label: member.isActive
              ? AppStrings.staffStatusActive
              : AppStrings.staffStatusInactive,
          color: member.isActive ? AppColors.success : AppColors.warning,
        ),
        const SizedBox(width: 8),
        if (onToggleActive != null)
          IconButton(
            icon: Icon(
              member.isActive ? Icons.visibility_off : Icons.visibility,
              color: AppColors.textSecondary,
            ),
            onPressed: onToggleActive,
            tooltip: member.isActive
                ? AppStrings.staffActionDeactivate
                : AppStrings.staffActionActivate,
          ),
      ],
    );
  }
}
