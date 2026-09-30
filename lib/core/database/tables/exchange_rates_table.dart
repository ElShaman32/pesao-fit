import 'package:drift/drift.dart';

/// Tasa BCV por gimnasio (ADR-017). Caché para cálculo offline de pagos.
class ExchangeRates extends Table {
  TextColumn get id => text()();
  TextColumn get gymId => text()();
  RealColumn get rate => real()();
  BoolColumn get isManual => boolean().withDefault(const Constant(false))();
  DateTimeColumn get validFrom => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
