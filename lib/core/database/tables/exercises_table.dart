import 'package:drift/drift.dart';

/// Catálogo de ejercicios (globales + custom por gym).
class Exercises extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get videoUrl => text().nullable()();
  BoolColumn get isGlobal => boolean().withDefault(const Constant(false))();
  TextColumn get sourceGymId => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
