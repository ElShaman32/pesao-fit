import 'package:equatable/equatable.dart';

/// Estadísticas del dashboard del entrenador.
/// MVP: placeholders hasta que construyamos F2 (rutinas/workouts).
class TrainerDashboardStats extends Equatable {
  const TrainerDashboardStats({
    required this.assignedClientsCount,
    required this.sessionsTodayCount,
    required this.activeRoutinesCount,
    required this.upcomingSessions,
  });

  final int assignedClientsCount;
  final int sessionsTodayCount;
  final int activeRoutinesCount;
  final List<UpcomingSession> upcomingSessions;

  bool get hasSessionsToday => sessionsTodayCount > 0;

  @override
  List<Object?> get props => [
    assignedClientsCount,
    sessionsTodayCount,
    activeRoutinesCount,
    upcomingSessions,
  ];
}

/// Sesión próxima para la lista secundaria.
class UpcomingSession extends Equatable {
  const UpcomingSession({
    required this.id,
    required this.clientName,
    required this.scheduledAt,
  });

  final String id;
  final String clientName;
  final DateTime scheduledAt;

  @override
  List<Object?> get props => [id, clientName, scheduledAt];
}
