import 'package:equatable/equatable.dart';

import 'client_member.dart';

/// Resumen de clientes del gimnasio.
class ClientOverview extends Equatable {
  final List<ClientMember> members;
  final int clientCount;
  final int? clientLimit; // null = ilimitado
  final bool isStale;

  const ClientOverview({
    required this.members,
    required this.clientCount,
    this.clientLimit,
    this.isStale = false,
  });

  bool get isUnlimited => clientLimit == null;

  bool get hasAvailableSlot => isUnlimited || clientCount < (clientLimit ?? 0);

  ClientOverview copyWith({
    List<ClientMember>? members,
    int? clientCount,
    int? clientLimit,
    bool? isStale,
  }) {
    return ClientOverview(
      members: members ?? this.members,
      clientCount: clientCount ?? this.clientCount,
      clientLimit: clientLimit ?? this.clientLimit,
      isStale: isStale ?? this.isStale,
    );
  }

  @override
  List<Object?> get props => [members, clientCount, clientLimit, isStale];
}
