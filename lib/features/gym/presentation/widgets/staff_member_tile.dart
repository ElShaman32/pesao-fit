import 'package:flutter/material.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/pesao_avatar.dart';
import '../../../../shared/widgets/pesao_badge.dart';
import '../../../../shared/widgets/pesao_list_tile.dart';
import '../../domain/entities/staff_member.dart';

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
    final strings = AppStrings.of(context);
    final roleLabel = member.role == 'trainer'
        ? strings.staffRoleTrainer
        : strings.staffRoleNutritionist;
    final email = member.email ?? '';
    final subtitle = email.isNotEmpty ? '$roleLabel • $email' : roleLabel;

    return PesaoListTile(
      leading: PesaoAvatar(
        imageUrl: member.avatarUrl,
        name: member.fullName,
        size: 48,
      ),
      title: member.fullName,
      subtitle: subtitle,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PesaoBadge(
            label: member.isActive
                ? strings.staffStatusActive
                : strings.staffStatusInactive,
            variant: member.isActive
                ? PesaoBadgeVariant.success
                : PesaoBadgeVariant.warning,
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
                  ? strings.staffActionDeactivate
                  : strings.staffActionActivate,
            ),
        ],
      ),
      onTap: onTap,
    );
  }
}
