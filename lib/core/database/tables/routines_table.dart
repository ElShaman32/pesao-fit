import 'package:drift/drift.dart';

/// Rutinas asignadas a clientes. Caché 7 días.
class Routines extends Table {
  TextColumn get id => text()();
  TextColumn get gymId => text()();
  TextColumn get clientId => text()();
  TextColumn get trainerId => text().nullable()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
