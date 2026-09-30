import 'package:drift/drift.dart';

/// Perfil de usuario. Espejo local de Supabase.profiles.
class Profiles extends Table {
  TextColumn get id => text()();
  TextColumn get email => text().nullable()();
  TextColumn get fullName => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get avatarUrl => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
