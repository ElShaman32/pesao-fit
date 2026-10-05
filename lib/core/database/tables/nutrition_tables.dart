import 'package:drift/drift.dart';

/// Catálogo de alimentos (cache local de `foods`).
class FoodsTable extends Table {
  TextColumn get id => text()();
  TextColumn get gymId => text().nullable()();
  TextColumn get name => text()();
  TextColumn get brand => text().nullable()();
  TextColumn get barcode => text().nullable()();
  RealColumn get servingSize => real()();
  TextColumn get servingUnit => text().withDefault(const Constant('g'))();
  RealColumn get caloriesKcal => real()();
  RealColumn get proteinG => real()();
  RealColumn get carbsG => real()();
  RealColumn get fatsG => real()();
  RealColumn get fiberG => real().nullable()();
  RealColumn get sugarG => real().nullable()();
  RealColumn get sodiumMg => real().nullable()();
  BoolColumn get isVerified => boolean().withDefault(const Constant(false))();
  BoolColumn get isSystem => boolean().withDefault(const Constant(false))();
  TextColumn get createdBy => text().nullable()();
  TextColumn get source => text().withDefault(const Constant('local'))();
  TextColumn get externalId => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Planes nutricionales (cache local de `nutrition_plans`).
class NutritionPlansTable extends Table {
  TextColumn get id => text()();
  TextColumn get gymId => text()();
  TextColumn get clientId => text()();
  TextColumn get nutritionistId => text()();
  TextColumn get name => text()();
  TextColumn get goal => text().nullable()();
  RealColumn get targetCaloriesKcal => real()();
  RealColumn get targetProteinG => real()();
  RealColumn get targetCarbsG => real()();
  RealColumn get targetFatsG => real()();
  IntColumn get durationDays => integer()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Metas nutricionales por cliente (cache local de `nutrition_goals`).
class NutritionGoalsTable extends Table {
  TextColumn get id => text()();
  TextColumn get clientId => text()();
  TextColumn get gymId => text()();
  TextColumn get setBy => text().nullable()();
  RealColumn get targetCaloriesKcal => real()();
  RealColumn get targetProteinG => real()();
  RealColumn get targetCarbsG => real()();
  RealColumn get targetFatsG => real()();
  TextColumn get goalType => text().withDefault(const Constant('maintain'))();
  TextColumn get notes => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Registro diario de comidas (cache local de `food_logs`).
class FoodLogsTable extends Table {
  TextColumn get id => text()();
  TextColumn get clientId => text()();
  TextColumn get gymId => text()();
  DateTimeColumn get logDate => dateTime()();
  RealColumn get totalCaloriesKcal => real().withDefault(const Constant(0))();
  RealColumn get totalProteinG => real().withDefault(const Constant(0))();
  RealColumn get totalCarbsG => real().withDefault(const Constant(0))();
  RealColumn get totalFatsG => real().withDefault(const Constant(0))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Items de comida en el log diario (cache local de `food_log_items`).
class FoodLogItemsTable extends Table {
  TextColumn get id => text()();
  TextColumn get logId => text()();
  TextColumn get foodId => text()();
  TextColumn get mealType => text()();
  RealColumn get quantity => real()();
  RealColumn get caloriesKcal => real()();
  RealColumn get proteinG => real()();
  RealColumn get carbsG => real()();
  RealColumn get fatsG => real()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
