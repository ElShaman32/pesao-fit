import 'package:drift/drift.dart';

/// Suscripción activa del gimnasio a un plan.
class Subscriptions extends Table {
  TextColumn get id => text()();
  TextColumn get gymId => text()();
  TextColumn get planId => text()();
  TextColumn get status => text()();
  DateTimeColumn get expiresAt => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
