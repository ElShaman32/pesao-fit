import 'package:drift/drift.dart';

/// Medidas corporales para seguimiento de progreso.
class BodyMeasurements extends Table {
  TextColumn get id => text()();
  TextColumn get gymId => text()();
  TextColumn get userId => text()();
  DateTimeColumn get recordedAt => dateTime()();
  RealColumn get weightKg => real().nullable()();
  RealColumn get bodyFatPct => real().nullable()();
  RealColumn get waistCm => real().nullable()();
  RealColumn get hipsCm => real().nullable()();
  RealColumn get chestCm => real().nullable()();
  RealColumn get armsCm => real().nullable()();
  RealColumn get thighsCm => real().nullable()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
