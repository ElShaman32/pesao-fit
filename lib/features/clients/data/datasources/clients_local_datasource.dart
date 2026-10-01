import 'package:drift/drift.dart';
import 'package:pesao_fit/core/database/app_database.dart';

import '../../domain/entities/client_member.dart';

/// Fuente local de clientes. Drift cache.
class ClientsLocalDatasource {
  final AppDatabase _db;

  const ClientsLocalDatasource(this._db);

  /// Cachea clientes.
  Future<void> cacheClients(List<ClientMember> members) async {
    await _db.batch((batch) {
      for (final member in members) {
        batch.insert(
          _db.memberships,
          MembershipsCompanion.insert(
            id: member.id,
            userId: member.userId,
            gymId: member.gymId,
            role: 'client',
            isActive: Value(member.isActive),
            createdAt: Value(member.joinedAt),
          ),
          mode: InsertMode.insertOrReplace,
        );

        batch.insert(
          _db.profiles,
          ProfilesCompanion.insert(
            id: member.userId,
            fullName: (member.fullName),
            email: Value(member.email),
            avatarUrl: Value(member.avatarUrl),
            phone: Value(member.phone),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  /// Lee clientes del cache.
  Future<List<ClientMember>> readClients(String gymId) async {
    final query =
        _db.select(_db.memberships).join([
            innerJoin(
              _db.profiles,
              _db.profiles.id.equalsExp(_db.memberships.userId),
            ),
          ])
          ..where(_db.memberships.gymId.equals(gymId))
          ..where(_db.memberships.role.equals('client'));

    final rows = await query.get();

    return rows.map((row) {
      final membership = row.readTable(_db.memberships);
      final profile = row.readTable(_db.profiles);
      return ClientMember(
        id: membership.id,
        userId: membership.userId,
        gymId: membership.gymId,
        isActive: membership.isActive,
        fullName: profile.fullName,
        email: profile.email,
        avatarUrl: profile.avatarUrl,
        phone: profile.phone,
        joinedAt: membership.createdAt,
      );
    }).toList();
  }

  /// Lee un cliente por membership id.
  Future<ClientMember?> readClient(String membershipId) async {
    final query = _db.select(_db.memberships).join([
      innerJoin(
        _db.profiles,
        _db.profiles.id.equalsExp(_db.memberships.userId),
      ),
    ])..where(_db.memberships.id.equals(membershipId));

    final rows = await query.get();
    if (rows.isEmpty) return null;

    final row = rows.first;
    final membership = row.readTable(_db.memberships);
    final profile = row.readTable(_db.profiles);

    return ClientMember(
      id: membership.id,
      userId: membership.userId,
      gymId: membership.gymId,
      isActive: membership.isActive,
      fullName: profile.fullName,
      email: profile.email,
      avatarUrl: profile.avatarUrl,
      phone: profile.phone,
      joinedAt: membership.createdAt,
    );
  }

  /// Limpia cache de clientes.
  Future<void> clearClientsCache(String gymId) async {
    await (_db.delete(_db.memberships)
          ..where((m) => m.gymId.equals(gymId))
          ..where((m) => m.role.equals('client')))
        .go();
  }
}
