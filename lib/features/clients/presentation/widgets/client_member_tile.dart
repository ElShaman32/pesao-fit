import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../shared/widgets/pesao_avatar.dart';
import '../../../../shared/widgets/pesao_badge.dart';
import '../../../../shared/widgets/pesao_list_tile.dart';
import '../../domain/entities/client_member.dart';

/// Tile para mostrar un cliente en la lista.
class ClientMemberTile extends StatelessWidget {
  final ClientMember member;
  final VoidCallback? onTap;

  const ClientMemberTile({super.key, required this.member, this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final joinedLabel = DateFormat.yMMMMd('es_VE').format(member.joinedAt);

    return PesaoListTile(
      leading: PesaoAvatar(
        imageUrl: member.avatarUrl,
        name: member.fullName,
        size: 48,
      ),
      title: member.fullName,
      subtitle: joinedLabel,
      trailing: PesaoBadge(
        label: member.isActive
            ? l10n.clientDetailStatusActive
            : l10n.clientDetailStatusInactive,
        variant: member.isActive
            ? PesaoBadgeVariant.success
            : PesaoBadgeVariant.warning,
      ),
      onTap: onTap,
    );
  }
}
