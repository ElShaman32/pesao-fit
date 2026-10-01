import 'package:drift/drift.dart';
import 'package:pesao_fit/core/database/app_database.dart';

import '../../domain/entities/staff_member.dart';

/// Fuente de datos local para staff. Usa Drift como caché offline.
class StaffLocalDatasource {
  final AppDatabase _db;

  const StaffLocalDatasource(this._db);

  /// Guarda o actualiza los miembros del staff en caché local.
  /// Usa upsert para evitar duplicados.
  Future<void> cacheStaffMembers(List<StaffMember> members) async {
    await _db.batch((batch) {
      for (final member in members) {
        batch.insert(
          _db.memberships,
          MembershipsCompanion.insert(
            id: member.id,
            userId: member.userId,
            gymId: member.gymId,
            role: member.role,
            isActive: Value(member.isActive),
          ),
          mode: InsertMode.insertOrReplace,
        );

        // También cacheamos el perfil asociado.
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

  /// Lee los miembros del staff de un gimnasio desde caché local.
  /// Hace join con profiles para traer nombre, email, avatar y teléfono.
  Future<List<StaffMember>> readStaffMembers(String gymId) async {
    final query =
        _db.select(_db.memberships).join([
            innerJoin(
              _db.profiles,
              _db.profiles.id.equalsExp(_db.memberships.userId),
            ),
          ])
          ..where(_db.memberships.gymId.equals(gymId))
          ..where(_db.memberships.role.isIn(['trainer', 'nutritionist']));

    final rows = await query.get();

    return rows.map((row) {
      final membership = row.readTable(_db.memberships);
      final profile = row.readTable(_db.profiles);
      return StaffMember(
        id: membership.id,
        userId: membership.userId,
        gymId: membership.gymId,
        role: membership.role,
        isActive: membership.isActive,
        fullName: profile.fullName,
        email: profile.email,
        avatarUrl: profile.avatarUrl,
        phone: profile.phone,
      );
    }).toList();
  }

  /// Limpia el caché de staff de un gimnasio.
  Future<void> clearStaffCache(String gymId) async {
    await (_db.delete(_db.memberships)
          ..where((m) => m.gymId.equals(gymId))
          ..where((m) => m.role.isIn(['trainer', 'nutritionist'])))
        .go();
  }
}
