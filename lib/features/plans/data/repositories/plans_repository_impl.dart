import 'dart:convert';

import 'package:drift/drift.dart' show Value;

import '../../../../core/database/app_database.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/repositories/plans_repository.dart';
import '../datasources/plans_local_datasource.dart';
import '../datasources/plans_remote_datasource.dart';

/// Implementación del repositorio de planes con estrategia offline-first.
/// Caché: 3 días (convenciones.md §10).
class PlansRepositoryImpl implements PlansRepository {
  final PlansLocalDatasource _local;
  final PlansRemoteDatasource _remote;
  final Duration _cacheTtl = const Duration(days: 3);

  PlansRepositoryImpl({
    required PlansLocalDatasource local,
    required PlansRemoteDatasource remote,
  }) : _local = local,
       _remote = remote;

  @override
  Future<Result<List<Plan>>> getPlans({bool forceRefresh = false}) async {
    try {
      // 1. Intentar leer de caché primero
      if (!forceRefresh) {
        final cached = await _local.getPlans();
        if (cached.isNotEmpty && !_isCacheExpired(cached.first.createdAt)) {
          return Result.success(cached);
        }
      }

      // 2. Caché vacío o vencido: bajar de red
      final remoteData = await _remote.fetchPlans();
      final companions =
          remoteData
              .map(
                (json) => PlansCompanion.insert(
                  id: json['id'] as String,
                  name: json['name'] as String,
                  priceUsd: (json['price_usd'] as num).toDouble(),
                  maxClients: json['max_clients'] as int,
                  maxTrainers: json['max_trainers'] as int,
                  features: Value(jsonEncode(json['features'] ?? {})),
                ),
              )
              .toList();

      await _local.savePlans(companions);

      // 3. Leer de caché recién guardado
      final freshData = await _local.getPlans();
      return Result.success(freshData);
    } catch (e) {
      // Si falla la red, intentar caché aunque esté vencido
      try {
        final stale = await _local.getPlans();
        if (stale.isNotEmpty) {
          return Result.success(stale);
        }
      } catch (_) {}

      return Result.failure(
        NetworkException(
          code: 'plans/fetch-error',
          message: 'Error al obtener planes desde la red',
          cause: e,
        ),
      );
    }
  }

  bool _isCacheExpired(DateTime createdAt) {
    return DateTime.now().difference(createdAt) > _cacheTtl;
  }
}
