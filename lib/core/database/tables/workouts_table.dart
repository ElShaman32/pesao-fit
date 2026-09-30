import 'package:drift/drift.dart';

/// Sesiones de entrenamiento realizadas.
class Workouts extends Table {
  TextColumn get id => text()();
  TextColumn get gymId => text()();
  TextColumn get userId => text()();
  TextColumn get routineId => text().nullable()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
