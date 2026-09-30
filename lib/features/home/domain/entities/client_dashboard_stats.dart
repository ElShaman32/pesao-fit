import 'package:equatable/equatable.dart';

/// Estadísticas del dashboard del cliente.
/// Clase POCO + Equatable (ADR-037).
///
/// MVP: todos los valores son placeholder (0 / null) hasta que
/// construyamos F2 (rutinas/workouts) y F3 (nutrición).
class ClientDashboardStats extends Equatable {
  const ClientDashboardStats({
    required this.kcalToday,
    required this.kcalGoal,
    required this.streakDays,
    required this.nextWorkoutLabel,
    required this.hasWorkoutToday,
  });

  /// Calorías consumidas hoy (F3 Nutrición).
  final int kcalToday;

  /// Meta calórica diaria (F3 Nutrición).
  final int kcalGoal;

  /// Días consecutivos entrenando (F2 Núcleo Fitness).
  final int streakDays;

  /// Nombre del próximo entreno, o null si no hay.
  final String? nextWorkoutLabel;

  /// Si hay una rutina asignada para hoy.
  final bool hasWorkoutToday;

  bool get hasStreak => streakDays > 0;

  @override
  List<Object?> get props => [
    kcalToday,
    kcalGoal,
    streakDays,
    nextWorkoutLabel,
    hasWorkoutToday,
  ];
}
