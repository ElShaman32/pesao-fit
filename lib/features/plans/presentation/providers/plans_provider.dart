import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/providers/database_provider.dart';
import '../../data/datasources/plans_local_datasource.dart';
import '../../data/datasources/plans_remote_datasource.dart';
import '../../data/repositories/plans_repository_impl.dart';
import '../../domain/repositories/plans_repository.dart';

part 'plans_provider.g.dart';

@riverpod
PlansRepository plansRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  final supabase = Supabase.instance.client;

  return PlansRepositoryImpl(
    local: PlansLocalDatasource(db),
    remote: PlansRemoteDatasource(supabase),
  );
}

@riverpod
Future<List<Map<String, dynamic>>> plans(Ref ref) async {
  final repository = ref.watch(plansRepositoryProvider);
  final result = await repository.getPlans();

  return result.when(
    idle: () => [],
    loading: () => [],
    success:
        (data) =>
            data
                .map(
                  (plan) => {
                    'id': plan.id,
                    'name': plan.name,
                    'priceUsd': plan.priceUsd,
                    'maxClients': plan.maxClients,
                    'maxTrainers': plan.maxTrainers,
                  },
                )
                .toList(),
    failure: (error) => throw error,
  );
}
