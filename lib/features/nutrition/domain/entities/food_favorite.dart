import 'package:equatable/equatable.dart';

/// Favorito de un cliente (acceso rápido en FoodSearchSheet).
/// POCO + Equatable (ADR-037). Mapea la tabla `food_favorites`.
///
/// UNIQUE(client_id, food_id) en BD.
class FoodFavorite extends Equatable {
  final String id;
  final String clientId;
  final String foodId;
  final DateTime createdAt;

  /// Nombre del alimento (denormalizado para display sin JOIN).
  final String? foodName;

  const FoodFavorite({
    required this.id,
    required this.clientId,
    required this.foodId,
    required this.createdAt,
    this.foodName,
  });

  factory FoodFavorite.fromJson(Map<String, dynamic> json) {
    return FoodFavorite(
      id: json['id'] as String,
      clientId: json['client_id'] as String,
      foodId: json['food_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      foodName: json['food_name'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, clientId, foodId, createdAt, foodName];
}
