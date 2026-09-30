import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/client_home_data.dart';

part 'client_home_provider.g.dart';

/// Provider del dashboard del cliente.
///
/// Notifier cuyo estado es directamente `Result<ClientHomeData>`,
///
/// /// para que la pantalla pueda usar state.when(idle/loading/success/failure).
///
/// Hoy devuelve datos simulados (FASE 0). En F2 se reemplaza la carga
/// por el caso de uso real manteniendo la misma estructura.
@riverpod
class ClientHome extends _$ClientHome {
  @override
  Result<ClientHomeData> build() {
    // Se pospone la carga para no mutar el estado durante el build.
    Future.microtask(load);
    return const Result.idle();
  }

  /// Carga los datos del dashboard.
  Future<void> load() async {
    state = const Result.loading();
    try {
      // Simulación de red (FASE 0). Se reemplaza por el usecase real en F2.
      await Future<void>.delayed(const Duration(milliseconds: 700));
      state = const Result.success(
        ClientHomeData(
          firstName: 'Leonel',
          kcalToday: 1850,
          streakDays: 12,
          nextWorkoutTitle: 'Tren superior',
          nextWorkoutWhen: 'Hoy · 6:00 PM',
          hasAssignedRoutine: true,
        ),
      );
    } on AppException catch (error) {
      state = Result.failure(error);
    } catch (error) {
      state = Result.failure(UnknownException(cause: error));
    }
  }
}
