import 'package:equatable/equatable.dart';

/// Alimento favorito de un cliente (tabla `food_favorites`).
class FoodFavorite extends Equatable {
  const FoodFavorite({
    required this.id,
    required this.clientId,
    required this.foodId,
    required this.createdAt,
  });

  final String id;
  final String clientId;
  final String foodId;
  final DateTime createdAt;

  factory FoodFavorite.fromJson(Map<String, dynamic> json) {
    return FoodFavorite(
      id: json['id'] as String,
      clientId: json['client_id'] as String,
      foodId: json['food_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_id': clientId,
      'food_id': foodId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, clientId, foodId];
}
