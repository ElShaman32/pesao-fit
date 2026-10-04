/// Tipo de objetivo nutricional.
/// Alineado con nutrition_goals.goal_type en Supabase.
enum GoalType {
  lose,
  maintain,
  gain;

  String toDbValue() {
    return switch (this) {
      GoalType.lose => 'lose',
      GoalType.maintain => 'maintain',
      GoalType.gain => 'gain',
    };
  }

  static GoalType fromDbValue(String value) {
    return switch (value) {
      'lose' => GoalType.lose,
      'maintain' => GoalType.maintain,
      'gain' => GoalType.gain,
      _ => GoalType.maintain,
    };
  }
}
