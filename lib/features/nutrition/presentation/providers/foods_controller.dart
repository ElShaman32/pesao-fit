import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../../../core/providers/database_provider.dart';
import '../../../../core/providers/supabase_provider.dart';
import '../../data/datasources/food_remote_datasource.dart';
import '../../data/repositories/food_repository_impl.dart';
import '../../domain/entities/food.dart';
import '../../domain/entities/food_favorite.dart';
import '../../domain/repositories/food_repository.dart';

part 'foods_controller.g.dart';

/// Estado del catálogo de alimentos.
class FoodsState {
  const FoodsState({
    this.foods = const [],
    this.favorites = const [],
    this.searchResults = const [],
    this.isLoading = false,
    this.isSearching = false,
    this.error,
  });

  final List<Food> foods;
  final List<FoodFavorite> favorites;
  final List<Food> searchResults;
  final bool isLoading;
  final bool isSearching;
  final String? error;

  bool get hasData => foods.isNotEmpty && error == null;
  bool get isEmpty => foods.isEmpty && error == null;

  /// Verifica si un food es favorito del cliente.
  bool isFavorite(String foodId) => favorites.any((f) => f.foodId == foodId);

  FoodsState copyWith({
    List<Food>? foods,
    List<FoodFavorite>? favorites,
    List<Food>? searchResults,
    bool? isLoading,
    bool? isSearching,
    String? error,
    bool clearError = false,
  }) {
    return FoodsState(
      foods: foods ?? this.foods,
      favorites: favorites ?? this.favorites,
      searchResults: searchResults ?? this.searchResults,
      isLoading: isLoading ?? this.isLoading,
      isSearching: isSearching ?? this.isSearching,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Controlador del catálogo de alimentos.
@Riverpod(keepAlive: true)
class FoodsController extends _$FoodsController {
  late final FoodRepository _repository;

  @override
  FoodsState build() {
    _repository = FoodRepositoryImpl(
      remote: FoodRemoteDatasource(
        supabaseClient,
        ref.read(appDatabaseProvider),
      ),
    );

    authProvider.addListener(_onAuthChange);
    ref.onDispose(() => authProvider.removeListener(_onAuthChange));

    if (authProvider.isLoggedIn && !authProvider.isInitializing) {
      Future.microtask(load);
    }

    return const FoodsState();
  }

  void _onAuthChange() {
    if (authProvider.isLoggedIn &&
        !authProvider.isInitializing &&
        !state.isLoading &&
        state.foods.isEmpty) {
      load();
    }
  }

  String? get _gymId => authProvider.userGymId;

  /// Carga todos los alimentos del gimnasio + favoritos.
  Future<void> load() async {
    final gymId = _gymId;
    if (gymId == null) return;

    state = state.copyWith(isLoading: true, clearError: true);

    final foodsResult = await _repository.fetchFoods(gymId: gymId);
    foodsResult.when(
      idle: () {},
      loading: () {},
      success: (foods) {
        state = state.copyWith(isLoading: false, foods: foods);
      },
      failure: (error) {
        state = state.copyWith(isLoading: false, error: error.code);
      },
    );
  }

  /// Busca alimentos por nombre/marca.
  Future<void> search(String query) async {
    final gymId = _gymId;
    if (gymId == null || query.trim().isEmpty) {
      state = state.copyWith(searchResults: [], isSearching: false);
      return;
    }

    state = state.copyWith(isSearching: true);

    final result = await _repository.searchFoods(
      query: query.trim(),
      gymId: gymId,
    );
    result.when(
      idle: () {},
      loading: () {},
      success: (foods) {
        state = state.copyWith(isSearching: false, searchResults: foods);
      },
      failure: (error) {
        state = state.copyWith(isSearching: false, error: error.code);
      },
    );
  }

  /// Crea un alimento nuevo.
  Future<bool> createFood(Food food) async {
    final result = await _repository.createFood(food);
    return result.when(
      idle: () => false,
      loading: () => false,
      success: (_) {
        load(); // Recargar lista.
        return true;
      },
      failure: (error) {
        state = state.copyWith(error: error.code);
        return false;
      },
    );
  }

  /// Actualiza un alimento existente.
  Future<bool> updateFood(Food food) async {
    final result = await _repository.updateFood(food);
    return result.when(
      idle: () => false,
      loading: () => false,
      success: (_) {
        load();
        return true;
      },
      failure: (error) {
        state = state.copyWith(error: error.code);
        return false;
      },
    );
  }

  /// Desactiva un alimento (soft delete).
  Future<bool> deactivateFood(String foodId) async {
    final result = await _repository.deactivateFood(foodId);
    return result.when(
      idle: () => false,
      loading: () => false,
      success: (_) {
        load();
        return true;
      },
      failure: (error) {
        state = state.copyWith(error: error.code);
        return false;
      },
    );
  }

  /// Toggle favorito para un cliente.
  Future<bool> toggleFavorite({
    required String clientId,
    required String foodId,
  }) async {
    final result = await _repository.toggleFavorite(
      clientId: clientId,
      foodId: foodId,
    );
    return result.when(
      idle: () => false,
      loading: () => false,
      success: (isFavorite) {
        // Recargar favoritos.
        _loadFavorites(clientId);
        return isFavorite;
      },
      failure: (error) {
        state = state.copyWith(error: error.code);
        return false;
      },
    );
  }

  /// Carga favoritos del cliente.
  Future<void> _loadFavorites(String clientId) async {
    final result = await _repository.fetchFavorites(clientId);
    result.when(
      idle: () {},
      loading: () {},
      success: (favorites) {
        state = state.copyWith(favorites: favorites);
      },
      failure: (_) {},
    );
  }
}
