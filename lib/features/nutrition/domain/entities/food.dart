import 'package:equatable/equatable.dart';

/// Fuente de origen del alimento.
/// Mapea el CHECK constraint de foods.source.
enum FoodSource {
  local,
  usda,
  openfoodfacts,
  custom;

  String get dbValue => name;

  static FoodSource fromDb(String? value) {
    return FoodSource.values.firstWhere(
      (s) => s.name == value,
      orElse: () => FoodSource.local,
    );
  }
}

/// Alimento del catálogo (global del sistema o personalizado por gym).
/// POCO + Equatable (ADR-037). Mapea la tabla `foods`.
///
/// Nota: la BD usa `serving_size` (numeric) + `serving_unit` (text)
/// en lugar de un solo campo `serving_size_g`.
class Food extends Equatable {
  final String id;
  final String? gymId;
  final String name;
  final String? brand;
  final String? barcode;

  /// Tamaño de la porción de referencia (default 100 en BD).
  final double servingSize;

  /// Unidad de la porción: 'g', 'ml', 'unidad', etc.
  final String servingUnit;

  // --- Macronutrientes por porción de referencia ---
  final double caloriesKcal;
  final double proteinG;
  final double carbsG;
  final double fatsG;
  final double? fiberG;
  final double? sugarG;
  final double? sodiumMg;

  /// true = alimento verificado por el nutricionista del gym.
  final bool isVerified;

  /// true = alimento del catálogo global del sistema (seed).
  final bool isSystem;

  /// Origen del alimento: local, usda, openfoodfacts, custom.
  final FoodSource source;

  /// ID externo (fdcId de USDA o code de OpenFoodFacts) para evitar duplicados.
  final String? externalId;

  final String? imageUrl;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Food({
    required this.id,
    this.gymId,
    required this.name,
    this.brand,
    this.barcode,
    this.servingSize = 100,
    this.servingUnit = 'g',
    required this.caloriesKcal,
    required this.proteinG,
    required this.carbsG,
    required this.fatsG,
    this.fiberG,
    this.sugarG,
    this.sodiumMg,
    this.isVerified = false,
    this.isSystem = false,
    this.source = FoodSource.local,
    this.externalId,
    this.imageUrl,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  /// true si es un alimento del catálogo global (visible para todos los gyms).
  bool get isGlobal => isSystem || gymId == null;

  /// Label legible de la porción: "100g", "240ml", "1 unidad".
  String get servingLabel => '$servingSize$servingUnit';

  /// Calcula macros proporcionales para una cantidad dada.
  /// Se usa en FoodPickerSheet y en add_food_to_log().
  FoodMacros macrosForQuantity(double quantity) {
    final factor = servingSize == 0 ? 1.0 : quantity / servingSize;
    return FoodMacros(
      caloriesKcal: caloriesKcal * factor,
      proteinG: proteinG * factor,
      carbsG: carbsG * factor,
      fatsG: fatsG * factor,
    );
  }

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'] as String,
      gymId: json['gym_id'] as String?,
      name: json['name'] as String,
      brand: json['brand'] as String?,
      barcode: json['barcode'] as String?,
      servingSize: (json['serving_size'] as num?)?.toDouble() ?? 100,
      servingUnit: json['serving_unit'] as String? ?? 'g',
      caloriesKcal: (json['calories_kcal'] as num?)?.toDouble() ?? 0,
      proteinG: (json['protein_g'] as num?)?.toDouble() ?? 0,
      carbsG: (json['carbs_g'] as num?)?.toDouble() ?? 0,
      fatsG: (json['fats_g'] as num?)?.toDouble() ?? 0,
      fiberG: (json['fiber_g'] as num?)?.toDouble(),
      sugarG: (json['sugar_g'] as num?)?.toDouble(),
      sodiumMg: (json['sodium_mg'] as num?)?.toDouble(),
      isVerified: json['is_verified'] as bool? ?? false,
      isSystem: json['is_system'] as bool? ?? false,
      source: FoodSource.fromDb(json['source'] as String?),
      externalId: json['external_id'] as String?,
      imageUrl: json['image_url'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Food copyWith({
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
    String? imageUrl,
  }) {
    return Food(
      id: id,
      gymId: gymId,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      barcode: barcode ?? this.barcode,
      servingSize: servingSize ?? this.servingSize,
      servingUnit: servingUnit ?? this.servingUnit,
      caloriesKcal: caloriesKcal ?? this.caloriesKcal,
      proteinG: proteinG ?? this.proteinG,
      carbsG: carbsG ?? this.carbsG,
      fatsG: fatsG ?? this.fatsG,
      fiberG: fiberG ?? this.fiberG,
      sugarG: sugarG ?? this.sugarG,
      sodiumMg: sodiumMg ?? this.sodiumMg,
      isVerified: isVerified ?? this.isVerified,
      isSystem: isSystem,
      source: source,
      externalId: externalId,
      imageUrl: imageUrl ?? this.imageUrl,
      createdBy: createdBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    gymId,
    name,
    brand,
    barcode,
    servingSize,
    servingUnit,
    caloriesKcal,
    proteinG,
    carbsG,
    fatsG,
    fiberG,
    sugarG,
    sodiumMg,
    isVerified,
    isSystem,
    source,
    externalId,
    imageUrl,
    createdBy,
    createdAt,
    updatedAt,
  ];
}

/// Macros calculados para una cantidad específica de un alimento.
/// Se usa en FoodPickerSheet (preview en vivo) y en food_log_items.
class FoodMacros extends Equatable {
  final double caloriesKcal;
  final double proteinG;
  final double carbsG;
  final double fatsG;

  const FoodMacros({
    required this.caloriesKcal,
    required this.proteinG,
    required this.carbsG,
    required this.fatsG,
  });

  /// Redondeo a 1 decimal para display.
  FoodMacros rounded() => FoodMacros(
    caloriesKcal: double.parse(caloriesKcal.toStringAsFixed(1)),
    proteinG: double.parse(proteinG.toStringAsFixed(1)),
    carbsG: double.parse(carbsG.toStringAsFixed(1)),
    fatsG: double.parse(fatsG.toStringAsFixed(1)),
  );

  @override
  List<Object?> get props => [caloriesKcal, proteinG, carbsG, fatsG];
}
