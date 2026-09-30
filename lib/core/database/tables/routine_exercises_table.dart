import 'package:drift/drift.dart';

/// Ejercicios dentro de una rutina (series, reps, peso).
class RoutineExercises extends Table {
  TextColumn get id => text()();
  TextColumn get routineId => text()();
  TextColumn get exerciseId => text()();
  IntColumn get sets => integer()();
  IntColumn get reps => integer().nullable()();
  RealColumn get weightKg => real().nullable()();
  IntColumn get restSeconds => integer().withDefault(const Constant(60))();
  IntColumn get orderIndex => integer()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
