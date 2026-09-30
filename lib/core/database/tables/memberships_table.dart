import 'package:drift/drift.dart';

/// Relación usuario-gimnasio-rol. Espejo de Supabase.memberships.
class Memberships extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get gymId => text()();
  TextColumn get role => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
