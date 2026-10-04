import 'package:equatable/equatable.dart';

/// Alimento del catálogo (tabla `foods`).
/// Puede ser global (is_system=true, gym_id=null) o del gimnasio.
class Food extends Equatable {
  const Food({
    required this.id,
    required this.name,
    required this.servingSize,
    required this.servingUnit,
    required this.caloriesKcal,
    required this.proteinG,
    required this.carbsG,
    required this.fatsG,
    required this.isVerified,
    required this.isSystem,
    required this.source,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.gymId,
    this.brand,
    this.barcode,
    this.fiberG,
    this.sugarG,
    this.sodiumMg,
    this.createdBy,
    this.externalId,
    this.imageUrl,
  });

  final String id;
  final String? gymId;
  final String name;
  final String? brand;
  final String? barcode;
  final double servingSize;
  final String servingUnit;
  final double caloriesKcal;
  final double proteinG;
  final double carbsG;
  final double fatsG;
  final double? fiberG;
  final double? sugarG;
  final double? sodiumMg;
  final bool isVerified;
  final bool isSystem;
  final String? createdBy;
  final String source;
  final String? externalId;
  final String? imageUrl;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Si es alimento del sistema (catálogo global).
  bool get isGlobal => isSystem;

  /// Si es alimento del gimnasio.
  bool get isGymFood => gymId != null && !isSystem;

  Food copyWith({
    String? id,
    String? gymId,
    String? name,
    String? brand,
    String? barcode,
    double? servingSize,
    String? servingUnit,
    double? caloriesKcal,
    double? proteinG,
    double? carbsG,
    double? fatsG,
    double? fiberG,
    double? sugarG,
    double? sodiumMg,
    bool? isVerified,
    bool? isSystem,
    String? createdBy,
    String? source,
    String? externalId,
    String? imageUrl,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool clearGymId = false,
    bool clearBrand = false,
    bool clearBarcode = false,
    bool clearFiberG = false,
    bool clearSugarG = false,
    bool clearSodiumMg = false,
    bool clearCreatedBy = false,
    bool clearExternalId = false,
    bool clearImageUrl = false,
  }) {
    return Food(
      id: id ?? this.id,
      gymId: clearGymId ? null : (gymId ?? this.gymId),
      name: name ?? this.name,
      brand: clearBrand ? null : (brand ?? this.brand),
      barcode: clearBarcode ? null : (barcode ?? this.barcode),
      servingSize: servingSize ?? this.servingSize,
      servingUnit: servingUnit ?? this.servingUnit,
      caloriesKcal: caloriesKcal ?? this.caloriesKcal,
      proteinG: proteinG ?? this.proteinG,
      carbsG: carbsG ?? this.carbsG,
      fatsG: fatsG ?? this.fatsG,
      fiberG: clearFiberG ? null : (fiberG ?? this.fiberG),
      sugarG: clearSugarG ? null : (sugarG ?? this.sugarG),
      sodiumMg: clearSodiumMg ? null : (sodiumMg ?? this.sodiumMg),
      isVerified: isVerified ?? this.isVerified,
      isSystem: isSystem ?? this.isSystem,
      createdBy: clearCreatedBy ? null : (createdBy ?? this.createdBy),
      source: source ?? this.source,
      externalId: clearExternalId ? null : (externalId ?? this.externalId),
      imageUrl: clearImageUrl ? null : (imageUrl ?? this.imageUrl),
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'] as String,
      gymId: json['gym_id'] as String?,
      name: json['name'] as String,
      brand: json['brand'] as String?,
      barcode: json['barcode'] as String?,
      servingSize: (json['serving_size'] as num).toDouble(),
      servingUnit: json['serving_unit'] as String,
      caloriesKcal: (json['calories_kcal'] as num).toDouble(),
      proteinG: (json['protein_g'] as num).toDouble(),
      carbsG: (json['carbs_g'] as num).toDouble(),
      fatsG: (json['fats_g'] as num).toDouble(),
      fiberG: (json['fiber_g'] as num?)?.toDouble(),
      sugarG: (json['sugar_g'] as num?)?.toDouble(),
      sodiumMg: (json['sodium_mg'] as num?)?.toDouble(),
      isVerified: json['is_verified'] as bool,
      isSystem: json['is_system'] as bool,
      createdBy: json['created_by'] as String?,
      source: json['source'] as String,
      externalId: json['external_id'] as String?,
      imageUrl: json['image_url'] as String?,
      isActive: json['is_active'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gym_id': gymId,
      'name': name,
      'brand': brand,
      'barcode': barcode,
      'serving_size': servingSize,
      'serving_unit': servingUnit,
      'calories_kcal': caloriesKcal,
      'protein_g': proteinG,
      'carbs_g': carbsG,
      'fats_g': fatsG,
      'fiber_g': fiberG,
      'sugar_g': sugarG,
      'sodium_mg': sodiumMg,
      'is_verified': isVerified,
      'is_system': isSystem,
      'created_by': createdBy,
      'source': source,
      'external_id': externalId,
      'image_url': imageUrl,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, name, caloriesKcal, proteinG, carbsG, fatsG];
}
