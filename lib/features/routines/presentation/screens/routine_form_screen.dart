import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/result.dart';
import '../../../../shared/widgets/pesao_app_bar.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_input.dart';
import '../../../../shared/widgets/pesao_shell.dart';
import '../../../../shared/widgets/pesao_toast.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/entities/routine.dart';
import '../../domain/repositories/routines_repository.dart';
import '../providers/routines_controller.dart';
import '../widgets/routine_exercise_editor.dart';
import 'exercise_picker_sheet.dart';

/// Formulario para crear o editar una rutina.
class RoutineFormScreen extends ConsumerStatefulWidget {
  const RoutineFormScreen({super.key, this.routineId});

  /// Si se pasa, se edita la rutina existente.
  final String? routineId;

  @override
  ConsumerState<RoutineFormScreen> createState() => _RoutineFormScreenState();
}

class _RoutineFormScreenState extends ConsumerState<RoutineFormScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedClientId;
  String? _selectedClientName;
  List<_RoutineExerciseDraft> _exerciseDrafts = [];
  Routine? _existingRoutine;

  bool _isLoadingRoutine = false;
  bool _isSubmitting = false;
  String? _nameError;
  String? _clientError;
  String? _exercisesError;

  bool get _isEditing => widget.routineId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _loadRoutine(widget.routineId!);
    }
  }

  Future<void> _loadRoutine(String routineId) async {
    setState(() => _isLoadingRoutine = true);
    try {
      final repository = ref.read(routinesRepositoryProvider);
      final result = await repository.getRoutine(routineId: routineId);
      result.when(
        idle: () {},
        loading: () {},
        success: (routine) {
          if (!mounted) return;
          setState(() {
            _existingRoutine = routine;
            _nameController.text = routine.name;
            _descriptionController.text = routine.description ?? '';
            _selectedClientId = routine.clientId;
            _selectedClientName = routine.clientName;
            _exerciseDrafts = routine.exercises
                .map(
                  (e) => _RoutineExerciseDraft(
                    exercise: Exercise(
                      id: e.exerciseId,
                      name: e.exerciseName ?? '',
                      muscleGroup: MuscleGroup.fromDb(e.exerciseMuscleGroup),
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    sets: e.sets,
                    reps: e.reps,
                    weightKg: e.weightKg,
                    restSeconds: e.restSeconds,
                    notes: e.notes,
                  ),
                )
                .toList();
          });
        },
        failure: (error) {
          if (!mounted) return;
          showPesaoToast(
            context,
            message: 'No se pudo cargar la rutina',
            semanticLabel: 'Error al cargar',
            variant: PesaoToastVariant.error,
          );
        },
      );
    } finally {
      if (mounted) {
        setState(() => _isLoadingRoutine = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickExercise() async {
    final exercise = await showExercisePickerSheet(context);
    if (exercise != null) {
      setState(() {
        _exerciseDrafts.add(
          _RoutineExerciseDraft(
            exercise: exercise,
            sets: 3,
            reps: 10,
            weightKg: null,
            restSeconds: 60,
            notes: null,
          ),
        );
        _exercisesError = null;
      });
    }
  }

  Future<void> _pickClient() async {
    // Cargar clientes del gym para el selector.
    final client = Supabase.instance.client;
    final gymId = authProvider.userGymId;
    if (gymId == null) return;

    final response = await client
        .from('memberships')
        .select('user_id, profiles:user_id (full_name)')
        .eq('gym_id', gymId)
        .eq('role', 'client')
        .eq('is_active', true);

    if (!mounted) return;

    final selected = await showModalBottomSheet<Map<String, String>>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        final l10n = AppStrings.of(sheetContext);
        return Padding(
          padding: const EdgeInsets.all(AppDimens.l),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: const BoxDecoration(
                  color: AppColors.outline,
                  borderRadius: AppDimens.pillBorderRadius,
                ),
              ),
              const SizedBox(height: AppDimens.l),
              Text(
                l10n.routineFormClientLabel,
                style: AppTypography.headline.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimens.m),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 400),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: response.length,
                  itemBuilder: (context, index) {
                    final row = response[index];
                    final userId = row['user_id'] as String;
                    final profile = row['profiles'] as Map<String, dynamic>?;
                    final name = profile?['full_name'] as String? ?? 'Cliente';
                    return ListTile(
                      title: Text(name),
                      onTap: () => Navigator.of(
                        sheetContext,
                      ).pop({'id': userId, 'name': name}),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppDimens.l),
            ],
          ),
        );
      },
    );

    if (selected != null) {
      setState(() {
        _selectedClientId = selected['id'];
        _selectedClientName = selected['name'];
        _clientError = null;
      });
    }
  }

  Future<void> _submit() async {
    final l10n = AppStrings.of(context);

    setState(() {
      _nameError = null;
      _clientError = null;
      _exercisesError = null;
    });

    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() => _nameError = l10n.routineFormNameError);
      return;
    }
    if (_selectedClientId == null) {
      setState(() => _clientError = l10n.routineFormClientError);
      return;
    }
    if (_exerciseDrafts.isEmpty) {
      setState(() => _exercisesError = l10n.routineFormNoExercises);
      return;
    }

    setState(() => _isSubmitting = true);

    final controller = ref.read(routinesControllerProvider.notifier);
    final exerciseData = _exerciseDrafts
        .map(
          (d) => RoutineExerciseDraft(
            exerciseId: d.exercise.id,
            sets: d.sets,
            reps: d.reps,
            weightKg: d.weightKg,
            restSeconds: d.restSeconds,
            notes: d.notes,
          ),
        )
        .toList();

    Result<Routine> result;

    if (_isEditing && _existingRoutine != null) {
      final repository = ref.read(routinesRepositoryProvider);
      result = await repository.updateRoutine(
        routine: _existingRoutine!.copyWith(
          name: name,
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
        ),
        exercises: exerciseData,
      );
    } else {
      result = await controller.createRoutine(
        clientId: _selectedClientId!,
        name: name,
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        exercises: exerciseData,
      );
    }

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    result.when(
      idle: () {},
      loading: () {},
      success: (_) {
        showPesaoToast(
          context,
          message: _isEditing
              ? l10n.routineUpdatedSuccess
              : l10n.routineCreatedSuccess,
          semanticLabel: _isEditing
              ? l10n.routineUpdatedSemantics
              : l10n.routineCreatedSemantics,
          variant: PesaoToastVariant.success,
        );
        Navigator.of(context).pop(true);
      },
      failure: (error) {
        showPesaoToast(
          context,
          message: 'No se pudo guardar la rutina',
          semanticLabel: 'Error al guardar',
          variant: PesaoToastVariant.error,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return PesaoShell(
      appBar: PesaoAppBar(
        title: _isEditing
            ? l10n.routineFormEditTitle
            : l10n.routineFormCreateTitle,
      ),
      body: _isLoadingRoutine
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(AppDimens.l),
              children: [
                // Nombre.
                PesaoInput(
                  label: l10n.routineFormNameLabel,
                  hint: l10n.routineFormNameHint,
                  controller: _nameController,
                ),
                if (_nameError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: AppDimens.xs),
                    child: Text(
                      _nameError!,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.errorText,
                      ),
                    ),
                  ),
                const SizedBox(height: AppDimens.m),

                // Descripción.
                PesaoInput(
                  label: l10n.routineFormDescriptionLabel,
                  hint: l10n.routineFormDescriptionHint,
                  controller: _descriptionController,
                ),
                const SizedBox(height: AppDimens.l),

                // Cliente.
                Text(
                  l10n.routineFormClientLabel,
                  style: AppTypography.label.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppDimens.s),
                _ClientSelector(
                  selectedName: _selectedClientName,
                  onTap: _pickClient,
                ),
                if (_clientError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: AppDimens.xs),
                    child: Text(
                      _clientError!,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.errorText,
                      ),
                    ),
                  ),
                const SizedBox(height: AppDimens.l),

                // Ejercicios.
                Row(
                  children: [
                    Text(
                      l10n.routineFormExercisesLabel,
                      style: AppTypography.label.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      icon: const Icon(Icons.add_rounded, size: 18),
                      label: Text(l10n.routineFormAddExercise),
                      onPressed: _pickExercise,
                    ),
                  ],
                ),
                if (_exercisesError != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppDimens.xs,
                      bottom: AppDimens.s,
                    ),
                    child: Text(
                      _exercisesError!,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.errorText,
                      ),
                    ),
                  ),
                const SizedBox(height: AppDimens.s),
                ..._exerciseDrafts.asMap().entries.map((entry) {
                  final index = entry.key;
                  final draft = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppDimens.s),
                    child: RoutineExerciseEditor(
                      exercise: draft.exercise,
                      sets: draft.sets,
                      reps: draft.reps,
                      weightKg: draft.weightKg,
                      restSeconds: draft.restSeconds,
                      notes: draft.notes,
                      onSetsChanged: (v) => setState(
                        () => _exerciseDrafts[index] = draft.copyWith(sets: v),
                      ),
                      onRepsChanged: (v) => setState(
                        () => _exerciseDrafts[index] = draft.copyWith(reps: v),
                      ),
                      onWeightChanged: (v) => setState(
                        () => _exerciseDrafts[index] = draft.copyWith(
                          weightKg: v,
                        ),
                      ),
                      onRestChanged: (v) => setState(
                        () => _exerciseDrafts[index] = draft.copyWith(
                          restSeconds: v,
                        ),
                      ),
                      onNotesChanged: (v) => setState(
                        () => _exerciseDrafts[index] = draft.copyWith(notes: v),
                      ),
                      onRemove: () =>
                          setState(() => _exerciseDrafts.removeAt(index)),
                    ),
                  );
                }),
                const SizedBox(height: AppDimens.xl),

                // Submit.
                PesaoButton(
                  label: _isSubmitting
                      ? l10n.routineFormSubmitting
                      : l10n.routineFormSubmit,
                  variant: PesaoButtonVariant.primary,
                  onPressed: _isSubmitting ? null : _submit,
                ),
                const SizedBox(height: AppDimens.xxl),
              ],
            ),
    );
  }
}

/// Borrador local de un ejercicio dentro de una rutina.
class _RoutineExerciseDraft {
  final Exercise exercise;
  final int sets;
  final int? reps;
  final double? weightKg;
  final int restSeconds;
  final String? notes;

  _RoutineExerciseDraft({
    required this.exercise,
    required this.sets,
    this.reps,
    this.weightKg,
    required this.restSeconds,
    this.notes,
  });

  _RoutineExerciseDraft copyWith({
    int? sets,
    int? reps,
    double? weightKg,
    int? restSeconds,
    String? notes,
  }) {
    return _RoutineExerciseDraft(
      exercise: exercise,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      weightKg: weightKg ?? this.weightKg,
      restSeconds: restSeconds ?? this.restSeconds,
      notes: notes ?? this.notes,
    );
  }
}

class _ClientSelector extends StatelessWidget {
  final String? selectedName;
  final VoidCallback onTap;

  const _ClientSelector({required this.selectedName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppDimens.l),
        decoration: BoxDecoration(
          color: AppColors.surfaceHigh,
          borderRadius: AppDimens.cardBorderRadius,
          border: Border.all(color: AppColors.outline),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.person_outline_rounded,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: AppDimens.m),
            Expanded(
              child: Text(
                selectedName ?? 'Seleccionar cliente',
                style: AppTypography.body.copyWith(
                  color: selectedName != null
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
