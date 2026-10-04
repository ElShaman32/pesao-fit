import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/utils/result.dart';
import '../../data/datasources/food_remote_datasource.dart';
import '../../data/repositories/foods_repository_impl.dart';
import '../../domain/entities/food.dart';
import '../../domain/repositories/foods_repository.dart';

part 'foods_controller.g.dart';

@riverpod
FoodsRepository foodsRepository(Ref ref) {
  return FoodsRepositoryImpl(
    remote: FoodsRemoteDatasource(Supabase.instance.client),
  );
}

/// Controller del catálogo de alimentos. keepAlive para que el catálogo
/// sobreviva a la navegación entre tabs del nutricionista.
@Riverpod(keepAlive: true)
class FoodsController extends _$FoodsController {
  late final FoodsRepository _repository;

  @override
  AsyncValue<List<Food>> build() {
    _repository = ref.watch(foodsRepositoryProvider);

    authProvider.addListener(_onAuthChange);
    ref.onDispose(() => authProvider.removeListener(_onAuthChange));

    if (authProvider.isLoggedIn && !authProvider.isInitializing) {
      Future.microtask(load);
    }

    return const AsyncValue.loading();
  }

  void _onAuthChange() {
    if (!authProvider.isLoggedIn) {
      state = const AsyncValue.data([]);
      return;
    }
    if (!authProvider.isInitializing && state.value == null) {
      load();
    }
  }

  /// Carga el catálogo completo visible para el gym del usuario.
  Future<void> load() async {
    final gymId = authProvider.userGymId;
    if (gymId == null) {
      state = AsyncValue.error(
        const UnknownException(
          code: 'Foods/no-gym',
          message: 'Usuario sin gimnasio activo',
        ),
        StackTrace.current,
      );
      return;
    }

    state = const AsyncValue.loading();
    final result = await _repository.getFoods(gymId: gymId);

    result.when(
      idle: () {},
      loading: () {},
      success: (foods) => state = AsyncValue.data(foods),
      failure: (error) => state = AsyncValue.error(error, StackTrace.current),
    );
  }

  /// Busca alimentos por nombre en el servidor.
  Future<Result<List<Food>>> search(String query) async {
    final gymId = authProvider.userGymId;
    if (gymId == null) {
      return const Result.failure(
        UnknownException(code: 'Foods/no-gym', message: 'Sin gimnasio'),
      );
    }
    return _repository.searchFoods(gymId: gymId, query: query);
  }

  /// Crea un alimento personalizado del gym.
  Future<Result<Food>> createFood({
    required String name,
    String? brand,
    String? barcode,
    double servingSize = 100,
    String servingUnit = 'g',
    required double caloriesKcal,
    required double proteinG,
    required double carbsG,
    required double fatsG,
    double? fiberG,
    double? sugarG,
    double? sodiumMg,
  }) async {
    final gymId = authProvider.userGymId;
    if (gymId == null) {
      return const Result.failure(
        UnknownException(code: 'Foods/no-gym', message: 'Sin gimnasio'),
      );
    }

    final result = await _repository.createFood(
      gymId: gymId,
      name: name,
      brand: brand,
      barcode: barcode,
      servingSize: servingSize,
      servingUnit: servingUnit,
      caloriesKcal: caloriesKcal,
      proteinG: proteinG,
      carbsG: carbsG,
      fatsG: fatsG,
      fiberG: fiberG,
      sugarG: sugarG,
      sodiumMg: sodiumMg,
    );

    if (result.isSuccess) await load();
    return result;
  }

  /// Actualiza un alimento y recarga el catálogo.
  Future<Result<Food>> updateFood({required Food food}) async {
    final result = await _repository.updateFood(food: food);
    if (result.isSuccess) await load();
    return result;
  }

  /// Elimina un alimento personalizado y recarga.
  Future<Result<void>> deleteFood({required String foodId}) async {
    final result = await _repository.deleteFood(foodId: foodId);
    if (result.isSuccess) await load();
    return result;
  }
}
