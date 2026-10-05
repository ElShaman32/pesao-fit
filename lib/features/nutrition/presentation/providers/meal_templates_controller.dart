import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../../../core/providers/database_provider.dart';
import '../../../../core/providers/supabase_provider.dart';
import '../../data/datasources/meal_template_remote_datasource.dart';
import '../../data/repositories/meal_template_repository_impl.dart';
import '../../domain/entities/meal_template.dart';
import '../../domain/entities/meal_template_food.dart';
import '../../domain/enums/meal_type.dart';
import '../../domain/repositories/meal_template_repository.dart';

part 'meal_templates_controller.g.dart';

/// Estado de las plantillas de comida.
class MealTemplatesState {
  const MealTemplatesState({
    this.templates = const [],
    this.selectedTemplate,
    this.selectedFoods = const [],
    this.isLoading = false,
    this.isLoadingDetail = false,
    this.error,
  });

  final List<MealTemplate> templates;
  final MealTemplate? selectedTemplate;
  final List<MealTemplateFood> selectedFoods;
  final bool isLoading;
  final bool isLoadingDetail;
  final String? error;

  bool get hasData => templates.isNotEmpty && error == null;
  bool get isEmpty => templates.isEmpty && error == null;

  MealTemplatesState copyWith({
    List<MealTemplate>? templates,
    MealTemplate? selectedTemplate,
    List<MealTemplateFood>? selectedFoods,
    bool? isLoading,
    bool? isLoadingDetail,
    String? error,
    bool clearError = false,
    bool clearSelected = false,
  }) {
    return MealTemplatesState(
      templates: templates ?? this.templates,
      selectedTemplate: clearSelected
          ? null
          : (selectedTemplate ?? this.selectedTemplate),
      selectedFoods: selectedFoods ?? this.selectedFoods,
      isLoading: isLoading ?? this.isLoading,
      isLoadingDetail: isLoadingDetail ?? this.isLoadingDetail,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Controlador de plantillas de comida del nutricionista.
@Riverpod(keepAlive: true)
class MealTemplatesController extends _$MealTemplatesController {
  late final MealTemplateRepository _repository;

  @override
  MealTemplatesState build() {
    _repository = MealTemplateRepositoryImpl(
      remote: MealTemplateRemoteDatasource(
        supabaseClient,
        ref.read(appDatabaseProvider),
      ),
    );

    authProvider.addListener(_onAuthChange);
    ref.onDispose(() => authProvider.removeListener(_onAuthChange));

    if (authProvider.isLoggedIn && !authProvider.isInitializing) {
      Future.microtask(load);
    }

    return const MealTemplatesState();
  }

  void _onAuthChange() {
    if (authProvider.isLoggedIn &&
        !authProvider.isInitializing &&
        !state.isLoading &&
        state.templates.isEmpty) {
      load();
    }
  }

  String? get _gymId => authProvider.userGymId;

  /// Carga todas las plantillas del gimnasio.
  Future<void> load({MealType? filterByMealType}) async {
    final gymId = _gymId;
    if (gymId == null) return;

    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.fetchTemplates(
      gymId: gymId,
      filterByMealType: filterByMealType,
    );
    result.when(
      idle: () {},
      loading: () {},
      success: (templates) {
        state = state.copyWith(isLoading: false, templates: templates);
      },
      failure: (error) {
        state = state.copyWith(isLoading: false, error: error.code);
      },
    );
  }

  /// Carga el detalle de una plantilla con sus foods.
  Future<void> loadDetail(String templateId) async {
    state = state.copyWith(isLoadingDetail: true, clearError: true);

    final result = await _repository.fetchTemplateDetail(templateId);
    result.when(
      idle: () {},
      loading: () {},
      success: (data) {
        final (template, foods) = data;
        state = state.copyWith(
          isLoadingDetail: false,
          selectedTemplate: template,
          selectedFoods: foods,
        );
      },
      failure: (error) {
        state = state.copyWith(isLoadingDetail: false, error: error.code);
      },
    );
  }

  /// Crea una plantilla nueva.
  Future<MealTemplate?> createTemplate(MealTemplate template) async {
    final result = await _repository.createTemplate(template);
    return result.when(
      idle: () => null,
      loading: () => null,
      success: (created) {
        load();
        return created;
      },
      failure: (error) {
        state = state.copyWith(error: error.code);
        return null;
      },
    );
  }

  /// Actualiza datos básicos de una plantilla.
  Future<bool> updateTemplate(MealTemplate template) async {
    final result = await _repository.updateTemplate(template);
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

  /// Desactiva una plantilla.
  Future<bool> deactivateTemplate(String templateId) async {
    final result = await _repository.deactivateTemplate(templateId);
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

  /// Agrega un alimento a la plantilla seleccionada.
  /// Si se pasa [templateId] explícitamente, se usa ese.
  /// Si no, se usa el de la plantilla actualmente seleccionada.
  Future<bool> addFoodToTemplate({
    String? templateId,
    required String foodId,
    required double quantity,
    int orderIndex = 0,
    String? notes,
  }) async {
    final resolvedTemplateId = templateId ?? state.selectedTemplate?.id;
    if (resolvedTemplateId == null) return false;

    final result = await _repository.addFoodToTemplate(
      templateId: resolvedTemplateId,
      foodId: foodId,
      quantity: quantity,
      orderIndex: orderIndex,
      notes: notes,
    );
    return result.when(
      idle: () => false,
      loading: () => false,
      success: (_) {
        loadDetail(resolvedTemplateId);
        return true;
      },
      failure: (error) {
        state = state.copyWith(error: error.code);
        return false;
      },
    );
  }

  /// Actualiza cantidad de un alimento en la plantilla.
  Future<bool> updateTemplateFood({
    required String templateFoodId,
    required double newQuantity,
    String? notes,
  }) async {
    final result = await _repository.updateTemplateFood(
      templateFoodId: templateFoodId,
      newQuantity: newQuantity,
      notes: notes,
    );
    return result.when(
      idle: () => false,
      loading: () => false,
      success: (_) {
        final templateId = state.selectedTemplate?.id;
        if (templateId != null) loadDetail(templateId);
        return true;
      },
      failure: (error) {
        state = state.copyWith(error: error.code);
        return false;
      },
    );
  }

  /// Elimina un alimento de la plantilla.
  Future<bool> removeFoodFromTemplate(String templateFoodId) async {
    final result = await _repository.removeFoodFromTemplate(templateFoodId);
    return result.when(
      idle: () => false,
      loading: () => false,
      success: (_) {
        final templateId = state.selectedTemplate?.id;
        if (templateId != null) loadDetail(templateId);
        return true;
      },
      failure: (error) {
        state = state.copyWith(error: error.code);
        return false;
      },
    );
  }

  /// Limpia la selección actual.
  void clearSelection() {
    state = state.copyWith(clearSelected: true, selectedFoods: []);
  }
}
