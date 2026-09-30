import 'package:drift/drift.dart';

/// Metadatos de fotos de progreso (la imagen vive en Cloudinary).
class ProgressPhotos extends Table {
  TextColumn get id => text()();
  TextColumn get gymId => text()();
  TextColumn get userId => text()();
  TextColumn get photoUrl => text()();
  DateTimeColumn get takenAt => dateTime()();
  TextColumn get category => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
