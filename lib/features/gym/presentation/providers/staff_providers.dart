import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/providers/database_provider.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/utils/result.dart';
import '../../data/datasources/staff_local_datasource.dart';
import '../../data/datasources/staff_remote_datasource.dart';
import '../../data/repositories/staff_repository_impl.dart';
import '../../domain/entities/staff_overview.dart';
import '../../domain/repositories/staff_repository.dart';

part 'staff_providers.g.dart';

@Riverpod(keepAlive: true)
class OwnerStaffController extends _$OwnerStaffController {
  late final StaffRepository _repository;

  @override
  Result<StaffOverview> build() {
    _repository = StaffRepositoryImpl(
      remote: StaffRemoteDatasource(Supabase.instance.client),
      local: StaffLocalDatasource(ref.watch(appDatabaseProvider)),
    );

    if (authProvider.isLoggedIn && !authProvider.isInitializing) {
      Future.microtask(load);
    }

    return const Result.idle();
  }

  Future<void> load() async {
    final gymId = authProvider.userGymId;
    debugPrint('🔍 STAFF LOAD: Intentando cargar para gymId = $gymId');

    if (gymId == null) {
      debugPrint(
        '⚠️ STAFF LOAD: gymId es null. El usuario no tiene un gimnasio asignado como owner.',
      );
      return;
    }

    state = const Result.loading();
    final result = await _repository.getStaffOverview(gymId: gymId);

    result.when(
      idle: () {},
      loading: () {},
      success: (overview) {
        debugPrint(
          '✅ STAFF LOAD: Éxito. Miembros encontrados: ${overview.members.length}',
        );
        state = Result.success(overview);
      },
      failure: (error) {
        debugPrint(
          '❌ STAFF LOAD: Fallo. Detalle del error: ${error.toString()}',
        );
        state = Result.failure(error);
      },
    );
  }

  Future<void> setStaffActive(String membershipId, bool isActive) async {
    final result = await _repository.setStaffActive(
      membershipId: membershipId,
      isActive: isActive,
    );

    result.when(
      idle: () {},
      loading: () {},
      success: (_) {
        load();
      },
      failure: (error) {
        debugPrint('❌ STAFF MUTATION: Fallo. Detalle: ${error.toString()}');
        state = Result.failure(error);
      },
    );
  }
}
