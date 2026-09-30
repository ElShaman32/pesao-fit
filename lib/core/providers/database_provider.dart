import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/app_database.dart';

part 'database_provider.g.dart';

/// Instancia única y global de AppDatabase (keepAlive).
/// La conexión vive mientras la app esté abierta; se cierra al disponer.
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}
