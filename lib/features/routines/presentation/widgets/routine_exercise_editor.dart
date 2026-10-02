import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pesao_input.dart';
import '../../domain/entities/exercise.dart';

/// Editor inline de un ejercicio dentro de una rutina.
class RoutineExerciseEditor extends StatelessWidget {
  final Exercise exercise;
  final int sets;
  final int? reps;
  final double? weightKg;
  final int restSeconds;
  final String? notes;
  final ValueChanged<int> onSetsChanged;
  final ValueChanged<int?> onRepsChanged;
  final ValueChanged<double?> onWeightChanged;
  final ValueChanged<int> onRestChanged;
  final ValueChanged<String?> onNotesChanged;
  final VoidCallback onRemove;

  const RoutineExerciseEditor({
    super.key,
    required this.exercise,
    required this.sets,
    required this.reps,
    required this.weightKg,
    required this.restSeconds,
    required this.notes,
    required this.onSetsChanged,
    required this.onRepsChanged,
    required this.onWeightChanged,
    required this.onRestChanged,
    required this.onNotesChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);

    return Container(
      padding: const EdgeInsets.all(AppDimens.l),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppDimens.cardBorderRadius,
        border: Border.all(color: AppColors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: nombre + botón eliminar.
          Row(
            children: [
              Expanded(
                child: Text(
                  exercise.name,
                  style: AppTypography.title.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.close_rounded,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
                onPressed: onRemove,
                tooltip: l10n.commonCancel,
              ),
            ],
          ),
          const SizedBox(height: AppDimens.m),

          // Campos en grid 2x2.
          Row(
            children: [
              Expanded(
                child: _NumberField(
                  label: l10n.routineExerciseSets,
                  value: sets.toString(),
                  onChanged: (v) {
                    final parsed = int.tryParse(v);
                    if (parsed != null && parsed > 0) {
                      onSetsChanged(parsed);
                    }
                  },
                ),
              ),
              const SizedBox(width: AppDimens.s),
              Expanded(
                child: _NumberField(
                  label: l10n.routineExerciseReps,
                  value: reps?.toString() ?? '',
                  onChanged: (v) {
                    onRepsChanged(v.isEmpty ? null : int.tryParse(v));
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.s),
          Row(
            children: [
              Expanded(
                child: _NumberField(
                  label: l10n.routineExerciseWeight,
                  value: weightKg?.toStringAsFixed(1) ?? '',
                  decimal: true,
                  onChanged: (v) {
                    onWeightChanged(v.isEmpty ? null : double.tryParse(v));
                  },
                ),
              ),
              const SizedBox(width: AppDimens.s),
              Expanded(
                child: _NumberField(
                  label: l10n.routineExerciseRest,
                  value: restSeconds.toString(),
                  onChanged: (v) {
                    final parsed = int.tryParse(v);
                    if (parsed != null && parsed >= 0) {
                      onRestChanged(parsed);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.s),
          _NotesField(
            label: l10n.routineExerciseNotes,
            hint: 'Ej: Bajar lento, subir explosivo',
            value: notes,
            onChanged: onNotesChanged,
          ),
        ],
      ),
    );
  }
}

class _NumberField extends StatefulWidget {
  final String label;
  final String value;
  final ValueChanged<String> onChanged;
  final bool decimal;

  const _NumberField({
    required this.label,
    required this.value,
    required this.onChanged,
    this.decimal = false,
  });

  @override
  State<_NumberField> createState() => _NumberFieldState();
}

class _NumberFieldState extends State<_NumberField> {
  late TextEditingController _controller;
  String _lastExternalValue = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _lastExternalValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant _NumberField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Solo actualizamos el controller si el valor externo cambió.
    if (widget.value != _lastExternalValue) {
      _lastExternalValue = widget.value;
      _controller.value = TextEditingValue(
        text: widget.value,
        selection: TextSelection.collapsed(offset: widget.value.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PesaoInput(
      label: widget.label,
      controller: _controller,
      keyboardType: TextInputType.numberWithOptions(decimal: widget.decimal),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(widget.decimal ? r'[0-9.,]' : r'[0-9]'),
        ),
      ],
      onChanged: (v) {
        _lastExternalValue = v;
        widget.onChanged(v);
      },
    );
  }
}

class _NotesField extends StatefulWidget {
  final String label;
  final String hint;
  final String? value;
  final ValueChanged<String?> onChanged;

  const _NotesField({
    required this.label,
    required this.hint,
    required this.value,
    required this.onChanged,
  });

  @override
  State<_NotesField> createState() => _NotesFieldState();
}

class _NotesFieldState extends State<_NotesField> {
  late TextEditingController _controller;
  String? _lastExternalValue;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value ?? '');
    _lastExternalValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant _NotesField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _lastExternalValue) {
      _lastExternalValue = widget.value;
      final text = widget.value ?? '';
      _controller.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PesaoInput(
      label: widget.label,
      hint: widget.hint,
      controller: _controller,
      onChanged: (v) {
        _lastExternalValue = v.isEmpty ? null : v;
        widget.onChanged(v.isEmpty ? null : v);
      },
    );
  }
}
