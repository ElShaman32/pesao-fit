import 'package:equatable/equatable.dart';

/// Estado de un pago manual.
enum PaymentStatus { pending, verified, rejected }

/// Tipo de pago.
/// client_membership: cliente paga al gimnasio.
/// gym_subscription: dueño paga a PESAO FIT (futuro).
enum PaymentKind { clientMembership, gymSubscription }

PaymentStatus paymentStatusFromString(String? value) {
  switch (value) {
    case 'verified':
      return PaymentStatus.verified;
    case 'rejected':
      return PaymentStatus.rejected;
    default:
      return PaymentStatus.pending;
  }
}

PaymentKind paymentKindFromString(String? value) {
  if (value == 'gym_subscription') {
    return PaymentKind.gymSubscription;
  }
  return PaymentKind.clientMembership;
}

/// Pago manual de un cliente del gimnasio.
/// POCO + Equatable (ADR-037).
class Payment extends Equatable {
  final String id;
  final String gymId;
  final String userId;
  final double amountBs;
  final double amountUsd;
  final double rateUsed;
  final String receiptUrl;
  final PaymentStatus status;
  final PaymentKind paymentKind;
  final String? verifiedBy;
  final String? rejectedReason;
  final String? payerName;
  final String? payerAvatarUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Payment({
    required this.id,
    required this.gymId,
    required this.userId,
    required this.amountBs,
    required this.amountUsd,
    required this.rateUsed,
    required this.receiptUrl,
    required this.status,
    required this.paymentKind,
    this.verifiedBy,
    this.rejectedReason,
    this.payerName,
    this.payerAvatarUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    final profile = json['profiles'] as Map<String, dynamic>?;
    final createdAt = DateTime.parse(json['created_at'] as String);
    final updatedAtRaw = json['updated_at'] as String?;

    return Payment(
      id: json['id'] as String,
      gymId: json['gym_id'] as String,
      userId: json['user_id'] as String,
      amountBs: (json['amount_bs'] as num).toDouble(),
      amountUsd: (json['amount_usd'] as num).toDouble(),
      rateUsed: (json['rate_used'] as num).toDouble(),
      receiptUrl: json['receipt_url'] as String,
      status: paymentStatusFromString(json['status'] as String?),
      paymentKind: paymentKindFromString(json['payment_kind'] as String?),
      verifiedBy: json['verified_by'] as String?,
      rejectedReason: json['rejected_reason'] as String?,
      payerName: profile?['full_name'] as String?,
      payerAvatarUrl: profile?['avatar_url'] as String?,
      createdAt: createdAt,
      updatedAt: updatedAtRaw == null
          ? createdAt
          : DateTime.parse(updatedAtRaw),
    );
  }

  @override
  List<Object?> get props => [
    id,
    gymId,
    userId,
    amountBs,
    amountUsd,
    rateUsed,
    receiptUrl,
    status,
    paymentKind,
    verifiedBy,
    rejectedReason,
    payerName,
    payerAvatarUrl,
    createdAt,
    updatedAt,
  ];
}
