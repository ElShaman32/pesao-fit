// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProfilesTable extends Profiles with TableInfo<$ProfilesTable, Profile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta(
    'avatarUrl',
  );
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    email,
    fullName,
    phone,
    avatarUrl,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Profile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Profile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Profile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }
}

class Profile extends DataClass implements Insertable<Profile> {
  final String id;
  final String? email;
  final String fullName;
  final String? phone;
  final String? avatarUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Profile({
    required this.id,
    this.email,
    required this.fullName,
    this.phone,
    this.avatarUrl,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      fullName: Value(fullName),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Profile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Profile(
      id: serializer.fromJson<String>(json['id']),
      email: serializer.fromJson<String?>(json['email']),
      fullName: serializer.fromJson<String>(json['fullName']),
      phone: serializer.fromJson<String?>(json['phone']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'email': serializer.toJson<String?>(email),
      'fullName': serializer.toJson<String>(fullName),
      'phone': serializer.toJson<String?>(phone),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Profile copyWith({
    String? id,
    Value<String?> email = const Value.absent(),
    String? fullName,
    Value<String?> phone = const Value.absent(),
    Value<String?> avatarUrl = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Profile(
    id: id ?? this.id,
    email: email.present ? email.value : this.email,
    fullName: fullName ?? this.fullName,
    phone: phone.present ? phone.value : this.phone,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Profile copyWithCompanion(ProfilesCompanion data) {
    return Profile(
      id: data.id.present ? data.id.value : this.id,
      email: data.email.present ? data.email.value : this.email,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      phone: data.phone.present ? data.phone.value : this.phone,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Profile(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('fullName: $fullName, ')
          ..write('phone: $phone, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, email, fullName, phone, avatarUrl, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Profile &&
          other.id == this.id &&
          other.email == this.email &&
          other.fullName == this.fullName &&
          other.phone == this.phone &&
          other.avatarUrl == this.avatarUrl &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProfilesCompanion extends UpdateCompanion<Profile> {
  final Value<String> id;
  final Value<String?> email;
  final Value<String> fullName;
  final Value<String?> phone;
  final Value<String?> avatarUrl;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.fullName = const Value.absent(),
    this.phone = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfilesCompanion.insert({
    required String id,
    this.email = const Value.absent(),
    required String fullName,
    this.phone = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fullName = Value(fullName);
  static Insertable<Profile> custom({
    Expression<String>? id,
    Expression<String>? email,
    Expression<String>? fullName,
    Expression<String>? phone,
    Expression<String>? avatarUrl,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (fullName != null) 'full_name': fullName,
      if (phone != null) 'phone': phone,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfilesCompanion copyWith({
    Value<String>? id,
    Value<String?>? email,
    Value<String>? fullName,
    Value<String?>? phone,
    Value<String?>? avatarUrl,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ProfilesCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('fullName: $fullName, ')
          ..write('phone: $phone, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GymsTable extends Gyms with TableInfo<$GymsTable, Gym> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GymsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _logoUrlMeta = const VerificationMeta(
    'logoUrl',
  );
  @override
  late final GeneratedColumn<String> logoUrl = GeneratedColumn<String>(
    'logo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timezoneMeta = const VerificationMeta(
    'timezone',
  );
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
    'timezone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('America/Caracas'),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    slug,
    logoUrl,
    timezone,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gyms';
  @override
  VerificationContext validateIntegrity(
    Insertable<Gym> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('logo_url')) {
      context.handle(
        _logoUrlMeta,
        logoUrl.isAcceptableOrUnknown(data['logo_url']!, _logoUrlMeta),
      );
    }
    if (data.containsKey('timezone')) {
      context.handle(
        _timezoneMeta,
        timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Gym map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Gym(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      logoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_url'],
      ),
      timezone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timezone'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $GymsTable createAlias(String alias) {
    return $GymsTable(attachedDatabase, alias);
  }
}

class Gym extends DataClass implements Insertable<Gym> {
  final String id;
  final String name;
  final String slug;
  final String? logoUrl;
  final String timezone;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Gym({
    required this.id,
    required this.name,
    required this.slug,
    this.logoUrl,
    required this.timezone,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['slug'] = Variable<String>(slug);
    if (!nullToAbsent || logoUrl != null) {
      map['logo_url'] = Variable<String>(logoUrl);
    }
    map['timezone'] = Variable<String>(timezone);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  GymsCompanion toCompanion(bool nullToAbsent) {
    return GymsCompanion(
      id: Value(id),
      name: Value(name),
      slug: Value(slug),
      logoUrl: logoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(logoUrl),
      timezone: Value(timezone),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Gym.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Gym(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      slug: serializer.fromJson<String>(json['slug']),
      logoUrl: serializer.fromJson<String?>(json['logoUrl']),
      timezone: serializer.fromJson<String>(json['timezone']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'slug': serializer.toJson<String>(slug),
      'logoUrl': serializer.toJson<String?>(logoUrl),
      'timezone': serializer.toJson<String>(timezone),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Gym copyWith({
    String? id,
    String? name,
    String? slug,
    Value<String?> logoUrl = const Value.absent(),
    String? timezone,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Gym(
    id: id ?? this.id,
    name: name ?? this.name,
    slug: slug ?? this.slug,
    logoUrl: logoUrl.present ? logoUrl.value : this.logoUrl,
    timezone: timezone ?? this.timezone,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Gym copyWithCompanion(GymsCompanion data) {
    return Gym(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      slug: data.slug.present ? data.slug.value : this.slug,
      logoUrl: data.logoUrl.present ? data.logoUrl.value : this.logoUrl,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Gym(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('timezone: $timezone, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    slug,
    logoUrl,
    timezone,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Gym &&
          other.id == this.id &&
          other.name == this.name &&
          other.slug == this.slug &&
          other.logoUrl == this.logoUrl &&
          other.timezone == this.timezone &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class GymsCompanion extends UpdateCompanion<Gym> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> slug;
  final Value<String?> logoUrl;
  final Value<String> timezone;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const GymsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.slug = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.timezone = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GymsCompanion.insert({
    required String id,
    required String name,
    required String slug,
    this.logoUrl = const Value.absent(),
    this.timezone = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       slug = Value(slug);
  static Insertable<Gym> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? slug,
    Expression<String>? logoUrl,
    Expression<String>? timezone,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (slug != null) 'slug': slug,
      if (logoUrl != null) 'logo_url': logoUrl,
      if (timezone != null) 'timezone': timezone,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GymsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? slug,
    Value<String?>? logoUrl,
    Value<String>? timezone,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return GymsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      logoUrl: logoUrl ?? this.logoUrl,
      timezone: timezone ?? this.timezone,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (logoUrl.present) {
      map['logo_url'] = Variable<String>(logoUrl.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GymsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('timezone: $timezone, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MembershipsTable extends Memberships
    with TableInfo<$MembershipsTable, Membership> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MembershipsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gymIdMeta = const VerificationMeta('gymId');
  @override
  late final GeneratedColumn<String> gymId = GeneratedColumn<String>(
    'gym_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    gymId,
    role,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'memberships';
  @override
  VerificationContext validateIntegrity(
    Insertable<Membership> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('gym_id')) {
      context.handle(
        _gymIdMeta,
        gymId.isAcceptableOrUnknown(data['gym_id']!, _gymIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gymIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Membership map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Membership(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      gymId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gym_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MembershipsTable createAlias(String alias) {
    return $MembershipsTable(attachedDatabase, alias);
  }
}

class Membership extends DataClass implements Insertable<Membership> {
  final String id;
  final String userId;
  final String gymId;
  final String role;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Membership({
    required this.id,
    required this.userId,
    required this.gymId,
    required this.role,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['gym_id'] = Variable<String>(gymId);
    map['role'] = Variable<String>(role);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MembershipsCompanion toCompanion(bool nullToAbsent) {
    return MembershipsCompanion(
      id: Value(id),
      userId: Value(userId),
      gymId: Value(gymId),
      role: Value(role),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Membership.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Membership(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      gymId: serializer.fromJson<String>(json['gymId']),
      role: serializer.fromJson<String>(json['role']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'gymId': serializer.toJson<String>(gymId),
      'role': serializer.toJson<String>(role),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Membership copyWith({
    String? id,
    String? userId,
    String? gymId,
    String? role,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Membership(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    gymId: gymId ?? this.gymId,
    role: role ?? this.role,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Membership copyWithCompanion(MembershipsCompanion data) {
    return Membership(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      gymId: data.gymId.present ? data.gymId.value : this.gymId,
      role: data.role.present ? data.role.value : this.role,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Membership(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('gymId: $gymId, ')
          ..write('role: $role, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, gymId, role, isActive, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Membership &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.gymId == this.gymId &&
          other.role == this.role &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MembershipsCompanion extends UpdateCompanion<Membership> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> gymId;
  final Value<String> role;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MembershipsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.gymId = const Value.absent(),
    this.role = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MembershipsCompanion.insert({
    required String id,
    required String userId,
    required String gymId,
    required String role,
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       gymId = Value(gymId),
       role = Value(role);
  static Insertable<Membership> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? gymId,
    Expression<String>? role,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (gymId != null) 'gym_id': gymId,
      if (role != null) 'role': role,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MembershipsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? gymId,
    Value<String>? role,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MembershipsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      gymId: gymId ?? this.gymId,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (gymId.present) {
      map['gym_id'] = Variable<String>(gymId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MembershipsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('gymId: $gymId, ')
          ..write('role: $role, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlansTable extends Plans with TableInfo<$PlansTable, Plan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceUsdMeta = const VerificationMeta(
    'priceUsd',
  );
  @override
  late final GeneratedColumn<double> priceUsd = GeneratedColumn<double>(
    'price_usd',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxClientsMeta = const VerificationMeta(
    'maxClients',
  );
  @override
  late final GeneratedColumn<int> maxClients = GeneratedColumn<int>(
    'max_clients',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxTrainersMeta = const VerificationMeta(
    'maxTrainers',
  );
  @override
  late final GeneratedColumn<int> maxTrainers = GeneratedColumn<int>(
    'max_trainers',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxStaffMeta = const VerificationMeta(
    'maxStaff',
  );
  @override
  late final GeneratedColumn<int> maxStaff = GeneratedColumn<int>(
    'max_staff',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _featuresMeta = const VerificationMeta(
    'features',
  );
  @override
  late final GeneratedColumn<String> features = GeneratedColumn<String>(
    'features',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    priceUsd,
    maxClients,
    maxTrainers,
    maxStaff,
    features,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<Plan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price_usd')) {
      context.handle(
        _priceUsdMeta,
        priceUsd.isAcceptableOrUnknown(data['price_usd']!, _priceUsdMeta),
      );
    } else if (isInserting) {
      context.missing(_priceUsdMeta);
    }
    if (data.containsKey('max_clients')) {
      context.handle(
        _maxClientsMeta,
        maxClients.isAcceptableOrUnknown(data['max_clients']!, _maxClientsMeta),
      );
    } else if (isInserting) {
      context.missing(_maxClientsMeta);
    }
    if (data.containsKey('max_trainers')) {
      context.handle(
        _maxTrainersMeta,
        maxTrainers.isAcceptableOrUnknown(
          data['max_trainers']!,
          _maxTrainersMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maxTrainersMeta);
    }
    if (data.containsKey('max_staff')) {
      context.handle(
        _maxStaffMeta,
        maxStaff.isAcceptableOrUnknown(data['max_staff']!, _maxStaffMeta),
      );
    }
    if (data.containsKey('features')) {
      context.handle(
        _featuresMeta,
        features.isAcceptableOrUnknown(data['features']!, _featuresMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Plan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Plan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      priceUsd: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_usd'],
      )!,
      maxClients: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_clients'],
      )!,
      maxTrainers: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_trainers'],
      )!,
      maxStaff: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_staff'],
      ),
      features: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}features'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PlansTable createAlias(String alias) {
    return $PlansTable(attachedDatabase, alias);
  }
}

class Plan extends DataClass implements Insertable<Plan> {
  final String id;
  final String name;
  final double priceUsd;
  final int maxClients;
  final int maxTrainers;
  final int? maxStaff;
  final String features;
  final DateTime createdAt;
  const Plan({
    required this.id,
    required this.name,
    required this.priceUsd,
    required this.maxClients,
    required this.maxTrainers,
    this.maxStaff,
    required this.features,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['price_usd'] = Variable<double>(priceUsd);
    map['max_clients'] = Variable<int>(maxClients);
    map['max_trainers'] = Variable<int>(maxTrainers);
    if (!nullToAbsent || maxStaff != null) {
      map['max_staff'] = Variable<int>(maxStaff);
    }
    map['features'] = Variable<String>(features);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PlansCompanion toCompanion(bool nullToAbsent) {
    return PlansCompanion(
      id: Value(id),
      name: Value(name),
      priceUsd: Value(priceUsd),
      maxClients: Value(maxClients),
      maxTrainers: Value(maxTrainers),
      maxStaff: maxStaff == null && nullToAbsent
          ? const Value.absent()
          : Value(maxStaff),
      features: Value(features),
      createdAt: Value(createdAt),
    );
  }

  factory Plan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Plan(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      priceUsd: serializer.fromJson<double>(json['priceUsd']),
      maxClients: serializer.fromJson<int>(json['maxClients']),
      maxTrainers: serializer.fromJson<int>(json['maxTrainers']),
      maxStaff: serializer.fromJson<int?>(json['maxStaff']),
      features: serializer.fromJson<String>(json['features']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'priceUsd': serializer.toJson<double>(priceUsd),
      'maxClients': serializer.toJson<int>(maxClients),
      'maxTrainers': serializer.toJson<int>(maxTrainers),
      'maxStaff': serializer.toJson<int?>(maxStaff),
      'features': serializer.toJson<String>(features),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Plan copyWith({
    String? id,
    String? name,
    double? priceUsd,
    int? maxClients,
    int? maxTrainers,
    Value<int?> maxStaff = const Value.absent(),
    String? features,
    DateTime? createdAt,
  }) => Plan(
    id: id ?? this.id,
    name: name ?? this.name,
    priceUsd: priceUsd ?? this.priceUsd,
    maxClients: maxClients ?? this.maxClients,
    maxTrainers: maxTrainers ?? this.maxTrainers,
    maxStaff: maxStaff.present ? maxStaff.value : this.maxStaff,
    features: features ?? this.features,
    createdAt: createdAt ?? this.createdAt,
  );
  Plan copyWithCompanion(PlansCompanion data) {
    return Plan(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      priceUsd: data.priceUsd.present ? data.priceUsd.value : this.priceUsd,
      maxClients: data.maxClients.present
          ? data.maxClients.value
          : this.maxClients,
      maxTrainers: data.maxTrainers.present
          ? data.maxTrainers.value
          : this.maxTrainers,
      maxStaff: data.maxStaff.present ? data.maxStaff.value : this.maxStaff,
      features: data.features.present ? data.features.value : this.features,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Plan(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('priceUsd: $priceUsd, ')
          ..write('maxClients: $maxClients, ')
          ..write('maxTrainers: $maxTrainers, ')
          ..write('maxStaff: $maxStaff, ')
          ..write('features: $features, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    priceUsd,
    maxClients,
    maxTrainers,
    maxStaff,
    features,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Plan &&
          other.id == this.id &&
          other.name == this.name &&
          other.priceUsd == this.priceUsd &&
          other.maxClients == this.maxClients &&
          other.maxTrainers == this.maxTrainers &&
          other.maxStaff == this.maxStaff &&
          other.features == this.features &&
          other.createdAt == this.createdAt);
}

class PlansCompanion extends UpdateCompanion<Plan> {
  final Value<String> id;
  final Value<String> name;
  final Value<double> priceUsd;
  final Value<int> maxClients;
  final Value<int> maxTrainers;
  final Value<int?> maxStaff;
  final Value<String> features;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PlansCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.priceUsd = const Value.absent(),
    this.maxClients = const Value.absent(),
    this.maxTrainers = const Value.absent(),
    this.maxStaff = const Value.absent(),
    this.features = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlansCompanion.insert({
    required String id,
    required String name,
    required double priceUsd,
    required int maxClients,
    required int maxTrainers,
    this.maxStaff = const Value.absent(),
    this.features = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       priceUsd = Value(priceUsd),
       maxClients = Value(maxClients),
       maxTrainers = Value(maxTrainers);
  static Insertable<Plan> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<double>? priceUsd,
    Expression<int>? maxClients,
    Expression<int>? maxTrainers,
    Expression<int>? maxStaff,
    Expression<String>? features,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (priceUsd != null) 'price_usd': priceUsd,
      if (maxClients != null) 'max_clients': maxClients,
      if (maxTrainers != null) 'max_trainers': maxTrainers,
      if (maxStaff != null) 'max_staff': maxStaff,
      if (features != null) 'features': features,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlansCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<double>? priceUsd,
    Value<int>? maxClients,
    Value<int>? maxTrainers,
    Value<int?>? maxStaff,
    Value<String>? features,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PlansCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      priceUsd: priceUsd ?? this.priceUsd,
      maxClients: maxClients ?? this.maxClients,
      maxTrainers: maxTrainers ?? this.maxTrainers,
      maxStaff: maxStaff ?? this.maxStaff,
      features: features ?? this.features,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (priceUsd.present) {
      map['price_usd'] = Variable<double>(priceUsd.value);
    }
    if (maxClients.present) {
      map['max_clients'] = Variable<int>(maxClients.value);
    }
    if (maxTrainers.present) {
      map['max_trainers'] = Variable<int>(maxTrainers.value);
    }
    if (maxStaff.present) {
      map['max_staff'] = Variable<int>(maxStaff.value);
    }
    if (features.present) {
      map['features'] = Variable<String>(features.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlansCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('priceUsd: $priceUsd, ')
          ..write('maxClients: $maxClients, ')
          ..write('maxTrainers: $maxTrainers, ')
          ..write('maxStaff: $maxStaff, ')
          ..write('features: $features, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SubscriptionsTable extends Subscriptions
    with TableInfo<$SubscriptionsTable, Subscription> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubscriptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gymIdMeta = const VerificationMeta('gymId');
  @override
  late final GeneratedColumn<String> gymId = GeneratedColumn<String>(
    'gym_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gymId,
    planId,
    status,
    expiresAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subscriptions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Subscription> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('gym_id')) {
      context.handle(
        _gymIdMeta,
        gymId.isAcceptableOrUnknown(data['gym_id']!, _gymIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gymIdMeta);
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subscription map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subscription(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      gymId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gym_id'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SubscriptionsTable createAlias(String alias) {
    return $SubscriptionsTable(attachedDatabase, alias);
  }
}

class Subscription extends DataClass implements Insertable<Subscription> {
  final String id;
  final String gymId;
  final String planId;
  final String status;
  final DateTime expiresAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Subscription({
    required this.id,
    required this.gymId,
    required this.planId,
    required this.status,
    required this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['gym_id'] = Variable<String>(gymId);
    map['plan_id'] = Variable<String>(planId);
    map['status'] = Variable<String>(status);
    map['expires_at'] = Variable<DateTime>(expiresAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SubscriptionsCompanion toCompanion(bool nullToAbsent) {
    return SubscriptionsCompanion(
      id: Value(id),
      gymId: Value(gymId),
      planId: Value(planId),
      status: Value(status),
      expiresAt: Value(expiresAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Subscription.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subscription(
      id: serializer.fromJson<String>(json['id']),
      gymId: serializer.fromJson<String>(json['gymId']),
      planId: serializer.fromJson<String>(json['planId']),
      status: serializer.fromJson<String>(json['status']),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'gymId': serializer.toJson<String>(gymId),
      'planId': serializer.toJson<String>(planId),
      'status': serializer.toJson<String>(status),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Subscription copyWith({
    String? id,
    String? gymId,
    String? planId,
    String? status,
    DateTime? expiresAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Subscription(
    id: id ?? this.id,
    gymId: gymId ?? this.gymId,
    planId: planId ?? this.planId,
    status: status ?? this.status,
    expiresAt: expiresAt ?? this.expiresAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Subscription copyWithCompanion(SubscriptionsCompanion data) {
    return Subscription(
      id: data.id.present ? data.id.value : this.id,
      gymId: data.gymId.present ? data.gymId.value : this.gymId,
      planId: data.planId.present ? data.planId.value : this.planId,
      status: data.status.present ? data.status.value : this.status,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Subscription(')
          ..write('id: $id, ')
          ..write('gymId: $gymId, ')
          ..write('planId: $planId, ')
          ..write('status: $status, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, gymId, planId, status, expiresAt, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subscription &&
          other.id == this.id &&
          other.gymId == this.gymId &&
          other.planId == this.planId &&
          other.status == this.status &&
          other.expiresAt == this.expiresAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SubscriptionsCompanion extends UpdateCompanion<Subscription> {
  final Value<String> id;
  final Value<String> gymId;
  final Value<String> planId;
  final Value<String> status;
  final Value<DateTime> expiresAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SubscriptionsCompanion({
    this.id = const Value.absent(),
    this.gymId = const Value.absent(),
    this.planId = const Value.absent(),
    this.status = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SubscriptionsCompanion.insert({
    required String id,
    required String gymId,
    required String planId,
    required String status,
    required DateTime expiresAt,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       gymId = Value(gymId),
       planId = Value(planId),
       status = Value(status),
       expiresAt = Value(expiresAt);
  static Insertable<Subscription> custom({
    Expression<String>? id,
    Expression<String>? gymId,
    Expression<String>? planId,
    Expression<String>? status,
    Expression<DateTime>? expiresAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gymId != null) 'gym_id': gymId,
      if (planId != null) 'plan_id': planId,
      if (status != null) 'status': status,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SubscriptionsCompanion copyWith({
    Value<String>? id,
    Value<String>? gymId,
    Value<String>? planId,
    Value<String>? status,
    Value<DateTime>? expiresAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SubscriptionsCompanion(
      id: id ?? this.id,
      gymId: gymId ?? this.gymId,
      planId: planId ?? this.planId,
      status: status ?? this.status,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (gymId.present) {
      map['gym_id'] = Variable<String>(gymId.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<String>(planId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubscriptionsCompanion(')
          ..write('id: $id, ')
          ..write('gymId: $gymId, ')
          ..write('planId: $planId, ')
          ..write('status: $status, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExercisesTable extends Exercises
    with TableInfo<$ExercisesTable, Exercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _videoUrlMeta = const VerificationMeta(
    'videoUrl',
  );
  @override
  late final GeneratedColumn<String> videoUrl = GeneratedColumn<String>(
    'video_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isGlobalMeta = const VerificationMeta(
    'isGlobal',
  );
  @override
  late final GeneratedColumn<bool> isGlobal = GeneratedColumn<bool>(
    'is_global',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_global" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sourceGymIdMeta = const VerificationMeta(
    'sourceGymId',
  );
  @override
  late final GeneratedColumn<String> sourceGymId = GeneratedColumn<String>(
    'source_gym_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    videoUrl,
    isGlobal,
    sourceGymId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<Exercise> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('video_url')) {
      context.handle(
        _videoUrlMeta,
        videoUrl.isAcceptableOrUnknown(data['video_url']!, _videoUrlMeta),
      );
    }
    if (data.containsKey('is_global')) {
      context.handle(
        _isGlobalMeta,
        isGlobal.isAcceptableOrUnknown(data['is_global']!, _isGlobalMeta),
      );
    }
    if (data.containsKey('source_gym_id')) {
      context.handle(
        _sourceGymIdMeta,
        sourceGymId.isAcceptableOrUnknown(
          data['source_gym_id']!,
          _sourceGymIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Exercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Exercise(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      videoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}video_url'],
      ),
      isGlobal: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_global'],
      )!,
      sourceGymId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_gym_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ExercisesTable createAlias(String alias) {
    return $ExercisesTable(attachedDatabase, alias);
  }
}

class Exercise extends DataClass implements Insertable<Exercise> {
  final String id;
  final String name;
  final String? description;
  final String? videoUrl;
  final bool isGlobal;
  final String? sourceGymId;
  final DateTime createdAt;
  const Exercise({
    required this.id,
    required this.name,
    this.description,
    this.videoUrl,
    required this.isGlobal,
    this.sourceGymId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || videoUrl != null) {
      map['video_url'] = Variable<String>(videoUrl);
    }
    map['is_global'] = Variable<bool>(isGlobal);
    if (!nullToAbsent || sourceGymId != null) {
      map['source_gym_id'] = Variable<String>(sourceGymId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExercisesCompanion toCompanion(bool nullToAbsent) {
    return ExercisesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      videoUrl: videoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(videoUrl),
      isGlobal: Value(isGlobal),
      sourceGymId: sourceGymId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceGymId),
      createdAt: Value(createdAt),
    );
  }

  factory Exercise.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Exercise(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      videoUrl: serializer.fromJson<String?>(json['videoUrl']),
      isGlobal: serializer.fromJson<bool>(json['isGlobal']),
      sourceGymId: serializer.fromJson<String?>(json['sourceGymId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'videoUrl': serializer.toJson<String?>(videoUrl),
      'isGlobal': serializer.toJson<bool>(isGlobal),
      'sourceGymId': serializer.toJson<String?>(sourceGymId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Exercise copyWith({
    String? id,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> videoUrl = const Value.absent(),
    bool? isGlobal,
    Value<String?> sourceGymId = const Value.absent(),
    DateTime? createdAt,
  }) => Exercise(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    videoUrl: videoUrl.present ? videoUrl.value : this.videoUrl,
    isGlobal: isGlobal ?? this.isGlobal,
    sourceGymId: sourceGymId.present ? sourceGymId.value : this.sourceGymId,
    createdAt: createdAt ?? this.createdAt,
  );
  Exercise copyWithCompanion(ExercisesCompanion data) {
    return Exercise(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      videoUrl: data.videoUrl.present ? data.videoUrl.value : this.videoUrl,
      isGlobal: data.isGlobal.present ? data.isGlobal.value : this.isGlobal,
      sourceGymId: data.sourceGymId.present
          ? data.sourceGymId.value
          : this.sourceGymId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Exercise(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('videoUrl: $videoUrl, ')
          ..write('isGlobal: $isGlobal, ')
          ..write('sourceGymId: $sourceGymId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    videoUrl,
    isGlobal,
    sourceGymId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Exercise &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.videoUrl == this.videoUrl &&
          other.isGlobal == this.isGlobal &&
          other.sourceGymId == this.sourceGymId &&
          other.createdAt == this.createdAt);
}

class ExercisesCompanion extends UpdateCompanion<Exercise> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> videoUrl;
  final Value<bool> isGlobal;
  final Value<String?> sourceGymId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.videoUrl = const Value.absent(),
    this.isGlobal = const Value.absent(),
    this.sourceGymId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExercisesCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.videoUrl = const Value.absent(),
    this.isGlobal = const Value.absent(),
    this.sourceGymId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<Exercise> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? videoUrl,
    Expression<bool>? isGlobal,
    Expression<String>? sourceGymId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (videoUrl != null) 'video_url': videoUrl,
      if (isGlobal != null) 'is_global': isGlobal,
      if (sourceGymId != null) 'source_gym_id': sourceGymId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExercisesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? videoUrl,
    Value<bool>? isGlobal,
    Value<String?>? sourceGymId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ExercisesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      videoUrl: videoUrl ?? this.videoUrl,
      isGlobal: isGlobal ?? this.isGlobal,
      sourceGymId: sourceGymId ?? this.sourceGymId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (videoUrl.present) {
      map['video_url'] = Variable<String>(videoUrl.value);
    }
    if (isGlobal.present) {
      map['is_global'] = Variable<bool>(isGlobal.value);
    }
    if (sourceGymId.present) {
      map['source_gym_id'] = Variable<String>(sourceGymId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('videoUrl: $videoUrl, ')
          ..write('isGlobal: $isGlobal, ')
          ..write('sourceGymId: $sourceGymId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RoutinesTable extends Routines with TableInfo<$RoutinesTable, Routine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gymIdMeta = const VerificationMeta('gymId');
  @override
  late final GeneratedColumn<String> gymId = GeneratedColumn<String>(
    'gym_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _trainerIdMeta = const VerificationMeta(
    'trainerId',
  );
  @override
  late final GeneratedColumn<String> trainerId = GeneratedColumn<String>(
    'trainer_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gymId,
    clientId,
    trainerId,
    name,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routines';
  @override
  VerificationContext validateIntegrity(
    Insertable<Routine> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('gym_id')) {
      context.handle(
        _gymIdMeta,
        gymId.isAcceptableOrUnknown(data['gym_id']!, _gymIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gymIdMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('trainer_id')) {
      context.handle(
        _trainerIdMeta,
        trainerId.isAcceptableOrUnknown(data['trainer_id']!, _trainerIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Routine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Routine(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      gymId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gym_id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      trainerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trainer_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RoutinesTable createAlias(String alias) {
    return $RoutinesTable(attachedDatabase, alias);
  }
}

class Routine extends DataClass implements Insertable<Routine> {
  final String id;
  final String gymId;
  final String clientId;
  final String? trainerId;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Routine({
    required this.id,
    required this.gymId,
    required this.clientId,
    this.trainerId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['gym_id'] = Variable<String>(gymId);
    map['client_id'] = Variable<String>(clientId);
    if (!nullToAbsent || trainerId != null) {
      map['trainer_id'] = Variable<String>(trainerId);
    }
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RoutinesCompanion toCompanion(bool nullToAbsent) {
    return RoutinesCompanion(
      id: Value(id),
      gymId: Value(gymId),
      clientId: Value(clientId),
      trainerId: trainerId == null && nullToAbsent
          ? const Value.absent()
          : Value(trainerId),
      name: Value(name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Routine.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Routine(
      id: serializer.fromJson<String>(json['id']),
      gymId: serializer.fromJson<String>(json['gymId']),
      clientId: serializer.fromJson<String>(json['clientId']),
      trainerId: serializer.fromJson<String?>(json['trainerId']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'gymId': serializer.toJson<String>(gymId),
      'clientId': serializer.toJson<String>(clientId),
      'trainerId': serializer.toJson<String?>(trainerId),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Routine copyWith({
    String? id,
    String? gymId,
    String? clientId,
    Value<String?> trainerId = const Value.absent(),
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Routine(
    id: id ?? this.id,
    gymId: gymId ?? this.gymId,
    clientId: clientId ?? this.clientId,
    trainerId: trainerId.present ? trainerId.value : this.trainerId,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Routine copyWithCompanion(RoutinesCompanion data) {
    return Routine(
      id: data.id.present ? data.id.value : this.id,
      gymId: data.gymId.present ? data.gymId.value : this.gymId,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      trainerId: data.trainerId.present ? data.trainerId.value : this.trainerId,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Routine(')
          ..write('id: $id, ')
          ..write('gymId: $gymId, ')
          ..write('clientId: $clientId, ')
          ..write('trainerId: $trainerId, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, gymId, clientId, trainerId, name, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Routine &&
          other.id == this.id &&
          other.gymId == this.gymId &&
          other.clientId == this.clientId &&
          other.trainerId == this.trainerId &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RoutinesCompanion extends UpdateCompanion<Routine> {
  final Value<String> id;
  final Value<String> gymId;
  final Value<String> clientId;
  final Value<String?> trainerId;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const RoutinesCompanion({
    this.id = const Value.absent(),
    this.gymId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.trainerId = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoutinesCompanion.insert({
    required String id,
    required String gymId,
    required String clientId,
    this.trainerId = const Value.absent(),
    required String name,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       gymId = Value(gymId),
       clientId = Value(clientId),
       name = Value(name);
  static Insertable<Routine> custom({
    Expression<String>? id,
    Expression<String>? gymId,
    Expression<String>? clientId,
    Expression<String>? trainerId,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gymId != null) 'gym_id': gymId,
      if (clientId != null) 'client_id': clientId,
      if (trainerId != null) 'trainer_id': trainerId,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoutinesCompanion copyWith({
    Value<String>? id,
    Value<String>? gymId,
    Value<String>? clientId,
    Value<String?>? trainerId,
    Value<String>? name,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return RoutinesCompanion(
      id: id ?? this.id,
      gymId: gymId ?? this.gymId,
      clientId: clientId ?? this.clientId,
      trainerId: trainerId ?? this.trainerId,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (gymId.present) {
      map['gym_id'] = Variable<String>(gymId.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (trainerId.present) {
      map['trainer_id'] = Variable<String>(trainerId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutinesCompanion(')
          ..write('id: $id, ')
          ..write('gymId: $gymId, ')
          ..write('clientId: $clientId, ')
          ..write('trainerId: $trainerId, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RoutineExercisesTable extends RoutineExercises
    with TableInfo<$RoutineExercisesTable, RoutineExercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutineExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _routineIdMeta = const VerificationMeta(
    'routineId',
  );
  @override
  late final GeneratedColumn<String> routineId = GeneratedColumn<String>(
    'routine_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _setsMeta = const VerificationMeta('sets');
  @override
  late final GeneratedColumn<int> sets = GeneratedColumn<int>(
    'sets',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _restSecondsMeta = const VerificationMeta(
    'restSeconds',
  );
  @override
  late final GeneratedColumn<int> restSeconds = GeneratedColumn<int>(
    'rest_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(60),
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    routineId,
    exerciseId,
    sets,
    reps,
    weightKg,
    restSeconds,
    orderIndex,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routine_exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoutineExercise> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('routine_id')) {
      context.handle(
        _routineIdMeta,
        routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_routineIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('sets')) {
      context.handle(
        _setsMeta,
        sets.isAcceptableOrUnknown(data['sets']!, _setsMeta),
      );
    } else if (isInserting) {
      context.missing(_setsMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('rest_seconds')) {
      context.handle(
        _restSecondsMeta,
        restSeconds.isAcceptableOrUnknown(
          data['rest_seconds']!,
          _restSecondsMeta,
        ),
      );
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutineExercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutineExercise(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      routineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}routine_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      sets: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sets'],
      )!,
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      ),
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      ),
      restSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rest_seconds'],
      )!,
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $RoutineExercisesTable createAlias(String alias) {
    return $RoutineExercisesTable(attachedDatabase, alias);
  }
}

class RoutineExercise extends DataClass implements Insertable<RoutineExercise> {
  final String id;
  final String routineId;
  final String exerciseId;
  final int sets;
  final int? reps;
  final double? weightKg;
  final int restSeconds;
  final int orderIndex;
  final String? notes;
  const RoutineExercise({
    required this.id,
    required this.routineId,
    required this.exerciseId,
    required this.sets,
    this.reps,
    this.weightKg,
    required this.restSeconds,
    required this.orderIndex,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['routine_id'] = Variable<String>(routineId);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['sets'] = Variable<int>(sets);
    if (!nullToAbsent || reps != null) {
      map['reps'] = Variable<int>(reps);
    }
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    map['rest_seconds'] = Variable<int>(restSeconds);
    map['order_index'] = Variable<int>(orderIndex);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  RoutineExercisesCompanion toCompanion(bool nullToAbsent) {
    return RoutineExercisesCompanion(
      id: Value(id),
      routineId: Value(routineId),
      exerciseId: Value(exerciseId),
      sets: Value(sets),
      reps: reps == null && nullToAbsent ? const Value.absent() : Value(reps),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      restSeconds: Value(restSeconds),
      orderIndex: Value(orderIndex),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory RoutineExercise.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutineExercise(
      id: serializer.fromJson<String>(json['id']),
      routineId: serializer.fromJson<String>(json['routineId']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      sets: serializer.fromJson<int>(json['sets']),
      reps: serializer.fromJson<int?>(json['reps']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      restSeconds: serializer.fromJson<int>(json['restSeconds']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'routineId': serializer.toJson<String>(routineId),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'sets': serializer.toJson<int>(sets),
      'reps': serializer.toJson<int?>(reps),
      'weightKg': serializer.toJson<double?>(weightKg),
      'restSeconds': serializer.toJson<int>(restSeconds),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  RoutineExercise copyWith({
    String? id,
    String? routineId,
    String? exerciseId,
    int? sets,
    Value<int?> reps = const Value.absent(),
    Value<double?> weightKg = const Value.absent(),
    int? restSeconds,
    int? orderIndex,
    Value<String?> notes = const Value.absent(),
  }) => RoutineExercise(
    id: id ?? this.id,
    routineId: routineId ?? this.routineId,
    exerciseId: exerciseId ?? this.exerciseId,
    sets: sets ?? this.sets,
    reps: reps.present ? reps.value : this.reps,
    weightKg: weightKg.present ? weightKg.value : this.weightKg,
    restSeconds: restSeconds ?? this.restSeconds,
    orderIndex: orderIndex ?? this.orderIndex,
    notes: notes.present ? notes.value : this.notes,
  );
  RoutineExercise copyWithCompanion(RoutineExercisesCompanion data) {
    return RoutineExercise(
      id: data.id.present ? data.id.value : this.id,
      routineId: data.routineId.present ? data.routineId.value : this.routineId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      sets: data.sets.present ? data.sets.value : this.sets,
      reps: data.reps.present ? data.reps.value : this.reps,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      restSeconds: data.restSeconds.present
          ? data.restSeconds.value
          : this.restSeconds,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoutineExercise(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('sets: $sets, ')
          ..write('reps: $reps, ')
          ..write('weightKg: $weightKg, ')
          ..write('restSeconds: $restSeconds, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    routineId,
    exerciseId,
    sets,
    reps,
    weightKg,
    restSeconds,
    orderIndex,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutineExercise &&
          other.id == this.id &&
          other.routineId == this.routineId &&
          other.exerciseId == this.exerciseId &&
          other.sets == this.sets &&
          other.reps == this.reps &&
          other.weightKg == this.weightKg &&
          other.restSeconds == this.restSeconds &&
          other.orderIndex == this.orderIndex &&
          other.notes == this.notes);
}

class RoutineExercisesCompanion extends UpdateCompanion<RoutineExercise> {
  final Value<String> id;
  final Value<String> routineId;
  final Value<String> exerciseId;
  final Value<int> sets;
  final Value<int?> reps;
  final Value<double?> weightKg;
  final Value<int> restSeconds;
  final Value<int> orderIndex;
  final Value<String?> notes;
  final Value<int> rowid;
  const RoutineExercisesCompanion({
    this.id = const Value.absent(),
    this.routineId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.sets = const Value.absent(),
    this.reps = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.restSeconds = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoutineExercisesCompanion.insert({
    required String id,
    required String routineId,
    required String exerciseId,
    required int sets,
    this.reps = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.restSeconds = const Value.absent(),
    required int orderIndex,
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       routineId = Value(routineId),
       exerciseId = Value(exerciseId),
       sets = Value(sets),
       orderIndex = Value(orderIndex);
  static Insertable<RoutineExercise> custom({
    Expression<String>? id,
    Expression<String>? routineId,
    Expression<String>? exerciseId,
    Expression<int>? sets,
    Expression<int>? reps,
    Expression<double>? weightKg,
    Expression<int>? restSeconds,
    Expression<int>? orderIndex,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routineId != null) 'routine_id': routineId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (sets != null) 'sets': sets,
      if (reps != null) 'reps': reps,
      if (weightKg != null) 'weight_kg': weightKg,
      if (restSeconds != null) 'rest_seconds': restSeconds,
      if (orderIndex != null) 'order_index': orderIndex,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoutineExercisesCompanion copyWith({
    Value<String>? id,
    Value<String>? routineId,
    Value<String>? exerciseId,
    Value<int>? sets,
    Value<int?>? reps,
    Value<double?>? weightKg,
    Value<int>? restSeconds,
    Value<int>? orderIndex,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return RoutineExercisesCompanion(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      exerciseId: exerciseId ?? this.exerciseId,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      weightKg: weightKg ?? this.weightKg,
      restSeconds: restSeconds ?? this.restSeconds,
      orderIndex: orderIndex ?? this.orderIndex,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<String>(routineId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (sets.present) {
      map['sets'] = Variable<int>(sets.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (restSeconds.present) {
      map['rest_seconds'] = Variable<int>(restSeconds.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutineExercisesCompanion(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('sets: $sets, ')
          ..write('reps: $reps, ')
          ..write('weightKg: $weightKg, ')
          ..write('restSeconds: $restSeconds, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutsTable extends Workouts with TableInfo<$WorkoutsTable, Workout> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gymIdMeta = const VerificationMeta('gymId');
  @override
  late final GeneratedColumn<String> gymId = GeneratedColumn<String>(
    'gym_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _routineIdMeta = const VerificationMeta(
    'routineId',
  );
  @override
  late final GeneratedColumn<String> routineId = GeneratedColumn<String>(
    'routine_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gymId,
    userId,
    routineId,
    startedAt,
    endedAt,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workouts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Workout> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('gym_id')) {
      context.handle(
        _gymIdMeta,
        gymId.isAcceptableOrUnknown(data['gym_id']!, _gymIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gymIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('routine_id')) {
      context.handle(
        _routineIdMeta,
        routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Workout map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Workout(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      gymId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gym_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      routineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}routine_id'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $WorkoutsTable createAlias(String alias) {
    return $WorkoutsTable(attachedDatabase, alias);
  }
}

class Workout extends DataClass implements Insertable<Workout> {
  final String id;
  final String gymId;
  final String userId;
  final String? routineId;
  final DateTime startedAt;
  final DateTime? endedAt;
  final String? notes;
  final DateTime createdAt;
  const Workout({
    required this.id,
    required this.gymId,
    required this.userId,
    this.routineId,
    required this.startedAt,
    this.endedAt,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['gym_id'] = Variable<String>(gymId);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || routineId != null) {
      map['routine_id'] = Variable<String>(routineId);
    }
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WorkoutsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutsCompanion(
      id: Value(id),
      gymId: Value(gymId),
      userId: Value(userId),
      routineId: routineId == null && nullToAbsent
          ? const Value.absent()
          : Value(routineId),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory Workout.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Workout(
      id: serializer.fromJson<String>(json['id']),
      gymId: serializer.fromJson<String>(json['gymId']),
      userId: serializer.fromJson<String>(json['userId']),
      routineId: serializer.fromJson<String?>(json['routineId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'gymId': serializer.toJson<String>(gymId),
      'userId': serializer.toJson<String>(userId),
      'routineId': serializer.toJson<String?>(routineId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Workout copyWith({
    String? id,
    String? gymId,
    String? userId,
    Value<String?> routineId = const Value.absent(),
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => Workout(
    id: id ?? this.id,
    gymId: gymId ?? this.gymId,
    userId: userId ?? this.userId,
    routineId: routineId.present ? routineId.value : this.routineId,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  Workout copyWithCompanion(WorkoutsCompanion data) {
    return Workout(
      id: data.id.present ? data.id.value : this.id,
      gymId: data.gymId.present ? data.gymId.value : this.gymId,
      userId: data.userId.present ? data.userId.value : this.userId,
      routineId: data.routineId.present ? data.routineId.value : this.routineId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Workout(')
          ..write('id: $id, ')
          ..write('gymId: $gymId, ')
          ..write('userId: $userId, ')
          ..write('routineId: $routineId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    gymId,
    userId,
    routineId,
    startedAt,
    endedAt,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Workout &&
          other.id == this.id &&
          other.gymId == this.gymId &&
          other.userId == this.userId &&
          other.routineId == this.routineId &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class WorkoutsCompanion extends UpdateCompanion<Workout> {
  final Value<String> id;
  final Value<String> gymId;
  final Value<String> userId;
  final Value<String?> routineId;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const WorkoutsCompanion({
    this.id = const Value.absent(),
    this.gymId = const Value.absent(),
    this.userId = const Value.absent(),
    this.routineId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutsCompanion.insert({
    required String id,
    required String gymId,
    required String userId,
    this.routineId = const Value.absent(),
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       gymId = Value(gymId),
       userId = Value(userId),
       startedAt = Value(startedAt);
  static Insertable<Workout> custom({
    Expression<String>? id,
    Expression<String>? gymId,
    Expression<String>? userId,
    Expression<String>? routineId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gymId != null) 'gym_id': gymId,
      if (userId != null) 'user_id': userId,
      if (routineId != null) 'routine_id': routineId,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutsCompanion copyWith({
    Value<String>? id,
    Value<String>? gymId,
    Value<String>? userId,
    Value<String?>? routineId,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return WorkoutsCompanion(
      id: id ?? this.id,
      gymId: gymId ?? this.gymId,
      userId: userId ?? this.userId,
      routineId: routineId ?? this.routineId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (gymId.present) {
      map['gym_id'] = Variable<String>(gymId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<String>(routineId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutsCompanion(')
          ..write('id: $id, ')
          ..write('gymId: $gymId, ')
          ..write('userId: $userId, ')
          ..write('routineId: $routineId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutExercisesTable extends WorkoutExercises
    with TableInfo<$WorkoutExercisesTable, WorkoutExercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workoutIdMeta = const VerificationMeta(
    'workoutId',
  );
  @override
  late final GeneratedColumn<String> workoutId = GeneratedColumn<String>(
    'workout_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _setNumberMeta = const VerificationMeta(
    'setNumber',
  );
  @override
  late final GeneratedColumn<int> setNumber = GeneratedColumn<int>(
    'set_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workoutId,
    exerciseId,
    setNumber,
    weightKg,
    reps,
    completed,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutExercise> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workout_id')) {
      context.handle(
        _workoutIdMeta,
        workoutId.isAcceptableOrUnknown(data['workout_id']!, _workoutIdMeta),
      );
    } else if (isInserting) {
      context.missing(_workoutIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('set_number')) {
      context.handle(
        _setNumberMeta,
        setNumber.isAcceptableOrUnknown(data['set_number']!, _setNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_setNumberMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutExercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutExercise(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      workoutId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workout_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      setNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}set_number'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      ),
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      ),
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $WorkoutExercisesTable createAlias(String alias) {
    return $WorkoutExercisesTable(attachedDatabase, alias);
  }
}

class WorkoutExercise extends DataClass implements Insertable<WorkoutExercise> {
  final String id;
  final String workoutId;
  final String exerciseId;
  final int setNumber;
  final double? weightKg;
  final int? reps;
  final bool completed;
  final DateTime createdAt;
  const WorkoutExercise({
    required this.id,
    required this.workoutId,
    required this.exerciseId,
    required this.setNumber,
    this.weightKg,
    this.reps,
    required this.completed,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workout_id'] = Variable<String>(workoutId);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['set_number'] = Variable<int>(setNumber);
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    if (!nullToAbsent || reps != null) {
      map['reps'] = Variable<int>(reps);
    }
    map['completed'] = Variable<bool>(completed);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WorkoutExercisesCompanion toCompanion(bool nullToAbsent) {
    return WorkoutExercisesCompanion(
      id: Value(id),
      workoutId: Value(workoutId),
      exerciseId: Value(exerciseId),
      setNumber: Value(setNumber),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      reps: reps == null && nullToAbsent ? const Value.absent() : Value(reps),
      completed: Value(completed),
      createdAt: Value(createdAt),
    );
  }

  factory WorkoutExercise.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutExercise(
      id: serializer.fromJson<String>(json['id']),
      workoutId: serializer.fromJson<String>(json['workoutId']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      setNumber: serializer.fromJson<int>(json['setNumber']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      reps: serializer.fromJson<int?>(json['reps']),
      completed: serializer.fromJson<bool>(json['completed']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workoutId': serializer.toJson<String>(workoutId),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'setNumber': serializer.toJson<int>(setNumber),
      'weightKg': serializer.toJson<double?>(weightKg),
      'reps': serializer.toJson<int?>(reps),
      'completed': serializer.toJson<bool>(completed),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  WorkoutExercise copyWith({
    String? id,
    String? workoutId,
    String? exerciseId,
    int? setNumber,
    Value<double?> weightKg = const Value.absent(),
    Value<int?> reps = const Value.absent(),
    bool? completed,
    DateTime? createdAt,
  }) => WorkoutExercise(
    id: id ?? this.id,
    workoutId: workoutId ?? this.workoutId,
    exerciseId: exerciseId ?? this.exerciseId,
    setNumber: setNumber ?? this.setNumber,
    weightKg: weightKg.present ? weightKg.value : this.weightKg,
    reps: reps.present ? reps.value : this.reps,
    completed: completed ?? this.completed,
    createdAt: createdAt ?? this.createdAt,
  );
  WorkoutExercise copyWithCompanion(WorkoutExercisesCompanion data) {
    return WorkoutExercise(
      id: data.id.present ? data.id.value : this.id,
      workoutId: data.workoutId.present ? data.workoutId.value : this.workoutId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      setNumber: data.setNumber.present ? data.setNumber.value : this.setNumber,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      reps: data.reps.present ? data.reps.value : this.reps,
      completed: data.completed.present ? data.completed.value : this.completed,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutExercise(')
          ..write('id: $id, ')
          ..write('workoutId: $workoutId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('setNumber: $setNumber, ')
          ..write('weightKg: $weightKg, ')
          ..write('reps: $reps, ')
          ..write('completed: $completed, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    workoutId,
    exerciseId,
    setNumber,
    weightKg,
    reps,
    completed,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutExercise &&
          other.id == this.id &&
          other.workoutId == this.workoutId &&
          other.exerciseId == this.exerciseId &&
          other.setNumber == this.setNumber &&
          other.weightKg == this.weightKg &&
          other.reps == this.reps &&
          other.completed == this.completed &&
          other.createdAt == this.createdAt);
}

class WorkoutExercisesCompanion extends UpdateCompanion<WorkoutExercise> {
  final Value<String> id;
  final Value<String> workoutId;
  final Value<String> exerciseId;
  final Value<int> setNumber;
  final Value<double?> weightKg;
  final Value<int?> reps;
  final Value<bool> completed;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const WorkoutExercisesCompanion({
    this.id = const Value.absent(),
    this.workoutId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.setNumber = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.reps = const Value.absent(),
    this.completed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutExercisesCompanion.insert({
    required String id,
    required String workoutId,
    required String exerciseId,
    required int setNumber,
    this.weightKg = const Value.absent(),
    this.reps = const Value.absent(),
    this.completed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       workoutId = Value(workoutId),
       exerciseId = Value(exerciseId),
       setNumber = Value(setNumber);
  static Insertable<WorkoutExercise> custom({
    Expression<String>? id,
    Expression<String>? workoutId,
    Expression<String>? exerciseId,
    Expression<int>? setNumber,
    Expression<double>? weightKg,
    Expression<int>? reps,
    Expression<bool>? completed,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workoutId != null) 'workout_id': workoutId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (setNumber != null) 'set_number': setNumber,
      if (weightKg != null) 'weight_kg': weightKg,
      if (reps != null) 'reps': reps,
      if (completed != null) 'completed': completed,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutExercisesCompanion copyWith({
    Value<String>? id,
    Value<String>? workoutId,
    Value<String>? exerciseId,
    Value<int>? setNumber,
    Value<double?>? weightKg,
    Value<int?>? reps,
    Value<bool>? completed,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return WorkoutExercisesCompanion(
      id: id ?? this.id,
      workoutId: workoutId ?? this.workoutId,
      exerciseId: exerciseId ?? this.exerciseId,
      setNumber: setNumber ?? this.setNumber,
      weightKg: weightKg ?? this.weightKg,
      reps: reps ?? this.reps,
      completed: completed ?? this.completed,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workoutId.present) {
      map['workout_id'] = Variable<String>(workoutId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (setNumber.present) {
      map['set_number'] = Variable<int>(setNumber.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutExercisesCompanion(')
          ..write('id: $id, ')
          ..write('workoutId: $workoutId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('setNumber: $setNumber, ')
          ..write('weightKg: $weightKg, ')
          ..write('reps: $reps, ')
          ..write('completed: $completed, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BodyMeasurementsTable extends BodyMeasurements
    with TableInfo<$BodyMeasurementsTable, BodyMeasurement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BodyMeasurementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gymIdMeta = const VerificationMeta('gymId');
  @override
  late final GeneratedColumn<String> gymId = GeneratedColumn<String>(
    'gym_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyFatPctMeta = const VerificationMeta(
    'bodyFatPct',
  );
  @override
  late final GeneratedColumn<double> bodyFatPct = GeneratedColumn<double>(
    'body_fat_pct',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _waistCmMeta = const VerificationMeta(
    'waistCm',
  );
  @override
  late final GeneratedColumn<double> waistCm = GeneratedColumn<double>(
    'waist_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hipsCmMeta = const VerificationMeta('hipsCm');
  @override
  late final GeneratedColumn<double> hipsCm = GeneratedColumn<double>(
    'hips_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chestCmMeta = const VerificationMeta(
    'chestCm',
  );
  @override
  late final GeneratedColumn<double> chestCm = GeneratedColumn<double>(
    'chest_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _armsCmMeta = const VerificationMeta('armsCm');
  @override
  late final GeneratedColumn<double> armsCm = GeneratedColumn<double>(
    'arms_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _thighsCmMeta = const VerificationMeta(
    'thighsCm',
  );
  @override
  late final GeneratedColumn<double> thighsCm = GeneratedColumn<double>(
    'thighs_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gymId,
    userId,
    recordedAt,
    weightKg,
    bodyFatPct,
    waistCm,
    hipsCm,
    chestCm,
    armsCm,
    thighsCm,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'body_measurements';
  @override
  VerificationContext validateIntegrity(
    Insertable<BodyMeasurement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('gym_id')) {
      context.handle(
        _gymIdMeta,
        gymId.isAcceptableOrUnknown(data['gym_id']!, _gymIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gymIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('body_fat_pct')) {
      context.handle(
        _bodyFatPctMeta,
        bodyFatPct.isAcceptableOrUnknown(
          data['body_fat_pct']!,
          _bodyFatPctMeta,
        ),
      );
    }
    if (data.containsKey('waist_cm')) {
      context.handle(
        _waistCmMeta,
        waistCm.isAcceptableOrUnknown(data['waist_cm']!, _waistCmMeta),
      );
    }
    if (data.containsKey('hips_cm')) {
      context.handle(
        _hipsCmMeta,
        hipsCm.isAcceptableOrUnknown(data['hips_cm']!, _hipsCmMeta),
      );
    }
    if (data.containsKey('chest_cm')) {
      context.handle(
        _chestCmMeta,
        chestCm.isAcceptableOrUnknown(data['chest_cm']!, _chestCmMeta),
      );
    }
    if (data.containsKey('arms_cm')) {
      context.handle(
        _armsCmMeta,
        armsCm.isAcceptableOrUnknown(data['arms_cm']!, _armsCmMeta),
      );
    }
    if (data.containsKey('thighs_cm')) {
      context.handle(
        _thighsCmMeta,
        thighsCm.isAcceptableOrUnknown(data['thighs_cm']!, _thighsCmMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BodyMeasurement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BodyMeasurement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      gymId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gym_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      recordedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recorded_at'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      ),
      bodyFatPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}body_fat_pct'],
      ),
      waistCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}waist_cm'],
      ),
      hipsCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hips_cm'],
      ),
      chestCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}chest_cm'],
      ),
      armsCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}arms_cm'],
      ),
      thighsCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}thighs_cm'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $BodyMeasurementsTable createAlias(String alias) {
    return $BodyMeasurementsTable(attachedDatabase, alias);
  }
}

class BodyMeasurement extends DataClass implements Insertable<BodyMeasurement> {
  final String id;
  final String gymId;
  final String userId;
  final DateTime recordedAt;
  final double? weightKg;
  final double? bodyFatPct;
  final double? waistCm;
  final double? hipsCm;
  final double? chestCm;
  final double? armsCm;
  final double? thighsCm;
  final String? notes;
  const BodyMeasurement({
    required this.id,
    required this.gymId,
    required this.userId,
    required this.recordedAt,
    this.weightKg,
    this.bodyFatPct,
    this.waistCm,
    this.hipsCm,
    this.chestCm,
    this.armsCm,
    this.thighsCm,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['gym_id'] = Variable<String>(gymId);
    map['user_id'] = Variable<String>(userId);
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    if (!nullToAbsent || bodyFatPct != null) {
      map['body_fat_pct'] = Variable<double>(bodyFatPct);
    }
    if (!nullToAbsent || waistCm != null) {
      map['waist_cm'] = Variable<double>(waistCm);
    }
    if (!nullToAbsent || hipsCm != null) {
      map['hips_cm'] = Variable<double>(hipsCm);
    }
    if (!nullToAbsent || chestCm != null) {
      map['chest_cm'] = Variable<double>(chestCm);
    }
    if (!nullToAbsent || armsCm != null) {
      map['arms_cm'] = Variable<double>(armsCm);
    }
    if (!nullToAbsent || thighsCm != null) {
      map['thighs_cm'] = Variable<double>(thighsCm);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  BodyMeasurementsCompanion toCompanion(bool nullToAbsent) {
    return BodyMeasurementsCompanion(
      id: Value(id),
      gymId: Value(gymId),
      userId: Value(userId),
      recordedAt: Value(recordedAt),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      bodyFatPct: bodyFatPct == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyFatPct),
      waistCm: waistCm == null && nullToAbsent
          ? const Value.absent()
          : Value(waistCm),
      hipsCm: hipsCm == null && nullToAbsent
          ? const Value.absent()
          : Value(hipsCm),
      chestCm: chestCm == null && nullToAbsent
          ? const Value.absent()
          : Value(chestCm),
      armsCm: armsCm == null && nullToAbsent
          ? const Value.absent()
          : Value(armsCm),
      thighsCm: thighsCm == null && nullToAbsent
          ? const Value.absent()
          : Value(thighsCm),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory BodyMeasurement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BodyMeasurement(
      id: serializer.fromJson<String>(json['id']),
      gymId: serializer.fromJson<String>(json['gymId']),
      userId: serializer.fromJson<String>(json['userId']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      bodyFatPct: serializer.fromJson<double?>(json['bodyFatPct']),
      waistCm: serializer.fromJson<double?>(json['waistCm']),
      hipsCm: serializer.fromJson<double?>(json['hipsCm']),
      chestCm: serializer.fromJson<double?>(json['chestCm']),
      armsCm: serializer.fromJson<double?>(json['armsCm']),
      thighsCm: serializer.fromJson<double?>(json['thighsCm']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'gymId': serializer.toJson<String>(gymId),
      'userId': serializer.toJson<String>(userId),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
      'weightKg': serializer.toJson<double?>(weightKg),
      'bodyFatPct': serializer.toJson<double?>(bodyFatPct),
      'waistCm': serializer.toJson<double?>(waistCm),
      'hipsCm': serializer.toJson<double?>(hipsCm),
      'chestCm': serializer.toJson<double?>(chestCm),
      'armsCm': serializer.toJson<double?>(armsCm),
      'thighsCm': serializer.toJson<double?>(thighsCm),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  BodyMeasurement copyWith({
    String? id,
    String? gymId,
    String? userId,
    DateTime? recordedAt,
    Value<double?> weightKg = const Value.absent(),
    Value<double?> bodyFatPct = const Value.absent(),
    Value<double?> waistCm = const Value.absent(),
    Value<double?> hipsCm = const Value.absent(),
    Value<double?> chestCm = const Value.absent(),
    Value<double?> armsCm = const Value.absent(),
    Value<double?> thighsCm = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => BodyMeasurement(
    id: id ?? this.id,
    gymId: gymId ?? this.gymId,
    userId: userId ?? this.userId,
    recordedAt: recordedAt ?? this.recordedAt,
    weightKg: weightKg.present ? weightKg.value : this.weightKg,
    bodyFatPct: bodyFatPct.present ? bodyFatPct.value : this.bodyFatPct,
    waistCm: waistCm.present ? waistCm.value : this.waistCm,
    hipsCm: hipsCm.present ? hipsCm.value : this.hipsCm,
    chestCm: chestCm.present ? chestCm.value : this.chestCm,
    armsCm: armsCm.present ? armsCm.value : this.armsCm,
    thighsCm: thighsCm.present ? thighsCm.value : this.thighsCm,
    notes: notes.present ? notes.value : this.notes,
  );
  BodyMeasurement copyWithCompanion(BodyMeasurementsCompanion data) {
    return BodyMeasurement(
      id: data.id.present ? data.id.value : this.id,
      gymId: data.gymId.present ? data.gymId.value : this.gymId,
      userId: data.userId.present ? data.userId.value : this.userId,
      recordedAt: data.recordedAt.present
          ? data.recordedAt.value
          : this.recordedAt,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      bodyFatPct: data.bodyFatPct.present
          ? data.bodyFatPct.value
          : this.bodyFatPct,
      waistCm: data.waistCm.present ? data.waistCm.value : this.waistCm,
      hipsCm: data.hipsCm.present ? data.hipsCm.value : this.hipsCm,
      chestCm: data.chestCm.present ? data.chestCm.value : this.chestCm,
      armsCm: data.armsCm.present ? data.armsCm.value : this.armsCm,
      thighsCm: data.thighsCm.present ? data.thighsCm.value : this.thighsCm,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BodyMeasurement(')
          ..write('id: $id, ')
          ..write('gymId: $gymId, ')
          ..write('userId: $userId, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('weightKg: $weightKg, ')
          ..write('bodyFatPct: $bodyFatPct, ')
          ..write('waistCm: $waistCm, ')
          ..write('hipsCm: $hipsCm, ')
          ..write('chestCm: $chestCm, ')
          ..write('armsCm: $armsCm, ')
          ..write('thighsCm: $thighsCm, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    gymId,
    userId,
    recordedAt,
    weightKg,
    bodyFatPct,
    waistCm,
    hipsCm,
    chestCm,
    armsCm,
    thighsCm,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BodyMeasurement &&
          other.id == this.id &&
          other.gymId == this.gymId &&
          other.userId == this.userId &&
          other.recordedAt == this.recordedAt &&
          other.weightKg == this.weightKg &&
          other.bodyFatPct == this.bodyFatPct &&
          other.waistCm == this.waistCm &&
          other.hipsCm == this.hipsCm &&
          other.chestCm == this.chestCm &&
          other.armsCm == this.armsCm &&
          other.thighsCm == this.thighsCm &&
          other.notes == this.notes);
}

class BodyMeasurementsCompanion extends UpdateCompanion<BodyMeasurement> {
  final Value<String> id;
  final Value<String> gymId;
  final Value<String> userId;
  final Value<DateTime> recordedAt;
  final Value<double?> weightKg;
  final Value<double?> bodyFatPct;
  final Value<double?> waistCm;
  final Value<double?> hipsCm;
  final Value<double?> chestCm;
  final Value<double?> armsCm;
  final Value<double?> thighsCm;
  final Value<String?> notes;
  final Value<int> rowid;
  const BodyMeasurementsCompanion({
    this.id = const Value.absent(),
    this.gymId = const Value.absent(),
    this.userId = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.bodyFatPct = const Value.absent(),
    this.waistCm = const Value.absent(),
    this.hipsCm = const Value.absent(),
    this.chestCm = const Value.absent(),
    this.armsCm = const Value.absent(),
    this.thighsCm = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BodyMeasurementsCompanion.insert({
    required String id,
    required String gymId,
    required String userId,
    required DateTime recordedAt,
    this.weightKg = const Value.absent(),
    this.bodyFatPct = const Value.absent(),
    this.waistCm = const Value.absent(),
    this.hipsCm = const Value.absent(),
    this.chestCm = const Value.absent(),
    this.armsCm = const Value.absent(),
    this.thighsCm = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       gymId = Value(gymId),
       userId = Value(userId),
       recordedAt = Value(recordedAt);
  static Insertable<BodyMeasurement> custom({
    Expression<String>? id,
    Expression<String>? gymId,
    Expression<String>? userId,
    Expression<DateTime>? recordedAt,
    Expression<double>? weightKg,
    Expression<double>? bodyFatPct,
    Expression<double>? waistCm,
    Expression<double>? hipsCm,
    Expression<double>? chestCm,
    Expression<double>? armsCm,
    Expression<double>? thighsCm,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gymId != null) 'gym_id': gymId,
      if (userId != null) 'user_id': userId,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (weightKg != null) 'weight_kg': weightKg,
      if (bodyFatPct != null) 'body_fat_pct': bodyFatPct,
      if (waistCm != null) 'waist_cm': waistCm,
      if (hipsCm != null) 'hips_cm': hipsCm,
      if (chestCm != null) 'chest_cm': chestCm,
      if (armsCm != null) 'arms_cm': armsCm,
      if (thighsCm != null) 'thighs_cm': thighsCm,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BodyMeasurementsCompanion copyWith({
    Value<String>? id,
    Value<String>? gymId,
    Value<String>? userId,
    Value<DateTime>? recordedAt,
    Value<double?>? weightKg,
    Value<double?>? bodyFatPct,
    Value<double?>? waistCm,
    Value<double?>? hipsCm,
    Value<double?>? chestCm,
    Value<double?>? armsCm,
    Value<double?>? thighsCm,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return BodyMeasurementsCompanion(
      id: id ?? this.id,
      gymId: gymId ?? this.gymId,
      userId: userId ?? this.userId,
      recordedAt: recordedAt ?? this.recordedAt,
      weightKg: weightKg ?? this.weightKg,
      bodyFatPct: bodyFatPct ?? this.bodyFatPct,
      waistCm: waistCm ?? this.waistCm,
      hipsCm: hipsCm ?? this.hipsCm,
      chestCm: chestCm ?? this.chestCm,
      armsCm: armsCm ?? this.armsCm,
      thighsCm: thighsCm ?? this.thighsCm,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (gymId.present) {
      map['gym_id'] = Variable<String>(gymId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (bodyFatPct.present) {
      map['body_fat_pct'] = Variable<double>(bodyFatPct.value);
    }
    if (waistCm.present) {
      map['waist_cm'] = Variable<double>(waistCm.value);
    }
    if (hipsCm.present) {
      map['hips_cm'] = Variable<double>(hipsCm.value);
    }
    if (chestCm.present) {
      map['chest_cm'] = Variable<double>(chestCm.value);
    }
    if (armsCm.present) {
      map['arms_cm'] = Variable<double>(armsCm.value);
    }
    if (thighsCm.present) {
      map['thighs_cm'] = Variable<double>(thighsCm.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BodyMeasurementsCompanion(')
          ..write('id: $id, ')
          ..write('gymId: $gymId, ')
          ..write('userId: $userId, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('weightKg: $weightKg, ')
          ..write('bodyFatPct: $bodyFatPct, ')
          ..write('waistCm: $waistCm, ')
          ..write('hipsCm: $hipsCm, ')
          ..write('chestCm: $chestCm, ')
          ..write('armsCm: $armsCm, ')
          ..write('thighsCm: $thighsCm, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProgressPhotosTable extends ProgressPhotos
    with TableInfo<$ProgressPhotosTable, ProgressPhoto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProgressPhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gymIdMeta = const VerificationMeta('gymId');
  @override
  late final GeneratedColumn<String> gymId = GeneratedColumn<String>(
    'gym_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _takenAtMeta = const VerificationMeta(
    'takenAt',
  );
  @override
  late final GeneratedColumn<DateTime> takenAt = GeneratedColumn<DateTime>(
    'taken_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gymId,
    userId,
    photoUrl,
    takenAt,
    category,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'progress_photos';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProgressPhoto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('gym_id')) {
      context.handle(
        _gymIdMeta,
        gymId.isAcceptableOrUnknown(data['gym_id']!, _gymIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gymIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_photoUrlMeta);
    }
    if (data.containsKey('taken_at')) {
      context.handle(
        _takenAtMeta,
        takenAt.isAcceptableOrUnknown(data['taken_at']!, _takenAtMeta),
      );
    } else if (isInserting) {
      context.missing(_takenAtMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProgressPhoto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProgressPhoto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      gymId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gym_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      )!,
      takenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}taken_at'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
    );
  }

  @override
  $ProgressPhotosTable createAlias(String alias) {
    return $ProgressPhotosTable(attachedDatabase, alias);
  }
}

class ProgressPhoto extends DataClass implements Insertable<ProgressPhoto> {
  final String id;
  final String gymId;
  final String userId;
  final String photoUrl;
  final DateTime takenAt;
  final String? category;
  const ProgressPhoto({
    required this.id,
    required this.gymId,
    required this.userId,
    required this.photoUrl,
    required this.takenAt,
    this.category,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['gym_id'] = Variable<String>(gymId);
    map['user_id'] = Variable<String>(userId);
    map['photo_url'] = Variable<String>(photoUrl);
    map['taken_at'] = Variable<DateTime>(takenAt);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    return map;
  }

  ProgressPhotosCompanion toCompanion(bool nullToAbsent) {
    return ProgressPhotosCompanion(
      id: Value(id),
      gymId: Value(gymId),
      userId: Value(userId),
      photoUrl: Value(photoUrl),
      takenAt: Value(takenAt),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
    );
  }

  factory ProgressPhoto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProgressPhoto(
      id: serializer.fromJson<String>(json['id']),
      gymId: serializer.fromJson<String>(json['gymId']),
      userId: serializer.fromJson<String>(json['userId']),
      photoUrl: serializer.fromJson<String>(json['photoUrl']),
      takenAt: serializer.fromJson<DateTime>(json['takenAt']),
      category: serializer.fromJson<String?>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'gymId': serializer.toJson<String>(gymId),
      'userId': serializer.toJson<String>(userId),
      'photoUrl': serializer.toJson<String>(photoUrl),
      'takenAt': serializer.toJson<DateTime>(takenAt),
      'category': serializer.toJson<String?>(category),
    };
  }

  ProgressPhoto copyWith({
    String? id,
    String? gymId,
    String? userId,
    String? photoUrl,
    DateTime? takenAt,
    Value<String?> category = const Value.absent(),
  }) => ProgressPhoto(
    id: id ?? this.id,
    gymId: gymId ?? this.gymId,
    userId: userId ?? this.userId,
    photoUrl: photoUrl ?? this.photoUrl,
    takenAt: takenAt ?? this.takenAt,
    category: category.present ? category.value : this.category,
  );
  ProgressPhoto copyWithCompanion(ProgressPhotosCompanion data) {
    return ProgressPhoto(
      id: data.id.present ? data.id.value : this.id,
      gymId: data.gymId.present ? data.gymId.value : this.gymId,
      userId: data.userId.present ? data.userId.value : this.userId,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      takenAt: data.takenAt.present ? data.takenAt.value : this.takenAt,
      category: data.category.present ? data.category.value : this.category,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProgressPhoto(')
          ..write('id: $id, ')
          ..write('gymId: $gymId, ')
          ..write('userId: $userId, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('takenAt: $takenAt, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, gymId, userId, photoUrl, takenAt, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProgressPhoto &&
          other.id == this.id &&
          other.gymId == this.gymId &&
          other.userId == this.userId &&
          other.photoUrl == this.photoUrl &&
          other.takenAt == this.takenAt &&
          other.category == this.category);
}

class ProgressPhotosCompanion extends UpdateCompanion<ProgressPhoto> {
  final Value<String> id;
  final Value<String> gymId;
  final Value<String> userId;
  final Value<String> photoUrl;
  final Value<DateTime> takenAt;
  final Value<String?> category;
  final Value<int> rowid;
  const ProgressPhotosCompanion({
    this.id = const Value.absent(),
    this.gymId = const Value.absent(),
    this.userId = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.takenAt = const Value.absent(),
    this.category = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProgressPhotosCompanion.insert({
    required String id,
    required String gymId,
    required String userId,
    required String photoUrl,
    required DateTime takenAt,
    this.category = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       gymId = Value(gymId),
       userId = Value(userId),
       photoUrl = Value(photoUrl),
       takenAt = Value(takenAt);
  static Insertable<ProgressPhoto> custom({
    Expression<String>? id,
    Expression<String>? gymId,
    Expression<String>? userId,
    Expression<String>? photoUrl,
    Expression<DateTime>? takenAt,
    Expression<String>? category,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gymId != null) 'gym_id': gymId,
      if (userId != null) 'user_id': userId,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (takenAt != null) 'taken_at': takenAt,
      if (category != null) 'category': category,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProgressPhotosCompanion copyWith({
    Value<String>? id,
    Value<String>? gymId,
    Value<String>? userId,
    Value<String>? photoUrl,
    Value<DateTime>? takenAt,
    Value<String?>? category,
    Value<int>? rowid,
  }) {
    return ProgressPhotosCompanion(
      id: id ?? this.id,
      gymId: gymId ?? this.gymId,
      userId: userId ?? this.userId,
      photoUrl: photoUrl ?? this.photoUrl,
      takenAt: takenAt ?? this.takenAt,
      category: category ?? this.category,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (gymId.present) {
      map['gym_id'] = Variable<String>(gymId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (takenAt.present) {
      map['taken_at'] = Variable<DateTime>(takenAt.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProgressPhotosCompanion(')
          ..write('id: $id, ')
          ..write('gymId: $gymId, ')
          ..write('userId: $userId, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('takenAt: $takenAt, ')
          ..write('category: $category, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationsTable extends Notifications
    with TableInfo<$NotificationsTable, Notification> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_read" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    title,
    body,
    isRead,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notifications';
  @override
  VerificationContext validateIntegrity(
    Insertable<Notification> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('is_read')) {
      context.handle(
        _isReadMeta,
        isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Notification map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Notification(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      isRead: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_read'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $NotificationsTable createAlias(String alias) {
    return $NotificationsTable(attachedDatabase, alias);
  }
}

class Notification extends DataClass implements Insertable<Notification> {
  final String id;
  final String userId;
  final String title;
  final String body;
  final bool isRead;
  final DateTime createdAt;
  const Notification({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    map['is_read'] = Variable<bool>(isRead);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  NotificationsCompanion toCompanion(bool nullToAbsent) {
    return NotificationsCompanion(
      id: Value(id),
      userId: Value(userId),
      title: Value(title),
      body: Value(body),
      isRead: Value(isRead),
      createdAt: Value(createdAt),
    );
  }

  factory Notification.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Notification(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'isRead': serializer.toJson<bool>(isRead),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Notification copyWith({
    String? id,
    String? userId,
    String? title,
    String? body,
    bool? isRead,
    DateTime? createdAt,
  }) => Notification(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    title: title ?? this.title,
    body: body ?? this.body,
    isRead: isRead ?? this.isRead,
    createdAt: createdAt ?? this.createdAt,
  );
  Notification copyWithCompanion(NotificationsCompanion data) {
    return Notification(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Notification(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('isRead: $isRead, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, title, body, isRead, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Notification &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.title == this.title &&
          other.body == this.body &&
          other.isRead == this.isRead &&
          other.createdAt == this.createdAt);
}

class NotificationsCompanion extends UpdateCompanion<Notification> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> title;
  final Value<String> body;
  final Value<bool> isRead;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const NotificationsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.isRead = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationsCompanion.insert({
    required String id,
    required String userId,
    required String title,
    required String body,
    this.isRead = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       title = Value(title),
       body = Value(body);
  static Insertable<Notification> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? title,
    Expression<String>? body,
    Expression<bool>? isRead,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (isRead != null) 'is_read': isRead,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? title,
    Value<String>? body,
    Value<bool>? isRead,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return NotificationsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('isRead: $isRead, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExchangeRatesTable extends ExchangeRates
    with TableInfo<$ExchangeRatesTable, ExchangeRate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExchangeRatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gymIdMeta = const VerificationMeta('gymId');
  @override
  late final GeneratedColumn<String> gymId = GeneratedColumn<String>(
    'gym_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rateMeta = const VerificationMeta('rate');
  @override
  late final GeneratedColumn<double> rate = GeneratedColumn<double>(
    'rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isManualMeta = const VerificationMeta(
    'isManual',
  );
  @override
  late final GeneratedColumn<bool> isManual = GeneratedColumn<bool>(
    'is_manual',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_manual" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _validFromMeta = const VerificationMeta(
    'validFrom',
  );
  @override
  late final GeneratedColumn<DateTime> validFrom = GeneratedColumn<DateTime>(
    'valid_from',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gymId,
    rate,
    isManual,
    validFrom,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exchange_rates';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExchangeRate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('gym_id')) {
      context.handle(
        _gymIdMeta,
        gymId.isAcceptableOrUnknown(data['gym_id']!, _gymIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gymIdMeta);
    }
    if (data.containsKey('rate')) {
      context.handle(
        _rateMeta,
        rate.isAcceptableOrUnknown(data['rate']!, _rateMeta),
      );
    } else if (isInserting) {
      context.missing(_rateMeta);
    }
    if (data.containsKey('is_manual')) {
      context.handle(
        _isManualMeta,
        isManual.isAcceptableOrUnknown(data['is_manual']!, _isManualMeta),
      );
    }
    if (data.containsKey('valid_from')) {
      context.handle(
        _validFromMeta,
        validFrom.isAcceptableOrUnknown(data['valid_from']!, _validFromMeta),
      );
    } else if (isInserting) {
      context.missing(_validFromMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExchangeRate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExchangeRate(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      gymId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gym_id'],
      )!,
      rate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rate'],
      )!,
      isManual: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_manual'],
      )!,
      validFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}valid_from'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ExchangeRatesTable createAlias(String alias) {
    return $ExchangeRatesTable(attachedDatabase, alias);
  }
}

class ExchangeRate extends DataClass implements Insertable<ExchangeRate> {
  final String id;
  final String gymId;
  final double rate;
  final bool isManual;
  final DateTime validFrom;
  final DateTime createdAt;
  const ExchangeRate({
    required this.id,
    required this.gymId,
    required this.rate,
    required this.isManual,
    required this.validFrom,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['gym_id'] = Variable<String>(gymId);
    map['rate'] = Variable<double>(rate);
    map['is_manual'] = Variable<bool>(isManual);
    map['valid_from'] = Variable<DateTime>(validFrom);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExchangeRatesCompanion toCompanion(bool nullToAbsent) {
    return ExchangeRatesCompanion(
      id: Value(id),
      gymId: Value(gymId),
      rate: Value(rate),
      isManual: Value(isManual),
      validFrom: Value(validFrom),
      createdAt: Value(createdAt),
    );
  }

  factory ExchangeRate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExchangeRate(
      id: serializer.fromJson<String>(json['id']),
      gymId: serializer.fromJson<String>(json['gymId']),
      rate: serializer.fromJson<double>(json['rate']),
      isManual: serializer.fromJson<bool>(json['isManual']),
      validFrom: serializer.fromJson<DateTime>(json['validFrom']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'gymId': serializer.toJson<String>(gymId),
      'rate': serializer.toJson<double>(rate),
      'isManual': serializer.toJson<bool>(isManual),
      'validFrom': serializer.toJson<DateTime>(validFrom),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ExchangeRate copyWith({
    String? id,
    String? gymId,
    double? rate,
    bool? isManual,
    DateTime? validFrom,
    DateTime? createdAt,
  }) => ExchangeRate(
    id: id ?? this.id,
    gymId: gymId ?? this.gymId,
    rate: rate ?? this.rate,
    isManual: isManual ?? this.isManual,
    validFrom: validFrom ?? this.validFrom,
    createdAt: createdAt ?? this.createdAt,
  );
  ExchangeRate copyWithCompanion(ExchangeRatesCompanion data) {
    return ExchangeRate(
      id: data.id.present ? data.id.value : this.id,
      gymId: data.gymId.present ? data.gymId.value : this.gymId,
      rate: data.rate.present ? data.rate.value : this.rate,
      isManual: data.isManual.present ? data.isManual.value : this.isManual,
      validFrom: data.validFrom.present ? data.validFrom.value : this.validFrom,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExchangeRate(')
          ..write('id: $id, ')
          ..write('gymId: $gymId, ')
          ..write('rate: $rate, ')
          ..write('isManual: $isManual, ')
          ..write('validFrom: $validFrom, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, gymId, rate, isManual, validFrom, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExchangeRate &&
          other.id == this.id &&
          other.gymId == this.gymId &&
          other.rate == this.rate &&
          other.isManual == this.isManual &&
          other.validFrom == this.validFrom &&
          other.createdAt == this.createdAt);
}

class ExchangeRatesCompanion extends UpdateCompanion<ExchangeRate> {
  final Value<String> id;
  final Value<String> gymId;
  final Value<double> rate;
  final Value<bool> isManual;
  final Value<DateTime> validFrom;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ExchangeRatesCompanion({
    this.id = const Value.absent(),
    this.gymId = const Value.absent(),
    this.rate = const Value.absent(),
    this.isManual = const Value.absent(),
    this.validFrom = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExchangeRatesCompanion.insert({
    required String id,
    required String gymId,
    required double rate,
    this.isManual = const Value.absent(),
    required DateTime validFrom,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       gymId = Value(gymId),
       rate = Value(rate),
       validFrom = Value(validFrom);
  static Insertable<ExchangeRate> custom({
    Expression<String>? id,
    Expression<String>? gymId,
    Expression<double>? rate,
    Expression<bool>? isManual,
    Expression<DateTime>? validFrom,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gymId != null) 'gym_id': gymId,
      if (rate != null) 'rate': rate,
      if (isManual != null) 'is_manual': isManual,
      if (validFrom != null) 'valid_from': validFrom,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExchangeRatesCompanion copyWith({
    Value<String>? id,
    Value<String>? gymId,
    Value<double>? rate,
    Value<bool>? isManual,
    Value<DateTime>? validFrom,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ExchangeRatesCompanion(
      id: id ?? this.id,
      gymId: gymId ?? this.gymId,
      rate: rate ?? this.rate,
      isManual: isManual ?? this.isManual,
      validFrom: validFrom ?? this.validFrom,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (gymId.present) {
      map['gym_id'] = Variable<String>(gymId.value);
    }
    if (rate.present) {
      map['rate'] = Variable<double>(rate.value);
    }
    if (isManual.present) {
      map['is_manual'] = Variable<bool>(isManual.value);
    }
    if (validFrom.present) {
      map['valid_from'] = Variable<DateTime>(validFrom.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExchangeRatesCompanion(')
          ..write('id: $id, ')
          ..write('gymId: $gymId, ')
          ..write('rate: $rate, ')
          ..write('isManual: $isManual, ')
          ..write('validFrom: $validFrom, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GymSettingsTable extends GymSettings
    with TableInfo<$GymSettingsTable, GymSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GymSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _gymIdMeta = const VerificationMeta('gymId');
  @override
  late final GeneratedColumn<String> gymId = GeneratedColumn<String>(
    'gym_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _primaryColorMeta = const VerificationMeta(
    'primaryColor',
  );
  @override
  late final GeneratedColumn<String> primaryColor = GeneratedColumn<String>(
    'primary_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('#8B5CF6'),
  );
  static const VerificationMeta _bcvRateMeta = const VerificationMeta(
    'bcvRate',
  );
  @override
  late final GeneratedColumn<double> bcvRate = GeneratedColumn<double>(
    'bcv_rate',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bcvRateManualMeta = const VerificationMeta(
    'bcvRateManual',
  );
  @override
  late final GeneratedColumn<bool> bcvRateManual = GeneratedColumn<bool>(
    'bcv_rate_manual',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("bcv_rate_manual" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    gymId,
    primaryColor,
    bcvRate,
    bcvRateManual,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gym_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<GymSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('gym_id')) {
      context.handle(
        _gymIdMeta,
        gymId.isAcceptableOrUnknown(data['gym_id']!, _gymIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gymIdMeta);
    }
    if (data.containsKey('primary_color')) {
      context.handle(
        _primaryColorMeta,
        primaryColor.isAcceptableOrUnknown(
          data['primary_color']!,
          _primaryColorMeta,
        ),
      );
    }
    if (data.containsKey('bcv_rate')) {
      context.handle(
        _bcvRateMeta,
        bcvRate.isAcceptableOrUnknown(data['bcv_rate']!, _bcvRateMeta),
      );
    }
    if (data.containsKey('bcv_rate_manual')) {
      context.handle(
        _bcvRateManualMeta,
        bcvRateManual.isAcceptableOrUnknown(
          data['bcv_rate_manual']!,
          _bcvRateManualMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {gymId};
  @override
  GymSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GymSetting(
      gymId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gym_id'],
      )!,
      primaryColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_color'],
      )!,
      bcvRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bcv_rate'],
      ),
      bcvRateManual: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}bcv_rate_manual'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $GymSettingsTable createAlias(String alias) {
    return $GymSettingsTable(attachedDatabase, alias);
  }
}

class GymSetting extends DataClass implements Insertable<GymSetting> {
  final String gymId;
  final String primaryColor;
  final double? bcvRate;
  final bool bcvRateManual;
  final DateTime updatedAt;
  const GymSetting({
    required this.gymId,
    required this.primaryColor,
    this.bcvRate,
    required this.bcvRateManual,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['gym_id'] = Variable<String>(gymId);
    map['primary_color'] = Variable<String>(primaryColor);
    if (!nullToAbsent || bcvRate != null) {
      map['bcv_rate'] = Variable<double>(bcvRate);
    }
    map['bcv_rate_manual'] = Variable<bool>(bcvRateManual);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  GymSettingsCompanion toCompanion(bool nullToAbsent) {
    return GymSettingsCompanion(
      gymId: Value(gymId),
      primaryColor: Value(primaryColor),
      bcvRate: bcvRate == null && nullToAbsent
          ? const Value.absent()
          : Value(bcvRate),
      bcvRateManual: Value(bcvRateManual),
      updatedAt: Value(updatedAt),
    );
  }

  factory GymSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GymSetting(
      gymId: serializer.fromJson<String>(json['gymId']),
      primaryColor: serializer.fromJson<String>(json['primaryColor']),
      bcvRate: serializer.fromJson<double?>(json['bcvRate']),
      bcvRateManual: serializer.fromJson<bool>(json['bcvRateManual']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'gymId': serializer.toJson<String>(gymId),
      'primaryColor': serializer.toJson<String>(primaryColor),
      'bcvRate': serializer.toJson<double?>(bcvRate),
      'bcvRateManual': serializer.toJson<bool>(bcvRateManual),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  GymSetting copyWith({
    String? gymId,
    String? primaryColor,
    Value<double?> bcvRate = const Value.absent(),
    bool? bcvRateManual,
    DateTime? updatedAt,
  }) => GymSetting(
    gymId: gymId ?? this.gymId,
    primaryColor: primaryColor ?? this.primaryColor,
    bcvRate: bcvRate.present ? bcvRate.value : this.bcvRate,
    bcvRateManual: bcvRateManual ?? this.bcvRateManual,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  GymSetting copyWithCompanion(GymSettingsCompanion data) {
    return GymSetting(
      gymId: data.gymId.present ? data.gymId.value : this.gymId,
      primaryColor: data.primaryColor.present
          ? data.primaryColor.value
          : this.primaryColor,
      bcvRate: data.bcvRate.present ? data.bcvRate.value : this.bcvRate,
      bcvRateManual: data.bcvRateManual.present
          ? data.bcvRateManual.value
          : this.bcvRateManual,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GymSetting(')
          ..write('gymId: $gymId, ')
          ..write('primaryColor: $primaryColor, ')
          ..write('bcvRate: $bcvRate, ')
          ..write('bcvRateManual: $bcvRateManual, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(gymId, primaryColor, bcvRate, bcvRateManual, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GymSetting &&
          other.gymId == this.gymId &&
          other.primaryColor == this.primaryColor &&
          other.bcvRate == this.bcvRate &&
          other.bcvRateManual == this.bcvRateManual &&
          other.updatedAt == this.updatedAt);
}

class GymSettingsCompanion extends UpdateCompanion<GymSetting> {
  final Value<String> gymId;
  final Value<String> primaryColor;
  final Value<double?> bcvRate;
  final Value<bool> bcvRateManual;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const GymSettingsCompanion({
    this.gymId = const Value.absent(),
    this.primaryColor = const Value.absent(),
    this.bcvRate = const Value.absent(),
    this.bcvRateManual = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GymSettingsCompanion.insert({
    required String gymId,
    this.primaryColor = const Value.absent(),
    this.bcvRate = const Value.absent(),
    this.bcvRateManual = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : gymId = Value(gymId);
  static Insertable<GymSetting> custom({
    Expression<String>? gymId,
    Expression<String>? primaryColor,
    Expression<double>? bcvRate,
    Expression<bool>? bcvRateManual,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (gymId != null) 'gym_id': gymId,
      if (primaryColor != null) 'primary_color': primaryColor,
      if (bcvRate != null) 'bcv_rate': bcvRate,
      if (bcvRateManual != null) 'bcv_rate_manual': bcvRateManual,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GymSettingsCompanion copyWith({
    Value<String>? gymId,
    Value<String>? primaryColor,
    Value<double?>? bcvRate,
    Value<bool>? bcvRateManual,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return GymSettingsCompanion(
      gymId: gymId ?? this.gymId,
      primaryColor: primaryColor ?? this.primaryColor,
      bcvRate: bcvRate ?? this.bcvRate,
      bcvRateManual: bcvRateManual ?? this.bcvRateManual,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (gymId.present) {
      map['gym_id'] = Variable<String>(gymId.value);
    }
    if (primaryColor.present) {
      map['primary_color'] = Variable<String>(primaryColor.value);
    }
    if (bcvRate.present) {
      map['bcv_rate'] = Variable<double>(bcvRate.value);
    }
    if (bcvRateManual.present) {
      map['bcv_rate_manual'] = Variable<bool>(bcvRateManual.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GymSettingsCompanion(')
          ..write('gymId: $gymId, ')
          ..write('primaryColor: $primaryColor, ')
          ..write('bcvRate: $bcvRate, ')
          ..write('bcvRateManual: $bcvRateManual, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FoodsTableTable extends FoodsTable
    with TableInfo<$FoodsTableTable, FoodsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gymIdMeta = const VerificationMeta('gymId');
  @override
  late final GeneratedColumn<String> gymId = GeneratedColumn<String>(
    'gym_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _servingSizeMeta = const VerificationMeta(
    'servingSize',
  );
  @override
  late final GeneratedColumn<double> servingSize = GeneratedColumn<double>(
    'serving_size',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _servingUnitMeta = const VerificationMeta(
    'servingUnit',
  );
  @override
  late final GeneratedColumn<String> servingUnit = GeneratedColumn<String>(
    'serving_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('g'),
  );
  static const VerificationMeta _caloriesKcalMeta = const VerificationMeta(
    'caloriesKcal',
  );
  @override
  late final GeneratedColumn<double> caloriesKcal = GeneratedColumn<double>(
    'calories_kcal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinGMeta = const VerificationMeta(
    'proteinG',
  );
  @override
  late final GeneratedColumn<double> proteinG = GeneratedColumn<double>(
    'protein_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbsGMeta = const VerificationMeta('carbsG');
  @override
  late final GeneratedColumn<double> carbsG = GeneratedColumn<double>(
    'carbs_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fatsGMeta = const VerificationMeta('fatsG');
  @override
  late final GeneratedColumn<double> fatsG = GeneratedColumn<double>(
    'fats_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fiberGMeta = const VerificationMeta('fiberG');
  @override
  late final GeneratedColumn<double> fiberG = GeneratedColumn<double>(
    'fiber_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sugarGMeta = const VerificationMeta('sugarG');
  @override
  late final GeneratedColumn<double> sugarG = GeneratedColumn<double>(
    'sugar_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sodiumMgMeta = const VerificationMeta(
    'sodiumMg',
  );
  @override
  late final GeneratedColumn<double> sodiumMg = GeneratedColumn<double>(
    'sodium_mg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isVerifiedMeta = const VerificationMeta(
    'isVerified',
  );
  @override
  late final GeneratedColumn<bool> isVerified = GeneratedColumn<bool>(
    'is_verified',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_verified" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isSystemMeta = const VerificationMeta(
    'isSystem',
  );
  @override
  late final GeneratedColumn<bool> isSystem = GeneratedColumn<bool>(
    'is_system',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_system" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local'),
  );
  static const VerificationMeta _externalIdMeta = const VerificationMeta(
    'externalId',
  );
  @override
  late final GeneratedColumn<String> externalId = GeneratedColumn<String>(
    'external_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gymId,
    name,
    brand,
    barcode,
    servingSize,
    servingUnit,
    caloriesKcal,
    proteinG,
    carbsG,
    fatsG,
    fiberG,
    sugarG,
    sodiumMg,
    isVerified,
    isSystem,
    createdBy,
    source,
    externalId,
    imageUrl,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'foods_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('gym_id')) {
      context.handle(
        _gymIdMeta,
        gymId.isAcceptableOrUnknown(data['gym_id']!, _gymIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    }
    if (data.containsKey('serving_size')) {
      context.handle(
        _servingSizeMeta,
        servingSize.isAcceptableOrUnknown(
          data['serving_size']!,
          _servingSizeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_servingSizeMeta);
    }
    if (data.containsKey('serving_unit')) {
      context.handle(
        _servingUnitMeta,
        servingUnit.isAcceptableOrUnknown(
          data['serving_unit']!,
          _servingUnitMeta,
        ),
      );
    }
    if (data.containsKey('calories_kcal')) {
      context.handle(
        _caloriesKcalMeta,
        caloriesKcal.isAcceptableOrUnknown(
          data['calories_kcal']!,
          _caloriesKcalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_caloriesKcalMeta);
    }
    if (data.containsKey('protein_g')) {
      context.handle(
        _proteinGMeta,
        proteinG.isAcceptableOrUnknown(data['protein_g']!, _proteinGMeta),
      );
    } else if (isInserting) {
      context.missing(_proteinGMeta);
    }
    if (data.containsKey('carbs_g')) {
      context.handle(
        _carbsGMeta,
        carbsG.isAcceptableOrUnknown(data['carbs_g']!, _carbsGMeta),
      );
    } else if (isInserting) {
      context.missing(_carbsGMeta);
    }
    if (data.containsKey('fats_g')) {
      context.handle(
        _fatsGMeta,
        fatsG.isAcceptableOrUnknown(data['fats_g']!, _fatsGMeta),
      );
    } else if (isInserting) {
      context.missing(_fatsGMeta);
    }
    if (data.containsKey('fiber_g')) {
      context.handle(
        _fiberGMeta,
        fiberG.isAcceptableOrUnknown(data['fiber_g']!, _fiberGMeta),
      );
    }
    if (data.containsKey('sugar_g')) {
      context.handle(
        _sugarGMeta,
        sugarG.isAcceptableOrUnknown(data['sugar_g']!, _sugarGMeta),
      );
    }
    if (data.containsKey('sodium_mg')) {
      context.handle(
        _sodiumMgMeta,
        sodiumMg.isAcceptableOrUnknown(data['sodium_mg']!, _sodiumMgMeta),
      );
    }
    if (data.containsKey('is_verified')) {
      context.handle(
        _isVerifiedMeta,
        isVerified.isAcceptableOrUnknown(data['is_verified']!, _isVerifiedMeta),
      );
    }
    if (data.containsKey('is_system')) {
      context.handle(
        _isSystemMeta,
        isSystem.isAcceptableOrUnknown(data['is_system']!, _isSystemMeta),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('external_id')) {
      context.handle(
        _externalIdMeta,
        externalId.isAcceptableOrUnknown(data['external_id']!, _externalIdMeta),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      gymId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gym_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      ),
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
      servingSize: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}serving_size'],
      )!,
      servingUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}serving_unit'],
      )!,
      caloriesKcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calories_kcal'],
      )!,
      proteinG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_g'],
      )!,
      carbsG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs_g'],
      )!,
      fatsG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fats_g'],
      )!,
      fiberG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fiber_g'],
      ),
      sugarG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sugar_g'],
      ),
      sodiumMg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sodium_mg'],
      ),
      isVerified: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_verified'],
      )!,
      isSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_system'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      externalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}external_id'],
      ),
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FoodsTableTable createAlias(String alias) {
    return $FoodsTableTable(attachedDatabase, alias);
  }
}

class FoodsTableData extends DataClass implements Insertable<FoodsTableData> {
  final String id;
  final String? gymId;
  final String name;
  final String? brand;
  final String? barcode;
  final double servingSize;
  final String servingUnit;
  final double caloriesKcal;
  final double proteinG;
  final double carbsG;
  final double fatsG;
  final double? fiberG;
  final double? sugarG;
  final double? sodiumMg;
  final bool isVerified;
  final bool isSystem;
  final String? createdBy;
  final String source;
  final String? externalId;
  final String? imageUrl;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FoodsTableData({
    required this.id,
    this.gymId,
    required this.name,
    this.brand,
    this.barcode,
    required this.servingSize,
    required this.servingUnit,
    required this.caloriesKcal,
    required this.proteinG,
    required this.carbsG,
    required this.fatsG,
    this.fiberG,
    this.sugarG,
    this.sodiumMg,
    required this.isVerified,
    required this.isSystem,
    this.createdBy,
    required this.source,
    this.externalId,
    this.imageUrl,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || gymId != null) {
      map['gym_id'] = Variable<String>(gymId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    map['serving_size'] = Variable<double>(servingSize);
    map['serving_unit'] = Variable<String>(servingUnit);
    map['calories_kcal'] = Variable<double>(caloriesKcal);
    map['protein_g'] = Variable<double>(proteinG);
    map['carbs_g'] = Variable<double>(carbsG);
    map['fats_g'] = Variable<double>(fatsG);
    if (!nullToAbsent || fiberG != null) {
      map['fiber_g'] = Variable<double>(fiberG);
    }
    if (!nullToAbsent || sugarG != null) {
      map['sugar_g'] = Variable<double>(sugarG);
    }
    if (!nullToAbsent || sodiumMg != null) {
      map['sodium_mg'] = Variable<double>(sodiumMg);
    }
    map['is_verified'] = Variable<bool>(isVerified);
    map['is_system'] = Variable<bool>(isSystem);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || externalId != null) {
      map['external_id'] = Variable<String>(externalId);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FoodsTableCompanion toCompanion(bool nullToAbsent) {
    return FoodsTableCompanion(
      id: Value(id),
      gymId: gymId == null && nullToAbsent
          ? const Value.absent()
          : Value(gymId),
      name: Value(name),
      brand: brand == null && nullToAbsent
          ? const Value.absent()
          : Value(brand),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      servingSize: Value(servingSize),
      servingUnit: Value(servingUnit),
      caloriesKcal: Value(caloriesKcal),
      proteinG: Value(proteinG),
      carbsG: Value(carbsG),
      fatsG: Value(fatsG),
      fiberG: fiberG == null && nullToAbsent
          ? const Value.absent()
          : Value(fiberG),
      sugarG: sugarG == null && nullToAbsent
          ? const Value.absent()
          : Value(sugarG),
      sodiumMg: sodiumMg == null && nullToAbsent
          ? const Value.absent()
          : Value(sodiumMg),
      isVerified: Value(isVerified),
      isSystem: Value(isSystem),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      source: Value(source),
      externalId: externalId == null && nullToAbsent
          ? const Value.absent()
          : Value(externalId),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FoodsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodsTableData(
      id: serializer.fromJson<String>(json['id']),
      gymId: serializer.fromJson<String?>(json['gymId']),
      name: serializer.fromJson<String>(json['name']),
      brand: serializer.fromJson<String?>(json['brand']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      servingSize: serializer.fromJson<double>(json['servingSize']),
      servingUnit: serializer.fromJson<String>(json['servingUnit']),
      caloriesKcal: serializer.fromJson<double>(json['caloriesKcal']),
      proteinG: serializer.fromJson<double>(json['proteinG']),
      carbsG: serializer.fromJson<double>(json['carbsG']),
      fatsG: serializer.fromJson<double>(json['fatsG']),
      fiberG: serializer.fromJson<double?>(json['fiberG']),
      sugarG: serializer.fromJson<double?>(json['sugarG']),
      sodiumMg: serializer.fromJson<double?>(json['sodiumMg']),
      isVerified: serializer.fromJson<bool>(json['isVerified']),
      isSystem: serializer.fromJson<bool>(json['isSystem']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      source: serializer.fromJson<String>(json['source']),
      externalId: serializer.fromJson<String?>(json['externalId']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'gymId': serializer.toJson<String?>(gymId),
      'name': serializer.toJson<String>(name),
      'brand': serializer.toJson<String?>(brand),
      'barcode': serializer.toJson<String?>(barcode),
      'servingSize': serializer.toJson<double>(servingSize),
      'servingUnit': serializer.toJson<String>(servingUnit),
      'caloriesKcal': serializer.toJson<double>(caloriesKcal),
      'proteinG': serializer.toJson<double>(proteinG),
      'carbsG': serializer.toJson<double>(carbsG),
      'fatsG': serializer.toJson<double>(fatsG),
      'fiberG': serializer.toJson<double?>(fiberG),
      'sugarG': serializer.toJson<double?>(sugarG),
      'sodiumMg': serializer.toJson<double?>(sodiumMg),
      'isVerified': serializer.toJson<bool>(isVerified),
      'isSystem': serializer.toJson<bool>(isSystem),
      'createdBy': serializer.toJson<String?>(createdBy),
      'source': serializer.toJson<String>(source),
      'externalId': serializer.toJson<String?>(externalId),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FoodsTableData copyWith({
    String? id,
    Value<String?> gymId = const Value.absent(),
    String? name,
    Value<String?> brand = const Value.absent(),
    Value<String?> barcode = const Value.absent(),
    double? servingSize,
    String? servingUnit,
    double? caloriesKcal,
    double? proteinG,
    double? carbsG,
    double? fatsG,
    Value<double?> fiberG = const Value.absent(),
    Value<double?> sugarG = const Value.absent(),
    Value<double?> sodiumMg = const Value.absent(),
    bool? isVerified,
    bool? isSystem,
    Value<String?> createdBy = const Value.absent(),
    String? source,
    Value<String?> externalId = const Value.absent(),
    Value<String?> imageUrl = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FoodsTableData(
    id: id ?? this.id,
    gymId: gymId.present ? gymId.value : this.gymId,
    name: name ?? this.name,
    brand: brand.present ? brand.value : this.brand,
    barcode: barcode.present ? barcode.value : this.barcode,
    servingSize: servingSize ?? this.servingSize,
    servingUnit: servingUnit ?? this.servingUnit,
    caloriesKcal: caloriesKcal ?? this.caloriesKcal,
    proteinG: proteinG ?? this.proteinG,
    carbsG: carbsG ?? this.carbsG,
    fatsG: fatsG ?? this.fatsG,
    fiberG: fiberG.present ? fiberG.value : this.fiberG,
    sugarG: sugarG.present ? sugarG.value : this.sugarG,
    sodiumMg: sodiumMg.present ? sodiumMg.value : this.sodiumMg,
    isVerified: isVerified ?? this.isVerified,
    isSystem: isSystem ?? this.isSystem,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    source: source ?? this.source,
    externalId: externalId.present ? externalId.value : this.externalId,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FoodsTableData copyWithCompanion(FoodsTableCompanion data) {
    return FoodsTableData(
      id: data.id.present ? data.id.value : this.id,
      gymId: data.gymId.present ? data.gymId.value : this.gymId,
      name: data.name.present ? data.name.value : this.name,
      brand: data.brand.present ? data.brand.value : this.brand,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      servingSize: data.servingSize.present
          ? data.servingSize.value
          : this.servingSize,
      servingUnit: data.servingUnit.present
          ? data.servingUnit.value
          : this.servingUnit,
      caloriesKcal: data.caloriesKcal.present
          ? data.caloriesKcal.value
          : this.caloriesKcal,
      proteinG: data.proteinG.present ? data.proteinG.value : this.proteinG,
      carbsG: data.carbsG.present ? data.carbsG.value : this.carbsG,
      fatsG: data.fatsG.present ? data.fatsG.value : this.fatsG,
      fiberG: data.fiberG.present ? data.fiberG.value : this.fiberG,
      sugarG: data.sugarG.present ? data.sugarG.value : this.sugarG,
      sodiumMg: data.sodiumMg.present ? data.sodiumMg.value : this.sodiumMg,
      isVerified: data.isVerified.present
          ? data.isVerified.value
          : this.isVerified,
      isSystem: data.isSystem.present ? data.isSystem.value : this.isSystem,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      source: data.source.present ? data.source.value : this.source,
      externalId: data.externalId.present
          ? data.externalId.value
          : this.externalId,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodsTableData(')
          ..write('id: $id, ')
          ..write('gymId: $gymId, ')
          ..write('name: $name, ')
          ..write('brand: $brand, ')
          ..write('barcode: $barcode, ')
          ..write('servingSize: $servingSize, ')
          ..write('servingUnit: $servingUnit, ')
          ..write('caloriesKcal: $caloriesKcal, ')
          ..write('proteinG: $proteinG, ')
          ..write('carbsG: $carbsG, ')
          ..write('fatsG: $fatsG, ')
          ..write('fiberG: $fiberG, ')
          ..write('sugarG: $sugarG, ')
          ..write('sodiumMg: $sodiumMg, ')
          ..write('isVerified: $isVerified, ')
          ..write('isSystem: $isSystem, ')
          ..write('createdBy: $createdBy, ')
          ..write('source: $source, ')
          ..write('externalId: $externalId, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    gymId,
    name,
    brand,
    barcode,
    servingSize,
    servingUnit,
    caloriesKcal,
    proteinG,
    carbsG,
    fatsG,
    fiberG,
    sugarG,
    sodiumMg,
    isVerified,
    isSystem,
    createdBy,
    source,
    externalId,
    imageUrl,
    isActive,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodsTableData &&
          other.id == this.id &&
          other.gymId == this.gymId &&
          other.name == this.name &&
          other.brand == this.brand &&
          other.barcode == this.barcode &&
          other.servingSize == this.servingSize &&
          other.servingUnit == this.servingUnit &&
          other.caloriesKcal == this.caloriesKcal &&
          other.proteinG == this.proteinG &&
          other.carbsG == this.carbsG &&
          other.fatsG == this.fatsG &&
          other.fiberG == this.fiberG &&
          other.sugarG == this.sugarG &&
          other.sodiumMg == this.sodiumMg &&
          other.isVerified == this.isVerified &&
          other.isSystem == this.isSystem &&
          other.createdBy == this.createdBy &&
          other.source == this.source &&
          other.externalId == this.externalId &&
          other.imageUrl == this.imageUrl &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FoodsTableCompanion extends UpdateCompanion<FoodsTableData> {
  final Value<String> id;
  final Value<String?> gymId;
  final Value<String> name;
  final Value<String?> brand;
  final Value<String?> barcode;
  final Value<double> servingSize;
  final Value<String> servingUnit;
  final Value<double> caloriesKcal;
  final Value<double> proteinG;
  final Value<double> carbsG;
  final Value<double> fatsG;
  final Value<double?> fiberG;
  final Value<double?> sugarG;
  final Value<double?> sodiumMg;
  final Value<bool> isVerified;
  final Value<bool> isSystem;
  final Value<String?> createdBy;
  final Value<String> source;
  final Value<String?> externalId;
  final Value<String?> imageUrl;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FoodsTableCompanion({
    this.id = const Value.absent(),
    this.gymId = const Value.absent(),
    this.name = const Value.absent(),
    this.brand = const Value.absent(),
    this.barcode = const Value.absent(),
    this.servingSize = const Value.absent(),
    this.servingUnit = const Value.absent(),
    this.caloriesKcal = const Value.absent(),
    this.proteinG = const Value.absent(),
    this.carbsG = const Value.absent(),
    this.fatsG = const Value.absent(),
    this.fiberG = const Value.absent(),
    this.sugarG = const Value.absent(),
    this.sodiumMg = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.source = const Value.absent(),
    this.externalId = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FoodsTableCompanion.insert({
    required String id,
    this.gymId = const Value.absent(),
    required String name,
    this.brand = const Value.absent(),
    this.barcode = const Value.absent(),
    required double servingSize,
    this.servingUnit = const Value.absent(),
    required double caloriesKcal,
    required double proteinG,
    required double carbsG,
    required double fatsG,
    this.fiberG = const Value.absent(),
    this.sugarG = const Value.absent(),
    this.sodiumMg = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.source = const Value.absent(),
    this.externalId = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       servingSize = Value(servingSize),
       caloriesKcal = Value(caloriesKcal),
       proteinG = Value(proteinG),
       carbsG = Value(carbsG),
       fatsG = Value(fatsG),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FoodsTableData> custom({
    Expression<String>? id,
    Expression<String>? gymId,
    Expression<String>? name,
    Expression<String>? brand,
    Expression<String>? barcode,
    Expression<double>? servingSize,
    Expression<String>? servingUnit,
    Expression<double>? caloriesKcal,
    Expression<double>? proteinG,
    Expression<double>? carbsG,
    Expression<double>? fatsG,
    Expression<double>? fiberG,
    Expression<double>? sugarG,
    Expression<double>? sodiumMg,
    Expression<bool>? isVerified,
    Expression<bool>? isSystem,
    Expression<String>? createdBy,
    Expression<String>? source,
    Expression<String>? externalId,
    Expression<String>? imageUrl,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gymId != null) 'gym_id': gymId,
      if (name != null) 'name': name,
      if (brand != null) 'brand': brand,
      if (barcode != null) 'barcode': barcode,
      if (servingSize != null) 'serving_size': servingSize,
      if (servingUnit != null) 'serving_unit': servingUnit,
      if (caloriesKcal != null) 'calories_kcal': caloriesKcal,
      if (proteinG != null) 'protein_g': proteinG,
      if (carbsG != null) 'carbs_g': carbsG,
      if (fatsG != null) 'fats_g': fatsG,
      if (fiberG != null) 'fiber_g': fiberG,
      if (sugarG != null) 'sugar_g': sugarG,
      if (sodiumMg != null) 'sodium_mg': sodiumMg,
      if (isVerified != null) 'is_verified': isVerified,
      if (isSystem != null) 'is_system': isSystem,
      if (createdBy != null) 'created_by': createdBy,
      if (source != null) 'source': source,
      if (externalId != null) 'external_id': externalId,
      if (imageUrl != null) 'image_url': imageUrl,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FoodsTableCompanion copyWith({
    Value<String>? id,
    Value<String?>? gymId,
    Value<String>? name,
    Value<String?>? brand,
    Value<String?>? barcode,
    Value<double>? servingSize,
    Value<String>? servingUnit,
    Value<double>? caloriesKcal,
    Value<double>? proteinG,
    Value<double>? carbsG,
    Value<double>? fatsG,
    Value<double?>? fiberG,
    Value<double?>? sugarG,
    Value<double?>? sodiumMg,
    Value<bool>? isVerified,
    Value<bool>? isSystem,
    Value<String?>? createdBy,
    Value<String>? source,
    Value<String?>? externalId,
    Value<String?>? imageUrl,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FoodsTableCompanion(
      id: id ?? this.id,
      gymId: gymId ?? this.gymId,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      barcode: barcode ?? this.barcode,
      servingSize: servingSize ?? this.servingSize,
      servingUnit: servingUnit ?? this.servingUnit,
      caloriesKcal: caloriesKcal ?? this.caloriesKcal,
      proteinG: proteinG ?? this.proteinG,
      carbsG: carbsG ?? this.carbsG,
      fatsG: fatsG ?? this.fatsG,
      fiberG: fiberG ?? this.fiberG,
      sugarG: sugarG ?? this.sugarG,
      sodiumMg: sodiumMg ?? this.sodiumMg,
      isVerified: isVerified ?? this.isVerified,
      isSystem: isSystem ?? this.isSystem,
      createdBy: createdBy ?? this.createdBy,
      source: source ?? this.source,
      externalId: externalId ?? this.externalId,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (gymId.present) {
      map['gym_id'] = Variable<String>(gymId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (servingSize.present) {
      map['serving_size'] = Variable<double>(servingSize.value);
    }
    if (servingUnit.present) {
      map['serving_unit'] = Variable<String>(servingUnit.value);
    }
    if (caloriesKcal.present) {
      map['calories_kcal'] = Variable<double>(caloriesKcal.value);
    }
    if (proteinG.present) {
      map['protein_g'] = Variable<double>(proteinG.value);
    }
    if (carbsG.present) {
      map['carbs_g'] = Variable<double>(carbsG.value);
    }
    if (fatsG.present) {
      map['fats_g'] = Variable<double>(fatsG.value);
    }
    if (fiberG.present) {
      map['fiber_g'] = Variable<double>(fiberG.value);
    }
    if (sugarG.present) {
      map['sugar_g'] = Variable<double>(sugarG.value);
    }
    if (sodiumMg.present) {
      map['sodium_mg'] = Variable<double>(sodiumMg.value);
    }
    if (isVerified.present) {
      map['is_verified'] = Variable<bool>(isVerified.value);
    }
    if (isSystem.present) {
      map['is_system'] = Variable<bool>(isSystem.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (externalId.present) {
      map['external_id'] = Variable<String>(externalId.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodsTableCompanion(')
          ..write('id: $id, ')
          ..write('gymId: $gymId, ')
          ..write('name: $name, ')
          ..write('brand: $brand, ')
          ..write('barcode: $barcode, ')
          ..write('servingSize: $servingSize, ')
          ..write('servingUnit: $servingUnit, ')
          ..write('caloriesKcal: $caloriesKcal, ')
          ..write('proteinG: $proteinG, ')
          ..write('carbsG: $carbsG, ')
          ..write('fatsG: $fatsG, ')
          ..write('fiberG: $fiberG, ')
          ..write('sugarG: $sugarG, ')
          ..write('sodiumMg: $sodiumMg, ')
          ..write('isVerified: $isVerified, ')
          ..write('isSystem: $isSystem, ')
          ..write('createdBy: $createdBy, ')
          ..write('source: $source, ')
          ..write('externalId: $externalId, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NutritionPlansTable extends NutritionPlans
    with TableInfo<$NutritionPlansTable, NutritionPlan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NutritionPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gymIdMeta = const VerificationMeta('gymId');
  @override
  late final GeneratedColumn<String> gymId = GeneratedColumn<String>(
    'gym_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nutritionistIdMeta = const VerificationMeta(
    'nutritionistId',
  );
  @override
  late final GeneratedColumn<String> nutritionistId = GeneratedColumn<String>(
    'nutritionist_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalMeta = const VerificationMeta('goal');
  @override
  late final GeneratedColumn<String> goal = GeneratedColumn<String>(
    'goal',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetCaloriesKcalMeta =
      const VerificationMeta('targetCaloriesKcal');
  @override
  late final GeneratedColumn<double> targetCaloriesKcal =
      GeneratedColumn<double>(
        'target_calories_kcal',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _targetProteinGMeta = const VerificationMeta(
    'targetProteinG',
  );
  @override
  late final GeneratedColumn<double> targetProteinG = GeneratedColumn<double>(
    'target_protein_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetCarbsGMeta = const VerificationMeta(
    'targetCarbsG',
  );
  @override
  late final GeneratedColumn<double> targetCarbsG = GeneratedColumn<double>(
    'target_carbs_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetFatsGMeta = const VerificationMeta(
    'targetFatsG',
  );
  @override
  late final GeneratedColumn<double> targetFatsG = GeneratedColumn<double>(
    'target_fats_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationDaysMeta = const VerificationMeta(
    'durationDays',
  );
  @override
  late final GeneratedColumn<int> durationDays = GeneratedColumn<int>(
    'duration_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gymId,
    clientId,
    nutritionistId,
    name,
    goal,
    targetCaloriesKcal,
    targetProteinG,
    targetCarbsG,
    targetFatsG,
    durationDays,
    notes,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nutrition_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<NutritionPlan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('gym_id')) {
      context.handle(
        _gymIdMeta,
        gymId.isAcceptableOrUnknown(data['gym_id']!, _gymIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gymIdMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('nutritionist_id')) {
      context.handle(
        _nutritionistIdMeta,
        nutritionistId.isAcceptableOrUnknown(
          data['nutritionist_id']!,
          _nutritionistIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nutritionistIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('goal')) {
      context.handle(
        _goalMeta,
        goal.isAcceptableOrUnknown(data['goal']!, _goalMeta),
      );
    }
    if (data.containsKey('target_calories_kcal')) {
      context.handle(
        _targetCaloriesKcalMeta,
        targetCaloriesKcal.isAcceptableOrUnknown(
          data['target_calories_kcal']!,
          _targetCaloriesKcalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetCaloriesKcalMeta);
    }
    if (data.containsKey('target_protein_g')) {
      context.handle(
        _targetProteinGMeta,
        targetProteinG.isAcceptableOrUnknown(
          data['target_protein_g']!,
          _targetProteinGMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetProteinGMeta);
    }
    if (data.containsKey('target_carbs_g')) {
      context.handle(
        _targetCarbsGMeta,
        targetCarbsG.isAcceptableOrUnknown(
          data['target_carbs_g']!,
          _targetCarbsGMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetCarbsGMeta);
    }
    if (data.containsKey('target_fats_g')) {
      context.handle(
        _targetFatsGMeta,
        targetFatsG.isAcceptableOrUnknown(
          data['target_fats_g']!,
          _targetFatsGMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetFatsGMeta);
    }
    if (data.containsKey('duration_days')) {
      context.handle(
        _durationDaysMeta,
        durationDays.isAcceptableOrUnknown(
          data['duration_days']!,
          _durationDaysMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationDaysMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NutritionPlan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NutritionPlan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      gymId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gym_id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      nutritionistId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nutritionist_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      goal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal'],
      ),
      targetCaloriesKcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_calories_kcal'],
      )!,
      targetProteinG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_protein_g'],
      )!,
      targetCarbsG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_carbs_g'],
      )!,
      targetFatsG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_fats_g'],
      )!,
      durationDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_days'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $NutritionPlansTable createAlias(String alias) {
    return $NutritionPlansTable(attachedDatabase, alias);
  }
}

class NutritionPlan extends DataClass implements Insertable<NutritionPlan> {
  final String id;
  final String gymId;
  final String clientId;
  final String nutritionistId;
  final String name;
  final String? goal;
  final double targetCaloriesKcal;
  final double targetProteinG;
  final double targetCarbsG;
  final double targetFatsG;
  final int durationDays;
  final String? notes;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const NutritionPlan({
    required this.id,
    required this.gymId,
    required this.clientId,
    required this.nutritionistId,
    required this.name,
    this.goal,
    required this.targetCaloriesKcal,
    required this.targetProteinG,
    required this.targetCarbsG,
    required this.targetFatsG,
    required this.durationDays,
    this.notes,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['gym_id'] = Variable<String>(gymId);
    map['client_id'] = Variable<String>(clientId);
    map['nutritionist_id'] = Variable<String>(nutritionistId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || goal != null) {
      map['goal'] = Variable<String>(goal);
    }
    map['target_calories_kcal'] = Variable<double>(targetCaloriesKcal);
    map['target_protein_g'] = Variable<double>(targetProteinG);
    map['target_carbs_g'] = Variable<double>(targetCarbsG);
    map['target_fats_g'] = Variable<double>(targetFatsG);
    map['duration_days'] = Variable<int>(durationDays);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  NutritionPlansCompanion toCompanion(bool nullToAbsent) {
    return NutritionPlansCompanion(
      id: Value(id),
      gymId: Value(gymId),
      clientId: Value(clientId),
      nutritionistId: Value(nutritionistId),
      name: Value(name),
      goal: goal == null && nullToAbsent ? const Value.absent() : Value(goal),
      targetCaloriesKcal: Value(targetCaloriesKcal),
      targetProteinG: Value(targetProteinG),
      targetCarbsG: Value(targetCarbsG),
      targetFatsG: Value(targetFatsG),
      durationDays: Value(durationDays),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory NutritionPlan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NutritionPlan(
      id: serializer.fromJson<String>(json['id']),
      gymId: serializer.fromJson<String>(json['gymId']),
      clientId: serializer.fromJson<String>(json['clientId']),
      nutritionistId: serializer.fromJson<String>(json['nutritionistId']),
      name: serializer.fromJson<String>(json['name']),
      goal: serializer.fromJson<String?>(json['goal']),
      targetCaloriesKcal: serializer.fromJson<double>(
        json['targetCaloriesKcal'],
      ),
      targetProteinG: serializer.fromJson<double>(json['targetProteinG']),
      targetCarbsG: serializer.fromJson<double>(json['targetCarbsG']),
      targetFatsG: serializer.fromJson<double>(json['targetFatsG']),
      durationDays: serializer.fromJson<int>(json['durationDays']),
      notes: serializer.fromJson<String?>(json['notes']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'gymId': serializer.toJson<String>(gymId),
      'clientId': serializer.toJson<String>(clientId),
      'nutritionistId': serializer.toJson<String>(nutritionistId),
      'name': serializer.toJson<String>(name),
      'goal': serializer.toJson<String?>(goal),
      'targetCaloriesKcal': serializer.toJson<double>(targetCaloriesKcal),
      'targetProteinG': serializer.toJson<double>(targetProteinG),
      'targetCarbsG': serializer.toJson<double>(targetCarbsG),
      'targetFatsG': serializer.toJson<double>(targetFatsG),
      'durationDays': serializer.toJson<int>(durationDays),
      'notes': serializer.toJson<String?>(notes),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  NutritionPlan copyWith({
    String? id,
    String? gymId,
    String? clientId,
    String? nutritionistId,
    String? name,
    Value<String?> goal = const Value.absent(),
    double? targetCaloriesKcal,
    double? targetProteinG,
    double? targetCarbsG,
    double? targetFatsG,
    int? durationDays,
    Value<String?> notes = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => NutritionPlan(
    id: id ?? this.id,
    gymId: gymId ?? this.gymId,
    clientId: clientId ?? this.clientId,
    nutritionistId: nutritionistId ?? this.nutritionistId,
    name: name ?? this.name,
    goal: goal.present ? goal.value : this.goal,
    targetCaloriesKcal: targetCaloriesKcal ?? this.targetCaloriesKcal,
    targetProteinG: targetProteinG ?? this.targetProteinG,
    targetCarbsG: targetCarbsG ?? this.targetCarbsG,
    targetFatsG: targetFatsG ?? this.targetFatsG,
    durationDays: durationDays ?? this.durationDays,
    notes: notes.present ? notes.value : this.notes,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  NutritionPlan copyWithCompanion(NutritionPlansCompanion data) {
    return NutritionPlan(
      id: data.id.present ? data.id.value : this.id,
      gymId: data.gymId.present ? data.gymId.value : this.gymId,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      nutritionistId: data.nutritionistId.present
          ? data.nutritionistId.value
          : this.nutritionistId,
      name: data.name.present ? data.name.value : this.name,
      goal: data.goal.present ? data.goal.value : this.goal,
      targetCaloriesKcal: data.targetCaloriesKcal.present
          ? data.targetCaloriesKcal.value
          : this.targetCaloriesKcal,
      targetProteinG: data.targetProteinG.present
          ? data.targetProteinG.value
          : this.targetProteinG,
      targetCarbsG: data.targetCarbsG.present
          ? data.targetCarbsG.value
          : this.targetCarbsG,
      targetFatsG: data.targetFatsG.present
          ? data.targetFatsG.value
          : this.targetFatsG,
      durationDays: data.durationDays.present
          ? data.durationDays.value
          : this.durationDays,
      notes: data.notes.present ? data.notes.value : this.notes,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NutritionPlan(')
          ..write('id: $id, ')
          ..write('gymId: $gymId, ')
          ..write('clientId: $clientId, ')
          ..write('nutritionistId: $nutritionistId, ')
          ..write('name: $name, ')
          ..write('goal: $goal, ')
          ..write('targetCaloriesKcal: $targetCaloriesKcal, ')
          ..write('targetProteinG: $targetProteinG, ')
          ..write('targetCarbsG: $targetCarbsG, ')
          ..write('targetFatsG: $targetFatsG, ')
          ..write('durationDays: $durationDays, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    gymId,
    clientId,
    nutritionistId,
    name,
    goal,
    targetCaloriesKcal,
    targetProteinG,
    targetCarbsG,
    targetFatsG,
    durationDays,
    notes,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NutritionPlan &&
          other.id == this.id &&
          other.gymId == this.gymId &&
          other.clientId == this.clientId &&
          other.nutritionistId == this.nutritionistId &&
          other.name == this.name &&
          other.goal == this.goal &&
          other.targetCaloriesKcal == this.targetCaloriesKcal &&
          other.targetProteinG == this.targetProteinG &&
          other.targetCarbsG == this.targetCarbsG &&
          other.targetFatsG == this.targetFatsG &&
          other.durationDays == this.durationDays &&
          other.notes == this.notes &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class NutritionPlansCompanion extends UpdateCompanion<NutritionPlan> {
  final Value<String> id;
  final Value<String> gymId;
  final Value<String> clientId;
  final Value<String> nutritionistId;
  final Value<String> name;
  final Value<String?> goal;
  final Value<double> targetCaloriesKcal;
  final Value<double> targetProteinG;
  final Value<double> targetCarbsG;
  final Value<double> targetFatsG;
  final Value<int> durationDays;
  final Value<String?> notes;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const NutritionPlansCompanion({
    this.id = const Value.absent(),
    this.gymId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.nutritionistId = const Value.absent(),
    this.name = const Value.absent(),
    this.goal = const Value.absent(),
    this.targetCaloriesKcal = const Value.absent(),
    this.targetProteinG = const Value.absent(),
    this.targetCarbsG = const Value.absent(),
    this.targetFatsG = const Value.absent(),
    this.durationDays = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NutritionPlansCompanion.insert({
    required String id,
    required String gymId,
    required String clientId,
    required String nutritionistId,
    required String name,
    this.goal = const Value.absent(),
    required double targetCaloriesKcal,
    required double targetProteinG,
    required double targetCarbsG,
    required double targetFatsG,
    required int durationDays,
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       gymId = Value(gymId),
       clientId = Value(clientId),
       nutritionistId = Value(nutritionistId),
       name = Value(name),
       targetCaloriesKcal = Value(targetCaloriesKcal),
       targetProteinG = Value(targetProteinG),
       targetCarbsG = Value(targetCarbsG),
       targetFatsG = Value(targetFatsG),
       durationDays = Value(durationDays),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<NutritionPlan> custom({
    Expression<String>? id,
    Expression<String>? gymId,
    Expression<String>? clientId,
    Expression<String>? nutritionistId,
    Expression<String>? name,
    Expression<String>? goal,
    Expression<double>? targetCaloriesKcal,
    Expression<double>? targetProteinG,
    Expression<double>? targetCarbsG,
    Expression<double>? targetFatsG,
    Expression<int>? durationDays,
    Expression<String>? notes,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gymId != null) 'gym_id': gymId,
      if (clientId != null) 'client_id': clientId,
      if (nutritionistId != null) 'nutritionist_id': nutritionistId,
      if (name != null) 'name': name,
      if (goal != null) 'goal': goal,
      if (targetCaloriesKcal != null)
        'target_calories_kcal': targetCaloriesKcal,
      if (targetProteinG != null) 'target_protein_g': targetProteinG,
      if (targetCarbsG != null) 'target_carbs_g': targetCarbsG,
      if (targetFatsG != null) 'target_fats_g': targetFatsG,
      if (durationDays != null) 'duration_days': durationDays,
      if (notes != null) 'notes': notes,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NutritionPlansCompanion copyWith({
    Value<String>? id,
    Value<String>? gymId,
    Value<String>? clientId,
    Value<String>? nutritionistId,
    Value<String>? name,
    Value<String?>? goal,
    Value<double>? targetCaloriesKcal,
    Value<double>? targetProteinG,
    Value<double>? targetCarbsG,
    Value<double>? targetFatsG,
    Value<int>? durationDays,
    Value<String?>? notes,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return NutritionPlansCompanion(
      id: id ?? this.id,
      gymId: gymId ?? this.gymId,
      clientId: clientId ?? this.clientId,
      nutritionistId: nutritionistId ?? this.nutritionistId,
      name: name ?? this.name,
      goal: goal ?? this.goal,
      targetCaloriesKcal: targetCaloriesKcal ?? this.targetCaloriesKcal,
      targetProteinG: targetProteinG ?? this.targetProteinG,
      targetCarbsG: targetCarbsG ?? this.targetCarbsG,
      targetFatsG: targetFatsG ?? this.targetFatsG,
      durationDays: durationDays ?? this.durationDays,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (gymId.present) {
      map['gym_id'] = Variable<String>(gymId.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (nutritionistId.present) {
      map['nutritionist_id'] = Variable<String>(nutritionistId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (goal.present) {
      map['goal'] = Variable<String>(goal.value);
    }
    if (targetCaloriesKcal.present) {
      map['target_calories_kcal'] = Variable<double>(targetCaloriesKcal.value);
    }
    if (targetProteinG.present) {
      map['target_protein_g'] = Variable<double>(targetProteinG.value);
    }
    if (targetCarbsG.present) {
      map['target_carbs_g'] = Variable<double>(targetCarbsG.value);
    }
    if (targetFatsG.present) {
      map['target_fats_g'] = Variable<double>(targetFatsG.value);
    }
    if (durationDays.present) {
      map['duration_days'] = Variable<int>(durationDays.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NutritionPlansCompanion(')
          ..write('id: $id, ')
          ..write('gymId: $gymId, ')
          ..write('clientId: $clientId, ')
          ..write('nutritionistId: $nutritionistId, ')
          ..write('name: $name, ')
          ..write('goal: $goal, ')
          ..write('targetCaloriesKcal: $targetCaloriesKcal, ')
          ..write('targetProteinG: $targetProteinG, ')
          ..write('targetCarbsG: $targetCarbsG, ')
          ..write('targetFatsG: $targetFatsG, ')
          ..write('durationDays: $durationDays, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NutritionGoalsTable extends NutritionGoals
    with TableInfo<$NutritionGoalsTable, NutritionGoal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NutritionGoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gymIdMeta = const VerificationMeta('gymId');
  @override
  late final GeneratedColumn<String> gymId = GeneratedColumn<String>(
    'gym_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _setByMeta = const VerificationMeta('setBy');
  @override
  late final GeneratedColumn<String> setBy = GeneratedColumn<String>(
    'set_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetCaloriesKcalMeta =
      const VerificationMeta('targetCaloriesKcal');
  @override
  late final GeneratedColumn<double> targetCaloriesKcal =
      GeneratedColumn<double>(
        'target_calories_kcal',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _targetProteinGMeta = const VerificationMeta(
    'targetProteinG',
  );
  @override
  late final GeneratedColumn<double> targetProteinG = GeneratedColumn<double>(
    'target_protein_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetCarbsGMeta = const VerificationMeta(
    'targetCarbsG',
  );
  @override
  late final GeneratedColumn<double> targetCarbsG = GeneratedColumn<double>(
    'target_carbs_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetFatsGMeta = const VerificationMeta(
    'targetFatsG',
  );
  @override
  late final GeneratedColumn<double> targetFatsG = GeneratedColumn<double>(
    'target_fats_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalTypeMeta = const VerificationMeta(
    'goalType',
  );
  @override
  late final GeneratedColumn<String> goalType = GeneratedColumn<String>(
    'goal_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('maintain'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    gymId,
    setBy,
    targetCaloriesKcal,
    targetProteinG,
    targetCarbsG,
    targetFatsG,
    goalType,
    notes,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nutrition_goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<NutritionGoal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('gym_id')) {
      context.handle(
        _gymIdMeta,
        gymId.isAcceptableOrUnknown(data['gym_id']!, _gymIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gymIdMeta);
    }
    if (data.containsKey('set_by')) {
      context.handle(
        _setByMeta,
        setBy.isAcceptableOrUnknown(data['set_by']!, _setByMeta),
      );
    }
    if (data.containsKey('target_calories_kcal')) {
      context.handle(
        _targetCaloriesKcalMeta,
        targetCaloriesKcal.isAcceptableOrUnknown(
          data['target_calories_kcal']!,
          _targetCaloriesKcalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetCaloriesKcalMeta);
    }
    if (data.containsKey('target_protein_g')) {
      context.handle(
        _targetProteinGMeta,
        targetProteinG.isAcceptableOrUnknown(
          data['target_protein_g']!,
          _targetProteinGMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetProteinGMeta);
    }
    if (data.containsKey('target_carbs_g')) {
      context.handle(
        _targetCarbsGMeta,
        targetCarbsG.isAcceptableOrUnknown(
          data['target_carbs_g']!,
          _targetCarbsGMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetCarbsGMeta);
    }
    if (data.containsKey('target_fats_g')) {
      context.handle(
        _targetFatsGMeta,
        targetFatsG.isAcceptableOrUnknown(
          data['target_fats_g']!,
          _targetFatsGMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetFatsGMeta);
    }
    if (data.containsKey('goal_type')) {
      context.handle(
        _goalTypeMeta,
        goalType.isAcceptableOrUnknown(data['goal_type']!, _goalTypeMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NutritionGoal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NutritionGoal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      gymId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gym_id'],
      )!,
      setBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}set_by'],
      ),
      targetCaloriesKcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_calories_kcal'],
      )!,
      targetProteinG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_protein_g'],
      )!,
      targetCarbsG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_carbs_g'],
      )!,
      targetFatsG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_fats_g'],
      )!,
      goalType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_type'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $NutritionGoalsTable createAlias(String alias) {
    return $NutritionGoalsTable(attachedDatabase, alias);
  }
}

class NutritionGoal extends DataClass implements Insertable<NutritionGoal> {
  final String id;
  final String clientId;
  final String gymId;
  final String? setBy;
  final double targetCaloriesKcal;
  final double targetProteinG;
  final double targetCarbsG;
  final double targetFatsG;
  final String goalType;
  final String? notes;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const NutritionGoal({
    required this.id,
    required this.clientId,
    required this.gymId,
    this.setBy,
    required this.targetCaloriesKcal,
    required this.targetProteinG,
    required this.targetCarbsG,
    required this.targetFatsG,
    required this.goalType,
    this.notes,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['client_id'] = Variable<String>(clientId);
    map['gym_id'] = Variable<String>(gymId);
    if (!nullToAbsent || setBy != null) {
      map['set_by'] = Variable<String>(setBy);
    }
    map['target_calories_kcal'] = Variable<double>(targetCaloriesKcal);
    map['target_protein_g'] = Variable<double>(targetProteinG);
    map['target_carbs_g'] = Variable<double>(targetCarbsG);
    map['target_fats_g'] = Variable<double>(targetFatsG);
    map['goal_type'] = Variable<String>(goalType);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  NutritionGoalsCompanion toCompanion(bool nullToAbsent) {
    return NutritionGoalsCompanion(
      id: Value(id),
      clientId: Value(clientId),
      gymId: Value(gymId),
      setBy: setBy == null && nullToAbsent
          ? const Value.absent()
          : Value(setBy),
      targetCaloriesKcal: Value(targetCaloriesKcal),
      targetProteinG: Value(targetProteinG),
      targetCarbsG: Value(targetCarbsG),
      targetFatsG: Value(targetFatsG),
      goalType: Value(goalType),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory NutritionGoal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NutritionGoal(
      id: serializer.fromJson<String>(json['id']),
      clientId: serializer.fromJson<String>(json['clientId']),
      gymId: serializer.fromJson<String>(json['gymId']),
      setBy: serializer.fromJson<String?>(json['setBy']),
      targetCaloriesKcal: serializer.fromJson<double>(
        json['targetCaloriesKcal'],
      ),
      targetProteinG: serializer.fromJson<double>(json['targetProteinG']),
      targetCarbsG: serializer.fromJson<double>(json['targetCarbsG']),
      targetFatsG: serializer.fromJson<double>(json['targetFatsG']),
      goalType: serializer.fromJson<String>(json['goalType']),
      notes: serializer.fromJson<String?>(json['notes']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clientId': serializer.toJson<String>(clientId),
      'gymId': serializer.toJson<String>(gymId),
      'setBy': serializer.toJson<String?>(setBy),
      'targetCaloriesKcal': serializer.toJson<double>(targetCaloriesKcal),
      'targetProteinG': serializer.toJson<double>(targetProteinG),
      'targetCarbsG': serializer.toJson<double>(targetCarbsG),
      'targetFatsG': serializer.toJson<double>(targetFatsG),
      'goalType': serializer.toJson<String>(goalType),
      'notes': serializer.toJson<String?>(notes),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  NutritionGoal copyWith({
    String? id,
    String? clientId,
    String? gymId,
    Value<String?> setBy = const Value.absent(),
    double? targetCaloriesKcal,
    double? targetProteinG,
    double? targetCarbsG,
    double? targetFatsG,
    String? goalType,
    Value<String?> notes = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => NutritionGoal(
    id: id ?? this.id,
    clientId: clientId ?? this.clientId,
    gymId: gymId ?? this.gymId,
    setBy: setBy.present ? setBy.value : this.setBy,
    targetCaloriesKcal: targetCaloriesKcal ?? this.targetCaloriesKcal,
    targetProteinG: targetProteinG ?? this.targetProteinG,
    targetCarbsG: targetCarbsG ?? this.targetCarbsG,
    targetFatsG: targetFatsG ?? this.targetFatsG,
    goalType: goalType ?? this.goalType,
    notes: notes.present ? notes.value : this.notes,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  NutritionGoal copyWithCompanion(NutritionGoalsCompanion data) {
    return NutritionGoal(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      gymId: data.gymId.present ? data.gymId.value : this.gymId,
      setBy: data.setBy.present ? data.setBy.value : this.setBy,
      targetCaloriesKcal: data.targetCaloriesKcal.present
          ? data.targetCaloriesKcal.value
          : this.targetCaloriesKcal,
      targetProteinG: data.targetProteinG.present
          ? data.targetProteinG.value
          : this.targetProteinG,
      targetCarbsG: data.targetCarbsG.present
          ? data.targetCarbsG.value
          : this.targetCarbsG,
      targetFatsG: data.targetFatsG.present
          ? data.targetFatsG.value
          : this.targetFatsG,
      goalType: data.goalType.present ? data.goalType.value : this.goalType,
      notes: data.notes.present ? data.notes.value : this.notes,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NutritionGoal(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('gymId: $gymId, ')
          ..write('setBy: $setBy, ')
          ..write('targetCaloriesKcal: $targetCaloriesKcal, ')
          ..write('targetProteinG: $targetProteinG, ')
          ..write('targetCarbsG: $targetCarbsG, ')
          ..write('targetFatsG: $targetFatsG, ')
          ..write('goalType: $goalType, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientId,
    gymId,
    setBy,
    targetCaloriesKcal,
    targetProteinG,
    targetCarbsG,
    targetFatsG,
    goalType,
    notes,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NutritionGoal &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.gymId == this.gymId &&
          other.setBy == this.setBy &&
          other.targetCaloriesKcal == this.targetCaloriesKcal &&
          other.targetProteinG == this.targetProteinG &&
          other.targetCarbsG == this.targetCarbsG &&
          other.targetFatsG == this.targetFatsG &&
          other.goalType == this.goalType &&
          other.notes == this.notes &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class NutritionGoalsCompanion extends UpdateCompanion<NutritionGoal> {
  final Value<String> id;
  final Value<String> clientId;
  final Value<String> gymId;
  final Value<String?> setBy;
  final Value<double> targetCaloriesKcal;
  final Value<double> targetProteinG;
  final Value<double> targetCarbsG;
  final Value<double> targetFatsG;
  final Value<String> goalType;
  final Value<String?> notes;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const NutritionGoalsCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.gymId = const Value.absent(),
    this.setBy = const Value.absent(),
    this.targetCaloriesKcal = const Value.absent(),
    this.targetProteinG = const Value.absent(),
    this.targetCarbsG = const Value.absent(),
    this.targetFatsG = const Value.absent(),
    this.goalType = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NutritionGoalsCompanion.insert({
    required String id,
    required String clientId,
    required String gymId,
    this.setBy = const Value.absent(),
    required double targetCaloriesKcal,
    required double targetProteinG,
    required double targetCarbsG,
    required double targetFatsG,
    this.goalType = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       clientId = Value(clientId),
       gymId = Value(gymId),
       targetCaloriesKcal = Value(targetCaloriesKcal),
       targetProteinG = Value(targetProteinG),
       targetCarbsG = Value(targetCarbsG),
       targetFatsG = Value(targetFatsG),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<NutritionGoal> custom({
    Expression<String>? id,
    Expression<String>? clientId,
    Expression<String>? gymId,
    Expression<String>? setBy,
    Expression<double>? targetCaloriesKcal,
    Expression<double>? targetProteinG,
    Expression<double>? targetCarbsG,
    Expression<double>? targetFatsG,
    Expression<String>? goalType,
    Expression<String>? notes,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (gymId != null) 'gym_id': gymId,
      if (setBy != null) 'set_by': setBy,
      if (targetCaloriesKcal != null)
        'target_calories_kcal': targetCaloriesKcal,
      if (targetProteinG != null) 'target_protein_g': targetProteinG,
      if (targetCarbsG != null) 'target_carbs_g': targetCarbsG,
      if (targetFatsG != null) 'target_fats_g': targetFatsG,
      if (goalType != null) 'goal_type': goalType,
      if (notes != null) 'notes': notes,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NutritionGoalsCompanion copyWith({
    Value<String>? id,
    Value<String>? clientId,
    Value<String>? gymId,
    Value<String?>? setBy,
    Value<double>? targetCaloriesKcal,
    Value<double>? targetProteinG,
    Value<double>? targetCarbsG,
    Value<double>? targetFatsG,
    Value<String>? goalType,
    Value<String?>? notes,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return NutritionGoalsCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      gymId: gymId ?? this.gymId,
      setBy: setBy ?? this.setBy,
      targetCaloriesKcal: targetCaloriesKcal ?? this.targetCaloriesKcal,
      targetProteinG: targetProteinG ?? this.targetProteinG,
      targetCarbsG: targetCarbsG ?? this.targetCarbsG,
      targetFatsG: targetFatsG ?? this.targetFatsG,
      goalType: goalType ?? this.goalType,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (gymId.present) {
      map['gym_id'] = Variable<String>(gymId.value);
    }
    if (setBy.present) {
      map['set_by'] = Variable<String>(setBy.value);
    }
    if (targetCaloriesKcal.present) {
      map['target_calories_kcal'] = Variable<double>(targetCaloriesKcal.value);
    }
    if (targetProteinG.present) {
      map['target_protein_g'] = Variable<double>(targetProteinG.value);
    }
    if (targetCarbsG.present) {
      map['target_carbs_g'] = Variable<double>(targetCarbsG.value);
    }
    if (targetFatsG.present) {
      map['target_fats_g'] = Variable<double>(targetFatsG.value);
    }
    if (goalType.present) {
      map['goal_type'] = Variable<String>(goalType.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NutritionGoalsCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('gymId: $gymId, ')
          ..write('setBy: $setBy, ')
          ..write('targetCaloriesKcal: $targetCaloriesKcal, ')
          ..write('targetProteinG: $targetProteinG, ')
          ..write('targetCarbsG: $targetCarbsG, ')
          ..write('targetFatsG: $targetFatsG, ')
          ..write('goalType: $goalType, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FoodLogsTable extends FoodLogs with TableInfo<$FoodLogsTable, FoodLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gymIdMeta = const VerificationMeta('gymId');
  @override
  late final GeneratedColumn<String> gymId = GeneratedColumn<String>(
    'gym_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _logDateMeta = const VerificationMeta(
    'logDate',
  );
  @override
  late final GeneratedColumn<DateTime> logDate = GeneratedColumn<DateTime>(
    'log_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalCaloriesKcalMeta = const VerificationMeta(
    'totalCaloriesKcal',
  );
  @override
  late final GeneratedColumn<double> totalCaloriesKcal =
      GeneratedColumn<double>(
        'total_calories_kcal',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _totalProteinGMeta = const VerificationMeta(
    'totalProteinG',
  );
  @override
  late final GeneratedColumn<double> totalProteinG = GeneratedColumn<double>(
    'total_protein_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalCarbsGMeta = const VerificationMeta(
    'totalCarbsG',
  );
  @override
  late final GeneratedColumn<double> totalCarbsG = GeneratedColumn<double>(
    'total_carbs_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalFatsGMeta = const VerificationMeta(
    'totalFatsG',
  );
  @override
  late final GeneratedColumn<double> totalFatsG = GeneratedColumn<double>(
    'total_fats_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    gymId,
    logDate,
    totalCaloriesKcal,
    totalProteinG,
    totalCarbsG,
    totalFatsG,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('gym_id')) {
      context.handle(
        _gymIdMeta,
        gymId.isAcceptableOrUnknown(data['gym_id']!, _gymIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gymIdMeta);
    }
    if (data.containsKey('log_date')) {
      context.handle(
        _logDateMeta,
        logDate.isAcceptableOrUnknown(data['log_date']!, _logDateMeta),
      );
    } else if (isInserting) {
      context.missing(_logDateMeta);
    }
    if (data.containsKey('total_calories_kcal')) {
      context.handle(
        _totalCaloriesKcalMeta,
        totalCaloriesKcal.isAcceptableOrUnknown(
          data['total_calories_kcal']!,
          _totalCaloriesKcalMeta,
        ),
      );
    }
    if (data.containsKey('total_protein_g')) {
      context.handle(
        _totalProteinGMeta,
        totalProteinG.isAcceptableOrUnknown(
          data['total_protein_g']!,
          _totalProteinGMeta,
        ),
      );
    }
    if (data.containsKey('total_carbs_g')) {
      context.handle(
        _totalCarbsGMeta,
        totalCarbsG.isAcceptableOrUnknown(
          data['total_carbs_g']!,
          _totalCarbsGMeta,
        ),
      );
    }
    if (data.containsKey('total_fats_g')) {
      context.handle(
        _totalFatsGMeta,
        totalFatsG.isAcceptableOrUnknown(
          data['total_fats_g']!,
          _totalFatsGMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      gymId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gym_id'],
      )!,
      logDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}log_date'],
      )!,
      totalCaloriesKcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_calories_kcal'],
      )!,
      totalProteinG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_protein_g'],
      )!,
      totalCarbsG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_carbs_g'],
      )!,
      totalFatsG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_fats_g'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FoodLogsTable createAlias(String alias) {
    return $FoodLogsTable(attachedDatabase, alias);
  }
}

class FoodLog extends DataClass implements Insertable<FoodLog> {
  final String id;
  final String clientId;
  final String gymId;
  final DateTime logDate;
  final double totalCaloriesKcal;
  final double totalProteinG;
  final double totalCarbsG;
  final double totalFatsG;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FoodLog({
    required this.id,
    required this.clientId,
    required this.gymId,
    required this.logDate,
    required this.totalCaloriesKcal,
    required this.totalProteinG,
    required this.totalCarbsG,
    required this.totalFatsG,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['client_id'] = Variable<String>(clientId);
    map['gym_id'] = Variable<String>(gymId);
    map['log_date'] = Variable<DateTime>(logDate);
    map['total_calories_kcal'] = Variable<double>(totalCaloriesKcal);
    map['total_protein_g'] = Variable<double>(totalProteinG);
    map['total_carbs_g'] = Variable<double>(totalCarbsG);
    map['total_fats_g'] = Variable<double>(totalFatsG);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FoodLogsCompanion toCompanion(bool nullToAbsent) {
    return FoodLogsCompanion(
      id: Value(id),
      clientId: Value(clientId),
      gymId: Value(gymId),
      logDate: Value(logDate),
      totalCaloriesKcal: Value(totalCaloriesKcal),
      totalProteinG: Value(totalProteinG),
      totalCarbsG: Value(totalCarbsG),
      totalFatsG: Value(totalFatsG),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FoodLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodLog(
      id: serializer.fromJson<String>(json['id']),
      clientId: serializer.fromJson<String>(json['clientId']),
      gymId: serializer.fromJson<String>(json['gymId']),
      logDate: serializer.fromJson<DateTime>(json['logDate']),
      totalCaloriesKcal: serializer.fromJson<double>(json['totalCaloriesKcal']),
      totalProteinG: serializer.fromJson<double>(json['totalProteinG']),
      totalCarbsG: serializer.fromJson<double>(json['totalCarbsG']),
      totalFatsG: serializer.fromJson<double>(json['totalFatsG']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clientId': serializer.toJson<String>(clientId),
      'gymId': serializer.toJson<String>(gymId),
      'logDate': serializer.toJson<DateTime>(logDate),
      'totalCaloriesKcal': serializer.toJson<double>(totalCaloriesKcal),
      'totalProteinG': serializer.toJson<double>(totalProteinG),
      'totalCarbsG': serializer.toJson<double>(totalCarbsG),
      'totalFatsG': serializer.toJson<double>(totalFatsG),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FoodLog copyWith({
    String? id,
    String? clientId,
    String? gymId,
    DateTime? logDate,
    double? totalCaloriesKcal,
    double? totalProteinG,
    double? totalCarbsG,
    double? totalFatsG,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FoodLog(
    id: id ?? this.id,
    clientId: clientId ?? this.clientId,
    gymId: gymId ?? this.gymId,
    logDate: logDate ?? this.logDate,
    totalCaloriesKcal: totalCaloriesKcal ?? this.totalCaloriesKcal,
    totalProteinG: totalProteinG ?? this.totalProteinG,
    totalCarbsG: totalCarbsG ?? this.totalCarbsG,
    totalFatsG: totalFatsG ?? this.totalFatsG,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FoodLog copyWithCompanion(FoodLogsCompanion data) {
    return FoodLog(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      gymId: data.gymId.present ? data.gymId.value : this.gymId,
      logDate: data.logDate.present ? data.logDate.value : this.logDate,
      totalCaloriesKcal: data.totalCaloriesKcal.present
          ? data.totalCaloriesKcal.value
          : this.totalCaloriesKcal,
      totalProteinG: data.totalProteinG.present
          ? data.totalProteinG.value
          : this.totalProteinG,
      totalCarbsG: data.totalCarbsG.present
          ? data.totalCarbsG.value
          : this.totalCarbsG,
      totalFatsG: data.totalFatsG.present
          ? data.totalFatsG.value
          : this.totalFatsG,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodLog(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('gymId: $gymId, ')
          ..write('logDate: $logDate, ')
          ..write('totalCaloriesKcal: $totalCaloriesKcal, ')
          ..write('totalProteinG: $totalProteinG, ')
          ..write('totalCarbsG: $totalCarbsG, ')
          ..write('totalFatsG: $totalFatsG, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientId,
    gymId,
    logDate,
    totalCaloriesKcal,
    totalProteinG,
    totalCarbsG,
    totalFatsG,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodLog &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.gymId == this.gymId &&
          other.logDate == this.logDate &&
          other.totalCaloriesKcal == this.totalCaloriesKcal &&
          other.totalProteinG == this.totalProteinG &&
          other.totalCarbsG == this.totalCarbsG &&
          other.totalFatsG == this.totalFatsG &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FoodLogsCompanion extends UpdateCompanion<FoodLog> {
  final Value<String> id;
  final Value<String> clientId;
  final Value<String> gymId;
  final Value<DateTime> logDate;
  final Value<double> totalCaloriesKcal;
  final Value<double> totalProteinG;
  final Value<double> totalCarbsG;
  final Value<double> totalFatsG;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FoodLogsCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.gymId = const Value.absent(),
    this.logDate = const Value.absent(),
    this.totalCaloriesKcal = const Value.absent(),
    this.totalProteinG = const Value.absent(),
    this.totalCarbsG = const Value.absent(),
    this.totalFatsG = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FoodLogsCompanion.insert({
    required String id,
    required String clientId,
    required String gymId,
    required DateTime logDate,
    this.totalCaloriesKcal = const Value.absent(),
    this.totalProteinG = const Value.absent(),
    this.totalCarbsG = const Value.absent(),
    this.totalFatsG = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       clientId = Value(clientId),
       gymId = Value(gymId),
       logDate = Value(logDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FoodLog> custom({
    Expression<String>? id,
    Expression<String>? clientId,
    Expression<String>? gymId,
    Expression<DateTime>? logDate,
    Expression<double>? totalCaloriesKcal,
    Expression<double>? totalProteinG,
    Expression<double>? totalCarbsG,
    Expression<double>? totalFatsG,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (gymId != null) 'gym_id': gymId,
      if (logDate != null) 'log_date': logDate,
      if (totalCaloriesKcal != null) 'total_calories_kcal': totalCaloriesKcal,
      if (totalProteinG != null) 'total_protein_g': totalProteinG,
      if (totalCarbsG != null) 'total_carbs_g': totalCarbsG,
      if (totalFatsG != null) 'total_fats_g': totalFatsG,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FoodLogsCompanion copyWith({
    Value<String>? id,
    Value<String>? clientId,
    Value<String>? gymId,
    Value<DateTime>? logDate,
    Value<double>? totalCaloriesKcal,
    Value<double>? totalProteinG,
    Value<double>? totalCarbsG,
    Value<double>? totalFatsG,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FoodLogsCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      gymId: gymId ?? this.gymId,
      logDate: logDate ?? this.logDate,
      totalCaloriesKcal: totalCaloriesKcal ?? this.totalCaloriesKcal,
      totalProteinG: totalProteinG ?? this.totalProteinG,
      totalCarbsG: totalCarbsG ?? this.totalCarbsG,
      totalFatsG: totalFatsG ?? this.totalFatsG,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (gymId.present) {
      map['gym_id'] = Variable<String>(gymId.value);
    }
    if (logDate.present) {
      map['log_date'] = Variable<DateTime>(logDate.value);
    }
    if (totalCaloriesKcal.present) {
      map['total_calories_kcal'] = Variable<double>(totalCaloriesKcal.value);
    }
    if (totalProteinG.present) {
      map['total_protein_g'] = Variable<double>(totalProteinG.value);
    }
    if (totalCarbsG.present) {
      map['total_carbs_g'] = Variable<double>(totalCarbsG.value);
    }
    if (totalFatsG.present) {
      map['total_fats_g'] = Variable<double>(totalFatsG.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodLogsCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('gymId: $gymId, ')
          ..write('logDate: $logDate, ')
          ..write('totalCaloriesKcal: $totalCaloriesKcal, ')
          ..write('totalProteinG: $totalProteinG, ')
          ..write('totalCarbsG: $totalCarbsG, ')
          ..write('totalFatsG: $totalFatsG, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FoodLogItemsTable extends FoodLogItems
    with TableInfo<$FoodLogItemsTable, FoodLogItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodLogItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _logIdMeta = const VerificationMeta('logId');
  @override
  late final GeneratedColumn<String> logId = GeneratedColumn<String>(
    'log_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<String> foodId = GeneratedColumn<String>(
    'food_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mealTypeMeta = const VerificationMeta(
    'mealType',
  );
  @override
  late final GeneratedColumn<String> mealType = GeneratedColumn<String>(
    'meal_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caloriesKcalMeta = const VerificationMeta(
    'caloriesKcal',
  );
  @override
  late final GeneratedColumn<double> caloriesKcal = GeneratedColumn<double>(
    'calories_kcal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinGMeta = const VerificationMeta(
    'proteinG',
  );
  @override
  late final GeneratedColumn<double> proteinG = GeneratedColumn<double>(
    'protein_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbsGMeta = const VerificationMeta('carbsG');
  @override
  late final GeneratedColumn<double> carbsG = GeneratedColumn<double>(
    'carbs_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fatsGMeta = const VerificationMeta('fatsG');
  @override
  late final GeneratedColumn<double> fatsG = GeneratedColumn<double>(
    'fats_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    logId,
    foodId,
    mealType,
    quantity,
    caloriesKcal,
    proteinG,
    carbsG,
    fatsG,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_log_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodLogItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('log_id')) {
      context.handle(
        _logIdMeta,
        logId.isAcceptableOrUnknown(data['log_id']!, _logIdMeta),
      );
    } else if (isInserting) {
      context.missing(_logIdMeta);
    }
    if (data.containsKey('food_id')) {
      context.handle(
        _foodIdMeta,
        foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta),
      );
    } else if (isInserting) {
      context.missing(_foodIdMeta);
    }
    if (data.containsKey('meal_type')) {
      context.handle(
        _mealTypeMeta,
        mealType.isAcceptableOrUnknown(data['meal_type']!, _mealTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mealTypeMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('calories_kcal')) {
      context.handle(
        _caloriesKcalMeta,
        caloriesKcal.isAcceptableOrUnknown(
          data['calories_kcal']!,
          _caloriesKcalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_caloriesKcalMeta);
    }
    if (data.containsKey('protein_g')) {
      context.handle(
        _proteinGMeta,
        proteinG.isAcceptableOrUnknown(data['protein_g']!, _proteinGMeta),
      );
    } else if (isInserting) {
      context.missing(_proteinGMeta);
    }
    if (data.containsKey('carbs_g')) {
      context.handle(
        _carbsGMeta,
        carbsG.isAcceptableOrUnknown(data['carbs_g']!, _carbsGMeta),
      );
    } else if (isInserting) {
      context.missing(_carbsGMeta);
    }
    if (data.containsKey('fats_g')) {
      context.handle(
        _fatsGMeta,
        fatsG.isAcceptableOrUnknown(data['fats_g']!, _fatsGMeta),
      );
    } else if (isInserting) {
      context.missing(_fatsGMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodLogItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodLogItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      logId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}log_id'],
      )!,
      foodId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}food_id'],
      )!,
      mealType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_type'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      caloriesKcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calories_kcal'],
      )!,
      proteinG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_g'],
      )!,
      carbsG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs_g'],
      )!,
      fatsG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fats_g'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FoodLogItemsTable createAlias(String alias) {
    return $FoodLogItemsTable(attachedDatabase, alias);
  }
}

class FoodLogItem extends DataClass implements Insertable<FoodLogItem> {
  final String id;
  final String logId;
  final String foodId;
  final String mealType;
  final double quantity;
  final double caloriesKcal;
  final double proteinG;
  final double carbsG;
  final double fatsG;
  final DateTime createdAt;
  const FoodLogItem({
    required this.id,
    required this.logId,
    required this.foodId,
    required this.mealType,
    required this.quantity,
    required this.caloriesKcal,
    required this.proteinG,
    required this.carbsG,
    required this.fatsG,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['log_id'] = Variable<String>(logId);
    map['food_id'] = Variable<String>(foodId);
    map['meal_type'] = Variable<String>(mealType);
    map['quantity'] = Variable<double>(quantity);
    map['calories_kcal'] = Variable<double>(caloriesKcal);
    map['protein_g'] = Variable<double>(proteinG);
    map['carbs_g'] = Variable<double>(carbsG);
    map['fats_g'] = Variable<double>(fatsG);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FoodLogItemsCompanion toCompanion(bool nullToAbsent) {
    return FoodLogItemsCompanion(
      id: Value(id),
      logId: Value(logId),
      foodId: Value(foodId),
      mealType: Value(mealType),
      quantity: Value(quantity),
      caloriesKcal: Value(caloriesKcal),
      proteinG: Value(proteinG),
      carbsG: Value(carbsG),
      fatsG: Value(fatsG),
      createdAt: Value(createdAt),
    );
  }

  factory FoodLogItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodLogItem(
      id: serializer.fromJson<String>(json['id']),
      logId: serializer.fromJson<String>(json['logId']),
      foodId: serializer.fromJson<String>(json['foodId']),
      mealType: serializer.fromJson<String>(json['mealType']),
      quantity: serializer.fromJson<double>(json['quantity']),
      caloriesKcal: serializer.fromJson<double>(json['caloriesKcal']),
      proteinG: serializer.fromJson<double>(json['proteinG']),
      carbsG: serializer.fromJson<double>(json['carbsG']),
      fatsG: serializer.fromJson<double>(json['fatsG']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'logId': serializer.toJson<String>(logId),
      'foodId': serializer.toJson<String>(foodId),
      'mealType': serializer.toJson<String>(mealType),
      'quantity': serializer.toJson<double>(quantity),
      'caloriesKcal': serializer.toJson<double>(caloriesKcal),
      'proteinG': serializer.toJson<double>(proteinG),
      'carbsG': serializer.toJson<double>(carbsG),
      'fatsG': serializer.toJson<double>(fatsG),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FoodLogItem copyWith({
    String? id,
    String? logId,
    String? foodId,
    String? mealType,
    double? quantity,
    double? caloriesKcal,
    double? proteinG,
    double? carbsG,
    double? fatsG,
    DateTime? createdAt,
  }) => FoodLogItem(
    id: id ?? this.id,
    logId: logId ?? this.logId,
    foodId: foodId ?? this.foodId,
    mealType: mealType ?? this.mealType,
    quantity: quantity ?? this.quantity,
    caloriesKcal: caloriesKcal ?? this.caloriesKcal,
    proteinG: proteinG ?? this.proteinG,
    carbsG: carbsG ?? this.carbsG,
    fatsG: fatsG ?? this.fatsG,
    createdAt: createdAt ?? this.createdAt,
  );
  FoodLogItem copyWithCompanion(FoodLogItemsCompanion data) {
    return FoodLogItem(
      id: data.id.present ? data.id.value : this.id,
      logId: data.logId.present ? data.logId.value : this.logId,
      foodId: data.foodId.present ? data.foodId.value : this.foodId,
      mealType: data.mealType.present ? data.mealType.value : this.mealType,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      caloriesKcal: data.caloriesKcal.present
          ? data.caloriesKcal.value
          : this.caloriesKcal,
      proteinG: data.proteinG.present ? data.proteinG.value : this.proteinG,
      carbsG: data.carbsG.present ? data.carbsG.value : this.carbsG,
      fatsG: data.fatsG.present ? data.fatsG.value : this.fatsG,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodLogItem(')
          ..write('id: $id, ')
          ..write('logId: $logId, ')
          ..write('foodId: $foodId, ')
          ..write('mealType: $mealType, ')
          ..write('quantity: $quantity, ')
          ..write('caloriesKcal: $caloriesKcal, ')
          ..write('proteinG: $proteinG, ')
          ..write('carbsG: $carbsG, ')
          ..write('fatsG: $fatsG, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    logId,
    foodId,
    mealType,
    quantity,
    caloriesKcal,
    proteinG,
    carbsG,
    fatsG,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodLogItem &&
          other.id == this.id &&
          other.logId == this.logId &&
          other.foodId == this.foodId &&
          other.mealType == this.mealType &&
          other.quantity == this.quantity &&
          other.caloriesKcal == this.caloriesKcal &&
          other.proteinG == this.proteinG &&
          other.carbsG == this.carbsG &&
          other.fatsG == this.fatsG &&
          other.createdAt == this.createdAt);
}

class FoodLogItemsCompanion extends UpdateCompanion<FoodLogItem> {
  final Value<String> id;
  final Value<String> logId;
  final Value<String> foodId;
  final Value<String> mealType;
  final Value<double> quantity;
  final Value<double> caloriesKcal;
  final Value<double> proteinG;
  final Value<double> carbsG;
  final Value<double> fatsG;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const FoodLogItemsCompanion({
    this.id = const Value.absent(),
    this.logId = const Value.absent(),
    this.foodId = const Value.absent(),
    this.mealType = const Value.absent(),
    this.quantity = const Value.absent(),
    this.caloriesKcal = const Value.absent(),
    this.proteinG = const Value.absent(),
    this.carbsG = const Value.absent(),
    this.fatsG = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FoodLogItemsCompanion.insert({
    required String id,
    required String logId,
    required String foodId,
    required String mealType,
    required double quantity,
    required double caloriesKcal,
    required double proteinG,
    required double carbsG,
    required double fatsG,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       logId = Value(logId),
       foodId = Value(foodId),
       mealType = Value(mealType),
       quantity = Value(quantity),
       caloriesKcal = Value(caloriesKcal),
       proteinG = Value(proteinG),
       carbsG = Value(carbsG),
       fatsG = Value(fatsG),
       createdAt = Value(createdAt);
  static Insertable<FoodLogItem> custom({
    Expression<String>? id,
    Expression<String>? logId,
    Expression<String>? foodId,
    Expression<String>? mealType,
    Expression<double>? quantity,
    Expression<double>? caloriesKcal,
    Expression<double>? proteinG,
    Expression<double>? carbsG,
    Expression<double>? fatsG,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (logId != null) 'log_id': logId,
      if (foodId != null) 'food_id': foodId,
      if (mealType != null) 'meal_type': mealType,
      if (quantity != null) 'quantity': quantity,
      if (caloriesKcal != null) 'calories_kcal': caloriesKcal,
      if (proteinG != null) 'protein_g': proteinG,
      if (carbsG != null) 'carbs_g': carbsG,
      if (fatsG != null) 'fats_g': fatsG,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FoodLogItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? logId,
    Value<String>? foodId,
    Value<String>? mealType,
    Value<double>? quantity,
    Value<double>? caloriesKcal,
    Value<double>? proteinG,
    Value<double>? carbsG,
    Value<double>? fatsG,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return FoodLogItemsCompanion(
      id: id ?? this.id,
      logId: logId ?? this.logId,
      foodId: foodId ?? this.foodId,
      mealType: mealType ?? this.mealType,
      quantity: quantity ?? this.quantity,
      caloriesKcal: caloriesKcal ?? this.caloriesKcal,
      proteinG: proteinG ?? this.proteinG,
      carbsG: carbsG ?? this.carbsG,
      fatsG: fatsG ?? this.fatsG,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (logId.present) {
      map['log_id'] = Variable<String>(logId.value);
    }
    if (foodId.present) {
      map['food_id'] = Variable<String>(foodId.value);
    }
    if (mealType.present) {
      map['meal_type'] = Variable<String>(mealType.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (caloriesKcal.present) {
      map['calories_kcal'] = Variable<double>(caloriesKcal.value);
    }
    if (proteinG.present) {
      map['protein_g'] = Variable<double>(proteinG.value);
    }
    if (carbsG.present) {
      map['carbs_g'] = Variable<double>(carbsG.value);
    }
    if (fatsG.present) {
      map['fats_g'] = Variable<double>(fatsG.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodLogItemsCompanion(')
          ..write('id: $id, ')
          ..write('logId: $logId, ')
          ..write('foodId: $foodId, ')
          ..write('mealType: $mealType, ')
          ..write('quantity: $quantity, ')
          ..write('caloriesKcal: $caloriesKcal, ')
          ..write('proteinG: $proteinG, ')
          ..write('carbsG: $carbsG, ')
          ..write('fatsG: $fatsG, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final $GymsTable gyms = $GymsTable(this);
  late final $MembershipsTable memberships = $MembershipsTable(this);
  late final $PlansTable plans = $PlansTable(this);
  late final $SubscriptionsTable subscriptions = $SubscriptionsTable(this);
  late final $ExercisesTable exercises = $ExercisesTable(this);
  late final $RoutinesTable routines = $RoutinesTable(this);
  late final $RoutineExercisesTable routineExercises = $RoutineExercisesTable(
    this,
  );
  late final $WorkoutsTable workouts = $WorkoutsTable(this);
  late final $WorkoutExercisesTable workoutExercises = $WorkoutExercisesTable(
    this,
  );
  late final $BodyMeasurementsTable bodyMeasurements = $BodyMeasurementsTable(
    this,
  );
  late final $ProgressPhotosTable progressPhotos = $ProgressPhotosTable(this);
  late final $NotificationsTable notifications = $NotificationsTable(this);
  late final $ExchangeRatesTable exchangeRates = $ExchangeRatesTable(this);
  late final $GymSettingsTable gymSettings = $GymSettingsTable(this);
  late final $FoodsTableTable foodsTable = $FoodsTableTable(this);
  late final $NutritionPlansTable nutritionPlans = $NutritionPlansTable(this);
  late final $NutritionGoalsTable nutritionGoals = $NutritionGoalsTable(this);
  late final $FoodLogsTable foodLogs = $FoodLogsTable(this);
  late final $FoodLogItemsTable foodLogItems = $FoodLogItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    profiles,
    gyms,
    memberships,
    plans,
    subscriptions,
    exercises,
    routines,
    routineExercises,
    workouts,
    workoutExercises,
    bodyMeasurements,
    progressPhotos,
    notifications,
    exchangeRates,
    gymSettings,
    foodsTable,
    nutritionPlans,
    nutritionGoals,
    foodLogs,
    foodLogItems,
  ];
}

typedef $$ProfilesTableCreateCompanionBuilder =
    ProfilesCompanion Function({
      required String id,
      Value<String?> email,
      required String fullName,
      Value<String?> phone,
      Value<String?> avatarUrl,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$ProfilesTableUpdateCompanionBuilder =
    ProfilesCompanion Function({
      Value<String> id,
      Value<String?> email,
      Value<String> fullName,
      Value<String?> phone,
      Value<String?> avatarUrl,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfilesTable,
          Profile,
          $$ProfilesTableFilterComposer,
          $$ProfilesTableOrderingComposer,
          $$ProfilesTableAnnotationComposer,
          $$ProfilesTableCreateCompanionBuilder,
          $$ProfilesTableUpdateCompanionBuilder,
          (Profile, BaseReferences<_$AppDatabase, $ProfilesTable, Profile>),
          Profile,
          PrefetchHooks Function()
        > {
  $$ProfilesTableTableManager(_$AppDatabase db, $ProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfilesCompanion(
                id: id,
                email: email,
                fullName: fullName,
                phone: phone,
                avatarUrl: avatarUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> email = const Value.absent(),
                required String fullName,
                Value<String?> phone = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfilesCompanion.insert(
                id: id,
                email: email,
                fullName: fullName,
                phone: phone,
                avatarUrl: avatarUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProfilesTable, Profile>(table),
                  BaseReferences<_$AppDatabase, $ProfilesTable, Profile>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfilesTable,
      Profile,
      $$ProfilesTableFilterComposer,
      $$ProfilesTableOrderingComposer,
      $$ProfilesTableAnnotationComposer,
      $$ProfilesTableCreateCompanionBuilder,
      $$ProfilesTableUpdateCompanionBuilder,
      (Profile, BaseReferences<_$AppDatabase, $ProfilesTable, Profile>),
      Profile,
      PrefetchHooks Function()
    >;
typedef $$GymsTableCreateCompanionBuilder =
    GymsCompanion Function({
      required String id,
      required String name,
      required String slug,
      Value<String?> logoUrl,
      Value<String> timezone,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$GymsTableUpdateCompanionBuilder =
    GymsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> slug,
      Value<String?> logoUrl,
      Value<String> timezone,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$GymsTableFilterComposer extends Composer<_$AppDatabase, $GymsTable> {
  $$GymsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GymsTableOrderingComposer extends Composer<_$AppDatabase, $GymsTable> {
  $$GymsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GymsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GymsTable> {
  $$GymsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get logoUrl =>
      $composableBuilder(column: $table.logoUrl, builder: (column) => column);

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$GymsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GymsTable,
          Gym,
          $$GymsTableFilterComposer,
          $$GymsTableOrderingComposer,
          $$GymsTableAnnotationComposer,
          $$GymsTableCreateCompanionBuilder,
          $$GymsTableUpdateCompanionBuilder,
          (Gym, BaseReferences<_$AppDatabase, $GymsTable, Gym>),
          Gym,
          PrefetchHooks Function()
        > {
  $$GymsTableTableManager(_$AppDatabase db, $GymsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GymsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GymsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GymsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String?> logoUrl = const Value.absent(),
                Value<String> timezone = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GymsCompanion(
                id: id,
                name: name,
                slug: slug,
                logoUrl: logoUrl,
                timezone: timezone,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String slug,
                Value<String?> logoUrl = const Value.absent(),
                Value<String> timezone = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GymsCompanion.insert(
                id: id,
                name: name,
                slug: slug,
                logoUrl: logoUrl,
                timezone: timezone,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GymsTable, Gym>(table),
                  BaseReferences<_$AppDatabase, $GymsTable, Gym>(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GymsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GymsTable,
      Gym,
      $$GymsTableFilterComposer,
      $$GymsTableOrderingComposer,
      $$GymsTableAnnotationComposer,
      $$GymsTableCreateCompanionBuilder,
      $$GymsTableUpdateCompanionBuilder,
      (Gym, BaseReferences<_$AppDatabase, $GymsTable, Gym>),
      Gym,
      PrefetchHooks Function()
    >;
typedef $$MembershipsTableCreateCompanionBuilder =
    MembershipsCompanion Function({
      required String id,
      required String userId,
      required String gymId,
      required String role,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$MembershipsTableUpdateCompanionBuilder =
    MembershipsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> gymId,
      Value<String> role,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$MembershipsTableFilterComposer
    extends Composer<_$AppDatabase, $MembershipsTable> {
  $$MembershipsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gymId => $composableBuilder(
    column: $table.gymId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MembershipsTableOrderingComposer
    extends Composer<_$AppDatabase, $MembershipsTable> {
  $$MembershipsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gymId => $composableBuilder(
    column: $table.gymId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MembershipsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MembershipsTable> {
  $$MembershipsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get gymId =>
      $composableBuilder(column: $table.gymId, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MembershipsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MembershipsTable,
          Membership,
          $$MembershipsTableFilterComposer,
          $$MembershipsTableOrderingComposer,
          $$MembershipsTableAnnotationComposer,
          $$MembershipsTableCreateCompanionBuilder,
          $$MembershipsTableUpdateCompanionBuilder,
          (
            Membership,
            BaseReferences<_$AppDatabase, $MembershipsTable, Membership>,
          ),
          Membership,
          PrefetchHooks Function()
        > {
  $$MembershipsTableTableManager(_$AppDatabase db, $MembershipsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MembershipsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MembershipsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MembershipsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> gymId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembershipsCompanion(
                id: id,
                userId: userId,
                gymId: gymId,
                role: role,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String gymId,
                required String role,
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembershipsCompanion.insert(
                id: id,
                userId: userId,
                gymId: gymId,
                role: role,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MembershipsTable, Membership>(table),
                  BaseReferences<_$AppDatabase, $MembershipsTable, Membership>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MembershipsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MembershipsTable,
      Membership,
      $$MembershipsTableFilterComposer,
      $$MembershipsTableOrderingComposer,
      $$MembershipsTableAnnotationComposer,
      $$MembershipsTableCreateCompanionBuilder,
      $$MembershipsTableUpdateCompanionBuilder,
      (
        Membership,
        BaseReferences<_$AppDatabase, $MembershipsTable, Membership>,
      ),
      Membership,
      PrefetchHooks Function()
    >;
typedef $$PlansTableCreateCompanionBuilder =
    PlansCompanion Function({
      required String id,
      required String name,
      required double priceUsd,
      required int maxClients,
      required int maxTrainers,
      Value<int?> maxStaff,
      Value<String> features,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$PlansTableUpdateCompanionBuilder =
    PlansCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<double> priceUsd,
      Value<int> maxClients,
      Value<int> maxTrainers,
      Value<int?> maxStaff,
      Value<String> features,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$PlansTableFilterComposer extends Composer<_$AppDatabase, $PlansTable> {
  $$PlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get priceUsd => $composableBuilder(
    column: $table.priceUsd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxClients => $composableBuilder(
    column: $table.maxClients,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxTrainers => $composableBuilder(
    column: $table.maxTrainers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxStaff => $composableBuilder(
    column: $table.maxStaff,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get features => $composableBuilder(
    column: $table.features,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlansTableOrderingComposer
    extends Composer<_$AppDatabase, $PlansTable> {
  $$PlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get priceUsd => $composableBuilder(
    column: $table.priceUsd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxClients => $composableBuilder(
    column: $table.maxClients,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxTrainers => $composableBuilder(
    column: $table.maxTrainers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxStaff => $composableBuilder(
    column: $table.maxStaff,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get features => $composableBuilder(
    column: $table.features,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlansTable> {
  $$PlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get priceUsd =>
      $composableBuilder(column: $table.priceUsd, builder: (column) => column);

  GeneratedColumn<int> get maxClients => $composableBuilder(
    column: $table.maxClients,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxTrainers => $composableBuilder(
    column: $table.maxTrainers,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxStaff =>
      $composableBuilder(column: $table.maxStaff, builder: (column) => column);

  GeneratedColumn<String> get features =>
      $composableBuilder(column: $table.features, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlansTable,
          Plan,
          $$PlansTableFilterComposer,
          $$PlansTableOrderingComposer,
          $$PlansTableAnnotationComposer,
          $$PlansTableCreateCompanionBuilder,
          $$PlansTableUpdateCompanionBuilder,
          (Plan, BaseReferences<_$AppDatabase, $PlansTable, Plan>),
          Plan,
          PrefetchHooks Function()
        > {
  $$PlansTableTableManager(_$AppDatabase db, $PlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> priceUsd = const Value.absent(),
                Value<int> maxClients = const Value.absent(),
                Value<int> maxTrainers = const Value.absent(),
                Value<int?> maxStaff = const Value.absent(),
                Value<String> features = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlansCompanion(
                id: id,
                name: name,
                priceUsd: priceUsd,
                maxClients: maxClients,
                maxTrainers: maxTrainers,
                maxStaff: maxStaff,
                features: features,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required double priceUsd,
                required int maxClients,
                required int maxTrainers,
                Value<int?> maxStaff = const Value.absent(),
                Value<String> features = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlansCompanion.insert(
                id: id,
                name: name,
                priceUsd: priceUsd,
                maxClients: maxClients,
                maxTrainers: maxTrainers,
                maxStaff: maxStaff,
                features: features,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PlansTable, Plan>(table),
                  BaseReferences<_$AppDatabase, $PlansTable, Plan>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlansTable,
      Plan,
      $$PlansTableFilterComposer,
      $$PlansTableOrderingComposer,
      $$PlansTableAnnotationComposer,
      $$PlansTableCreateCompanionBuilder,
      $$PlansTableUpdateCompanionBuilder,
      (Plan, BaseReferences<_$AppDatabase, $PlansTable, Plan>),
      Plan,
      PrefetchHooks Function()
    >;
typedef $$SubscriptionsTableCreateCompanionBuilder =
    SubscriptionsCompanion Function({
      required String id,
      required String gymId,
      required String planId,
      required String status,
      required DateTime expiresAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$SubscriptionsTableUpdateCompanionBuilder =
    SubscriptionsCompanion Function({
      Value<String> id,
      Value<String> gymId,
      Value<String> planId,
      Value<String> status,
      Value<DateTime> expiresAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$SubscriptionsTableFilterComposer
    extends Composer<_$AppDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gymId => $composableBuilder(
    column: $table.gymId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SubscriptionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gymId => $composableBuilder(
    column: $table.gymId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SubscriptionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get gymId =>
      $composableBuilder(column: $table.gymId, builder: (column) => column);

  GeneratedColumn<String> get planId =>
      $composableBuilder(column: $table.planId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SubscriptionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubscriptionsTable,
          Subscription,
          $$SubscriptionsTableFilterComposer,
          $$SubscriptionsTableOrderingComposer,
          $$SubscriptionsTableAnnotationComposer,
          $$SubscriptionsTableCreateCompanionBuilder,
          $$SubscriptionsTableUpdateCompanionBuilder,
          (
            Subscription,
            BaseReferences<_$AppDatabase, $SubscriptionsTable, Subscription>,
          ),
          Subscription,
          PrefetchHooks Function()
        > {
  $$SubscriptionsTableTableManager(_$AppDatabase db, $SubscriptionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubscriptionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubscriptionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubscriptionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> gymId = const Value.absent(),
                Value<String> planId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> expiresAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubscriptionsCompanion(
                id: id,
                gymId: gymId,
                planId: planId,
                status: status,
                expiresAt: expiresAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String gymId,
                required String planId,
                required String status,
                required DateTime expiresAt,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubscriptionsCompanion.insert(
                id: id,
                gymId: gymId,
                planId: planId,
                status: status,
                expiresAt: expiresAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SubscriptionsTable, Subscription>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SubscriptionsTable,
                    Subscription
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SubscriptionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubscriptionsTable,
      Subscription,
      $$SubscriptionsTableFilterComposer,
      $$SubscriptionsTableOrderingComposer,
      $$SubscriptionsTableAnnotationComposer,
      $$SubscriptionsTableCreateCompanionBuilder,
      $$SubscriptionsTableUpdateCompanionBuilder,
      (
        Subscription,
        BaseReferences<_$AppDatabase, $SubscriptionsTable, Subscription>,
      ),
      Subscription,
      PrefetchHooks Function()
    >;
typedef $$ExercisesTableCreateCompanionBuilder =
    ExercisesCompanion Function({
      required String id,
      required String name,
      Value<String?> description,
      Value<String?> videoUrl,
      Value<bool> isGlobal,
      Value<String?> sourceGymId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$ExercisesTableUpdateCompanionBuilder =
    ExercisesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> description,
      Value<String?> videoUrl,
      Value<bool> isGlobal,
      Value<String?> sourceGymId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$ExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get videoUrl => $composableBuilder(
    column: $table.videoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isGlobal => $composableBuilder(
    column: $table.isGlobal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceGymId => $composableBuilder(
    column: $table.sourceGymId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get videoUrl => $composableBuilder(
    column: $table.videoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isGlobal => $composableBuilder(
    column: $table.isGlobal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceGymId => $composableBuilder(
    column: $table.sourceGymId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get videoUrl =>
      $composableBuilder(column: $table.videoUrl, builder: (column) => column);

  GeneratedColumn<bool> get isGlobal =>
      $composableBuilder(column: $table.isGlobal, builder: (column) => column);

  GeneratedColumn<String> get sourceGymId => $composableBuilder(
    column: $table.sourceGymId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ExercisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExercisesTable,
          Exercise,
          $$ExercisesTableFilterComposer,
          $$ExercisesTableOrderingComposer,
          $$ExercisesTableAnnotationComposer,
          $$ExercisesTableCreateCompanionBuilder,
          $$ExercisesTableUpdateCompanionBuilder,
          (Exercise, BaseReferences<_$AppDatabase, $ExercisesTable, Exercise>),
          Exercise,
          PrefetchHooks Function()
        > {
  $$ExercisesTableTableManager(_$AppDatabase db, $ExercisesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> videoUrl = const Value.absent(),
                Value<bool> isGlobal = const Value.absent(),
                Value<String?> sourceGymId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExercisesCompanion(
                id: id,
                name: name,
                description: description,
                videoUrl: videoUrl,
                isGlobal: isGlobal,
                sourceGymId: sourceGymId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> videoUrl = const Value.absent(),
                Value<bool> isGlobal = const Value.absent(),
                Value<String?> sourceGymId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExercisesCompanion.insert(
                id: id,
                name: name,
                description: description,
                videoUrl: videoUrl,
                isGlobal: isGlobal,
                sourceGymId: sourceGymId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExercisesTable, Exercise>(table),
                  BaseReferences<_$AppDatabase, $ExercisesTable, Exercise>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExercisesTable,
      Exercise,
      $$ExercisesTableFilterComposer,
      $$ExercisesTableOrderingComposer,
      $$ExercisesTableAnnotationComposer,
      $$ExercisesTableCreateCompanionBuilder,
      $$ExercisesTableUpdateCompanionBuilder,
      (Exercise, BaseReferences<_$AppDatabase, $ExercisesTable, Exercise>),
      Exercise,
      PrefetchHooks Function()
    >;
typedef $$RoutinesTableCreateCompanionBuilder =
    RoutinesCompanion Function({
      required String id,
      required String gymId,
      required String clientId,
      Value<String?> trainerId,
      required String name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$RoutinesTableUpdateCompanionBuilder =
    RoutinesCompanion Function({
      Value<String> id,
      Value<String> gymId,
      Value<String> clientId,
      Value<String?> trainerId,
      Value<String> name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$RoutinesTableFilterComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gymId => $composableBuilder(
    column: $table.gymId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trainerId => $composableBuilder(
    column: $table.trainerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RoutinesTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gymId => $composableBuilder(
    column: $table.gymId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trainerId => $composableBuilder(
    column: $table.trainerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RoutinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get gymId =>
      $composableBuilder(column: $table.gymId, builder: (column) => column);

  GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<String> get trainerId =>
      $composableBuilder(column: $table.trainerId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$RoutinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutinesTable,
          Routine,
          $$RoutinesTableFilterComposer,
          $$RoutinesTableOrderingComposer,
          $$RoutinesTableAnnotationComposer,
          $$RoutinesTableCreateCompanionBuilder,
          $$RoutinesTableUpdateCompanionBuilder,
          (Routine, BaseReferences<_$AppDatabase, $RoutinesTable, Routine>),
          Routine,
          PrefetchHooks Function()
        > {
  $$RoutinesTableTableManager(_$AppDatabase db, $RoutinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> gymId = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String?> trainerId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoutinesCompanion(
                id: id,
                gymId: gymId,
                clientId: clientId,
                trainerId: trainerId,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String gymId,
                required String clientId,
                Value<String?> trainerId = const Value.absent(),
                required String name,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoutinesCompanion.insert(
                id: id,
                gymId: gymId,
                clientId: clientId,
                trainerId: trainerId,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RoutinesTable, Routine>(table),
                  BaseReferences<_$AppDatabase, $RoutinesTable, Routine>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RoutinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutinesTable,
      Routine,
      $$RoutinesTableFilterComposer,
      $$RoutinesTableOrderingComposer,
      $$RoutinesTableAnnotationComposer,
      $$RoutinesTableCreateCompanionBuilder,
      $$RoutinesTableUpdateCompanionBuilder,
      (Routine, BaseReferences<_$AppDatabase, $RoutinesTable, Routine>),
      Routine,
      PrefetchHooks Function()
    >;
typedef $$RoutineExercisesTableCreateCompanionBuilder =
    RoutineExercisesCompanion Function({
      required String id,
      required String routineId,
      required String exerciseId,
      required int sets,
      Value<int?> reps,
      Value<double?> weightKg,
      Value<int> restSeconds,
      required int orderIndex,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$RoutineExercisesTableUpdateCompanionBuilder =
    RoutineExercisesCompanion Function({
      Value<String> id,
      Value<String> routineId,
      Value<String> exerciseId,
      Value<int> sets,
      Value<int?> reps,
      Value<double?> weightKg,
      Value<int> restSeconds,
      Value<int> orderIndex,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$RoutineExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $RoutineExercisesTable> {
  $$RoutineExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get routineId => $composableBuilder(
    column: $table.routineId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sets => $composableBuilder(
    column: $table.sets,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get restSeconds => $composableBuilder(
    column: $table.restSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RoutineExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutineExercisesTable> {
  $$RoutineExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get routineId => $composableBuilder(
    column: $table.routineId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sets => $composableBuilder(
    column: $table.sets,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get restSeconds => $composableBuilder(
    column: $table.restSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RoutineExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutineExercisesTable> {
  $$RoutineExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get routineId =>
      $composableBuilder(column: $table.routineId, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sets =>
      $composableBuilder(column: $table.sets, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<int> get restSeconds => $composableBuilder(
    column: $table.restSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$RoutineExercisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutineExercisesTable,
          RoutineExercise,
          $$RoutineExercisesTableFilterComposer,
          $$RoutineExercisesTableOrderingComposer,
          $$RoutineExercisesTableAnnotationComposer,
          $$RoutineExercisesTableCreateCompanionBuilder,
          $$RoutineExercisesTableUpdateCompanionBuilder,
          (
            RoutineExercise,
            BaseReferences<
              _$AppDatabase,
              $RoutineExercisesTable,
              RoutineExercise
            >,
          ),
          RoutineExercise,
          PrefetchHooks Function()
        > {
  $$RoutineExercisesTableTableManager(
    _$AppDatabase db,
    $RoutineExercisesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutineExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutineExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutineExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> routineId = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<int> sets = const Value.absent(),
                Value<int?> reps = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<int> restSeconds = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoutineExercisesCompanion(
                id: id,
                routineId: routineId,
                exerciseId: exerciseId,
                sets: sets,
                reps: reps,
                weightKg: weightKg,
                restSeconds: restSeconds,
                orderIndex: orderIndex,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String routineId,
                required String exerciseId,
                required int sets,
                Value<int?> reps = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<int> restSeconds = const Value.absent(),
                required int orderIndex,
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoutineExercisesCompanion.insert(
                id: id,
                routineId: routineId,
                exerciseId: exerciseId,
                sets: sets,
                reps: reps,
                weightKg: weightKg,
                restSeconds: restSeconds,
                orderIndex: orderIndex,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RoutineExercisesTable, RoutineExercise>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $RoutineExercisesTable,
                    RoutineExercise
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RoutineExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutineExercisesTable,
      RoutineExercise,
      $$RoutineExercisesTableFilterComposer,
      $$RoutineExercisesTableOrderingComposer,
      $$RoutineExercisesTableAnnotationComposer,
      $$RoutineExercisesTableCreateCompanionBuilder,
      $$RoutineExercisesTableUpdateCompanionBuilder,
      (
        RoutineExercise,
        BaseReferences<_$AppDatabase, $RoutineExercisesTable, RoutineExercise>,
      ),
      RoutineExercise,
      PrefetchHooks Function()
    >;
typedef $$WorkoutsTableCreateCompanionBuilder =
    WorkoutsCompanion Function({
      required String id,
      required String gymId,
      required String userId,
      Value<String?> routineId,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$WorkoutsTableUpdateCompanionBuilder =
    WorkoutsCompanion Function({
      Value<String> id,
      Value<String> gymId,
      Value<String> userId,
      Value<String?> routineId,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$WorkoutsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gymId => $composableBuilder(
    column: $table.gymId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get routineId => $composableBuilder(
    column: $table.routineId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkoutsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gymId => $composableBuilder(
    column: $table.gymId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get routineId => $composableBuilder(
    column: $table.routineId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkoutsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get gymId =>
      $composableBuilder(column: $table.gymId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get routineId =>
      $composableBuilder(column: $table.routineId, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$WorkoutsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutsTable,
          Workout,
          $$WorkoutsTableFilterComposer,
          $$WorkoutsTableOrderingComposer,
          $$WorkoutsTableAnnotationComposer,
          $$WorkoutsTableCreateCompanionBuilder,
          $$WorkoutsTableUpdateCompanionBuilder,
          (Workout, BaseReferences<_$AppDatabase, $WorkoutsTable, Workout>),
          Workout,
          PrefetchHooks Function()
        > {
  $$WorkoutsTableTableManager(_$AppDatabase db, $WorkoutsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> gymId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String?> routineId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutsCompanion(
                id: id,
                gymId: gymId,
                userId: userId,
                routineId: routineId,
                startedAt: startedAt,
                endedAt: endedAt,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String gymId,
                required String userId,
                Value<String?> routineId = const Value.absent(),
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutsCompanion.insert(
                id: id,
                gymId: gymId,
                userId: userId,
                routineId: routineId,
                startedAt: startedAt,
                endedAt: endedAt,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WorkoutsTable, Workout>(table),
                  BaseReferences<_$AppDatabase, $WorkoutsTable, Workout>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkoutsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutsTable,
      Workout,
      $$WorkoutsTableFilterComposer,
      $$WorkoutsTableOrderingComposer,
      $$WorkoutsTableAnnotationComposer,
      $$WorkoutsTableCreateCompanionBuilder,
      $$WorkoutsTableUpdateCompanionBuilder,
      (Workout, BaseReferences<_$AppDatabase, $WorkoutsTable, Workout>),
      Workout,
      PrefetchHooks Function()
    >;
typedef $$WorkoutExercisesTableCreateCompanionBuilder =
    WorkoutExercisesCompanion Function({
      required String id,
      required String workoutId,
      required String exerciseId,
      required int setNumber,
      Value<double?> weightKg,
      Value<int?> reps,
      Value<bool> completed,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$WorkoutExercisesTableUpdateCompanionBuilder =
    WorkoutExercisesCompanion Function({
      Value<String> id,
      Value<String> workoutId,
      Value<String> exerciseId,
      Value<int> setNumber,
      Value<double?> weightKg,
      Value<int?> reps,
      Value<bool> completed,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$WorkoutExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutExercisesTable> {
  $$WorkoutExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workoutId => $composableBuilder(
    column: $table.workoutId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get setNumber => $composableBuilder(
    column: $table.setNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkoutExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutExercisesTable> {
  $$WorkoutExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workoutId => $composableBuilder(
    column: $table.workoutId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get setNumber => $composableBuilder(
    column: $table.setNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkoutExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutExercisesTable> {
  $$WorkoutExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workoutId =>
      $composableBuilder(column: $table.workoutId, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get setNumber =>
      $composableBuilder(column: $table.setNumber, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$WorkoutExercisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutExercisesTable,
          WorkoutExercise,
          $$WorkoutExercisesTableFilterComposer,
          $$WorkoutExercisesTableOrderingComposer,
          $$WorkoutExercisesTableAnnotationComposer,
          $$WorkoutExercisesTableCreateCompanionBuilder,
          $$WorkoutExercisesTableUpdateCompanionBuilder,
          (
            WorkoutExercise,
            BaseReferences<
              _$AppDatabase,
              $WorkoutExercisesTable,
              WorkoutExercise
            >,
          ),
          WorkoutExercise,
          PrefetchHooks Function()
        > {
  $$WorkoutExercisesTableTableManager(
    _$AppDatabase db,
    $WorkoutExercisesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> workoutId = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<int> setNumber = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<int?> reps = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutExercisesCompanion(
                id: id,
                workoutId: workoutId,
                exerciseId: exerciseId,
                setNumber: setNumber,
                weightKg: weightKg,
                reps: reps,
                completed: completed,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String workoutId,
                required String exerciseId,
                required int setNumber,
                Value<double?> weightKg = const Value.absent(),
                Value<int?> reps = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutExercisesCompanion.insert(
                id: id,
                workoutId: workoutId,
                exerciseId: exerciseId,
                setNumber: setNumber,
                weightKg: weightKg,
                reps: reps,
                completed: completed,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WorkoutExercisesTable, WorkoutExercise>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $WorkoutExercisesTable,
                    WorkoutExercise
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkoutExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutExercisesTable,
      WorkoutExercise,
      $$WorkoutExercisesTableFilterComposer,
      $$WorkoutExercisesTableOrderingComposer,
      $$WorkoutExercisesTableAnnotationComposer,
      $$WorkoutExercisesTableCreateCompanionBuilder,
      $$WorkoutExercisesTableUpdateCompanionBuilder,
      (
        WorkoutExercise,
        BaseReferences<_$AppDatabase, $WorkoutExercisesTable, WorkoutExercise>,
      ),
      WorkoutExercise,
      PrefetchHooks Function()
    >;
typedef $$BodyMeasurementsTableCreateCompanionBuilder =
    BodyMeasurementsCompanion Function({
      required String id,
      required String gymId,
      required String userId,
      required DateTime recordedAt,
      Value<double?> weightKg,
      Value<double?> bodyFatPct,
      Value<double?> waistCm,
      Value<double?> hipsCm,
      Value<double?> chestCm,
      Value<double?> armsCm,
      Value<double?> thighsCm,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$BodyMeasurementsTableUpdateCompanionBuilder =
    BodyMeasurementsCompanion Function({
      Value<String> id,
      Value<String> gymId,
      Value<String> userId,
      Value<DateTime> recordedAt,
      Value<double?> weightKg,
      Value<double?> bodyFatPct,
      Value<double?> waistCm,
      Value<double?> hipsCm,
      Value<double?> chestCm,
      Value<double?> armsCm,
      Value<double?> thighsCm,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$BodyMeasurementsTableFilterComposer
    extends Composer<_$AppDatabase, $BodyMeasurementsTable> {
  $$BodyMeasurementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gymId => $composableBuilder(
    column: $table.gymId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bodyFatPct => $composableBuilder(
    column: $table.bodyFatPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get waistCm => $composableBuilder(
    column: $table.waistCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hipsCm => $composableBuilder(
    column: $table.hipsCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get chestCm => $composableBuilder(
    column: $table.chestCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get armsCm => $composableBuilder(
    column: $table.armsCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get thighsCm => $composableBuilder(
    column: $table.thighsCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BodyMeasurementsTableOrderingComposer
    extends Composer<_$AppDatabase, $BodyMeasurementsTable> {
  $$BodyMeasurementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gymId => $composableBuilder(
    column: $table.gymId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bodyFatPct => $composableBuilder(
    column: $table.bodyFatPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get waistCm => $composableBuilder(
    column: $table.waistCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hipsCm => $composableBuilder(
    column: $table.hipsCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get chestCm => $composableBuilder(
    column: $table.chestCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get armsCm => $composableBuilder(
    column: $table.armsCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get thighsCm => $composableBuilder(
    column: $table.thighsCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BodyMeasurementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BodyMeasurementsTable> {
  $$BodyMeasurementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get gymId =>
      $composableBuilder(column: $table.gymId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<double> get bodyFatPct => $composableBuilder(
    column: $table.bodyFatPct,
    builder: (column) => column,
  );

  GeneratedColumn<double> get waistCm =>
      $composableBuilder(column: $table.waistCm, builder: (column) => column);

  GeneratedColumn<double> get hipsCm =>
      $composableBuilder(column: $table.hipsCm, builder: (column) => column);

  GeneratedColumn<double> get chestCm =>
      $composableBuilder(column: $table.chestCm, builder: (column) => column);

  GeneratedColumn<double> get armsCm =>
      $composableBuilder(column: $table.armsCm, builder: (column) => column);

  GeneratedColumn<double> get thighsCm =>
      $composableBuilder(column: $table.thighsCm, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$BodyMeasurementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BodyMeasurementsTable,
          BodyMeasurement,
          $$BodyMeasurementsTableFilterComposer,
          $$BodyMeasurementsTableOrderingComposer,
          $$BodyMeasurementsTableAnnotationComposer,
          $$BodyMeasurementsTableCreateCompanionBuilder,
          $$BodyMeasurementsTableUpdateCompanionBuilder,
          (
            BodyMeasurement,
            BaseReferences<
              _$AppDatabase,
              $BodyMeasurementsTable,
              BodyMeasurement
            >,
          ),
          BodyMeasurement,
          PrefetchHooks Function()
        > {
  $$BodyMeasurementsTableTableManager(
    _$AppDatabase db,
    $BodyMeasurementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BodyMeasurementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BodyMeasurementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BodyMeasurementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> gymId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<double?> bodyFatPct = const Value.absent(),
                Value<double?> waistCm = const Value.absent(),
                Value<double?> hipsCm = const Value.absent(),
                Value<double?> chestCm = const Value.absent(),
                Value<double?> armsCm = const Value.absent(),
                Value<double?> thighsCm = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BodyMeasurementsCompanion(
                id: id,
                gymId: gymId,
                userId: userId,
                recordedAt: recordedAt,
                weightKg: weightKg,
                bodyFatPct: bodyFatPct,
                waistCm: waistCm,
                hipsCm: hipsCm,
                chestCm: chestCm,
                armsCm: armsCm,
                thighsCm: thighsCm,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String gymId,
                required String userId,
                required DateTime recordedAt,
                Value<double?> weightKg = const Value.absent(),
                Value<double?> bodyFatPct = const Value.absent(),
                Value<double?> waistCm = const Value.absent(),
                Value<double?> hipsCm = const Value.absent(),
                Value<double?> chestCm = const Value.absent(),
                Value<double?> armsCm = const Value.absent(),
                Value<double?> thighsCm = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BodyMeasurementsCompanion.insert(
                id: id,
                gymId: gymId,
                userId: userId,
                recordedAt: recordedAt,
                weightKg: weightKg,
                bodyFatPct: bodyFatPct,
                waistCm: waistCm,
                hipsCm: hipsCm,
                chestCm: chestCm,
                armsCm: armsCm,
                thighsCm: thighsCm,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BodyMeasurementsTable, BodyMeasurement>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $BodyMeasurementsTable,
                    BodyMeasurement
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BodyMeasurementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BodyMeasurementsTable,
      BodyMeasurement,
      $$BodyMeasurementsTableFilterComposer,
      $$BodyMeasurementsTableOrderingComposer,
      $$BodyMeasurementsTableAnnotationComposer,
      $$BodyMeasurementsTableCreateCompanionBuilder,
      $$BodyMeasurementsTableUpdateCompanionBuilder,
      (
        BodyMeasurement,
        BaseReferences<_$AppDatabase, $BodyMeasurementsTable, BodyMeasurement>,
      ),
      BodyMeasurement,
      PrefetchHooks Function()
    >;
typedef $$ProgressPhotosTableCreateCompanionBuilder =
    ProgressPhotosCompanion Function({
      required String id,
      required String gymId,
      required String userId,
      required String photoUrl,
      required DateTime takenAt,
      Value<String?> category,
      Value<int> rowid,
    });
typedef $$ProgressPhotosTableUpdateCompanionBuilder =
    ProgressPhotosCompanion Function({
      Value<String> id,
      Value<String> gymId,
      Value<String> userId,
      Value<String> photoUrl,
      Value<DateTime> takenAt,
      Value<String?> category,
      Value<int> rowid,
    });

class $$ProgressPhotosTableFilterComposer
    extends Composer<_$AppDatabase, $ProgressPhotosTable> {
  $$ProgressPhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gymId => $composableBuilder(
    column: $table.gymId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProgressPhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $ProgressPhotosTable> {
  $$ProgressPhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gymId => $composableBuilder(
    column: $table.gymId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProgressPhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProgressPhotosTable> {
  $$ProgressPhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get gymId =>
      $composableBuilder(column: $table.gymId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get takenAt =>
      $composableBuilder(column: $table.takenAt, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);
}

class $$ProgressPhotosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProgressPhotosTable,
          ProgressPhoto,
          $$ProgressPhotosTableFilterComposer,
          $$ProgressPhotosTableOrderingComposer,
          $$ProgressPhotosTableAnnotationComposer,
          $$ProgressPhotosTableCreateCompanionBuilder,
          $$ProgressPhotosTableUpdateCompanionBuilder,
          (
            ProgressPhoto,
            BaseReferences<_$AppDatabase, $ProgressPhotosTable, ProgressPhoto>,
          ),
          ProgressPhoto,
          PrefetchHooks Function()
        > {
  $$ProgressPhotosTableTableManager(
    _$AppDatabase db,
    $ProgressPhotosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProgressPhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProgressPhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProgressPhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> gymId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> photoUrl = const Value.absent(),
                Value<DateTime> takenAt = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProgressPhotosCompanion(
                id: id,
                gymId: gymId,
                userId: userId,
                photoUrl: photoUrl,
                takenAt: takenAt,
                category: category,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String gymId,
                required String userId,
                required String photoUrl,
                required DateTime takenAt,
                Value<String?> category = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProgressPhotosCompanion.insert(
                id: id,
                gymId: gymId,
                userId: userId,
                photoUrl: photoUrl,
                takenAt: takenAt,
                category: category,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProgressPhotosTable, ProgressPhoto>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ProgressPhotosTable,
                    ProgressPhoto
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProgressPhotosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProgressPhotosTable,
      ProgressPhoto,
      $$ProgressPhotosTableFilterComposer,
      $$ProgressPhotosTableOrderingComposer,
      $$ProgressPhotosTableAnnotationComposer,
      $$ProgressPhotosTableCreateCompanionBuilder,
      $$ProgressPhotosTableUpdateCompanionBuilder,
      (
        ProgressPhoto,
        BaseReferences<_$AppDatabase, $ProgressPhotosTable, ProgressPhoto>,
      ),
      ProgressPhoto,
      PrefetchHooks Function()
    >;
typedef $$NotificationsTableCreateCompanionBuilder =
    NotificationsCompanion Function({
      required String id,
      required String userId,
      required String title,
      required String body,
      Value<bool> isRead,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$NotificationsTableUpdateCompanionBuilder =
    NotificationsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> title,
      Value<String> body,
      Value<bool> isRead,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$NotificationsTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationsTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$NotificationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationsTable,
          Notification,
          $$NotificationsTableFilterComposer,
          $$NotificationsTableOrderingComposer,
          $$NotificationsTableAnnotationComposer,
          $$NotificationsTableCreateCompanionBuilder,
          $$NotificationsTableUpdateCompanionBuilder,
          (
            Notification,
            BaseReferences<_$AppDatabase, $NotificationsTable, Notification>,
          ),
          Notification,
          PrefetchHooks Function()
        > {
  $$NotificationsTableTableManager(_$AppDatabase db, $NotificationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationsCompanion(
                id: id,
                userId: userId,
                title: title,
                body: body,
                isRead: isRead,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String title,
                required String body,
                Value<bool> isRead = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationsCompanion.insert(
                id: id,
                userId: userId,
                title: title,
                body: body,
                isRead: isRead,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NotificationsTable, Notification>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $NotificationsTable,
                    Notification
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationsTable,
      Notification,
      $$NotificationsTableFilterComposer,
      $$NotificationsTableOrderingComposer,
      $$NotificationsTableAnnotationComposer,
      $$NotificationsTableCreateCompanionBuilder,
      $$NotificationsTableUpdateCompanionBuilder,
      (
        Notification,
        BaseReferences<_$AppDatabase, $NotificationsTable, Notification>,
      ),
      Notification,
      PrefetchHooks Function()
    >;
typedef $$ExchangeRatesTableCreateCompanionBuilder =
    ExchangeRatesCompanion Function({
      required String id,
      required String gymId,
      required double rate,
      Value<bool> isManual,
      required DateTime validFrom,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$ExchangeRatesTableUpdateCompanionBuilder =
    ExchangeRatesCompanion Function({
      Value<String> id,
      Value<String> gymId,
      Value<double> rate,
      Value<bool> isManual,
      Value<DateTime> validFrom,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$ExchangeRatesTableFilterComposer
    extends Composer<_$AppDatabase, $ExchangeRatesTable> {
  $$ExchangeRatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gymId => $composableBuilder(
    column: $table.gymId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isManual => $composableBuilder(
    column: $table.isManual,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get validFrom => $composableBuilder(
    column: $table.validFrom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExchangeRatesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExchangeRatesTable> {
  $$ExchangeRatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gymId => $composableBuilder(
    column: $table.gymId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isManual => $composableBuilder(
    column: $table.isManual,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get validFrom => $composableBuilder(
    column: $table.validFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExchangeRatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExchangeRatesTable> {
  $$ExchangeRatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get gymId =>
      $composableBuilder(column: $table.gymId, builder: (column) => column);

  GeneratedColumn<double> get rate =>
      $composableBuilder(column: $table.rate, builder: (column) => column);

  GeneratedColumn<bool> get isManual =>
      $composableBuilder(column: $table.isManual, builder: (column) => column);

  GeneratedColumn<DateTime> get validFrom =>
      $composableBuilder(column: $table.validFrom, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ExchangeRatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExchangeRatesTable,
          ExchangeRate,
          $$ExchangeRatesTableFilterComposer,
          $$ExchangeRatesTableOrderingComposer,
          $$ExchangeRatesTableAnnotationComposer,
          $$ExchangeRatesTableCreateCompanionBuilder,
          $$ExchangeRatesTableUpdateCompanionBuilder,
          (
            ExchangeRate,
            BaseReferences<_$AppDatabase, $ExchangeRatesTable, ExchangeRate>,
          ),
          ExchangeRate,
          PrefetchHooks Function()
        > {
  $$ExchangeRatesTableTableManager(_$AppDatabase db, $ExchangeRatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExchangeRatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExchangeRatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExchangeRatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> gymId = const Value.absent(),
                Value<double> rate = const Value.absent(),
                Value<bool> isManual = const Value.absent(),
                Value<DateTime> validFrom = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExchangeRatesCompanion(
                id: id,
                gymId: gymId,
                rate: rate,
                isManual: isManual,
                validFrom: validFrom,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String gymId,
                required double rate,
                Value<bool> isManual = const Value.absent(),
                required DateTime validFrom,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExchangeRatesCompanion.insert(
                id: id,
                gymId: gymId,
                rate: rate,
                isManual: isManual,
                validFrom: validFrom,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExchangeRatesTable, ExchangeRate>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ExchangeRatesTable,
                    ExchangeRate
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExchangeRatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExchangeRatesTable,
      ExchangeRate,
      $$ExchangeRatesTableFilterComposer,
      $$ExchangeRatesTableOrderingComposer,
      $$ExchangeRatesTableAnnotationComposer,
      $$ExchangeRatesTableCreateCompanionBuilder,
      $$ExchangeRatesTableUpdateCompanionBuilder,
      (
        ExchangeRate,
        BaseReferences<_$AppDatabase, $ExchangeRatesTable, ExchangeRate>,
      ),
      ExchangeRate,
      PrefetchHooks Function()
    >;
typedef $$GymSettingsTableCreateCompanionBuilder =
    GymSettingsCompanion Function({
      required String gymId,
      Value<String> primaryColor,
      Value<double?> bcvRate,
      Value<bool> bcvRateManual,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$GymSettingsTableUpdateCompanionBuilder =
    GymSettingsCompanion Function({
      Value<String> gymId,
      Value<String> primaryColor,
      Value<double?> bcvRate,
      Value<bool> bcvRateManual,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$GymSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $GymSettingsTable> {
  $$GymSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get gymId => $composableBuilder(
    column: $table.gymId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryColor => $composableBuilder(
    column: $table.primaryColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bcvRate => $composableBuilder(
    column: $table.bcvRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get bcvRateManual => $composableBuilder(
    column: $table.bcvRateManual,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GymSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $GymSettingsTable> {
  $$GymSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get gymId => $composableBuilder(
    column: $table.gymId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryColor => $composableBuilder(
    column: $table.primaryColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bcvRate => $composableBuilder(
    column: $table.bcvRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get bcvRateManual => $composableBuilder(
    column: $table.bcvRateManual,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GymSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GymSettingsTable> {
  $$GymSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get gymId =>
      $composableBuilder(column: $table.gymId, builder: (column) => column);

  GeneratedColumn<String> get primaryColor => $composableBuilder(
    column: $table.primaryColor,
    builder: (column) => column,
  );

  GeneratedColumn<double> get bcvRate =>
      $composableBuilder(column: $table.bcvRate, builder: (column) => column);

  GeneratedColumn<bool> get bcvRateManual => $composableBuilder(
    column: $table.bcvRateManual,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$GymSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GymSettingsTable,
          GymSetting,
          $$GymSettingsTableFilterComposer,
          $$GymSettingsTableOrderingComposer,
          $$GymSettingsTableAnnotationComposer,
          $$GymSettingsTableCreateCompanionBuilder,
          $$GymSettingsTableUpdateCompanionBuilder,
          (
            GymSetting,
            BaseReferences<_$AppDatabase, $GymSettingsTable, GymSetting>,
          ),
          GymSetting,
          PrefetchHooks Function()
        > {
  $$GymSettingsTableTableManager(_$AppDatabase db, $GymSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GymSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GymSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GymSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> gymId = const Value.absent(),
                Value<String> primaryColor = const Value.absent(),
                Value<double?> bcvRate = const Value.absent(),
                Value<bool> bcvRateManual = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GymSettingsCompanion(
                gymId: gymId,
                primaryColor: primaryColor,
                bcvRate: bcvRate,
                bcvRateManual: bcvRateManual,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String gymId,
                Value<String> primaryColor = const Value.absent(),
                Value<double?> bcvRate = const Value.absent(),
                Value<bool> bcvRateManual = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GymSettingsCompanion.insert(
                gymId: gymId,
                primaryColor: primaryColor,
                bcvRate: bcvRate,
                bcvRateManual: bcvRateManual,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GymSettingsTable, GymSetting>(table),
                  BaseReferences<_$AppDatabase, $GymSettingsTable, GymSetting>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GymSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GymSettingsTable,
      GymSetting,
      $$GymSettingsTableFilterComposer,
      $$GymSettingsTableOrderingComposer,
      $$GymSettingsTableAnnotationComposer,
      $$GymSettingsTableCreateCompanionBuilder,
      $$GymSettingsTableUpdateCompanionBuilder,
      (
        GymSetting,
        BaseReferences<_$AppDatabase, $GymSettingsTable, GymSetting>,
      ),
      GymSetting,
      PrefetchHooks Function()
    >;
typedef $$FoodsTableTableCreateCompanionBuilder =
    FoodsTableCompanion Function({
      required String id,
      Value<String?> gymId,
      required String name,
      Value<String?> brand,
      Value<String?> barcode,
      required double servingSize,
      Value<String> servingUnit,
      required double caloriesKcal,
      required double proteinG,
      required double carbsG,
      required double fatsG,
      Value<double?> fiberG,
      Value<double?> sugarG,
      Value<double?> sodiumMg,
      Value<bool> isVerified,
      Value<bool> isSystem,
      Value<String?> createdBy,
      Value<String> source,
      Value<String?> externalId,
      Value<String?> imageUrl,
      Value<bool> isActive,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$FoodsTableTableUpdateCompanionBuilder =
    FoodsTableCompanion Function({
      Value<String> id,
      Value<String?> gymId,
      Value<String> name,
      Value<String?> brand,
      Value<String?> barcode,
      Value<double> servingSize,
      Value<String> servingUnit,
      Value<double> caloriesKcal,
      Value<double> proteinG,
      Value<double> carbsG,
      Value<double> fatsG,
      Value<double?> fiberG,
      Value<double?> sugarG,
      Value<double?> sodiumMg,
      Value<bool> isVerified,
      Value<bool> isSystem,
      Value<String?> createdBy,
      Value<String> source,
      Value<String?> externalId,
      Value<String?> imageUrl,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$FoodsTableTableFilterComposer
    extends Composer<_$AppDatabase, $FoodsTableTable> {
  $$FoodsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gymId => $composableBuilder(
    column: $table.gymId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get servingSize => $composableBuilder(
    column: $table.servingSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get servingUnit => $composableBuilder(
    column: $table.servingUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get caloriesKcal => $composableBuilder(
    column: $table.caloriesKcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinG => $composableBuilder(
    column: $table.proteinG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbsG => $composableBuilder(
    column: $table.carbsG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatsG => $composableBuilder(
    column: $table.fatsG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fiberG => $composableBuilder(
    column: $table.fiberG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sugarG => $composableBuilder(
    column: $table.sugarG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sodiumMg => $composableBuilder(
    column: $table.sodiumMg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FoodsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodsTableTable> {
  $$FoodsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gymId => $composableBuilder(
    column: $table.gymId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get servingSize => $composableBuilder(
    column: $table.servingSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get servingUnit => $composableBuilder(
    column: $table.servingUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get caloriesKcal => $composableBuilder(
    column: $table.caloriesKcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinG => $composableBuilder(
    column: $table.proteinG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbsG => $composableBuilder(
    column: $table.carbsG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatsG => $composableBuilder(
    column: $table.fatsG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fiberG => $composableBuilder(
    column: $table.fiberG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sugarG => $composableBuilder(
    column: $table.sugarG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sodiumMg => $composableBuilder(
    column: $table.sodiumMg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FoodsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodsTableTable> {
  $$FoodsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get gymId =>
      $composableBuilder(column: $table.gymId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<double> get servingSize => $composableBuilder(
    column: $table.servingSize,
    builder: (column) => column,
  );

  GeneratedColumn<String> get servingUnit => $composableBuilder(
    column: $table.servingUnit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get caloriesKcal => $composableBuilder(
    column: $table.caloriesKcal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinG =>
      $composableBuilder(column: $table.proteinG, builder: (column) => column);

  GeneratedColumn<double> get carbsG =>
      $composableBuilder(column: $table.carbsG, builder: (column) => column);

  GeneratedColumn<double> get fatsG =>
      $composableBuilder(column: $table.fatsG, builder: (column) => column);

  GeneratedColumn<double> get fiberG =>
      $composableBuilder(column: $table.fiberG, builder: (column) => column);

  GeneratedColumn<double> get sugarG =>
      $composableBuilder(column: $table.sugarG, builder: (column) => column);

  GeneratedColumn<double> get sodiumMg =>
      $composableBuilder(column: $table.sodiumMg, builder: (column) => column);

  GeneratedColumn<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSystem =>
      $composableBuilder(column: $table.isSystem, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$FoodsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodsTableTable,
          FoodsTableData,
          $$FoodsTableTableFilterComposer,
          $$FoodsTableTableOrderingComposer,
          $$FoodsTableTableAnnotationComposer,
          $$FoodsTableTableCreateCompanionBuilder,
          $$FoodsTableTableUpdateCompanionBuilder,
          (
            FoodsTableData,
            BaseReferences<_$AppDatabase, $FoodsTableTable, FoodsTableData>,
          ),
          FoodsTableData,
          PrefetchHooks Function()
        > {
  $$FoodsTableTableTableManager(_$AppDatabase db, $FoodsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> gymId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<double> servingSize = const Value.absent(),
                Value<String> servingUnit = const Value.absent(),
                Value<double> caloriesKcal = const Value.absent(),
                Value<double> proteinG = const Value.absent(),
                Value<double> carbsG = const Value.absent(),
                Value<double> fatsG = const Value.absent(),
                Value<double?> fiberG = const Value.absent(),
                Value<double?> sugarG = const Value.absent(),
                Value<double?> sodiumMg = const Value.absent(),
                Value<bool> isVerified = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> externalId = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FoodsTableCompanion(
                id: id,
                gymId: gymId,
                name: name,
                brand: brand,
                barcode: barcode,
                servingSize: servingSize,
                servingUnit: servingUnit,
                caloriesKcal: caloriesKcal,
                proteinG: proteinG,
                carbsG: carbsG,
                fatsG: fatsG,
                fiberG: fiberG,
                sugarG: sugarG,
                sodiumMg: sodiumMg,
                isVerified: isVerified,
                isSystem: isSystem,
                createdBy: createdBy,
                source: source,
                externalId: externalId,
                imageUrl: imageUrl,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> gymId = const Value.absent(),
                required String name,
                Value<String?> brand = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                required double servingSize,
                Value<String> servingUnit = const Value.absent(),
                required double caloriesKcal,
                required double proteinG,
                required double carbsG,
                required double fatsG,
                Value<double?> fiberG = const Value.absent(),
                Value<double?> sugarG = const Value.absent(),
                Value<double?> sodiumMg = const Value.absent(),
                Value<bool> isVerified = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> externalId = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => FoodsTableCompanion.insert(
                id: id,
                gymId: gymId,
                name: name,
                brand: brand,
                barcode: barcode,
                servingSize: servingSize,
                servingUnit: servingUnit,
                caloriesKcal: caloriesKcal,
                proteinG: proteinG,
                carbsG: carbsG,
                fatsG: fatsG,
                fiberG: fiberG,
                sugarG: sugarG,
                sodiumMg: sodiumMg,
                isVerified: isVerified,
                isSystem: isSystem,
                createdBy: createdBy,
                source: source,
                externalId: externalId,
                imageUrl: imageUrl,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FoodsTableTable, FoodsTableData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $FoodsTableTable,
                    FoodsTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FoodsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodsTableTable,
      FoodsTableData,
      $$FoodsTableTableFilterComposer,
      $$FoodsTableTableOrderingComposer,
      $$FoodsTableTableAnnotationComposer,
      $$FoodsTableTableCreateCompanionBuilder,
      $$FoodsTableTableUpdateCompanionBuilder,
      (
        FoodsTableData,
        BaseReferences<_$AppDatabase, $FoodsTableTable, FoodsTableData>,
      ),
      FoodsTableData,
      PrefetchHooks Function()
    >;
typedef $$NutritionPlansTableCreateCompanionBuilder =
    NutritionPlansCompanion Function({
      required String id,
      required String gymId,
      required String clientId,
      required String nutritionistId,
      required String name,
      Value<String?> goal,
      required double targetCaloriesKcal,
      required double targetProteinG,
      required double targetCarbsG,
      required double targetFatsG,
      required int durationDays,
      Value<String?> notes,
      Value<bool> isActive,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$NutritionPlansTableUpdateCompanionBuilder =
    NutritionPlansCompanion Function({
      Value<String> id,
      Value<String> gymId,
      Value<String> clientId,
      Value<String> nutritionistId,
      Value<String> name,
      Value<String?> goal,
      Value<double> targetCaloriesKcal,
      Value<double> targetProteinG,
      Value<double> targetCarbsG,
      Value<double> targetFatsG,
      Value<int> durationDays,
      Value<String?> notes,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$NutritionPlansTableFilterComposer
    extends Composer<_$AppDatabase, $NutritionPlansTable> {
  $$NutritionPlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gymId => $composableBuilder(
    column: $table.gymId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nutritionistId => $composableBuilder(
    column: $table.nutritionistId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetCaloriesKcal => $composableBuilder(
    column: $table.targetCaloriesKcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetProteinG => $composableBuilder(
    column: $table.targetProteinG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetCarbsG => $composableBuilder(
    column: $table.targetCarbsG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetFatsG => $composableBuilder(
    column: $table.targetFatsG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationDays => $composableBuilder(
    column: $table.durationDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NutritionPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $NutritionPlansTable> {
  $$NutritionPlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gymId => $composableBuilder(
    column: $table.gymId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nutritionistId => $composableBuilder(
    column: $table.nutritionistId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetCaloriesKcal => $composableBuilder(
    column: $table.targetCaloriesKcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetProteinG => $composableBuilder(
    column: $table.targetProteinG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetCarbsG => $composableBuilder(
    column: $table.targetCarbsG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetFatsG => $composableBuilder(
    column: $table.targetFatsG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationDays => $composableBuilder(
    column: $table.durationDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NutritionPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $NutritionPlansTable> {
  $$NutritionPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get gymId =>
      $composableBuilder(column: $table.gymId, builder: (column) => column);

  GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<String> get nutritionistId => $composableBuilder(
    column: $table.nutritionistId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get goal =>
      $composableBuilder(column: $table.goal, builder: (column) => column);

  GeneratedColumn<double> get targetCaloriesKcal => $composableBuilder(
    column: $table.targetCaloriesKcal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetProteinG => $composableBuilder(
    column: $table.targetProteinG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetCarbsG => $composableBuilder(
    column: $table.targetCarbsG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetFatsG => $composableBuilder(
    column: $table.targetFatsG,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationDays => $composableBuilder(
    column: $table.durationDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$NutritionPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NutritionPlansTable,
          NutritionPlan,
          $$NutritionPlansTableFilterComposer,
          $$NutritionPlansTableOrderingComposer,
          $$NutritionPlansTableAnnotationComposer,
          $$NutritionPlansTableCreateCompanionBuilder,
          $$NutritionPlansTableUpdateCompanionBuilder,
          (
            NutritionPlan,
            BaseReferences<_$AppDatabase, $NutritionPlansTable, NutritionPlan>,
          ),
          NutritionPlan,
          PrefetchHooks Function()
        > {
  $$NutritionPlansTableTableManager(
    _$AppDatabase db,
    $NutritionPlansTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NutritionPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NutritionPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NutritionPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> gymId = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String> nutritionistId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> goal = const Value.absent(),
                Value<double> targetCaloriesKcal = const Value.absent(),
                Value<double> targetProteinG = const Value.absent(),
                Value<double> targetCarbsG = const Value.absent(),
                Value<double> targetFatsG = const Value.absent(),
                Value<int> durationDays = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NutritionPlansCompanion(
                id: id,
                gymId: gymId,
                clientId: clientId,
                nutritionistId: nutritionistId,
                name: name,
                goal: goal,
                targetCaloriesKcal: targetCaloriesKcal,
                targetProteinG: targetProteinG,
                targetCarbsG: targetCarbsG,
                targetFatsG: targetFatsG,
                durationDays: durationDays,
                notes: notes,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String gymId,
                required String clientId,
                required String nutritionistId,
                required String name,
                Value<String?> goal = const Value.absent(),
                required double targetCaloriesKcal,
                required double targetProteinG,
                required double targetCarbsG,
                required double targetFatsG,
                required int durationDays,
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => NutritionPlansCompanion.insert(
                id: id,
                gymId: gymId,
                clientId: clientId,
                nutritionistId: nutritionistId,
                name: name,
                goal: goal,
                targetCaloriesKcal: targetCaloriesKcal,
                targetProteinG: targetProteinG,
                targetCarbsG: targetCarbsG,
                targetFatsG: targetFatsG,
                durationDays: durationDays,
                notes: notes,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NutritionPlansTable, NutritionPlan>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $NutritionPlansTable,
                    NutritionPlan
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NutritionPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NutritionPlansTable,
      NutritionPlan,
      $$NutritionPlansTableFilterComposer,
      $$NutritionPlansTableOrderingComposer,
      $$NutritionPlansTableAnnotationComposer,
      $$NutritionPlansTableCreateCompanionBuilder,
      $$NutritionPlansTableUpdateCompanionBuilder,
      (
        NutritionPlan,
        BaseReferences<_$AppDatabase, $NutritionPlansTable, NutritionPlan>,
      ),
      NutritionPlan,
      PrefetchHooks Function()
    >;
typedef $$NutritionGoalsTableCreateCompanionBuilder =
    NutritionGoalsCompanion Function({
      required String id,
      required String clientId,
      required String gymId,
      Value<String?> setBy,
      required double targetCaloriesKcal,
      required double targetProteinG,
      required double targetCarbsG,
      required double targetFatsG,
      Value<String> goalType,
      Value<String?> notes,
      Value<bool> isActive,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$NutritionGoalsTableUpdateCompanionBuilder =
    NutritionGoalsCompanion Function({
      Value<String> id,
      Value<String> clientId,
      Value<String> gymId,
      Value<String?> setBy,
      Value<double> targetCaloriesKcal,
      Value<double> targetProteinG,
      Value<double> targetCarbsG,
      Value<double> targetFatsG,
      Value<String> goalType,
      Value<String?> notes,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$NutritionGoalsTableFilterComposer
    extends Composer<_$AppDatabase, $NutritionGoalsTable> {
  $$NutritionGoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gymId => $composableBuilder(
    column: $table.gymId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get setBy => $composableBuilder(
    column: $table.setBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetCaloriesKcal => $composableBuilder(
    column: $table.targetCaloriesKcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetProteinG => $composableBuilder(
    column: $table.targetProteinG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetCarbsG => $composableBuilder(
    column: $table.targetCarbsG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetFatsG => $composableBuilder(
    column: $table.targetFatsG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goalType => $composableBuilder(
    column: $table.goalType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NutritionGoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $NutritionGoalsTable> {
  $$NutritionGoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gymId => $composableBuilder(
    column: $table.gymId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get setBy => $composableBuilder(
    column: $table.setBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetCaloriesKcal => $composableBuilder(
    column: $table.targetCaloriesKcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetProteinG => $composableBuilder(
    column: $table.targetProteinG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetCarbsG => $composableBuilder(
    column: $table.targetCarbsG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetFatsG => $composableBuilder(
    column: $table.targetFatsG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goalType => $composableBuilder(
    column: $table.goalType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NutritionGoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NutritionGoalsTable> {
  $$NutritionGoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<String> get gymId =>
      $composableBuilder(column: $table.gymId, builder: (column) => column);

  GeneratedColumn<String> get setBy =>
      $composableBuilder(column: $table.setBy, builder: (column) => column);

  GeneratedColumn<double> get targetCaloriesKcal => $composableBuilder(
    column: $table.targetCaloriesKcal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetProteinG => $composableBuilder(
    column: $table.targetProteinG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetCarbsG => $composableBuilder(
    column: $table.targetCarbsG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetFatsG => $composableBuilder(
    column: $table.targetFatsG,
    builder: (column) => column,
  );

  GeneratedColumn<String> get goalType =>
      $composableBuilder(column: $table.goalType, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$NutritionGoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NutritionGoalsTable,
          NutritionGoal,
          $$NutritionGoalsTableFilterComposer,
          $$NutritionGoalsTableOrderingComposer,
          $$NutritionGoalsTableAnnotationComposer,
          $$NutritionGoalsTableCreateCompanionBuilder,
          $$NutritionGoalsTableUpdateCompanionBuilder,
          (
            NutritionGoal,
            BaseReferences<_$AppDatabase, $NutritionGoalsTable, NutritionGoal>,
          ),
          NutritionGoal,
          PrefetchHooks Function()
        > {
  $$NutritionGoalsTableTableManager(
    _$AppDatabase db,
    $NutritionGoalsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NutritionGoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NutritionGoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NutritionGoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String> gymId = const Value.absent(),
                Value<String?> setBy = const Value.absent(),
                Value<double> targetCaloriesKcal = const Value.absent(),
                Value<double> targetProteinG = const Value.absent(),
                Value<double> targetCarbsG = const Value.absent(),
                Value<double> targetFatsG = const Value.absent(),
                Value<String> goalType = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NutritionGoalsCompanion(
                id: id,
                clientId: clientId,
                gymId: gymId,
                setBy: setBy,
                targetCaloriesKcal: targetCaloriesKcal,
                targetProteinG: targetProteinG,
                targetCarbsG: targetCarbsG,
                targetFatsG: targetFatsG,
                goalType: goalType,
                notes: notes,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String clientId,
                required String gymId,
                Value<String?> setBy = const Value.absent(),
                required double targetCaloriesKcal,
                required double targetProteinG,
                required double targetCarbsG,
                required double targetFatsG,
                Value<String> goalType = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => NutritionGoalsCompanion.insert(
                id: id,
                clientId: clientId,
                gymId: gymId,
                setBy: setBy,
                targetCaloriesKcal: targetCaloriesKcal,
                targetProteinG: targetProteinG,
                targetCarbsG: targetCarbsG,
                targetFatsG: targetFatsG,
                goalType: goalType,
                notes: notes,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NutritionGoalsTable, NutritionGoal>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $NutritionGoalsTable,
                    NutritionGoal
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NutritionGoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NutritionGoalsTable,
      NutritionGoal,
      $$NutritionGoalsTableFilterComposer,
      $$NutritionGoalsTableOrderingComposer,
      $$NutritionGoalsTableAnnotationComposer,
      $$NutritionGoalsTableCreateCompanionBuilder,
      $$NutritionGoalsTableUpdateCompanionBuilder,
      (
        NutritionGoal,
        BaseReferences<_$AppDatabase, $NutritionGoalsTable, NutritionGoal>,
      ),
      NutritionGoal,
      PrefetchHooks Function()
    >;
typedef $$FoodLogsTableCreateCompanionBuilder =
    FoodLogsCompanion Function({
      required String id,
      required String clientId,
      required String gymId,
      required DateTime logDate,
      Value<double> totalCaloriesKcal,
      Value<double> totalProteinG,
      Value<double> totalCarbsG,
      Value<double> totalFatsG,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$FoodLogsTableUpdateCompanionBuilder =
    FoodLogsCompanion Function({
      Value<String> id,
      Value<String> clientId,
      Value<String> gymId,
      Value<DateTime> logDate,
      Value<double> totalCaloriesKcal,
      Value<double> totalProteinG,
      Value<double> totalCarbsG,
      Value<double> totalFatsG,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$FoodLogsTableFilterComposer
    extends Composer<_$AppDatabase, $FoodLogsTable> {
  $$FoodLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gymId => $composableBuilder(
    column: $table.gymId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get logDate => $composableBuilder(
    column: $table.logDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalCaloriesKcal => $composableBuilder(
    column: $table.totalCaloriesKcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalProteinG => $composableBuilder(
    column: $table.totalProteinG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalCarbsG => $composableBuilder(
    column: $table.totalCarbsG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalFatsG => $composableBuilder(
    column: $table.totalFatsG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FoodLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodLogsTable> {
  $$FoodLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gymId => $composableBuilder(
    column: $table.gymId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get logDate => $composableBuilder(
    column: $table.logDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalCaloriesKcal => $composableBuilder(
    column: $table.totalCaloriesKcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalProteinG => $composableBuilder(
    column: $table.totalProteinG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalCarbsG => $composableBuilder(
    column: $table.totalCarbsG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalFatsG => $composableBuilder(
    column: $table.totalFatsG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FoodLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodLogsTable> {
  $$FoodLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<String> get gymId =>
      $composableBuilder(column: $table.gymId, builder: (column) => column);

  GeneratedColumn<DateTime> get logDate =>
      $composableBuilder(column: $table.logDate, builder: (column) => column);

  GeneratedColumn<double> get totalCaloriesKcal => $composableBuilder(
    column: $table.totalCaloriesKcal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalProteinG => $composableBuilder(
    column: $table.totalProteinG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalCarbsG => $composableBuilder(
    column: $table.totalCarbsG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalFatsG => $composableBuilder(
    column: $table.totalFatsG,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$FoodLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodLogsTable,
          FoodLog,
          $$FoodLogsTableFilterComposer,
          $$FoodLogsTableOrderingComposer,
          $$FoodLogsTableAnnotationComposer,
          $$FoodLogsTableCreateCompanionBuilder,
          $$FoodLogsTableUpdateCompanionBuilder,
          (FoodLog, BaseReferences<_$AppDatabase, $FoodLogsTable, FoodLog>),
          FoodLog,
          PrefetchHooks Function()
        > {
  $$FoodLogsTableTableManager(_$AppDatabase db, $FoodLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String> gymId = const Value.absent(),
                Value<DateTime> logDate = const Value.absent(),
                Value<double> totalCaloriesKcal = const Value.absent(),
                Value<double> totalProteinG = const Value.absent(),
                Value<double> totalCarbsG = const Value.absent(),
                Value<double> totalFatsG = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FoodLogsCompanion(
                id: id,
                clientId: clientId,
                gymId: gymId,
                logDate: logDate,
                totalCaloriesKcal: totalCaloriesKcal,
                totalProteinG: totalProteinG,
                totalCarbsG: totalCarbsG,
                totalFatsG: totalFatsG,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String clientId,
                required String gymId,
                required DateTime logDate,
                Value<double> totalCaloriesKcal = const Value.absent(),
                Value<double> totalProteinG = const Value.absent(),
                Value<double> totalCarbsG = const Value.absent(),
                Value<double> totalFatsG = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => FoodLogsCompanion.insert(
                id: id,
                clientId: clientId,
                gymId: gymId,
                logDate: logDate,
                totalCaloriesKcal: totalCaloriesKcal,
                totalProteinG: totalProteinG,
                totalCarbsG: totalCarbsG,
                totalFatsG: totalFatsG,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FoodLogsTable, FoodLog>(table),
                  BaseReferences<_$AppDatabase, $FoodLogsTable, FoodLog>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FoodLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodLogsTable,
      FoodLog,
      $$FoodLogsTableFilterComposer,
      $$FoodLogsTableOrderingComposer,
      $$FoodLogsTableAnnotationComposer,
      $$FoodLogsTableCreateCompanionBuilder,
      $$FoodLogsTableUpdateCompanionBuilder,
      (FoodLog, BaseReferences<_$AppDatabase, $FoodLogsTable, FoodLog>),
      FoodLog,
      PrefetchHooks Function()
    >;
typedef $$FoodLogItemsTableCreateCompanionBuilder =
    FoodLogItemsCompanion Function({
      required String id,
      required String logId,
      required String foodId,
      required String mealType,
      required double quantity,
      required double caloriesKcal,
      required double proteinG,
      required double carbsG,
      required double fatsG,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$FoodLogItemsTableUpdateCompanionBuilder =
    FoodLogItemsCompanion Function({
      Value<String> id,
      Value<String> logId,
      Value<String> foodId,
      Value<String> mealType,
      Value<double> quantity,
      Value<double> caloriesKcal,
      Value<double> proteinG,
      Value<double> carbsG,
      Value<double> fatsG,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$FoodLogItemsTableFilterComposer
    extends Composer<_$AppDatabase, $FoodLogItemsTable> {
  $$FoodLogItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logId => $composableBuilder(
    column: $table.logId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get foodId => $composableBuilder(
    column: $table.foodId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get caloriesKcal => $composableBuilder(
    column: $table.caloriesKcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinG => $composableBuilder(
    column: $table.proteinG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbsG => $composableBuilder(
    column: $table.carbsG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatsG => $composableBuilder(
    column: $table.fatsG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FoodLogItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodLogItemsTable> {
  $$FoodLogItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logId => $composableBuilder(
    column: $table.logId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get foodId => $composableBuilder(
    column: $table.foodId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get caloriesKcal => $composableBuilder(
    column: $table.caloriesKcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinG => $composableBuilder(
    column: $table.proteinG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbsG => $composableBuilder(
    column: $table.carbsG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatsG => $composableBuilder(
    column: $table.fatsG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FoodLogItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodLogItemsTable> {
  $$FoodLogItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get logId =>
      $composableBuilder(column: $table.logId, builder: (column) => column);

  GeneratedColumn<String> get foodId =>
      $composableBuilder(column: $table.foodId, builder: (column) => column);

  GeneratedColumn<String> get mealType =>
      $composableBuilder(column: $table.mealType, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get caloriesKcal => $composableBuilder(
    column: $table.caloriesKcal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinG =>
      $composableBuilder(column: $table.proteinG, builder: (column) => column);

  GeneratedColumn<double> get carbsG =>
      $composableBuilder(column: $table.carbsG, builder: (column) => column);

  GeneratedColumn<double> get fatsG =>
      $composableBuilder(column: $table.fatsG, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$FoodLogItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodLogItemsTable,
          FoodLogItem,
          $$FoodLogItemsTableFilterComposer,
          $$FoodLogItemsTableOrderingComposer,
          $$FoodLogItemsTableAnnotationComposer,
          $$FoodLogItemsTableCreateCompanionBuilder,
          $$FoodLogItemsTableUpdateCompanionBuilder,
          (
            FoodLogItem,
            BaseReferences<_$AppDatabase, $FoodLogItemsTable, FoodLogItem>,
          ),
          FoodLogItem,
          PrefetchHooks Function()
        > {
  $$FoodLogItemsTableTableManager(_$AppDatabase db, $FoodLogItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodLogItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodLogItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodLogItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> logId = const Value.absent(),
                Value<String> foodId = const Value.absent(),
                Value<String> mealType = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<double> caloriesKcal = const Value.absent(),
                Value<double> proteinG = const Value.absent(),
                Value<double> carbsG = const Value.absent(),
                Value<double> fatsG = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FoodLogItemsCompanion(
                id: id,
                logId: logId,
                foodId: foodId,
                mealType: mealType,
                quantity: quantity,
                caloriesKcal: caloriesKcal,
                proteinG: proteinG,
                carbsG: carbsG,
                fatsG: fatsG,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String logId,
                required String foodId,
                required String mealType,
                required double quantity,
                required double caloriesKcal,
                required double proteinG,
                required double carbsG,
                required double fatsG,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => FoodLogItemsCompanion.insert(
                id: id,
                logId: logId,
                foodId: foodId,
                mealType: mealType,
                quantity: quantity,
                caloriesKcal: caloriesKcal,
                proteinG: proteinG,
                carbsG: carbsG,
                fatsG: fatsG,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FoodLogItemsTable, FoodLogItem>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $FoodLogItemsTable,
                    FoodLogItem
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FoodLogItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodLogItemsTable,
      FoodLogItem,
      $$FoodLogItemsTableFilterComposer,
      $$FoodLogItemsTableOrderingComposer,
      $$FoodLogItemsTableAnnotationComposer,
      $$FoodLogItemsTableCreateCompanionBuilder,
      $$FoodLogItemsTableUpdateCompanionBuilder,
      (
        FoodLogItem,
        BaseReferences<_$AppDatabase, $FoodLogItemsTable, FoodLogItem>,
      ),
      FoodLogItem,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db, _db.profiles);
  $$GymsTableTableManager get gyms => $$GymsTableTableManager(_db, _db.gyms);
  $$MembershipsTableTableManager get memberships =>
      $$MembershipsTableTableManager(_db, _db.memberships);
  $$PlansTableTableManager get plans =>
      $$PlansTableTableManager(_db, _db.plans);
  $$SubscriptionsTableTableManager get subscriptions =>
      $$SubscriptionsTableTableManager(_db, _db.subscriptions);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db, _db.exercises);
  $$RoutinesTableTableManager get routines =>
      $$RoutinesTableTableManager(_db, _db.routines);
  $$RoutineExercisesTableTableManager get routineExercises =>
      $$RoutineExercisesTableTableManager(_db, _db.routineExercises);
  $$WorkoutsTableTableManager get workouts =>
      $$WorkoutsTableTableManager(_db, _db.workouts);
  $$WorkoutExercisesTableTableManager get workoutExercises =>
      $$WorkoutExercisesTableTableManager(_db, _db.workoutExercises);
  $$BodyMeasurementsTableTableManager get bodyMeasurements =>
      $$BodyMeasurementsTableTableManager(_db, _db.bodyMeasurements);
  $$ProgressPhotosTableTableManager get progressPhotos =>
      $$ProgressPhotosTableTableManager(_db, _db.progressPhotos);
  $$NotificationsTableTableManager get notifications =>
      $$NotificationsTableTableManager(_db, _db.notifications);
  $$ExchangeRatesTableTableManager get exchangeRates =>
      $$ExchangeRatesTableTableManager(_db, _db.exchangeRates);
  $$GymSettingsTableTableManager get gymSettings =>
      $$GymSettingsTableTableManager(_db, _db.gymSettings);
  $$FoodsTableTableTableManager get foodsTable =>
      $$FoodsTableTableTableManager(_db, _db.foodsTable);
  $$NutritionPlansTableTableManager get nutritionPlans =>
      $$NutritionPlansTableTableManager(_db, _db.nutritionPlans);
  $$NutritionGoalsTableTableManager get nutritionGoals =>
      $$NutritionGoalsTableTableManager(_db, _db.nutritionGoals);
  $$FoodLogsTableTableManager get foodLogs =>
      $$FoodLogsTableTableManager(_db, _db.foodLogs);
  $$FoodLogItemsTableTableManager get foodLogItems =>
      $$FoodLogItemsTableTableManager(_db, _db.foodLogItems);
}
