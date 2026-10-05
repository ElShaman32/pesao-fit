import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/nutrition_tables.dart';
import 'tables/profiles_table.dart';
import 'tables/gyms_table.dart';
import 'tables/memberships_table.dart';
import 'tables/plans_table.dart';
import 'tables/subscriptions_table.dart';
import 'tables/exercises_table.dart';
import 'tables/routines_table.dart';
import 'tables/routine_exercises_table.dart';
import 'tables/workouts_table.dart';
import 'tables/workout_exercises_table.dart';
import 'tables/body_measurements_table.dart';
import 'tables/progress_photos_table.dart';
import 'tables/notifications_table.dart';
import 'tables/exchange_rates_table.dart';
import 'tables/gym_settings_table.dart';

part 'app_database.g.dart';

/// Base de datos local PESAO FIT (offline-first, ADR-012/019/033).
/// Espejo caché de las tablas de Supabase que se leen sin red.
@DriftDatabase(
  tables: [
    Profiles,
    Gyms,
    Memberships,
    Plans,
    Subscriptions,
    Exercises,
    Routines,
    RoutineExercises,
    Workouts,
    WorkoutExercises,
    BodyMeasurements,
    ProgressPhotos,
    Notifications,
    ExchangeRates,
    GymSettings,
    FoodsTable,
    NutritionPlansTable,
    NutritionGoalsTable,
    FoodLogsTable,
    FoodLogItemsTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Constructor para pruebas: permite inyectar una conexión en memoria.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Futuras migraciones del esquema local se agregan aquí.
      },
    );
  }
}

/// Conexión multiplataforma: SQLite nativo en mobile, IndexedDB en web (Wasm).
DatabaseConnection _openConnection() {
  return driftDatabase(name: 'pesao_fit');
}
