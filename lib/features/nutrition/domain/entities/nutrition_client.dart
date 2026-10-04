import 'package:equatable/equatable.dart';

/// Vista simplificada de un cliente del gym para el nutricionista.
/// POCO + Equatable (ADR-037). No mapea una tabla directamente;
/// se construye desde el JOIN de memberships + profiles.
class NutritionClient extends Equatable {
  final String userId;
  final String fullName;
  final String? email;
  final String? avatarUrl;
  final DateTime memberSince;

  const NutritionClient({
    required this.userId,
    required this.fullName,
    this.email,
    this.avatarUrl,
    required this.memberSince,
  });

  /// Inicial del nombre para avatar fallback.
  String get initial => fullName.isNotEmpty ? fullName[0].toUpperCase() : '?';

  factory NutritionClient.fromJson(Map<String, dynamic> json) {
    // El JOIN de Supabase devuelve profiles como objeto anidado.
    final profile = json['profiles'] as Map<String, dynamic>?;

    return NutritionClient(
      userId: json['user_id'] as String,
      fullName: profile?['full_name'] as String? ?? 'Sin nombre',
      email: profile?['email'] as String?,
      avatarUrl: profile?['avatar_url'] as String?,
      memberSince: DateTime.parse(json['created_at'] as String),
    );
  }

  @override
  List<Object?> get props => [userId, fullName, email, avatarUrl, memberSince];
}
