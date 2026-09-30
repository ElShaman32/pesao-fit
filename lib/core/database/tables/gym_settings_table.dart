import 'package:drift/drift.dart';

/// Marca blanca + tasa manual por gym (ADR-030).
class GymSettings extends Table {
  TextColumn get gymId => text()();
  TextColumn get primaryColor =>
      text().withDefault(const Constant('#8B5CF6'))();
  RealColumn get bcvRate => real().nullable()();
  BoolColumn get bcvRateManual =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {gymId};
}
