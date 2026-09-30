import 'package:drift/drift.dart';

/// Gimnasios. Espejo local de Supabase.gyms.
class Gyms extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get slug => text()();
  TextColumn get logoUrl => text().nullable()();
  TextColumn get timezone =>
      text().withDefault(const Constant('America/Caracas'))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
