import 'package:equatable/equatable.dart';

/// Estadísticas agregadas del dashboard del superadmin.
/// Clase POCO + Equatable (patrón ADR-037, sin Freezed).
class AdminDashboardStats extends Equatable {
  const AdminDashboardStats({
    required this.activeGymsCount,
    required this.pendingApplicationsCount,
    required this.activeSubscriptionsCount,
    required this.recentlyApprovedGyms,
  });

  final int activeGymsCount;
  final int pendingApplicationsCount;
  final int activeSubscriptionsCount;
  final List<RecentGym> recentlyApprovedGyms;

  bool get hasPending => pendingApplicationsCount > 0;
  bool get isEmpty =>
      activeGymsCount == 0 &&
      pendingApplicationsCount == 0 &&
      activeSubscriptionsCount == 0;

  @override
  List<Object?> get props => [
    activeGymsCount,
    pendingApplicationsCount,
    activeSubscriptionsCount,
    recentlyApprovedGyms,
  ];
}

/// Gimnasio recientemente aprobado para la lista secundaria.
class RecentGym extends Equatable {
  const RecentGym({
    required this.id,
    required this.name,
    required this.city,
    required this.state,
    required this.approvedAt,
  });

  final String id;
  final String name;
  final String city;
  final String state;
  final DateTime approvedAt;

  String get locationLabel => '$city, $state';

  factory RecentGym.fromJson(Map<String, dynamic> json) {
    return RecentGym(
      id: json['id'] as String,
      name: json['name'] as String,
      city: (json['city'] as String?) ?? '',
      state: (json['state'] as String?) ?? '',
      approvedAt: DateTime.parse(json['approved_at'] as String),
    );
  }

  @override
  List<Object?> get props => [id, name, city, state, approvedAt];
}
