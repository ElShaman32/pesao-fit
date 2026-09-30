import 'package:equatable/equatable.dart';

/// Estadísticas del dashboard del dueño.
/// MVP: placeholders hasta que construyamos F4 (pagos).
class OwnerDashboardStats extends Equatable {
  const OwnerDashboardStats({
    required this.activeClientsCount,
    required this.pendingPaymentsCount,
    required this.monthlyIncomeBs,
    required this.recentClients,
  });

  final int activeClientsCount;
  final int pendingPaymentsCount;
  final double monthlyIncomeBs;
  final List<RecentClient> recentClients;

  bool get hasPendingPayments => pendingPaymentsCount > 0;

  @override
  List<Object?> get props => [
    activeClientsCount,
    pendingPaymentsCount,
    monthlyIncomeBs,
    recentClients,
  ];
}

/// Cliente reciente para la lista secundaria.
class RecentClient extends Equatable {
  const RecentClient({
    required this.id,
    required this.fullName,
    required this.joinedAt,
  });

  final String id;
  final String fullName;
  final DateTime joinedAt;

  @override
  List<Object?> get props => [id, fullName, joinedAt];
}
