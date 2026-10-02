import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/router/route_names.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_toast.dart';
import '../providers/workout_execution_controller.dart';

/// Botón que inicia o retoma un workout y navega a la pantalla de ejecución.
class StartWorkoutButton extends ConsumerStatefulWidget {
  const StartWorkoutButton({super.key, required this.routineId});

  final String routineId;

  @override
  ConsumerState<StartWorkoutButton> createState() => _StartWorkoutButtonState();
}

class _StartWorkoutButtonState extends ConsumerState<StartWorkoutButton> {
  bool _isLoading = false;

  Future<void> _start() async {
    final l10n = AppStrings.of(context);
    final gymId = authProvider.userGymId;
    if (gymId == null) return;

    setState(() => _isLoading = true);

    final result = await ref
        .read(workoutExecutionControllerProvider.notifier)
        .startOrResume(gymId: gymId, routineId: widget.routineId);

    if (!mounted) return;
    setState(() => _isLoading = false);

    result.when(
      idle: () {},
      loading: () {},
      success: (workoutId) {
        context.pushNamed(
          RouteNames.clientWorkout,
          pathParameters: {'workoutId': workoutId},
        );
      },
      failure: (error) {
        showPesaoToast(
          context,
          message: l10n.workoutErrorTitle,
          semanticLabel: l10n.workoutErrorTitle,
          variant: PesaoToastVariant.error,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    return PesaoButton(
      label: l10n.workoutStartCta,
      variant: PesaoButtonVariant.primary,
      isExpanded: false,
      onPressed: _isLoading ? null : _start,
    );
  }
}
