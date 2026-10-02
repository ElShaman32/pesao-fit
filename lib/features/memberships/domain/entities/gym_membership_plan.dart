import 'package:equatable/equatable.dart';

/// Plan de membresía que un gimnasio ofrece a sus clientes.
/// POCO + Equatable (ADR-037).
class GymMembershipPlan extends Equatable {
  final String id;
  final String gymId;
  final String name;
  final String? description;
  final double priceUsd;
  final int durationDays;
  final bool includesTrainer;
  final bool includesNutritionist;
  final bool isActive;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;

  const GymMembershipPlan({
    required this.id,
    required this.gymId,
    required this.name,
    this.description,
    required this.priceUsd,
    required this.durationDays,
    this.includesTrainer = false,
    this.includesNutritionist = false,
    this.isActive = true,
    this.sortOrder = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GymMembershipPlan.fromJson(Map<String, dynamic> json) {
    return GymMembershipPlan(
      id: json['id'] as String,
      gymId: json['gym_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      priceUsd: (json['price_usd'] as num).toDouble(),
      durationDays: json['duration_days'] as int,
      includesTrainer: json['includes_trainer'] as bool? ?? false,
      includesNutritionist: json['includes_nutritionist'] as bool? ?? false,
      isActive: json['is_active'] as bool? ?? true,
      sortOrder: json['sort_order'] as int? ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  /// Copia con campos modificados (para edición).
  GymMembershipPlan copyWith({
    String? name,
    String? description,
    double? priceUsd,
    int? durationDays,
    bool? includesTrainer,
    bool? includesNutritionist,
    bool? isActive,
    int? sortOrder,
  }) {
    return GymMembershipPlan(
      id: id,
      gymId: gymId,
      name: name ?? this.name,
      description: description ?? this.description,
      priceUsd: priceUsd ?? this.priceUsd,
      durationDays: durationDays ?? this.durationDays,
      includesTrainer: includesTrainer ?? this.includesTrainer,
      includesNutritionist: includesNutritionist ?? this.includesNutritionist,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    gymId,
    name,
    description,
    priceUsd,
    durationDays,
    includesTrainer,
    includesNutritionist,
    isActive,
    sortOrder,
    createdAt,
    updatedAt,
  ];
}
