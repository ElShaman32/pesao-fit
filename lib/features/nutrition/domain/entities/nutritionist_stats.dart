import 'package:equatable/equatable.dart';

/// Estadísticas del dashboard del nutricionista.
/// POCO + Equatable (ADR-037). Se construye desde queries de conteo.
class NutritionistStats extends Equatable {
  final int totalClients;
  final int activePlans;
  final int totalFoods;
  final int clientsWithoutPlan;

  const NutritionistStats({
    required this.totalClients,
    required this.activePlans,
    required this.totalFoods,
    required this.clientsWithoutPlan,
  });

  /// true si hay clientes sin plan (para mostrar CTA en PrimaryCard).
  bool get hasClientsWithoutPlan => clientsWithoutPlan > 0;

  @override
  List<Object?> get props => [
    totalClients,
    activePlans,
    totalFoods,
    clientsWithoutPlan,
  ];
}
