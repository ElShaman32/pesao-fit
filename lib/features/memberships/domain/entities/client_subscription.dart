import 'package:equatable/equatable.dart';

/// Suscripción activa de un cliente a un plan del gimnasio.
/// Incluye el balance: positivo = debe, negativo = tiene crédito.
class ClientSubscription extends Equatable {
  final String id;
  final String userId;
  final String gymId;
  final String planId;
  final String planName;
  final double planPriceUsd;
  final int planDurationDays;
  final DateTime startsAt;
  final DateTime expiresAt;
  final double balanceUsd;
  final String status;

  const ClientSubscription({
    required this.id,
    required this.userId,
    required this.gymId,
    required this.planId,
    required this.planName,
    required this.planPriceUsd,
    required this.planDurationDays,
    required this.startsAt,
    required this.expiresAt,
    required this.balanceUsd,
    required this.status,
  });

  bool get isExpired => expiresAt.isBefore(DateTime.now());
  bool get owesMoney => balanceUsd > 0;
  bool get hasCredit => balanceUsd < 0;
  bool get isPaidUp => balanceUsd <= 0;

  factory ClientSubscription.fromJson(Map<String, dynamic> json) {
    final plan = json['gym_membership_plans'] as Map<String, dynamic>?;

    return ClientSubscription(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      gymId: json['gym_id'] as String,
      planId: json['plan_id'] as String,
      planName: plan?['name'] as String? ?? '',
      planPriceUsd: (plan?['price_usd'] as num?)?.toDouble() ?? 0,
      planDurationDays: plan?['duration_days'] as int? ?? 30,
      startsAt: DateTime.parse(json['starts_at'] as String),
      expiresAt: DateTime.parse(json['expires_at'] as String),
      balanceUsd: (json['balance_usd'] as num).toDouble(),
      status: json['status'] as String,
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    gymId,
    planId,
    planName,
    planPriceUsd,
    planDurationDays,
    startsAt,
    expiresAt,
    balanceUsd,
    status,
  ];
}
