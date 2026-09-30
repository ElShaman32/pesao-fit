import 'package:equatable/equatable.dart';

/// Entidad de gimnasio para el flujo de discovery.
/// Clase POCO + Equatable (patrón ADR-037).
class Gym extends Equatable {
  const Gym({
    required this.id,
    required this.name,
    required this.slug,
    this.logoUrl,
    this.address,
    this.city,
    this.state,
    this.phone,
  });

  final String id;
  final String name;
  final String slug;
  final String? logoUrl;
  final String? address;
  final String? city;
  final String? state;
  final String? phone;

  factory Gym.fromJson(Map<String, dynamic> json) {
    return Gym(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      logoUrl: json['logo_url'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      phone: json['phone'] as String?,
    );
  }

  /// Ciudad y estado formateados para mostrar.
  String get locationLabel {
    if (city == null && state == null) return '';
    if (city != null && state != null) return '$city, $state';
    return city ?? state ?? '';
  }

  @override
  List<Object?> get props => [
    id,
    name,
    slug,
    logoUrl,
    address,
    city,
    state,
    phone,
  ];
}
