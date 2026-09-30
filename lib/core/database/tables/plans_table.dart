import 'package:drift/drift.dart';

/// Catálogo de planes (Pluma/Hierro/Macizo). Caché 3 días.
class Plans extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  RealColumn get priceUsd => real()();
  IntColumn get maxClients => integer()();
  IntColumn get maxTrainers => integer()();
  IntColumn get maxStaff => integer().nullable()();
  TextColumn get features => text().withDefault(const Constant('{}'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
