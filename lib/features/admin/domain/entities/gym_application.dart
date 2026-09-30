import 'package:equatable/equatable.dart';

/// Solicitud de registro de gimnasio para revisión del superadmin (ADR-036).
/// Clase POCO + Equatable (patrón ADR-037, sin Freezed).
class GymApplication extends Equatable {
  const GymApplication({
    required this.id,
    required this.userId,
    required this.ownerName,
    required this.ownerPhone,
    this.ownerDocument,
    required this.gymName,
    this.gymRif,
    required this.gymAddress,
    required this.gymState,
    required this.gymCity,
    required this.gymPhone,
    this.gymInstagram,
    this.gymDescription,
    this.gymPhotoUrl,
    required this.status,
    this.rejectionReason,
    required this.submittedAt,
  });

  final String id;
  final String userId;
  final String ownerName;
  final String ownerPhone;
  final String? ownerDocument;
  final String gymName;
  final String? gymRif;
  final String gymAddress;
  final String gymState;
  final String gymCity;
  final String gymPhone;
  final String? gymInstagram;
  final String? gymDescription;
  final String? gymPhotoUrl;
  final String status;
  final String? rejectionReason;
  final DateTime submittedAt;

  factory GymApplication.fromJson(Map<String, dynamic> json) {
    return GymApplication(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      ownerName: json['owner_name'] as String,
      ownerPhone: json['owner_phone'] as String,
      ownerDocument: json['owner_document'] as String?,
      gymName: json['gym_name'] as String,
      gymRif: json['gym_rif'] as String?,
      gymAddress: json['gym_address'] as String,
      gymState: json['gym_state'] as String,
      gymCity: json['gym_city'] as String,
      gymPhone: json['gym_phone'] as String,
      gymInstagram: json['gym_instagram'] as String?,
      gymDescription: json['gym_description'] as String?,
      gymPhotoUrl: json['gym_photo_url'] as String?,
      status: json['status'] as String,
      rejectionReason: json['rejection_reason'] as String?,
      submittedAt: DateTime.parse(json['submitted_at'] as String),
    );
  }

  /// Ciudad y estado para mostrar en la card resumen.
  String get locationLabel => '$gymCity, $gymState';

  @override
  List<Object?> get props => [
    id,
    userId,
    ownerName,
    ownerPhone,
    ownerDocument,
    gymName,
    gymRif,
    gymAddress,
    gymState,
    gymCity,
    gymPhone,
    gymInstagram,
    gymDescription,
    gymPhotoUrl,
    status,
    rejectionReason,
    submittedAt,
  ];
}
