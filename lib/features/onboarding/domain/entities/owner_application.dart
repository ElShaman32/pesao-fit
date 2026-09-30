import 'package:equatable/equatable.dart';

/// Entidad de solicitud de registro de dueño (ADR-036).
class OwnerApplication extends Equatable {
  const OwnerApplication({
    this.id,
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
    this.latitude,
    this.longitude,
  });

  final String? id;
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
  final double? latitude;
  final double? longitude;

  @override
  List<Object?> get props => [
    id,
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
    latitude,
    longitude,
  ];
}
