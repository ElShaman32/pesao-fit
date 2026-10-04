/// Tipo de comida en el plan nutricional.
/// Mapea el CHECK constraint de la BD:
/// breakfast | lunch | dinner | snack
enum MealType {
  breakfast,
  lunch,
  dinner,
  snack;

  /// Valor que se guarda en la base de datos.
  String get dbValue => switch (this) {
    MealType.breakfast => 'breakfast',
    MealType.lunch => 'lunch',
    MealType.dinner => 'dinner',
    MealType.snack => 'snack',
  };

  /// Clave de traducción para AppStrings.
  String get l10nKey => switch (this) {
    MealType.breakfast => 'foodLogBreakfast',
    MealType.lunch => 'foodLogLunch',
    MealType.dinner => 'foodLogDinner',
    MealType.snack => 'foodLogSnack',
  };

  /// Icono representativo del momento de comida.
  /// Se usa en MealTimeSelector y MealCard.
  // Nota: el import de Material Icons se hace en la capa de presentación,
  // aquí solo devolvemos un string key para mantener Domain libre de Flutter.
  String get iconKey => switch (this) {
    MealType.breakfast => 'wb_sunny',
    MealType.lunch => 'lunch_dining',
    MealType.dinner => 'dinner_dining',
    MealType.snack => 'cookie',
  };

  static MealType fromDb(String? value) {
    return MealType.values.firstWhere(
      (m) => m.dbValue == value,
      orElse: () => MealType.snack,
    );
  }
}
