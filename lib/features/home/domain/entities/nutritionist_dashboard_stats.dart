import 'package:equatable/equatable.dart';

/// Estadísticas del dashboard del nutricionista.
/// MVP: placeholders hasta que construyamos F3 (nutrición).
class NutritionistDashboardStats extends Equatable {
  const NutritionistDashboardStats({
    required this.activePlansCount,
    required this.clientsWithPlanCount,
    required this.consultsTodayCount,
    required this.recentPlans,
  });

  final int activePlansCount;
  final int clientsWithPlanCount;
  final int consultsTodayCount;
  final List<RecentPlan> recentPlans;

  bool get hasPlansToReview => activePlansCount > 0;

  @override
  List<Object?> get props => [
    activePlansCount,
    clientsWithPlanCount,
    consultsTodayCount,
    recentPlans,
  ];
}

/// Plan reciente para la lista secundaria.
class RecentPlan extends Equatable {
  const RecentPlan({
    required this.id,
    required this.clientName,
    required this.createdAt,
  });

  final String id;
  final String clientName;
  final DateTime createdAt;

  @override
  List<Object?> get props => [id, clientName, createdAt];
}
