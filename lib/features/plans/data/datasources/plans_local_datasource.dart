import '../../../../core/database/app_database.dart';

/// Lee/escribe planes en la base de datos local Drift.
class PlansLocalDatasource {
  final AppDatabase _db;

  PlansLocalDatasource(this._db);

  /// Obtiene todos los planes cacheados.
  Future<List<Plan>> getPlans() async {
    return await _db.select(_db.plans).get();
  }

  /// Guarda planes en caché (reemplaza todos).
  Future<void> savePlans(List<PlansCompanion> plans) async {
    await _db.transaction(() async {
      await _db.delete(_db.plans).go();
      for (final plan in plans) {
        await _db.into(_db.plans).insert(plan);
      }
    });
  }
}
