/// Tipos de comida soportados.
/// Alineado con CHECK constraint de Supabase:
/// 'desayuno', 'almuerzo', 'cena', 'merienda_am', 'merienda_pm',
/// 'pre_entreno', 'post_entreno'.
enum MealType {
  breakfast,
  lunch,
  dinner,
  morningSnack,
  afternoonSnack,
  preWorkout,
  postWorkout;

  /// Convierte el enum al valor de BD.
  String toDbValue() {
    return switch (this) {
      MealType.breakfast => 'desayuno',
      MealType.lunch => 'almuerzo',
      MealType.dinner => 'cena',
      MealType.morningSnack => 'merienda_am',
      MealType.afternoonSnack => 'merienda_pm',
      MealType.preWorkout => 'pre_entreno',
      MealType.postWorkout => 'post_entreno',
    };
  }

  /// Parsea desde el valor de BD.
  static MealType fromDbValue(String value) {
    return switch (value) {
      'desayuno' => MealType.breakfast,
      'almuerzo' => MealType.lunch,
      'cena' => MealType.dinner,
      'merienda_am' => MealType.morningSnack,
      'merienda_pm' => MealType.afternoonSnack,
      'pre_entreno' => MealType.preWorkout,
      'post_entreno' => MealType.postWorkout,
      _ => MealType.breakfast,
    };
  }
}
