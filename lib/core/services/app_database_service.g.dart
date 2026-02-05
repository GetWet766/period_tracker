// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database_service.dart';

// ignore_for_file: type=lint
class $ProfileTable extends Profile with TableInfo<$ProfileTable, ProfileData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<UuidValue> id = GeneratedColumn<UuidValue>(
    'id',
    aliasedName,
    false,
    type: PgTypes.uuid,
    requiredDuringInsert: false,
    defaultValue: genRandomUuid(),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<PgDateTime> createdAt =
      GeneratedColumn<PgDateTime>(
        'created_at',
        aliasedName,
        false,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: false,
        defaultValue: now(),
      );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
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
  @override
  late final GeneratedColumnWithTypeConverter<UserRole, String> role =
      GeneratedColumn<String>(
        'role',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<UserRole>($ProfileTable.$converterrole);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<PgDateTime> updatedAt =
      GeneratedColumn<PgDateTime>(
        'updated_at',
        aliasedName,
        false,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: false,
        defaultValue: now(),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    displayName,
    avatarUrl,
    role,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
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
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ProfileData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileData(
      id: attachedDatabase.typeMapping.read(
        PgTypes.uuid,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        PgTypes.timestampWithTimezone,
        data['${effectivePrefix}created_at'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      ),
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      role: $ProfileTable.$converterrole.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}role'],
        )!,
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        PgTypes.timestampWithTimezone,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ProfileTable createAlias(String alias) {
    return $ProfileTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<UserRole, String, String> $converterrole =
      const EnumNameConverter<UserRole>(UserRole.values);
}

class ProfileData extends DataClass implements Insertable<ProfileData> {
  final UuidValue id;
  final PgDateTime createdAt;
  final String? displayName;
  final String? avatarUrl;
  final UserRole role;
  final PgDateTime updatedAt;
  const ProfileData({
    required this.id,
    required this.createdAt,
    this.displayName,
    this.avatarUrl,
    required this.role,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<UuidValue>(id, PgTypes.uuid);
    map['created_at'] = Variable<PgDateTime>(
      createdAt,
      PgTypes.timestampWithTimezone,
    );
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    {
      map['role'] = Variable<String>($ProfileTable.$converterrole.toSql(role));
    }
    map['updated_at'] = Variable<PgDateTime>(
      updatedAt,
      PgTypes.timestampWithTimezone,
    );
    return map;
  }

  ProfileCompanion toCompanion(bool nullToAbsent) {
    return ProfileCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      role: Value(role),
      updatedAt: Value(updatedAt),
    );
  }

  factory ProfileData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileData(
      id: serializer.fromJson<UuidValue>(json['id']),
      createdAt: serializer.fromJson<PgDateTime>(json['createdAt']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      role: $ProfileTable.$converterrole.fromJson(
        serializer.fromJson<String>(json['role']),
      ),
      updatedAt: serializer.fromJson<PgDateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<UuidValue>(id),
      'createdAt': serializer.toJson<PgDateTime>(createdAt),
      'displayName': serializer.toJson<String?>(displayName),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'role': serializer.toJson<String>(
        $ProfileTable.$converterrole.toJson(role),
      ),
      'updatedAt': serializer.toJson<PgDateTime>(updatedAt),
    };
  }

  ProfileData copyWith({
    UuidValue? id,
    PgDateTime? createdAt,
    Value<String?> displayName = const Value.absent(),
    Value<String?> avatarUrl = const Value.absent(),
    UserRole? role,
    PgDateTime? updatedAt,
  }) => ProfileData(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    displayName: displayName.present ? displayName.value : this.displayName,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    role: role ?? this.role,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ProfileData copyWithCompanion(ProfileCompanion data) {
    return ProfileData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      role: data.role.present ? data.role.value : this.role,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('displayName: $displayName, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('role: $role, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, displayName, avatarUrl, role, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.displayName == this.displayName &&
          other.avatarUrl == this.avatarUrl &&
          other.role == this.role &&
          other.updatedAt == this.updatedAt);
}

class ProfileCompanion extends UpdateCompanion<ProfileData> {
  final Value<UuidValue> id;
  final Value<PgDateTime> createdAt;
  final Value<String?> displayName;
  final Value<String?> avatarUrl;
  final Value<UserRole> role;
  final Value<PgDateTime> updatedAt;
  final Value<int> rowid;
  const ProfileCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.displayName = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.role = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfileCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.displayName = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    required UserRole role,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : role = Value(role);
  static Insertable<ProfileData> custom({
    Expression<UuidValue>? id,
    Expression<PgDateTime>? createdAt,
    Expression<String>? displayName,
    Expression<String>? avatarUrl,
    Expression<String>? role,
    Expression<PgDateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (displayName != null) 'display_name': displayName,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (role != null) 'role': role,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfileCompanion copyWith({
    Value<UuidValue>? id,
    Value<PgDateTime>? createdAt,
    Value<String?>? displayName,
    Value<String?>? avatarUrl,
    Value<UserRole>? role,
    Value<PgDateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ProfileCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<UuidValue>(id.value, PgTypes.uuid);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<PgDateTime>(
        createdAt.value,
        PgTypes.timestampWithTimezone,
      );
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(
        $ProfileTable.$converterrole.toSql(role.value),
      );
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<PgDateTime>(
        updatedAt.value,
        PgTypes.timestampWithTimezone,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('displayName: $displayName, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('role: $role, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CyclesTable extends Cycles with TableInfo<$CyclesTable, Cycle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CyclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<UuidValue> id = GeneratedColumn<UuidValue>(
    'id',
    aliasedName,
    false,
    type: PgTypes.uuid,
    requiredDuringInsert: false,
    defaultValue: genRandomUuid(),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<PgDateTime> createdAt =
      GeneratedColumn<PgDateTime>(
        'created_at',
        aliasedName,
        false,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: false,
        defaultValue: now(),
      );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<UuidValue> userId = GeneratedColumn<UuidValue>(
    'user_id',
    aliasedName,
    false,
    type: PgTypes.uuid,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profile (id)',
    ),
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<PgDate> startDate = GeneratedColumn<PgDate>(
    'start_date',
    aliasedName,
    false,
    type: PgTypes.date,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<PgDate> endDate = GeneratedColumn<PgDate>(
    'end_date',
    aliasedName,
    false,
    type: PgTypes.date,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    userId,
    startDate,
    endDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cycles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Cycle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Cycle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Cycle(
      id: attachedDatabase.typeMapping.read(
        PgTypes.uuid,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        PgTypes.timestampWithTimezone,
        data['${effectivePrefix}created_at'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        PgTypes.uuid,
        data['${effectivePrefix}user_id'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        PgTypes.date,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        PgTypes.date,
        data['${effectivePrefix}end_date'],
      )!,
    );
  }

  @override
  $CyclesTable createAlias(String alias) {
    return $CyclesTable(attachedDatabase, alias);
  }
}

class Cycle extends DataClass implements Insertable<Cycle> {
  final UuidValue id;
  final PgDateTime createdAt;
  final UuidValue userId;
  final PgDate startDate;
  final PgDate endDate;
  const Cycle({
    required this.id,
    required this.createdAt,
    required this.userId,
    required this.startDate,
    required this.endDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<UuidValue>(id, PgTypes.uuid);
    map['created_at'] = Variable<PgDateTime>(
      createdAt,
      PgTypes.timestampWithTimezone,
    );
    map['user_id'] = Variable<UuidValue>(userId, PgTypes.uuid);
    map['start_date'] = Variable<PgDate>(startDate, PgTypes.date);
    map['end_date'] = Variable<PgDate>(endDate, PgTypes.date);
    return map;
  }

  CyclesCompanion toCompanion(bool nullToAbsent) {
    return CyclesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      userId: Value(userId),
      startDate: Value(startDate),
      endDate: Value(endDate),
    );
  }

  factory Cycle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Cycle(
      id: serializer.fromJson<UuidValue>(json['id']),
      createdAt: serializer.fromJson<PgDateTime>(json['createdAt']),
      userId: serializer.fromJson<UuidValue>(json['userId']),
      startDate: serializer.fromJson<PgDate>(json['startDate']),
      endDate: serializer.fromJson<PgDate>(json['endDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<UuidValue>(id),
      'createdAt': serializer.toJson<PgDateTime>(createdAt),
      'userId': serializer.toJson<UuidValue>(userId),
      'startDate': serializer.toJson<PgDate>(startDate),
      'endDate': serializer.toJson<PgDate>(endDate),
    };
  }

  Cycle copyWith({
    UuidValue? id,
    PgDateTime? createdAt,
    UuidValue? userId,
    PgDate? startDate,
    PgDate? endDate,
  }) => Cycle(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    userId: userId ?? this.userId,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
  );
  Cycle copyWithCompanion(CyclesCompanion data) {
    return Cycle(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      userId: data.userId.present ? data.userId.value : this.userId,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Cycle(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('userId: $userId, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, userId, startDate, endDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Cycle &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.userId == this.userId &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate);
}

class CyclesCompanion extends UpdateCompanion<Cycle> {
  final Value<UuidValue> id;
  final Value<PgDateTime> createdAt;
  final Value<UuidValue> userId;
  final Value<PgDate> startDate;
  final Value<PgDate> endDate;
  final Value<int> rowid;
  const CyclesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.userId = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CyclesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    required UuidValue userId,
    required PgDate startDate,
    required PgDate endDate,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       startDate = Value(startDate),
       endDate = Value(endDate);
  static Insertable<Cycle> custom({
    Expression<UuidValue>? id,
    Expression<PgDateTime>? createdAt,
    Expression<UuidValue>? userId,
    Expression<PgDate>? startDate,
    Expression<PgDate>? endDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (userId != null) 'user_id': userId,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CyclesCompanion copyWith({
    Value<UuidValue>? id,
    Value<PgDateTime>? createdAt,
    Value<UuidValue>? userId,
    Value<PgDate>? startDate,
    Value<PgDate>? endDate,
    Value<int>? rowid,
  }) {
    return CyclesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<UuidValue>(id.value, PgTypes.uuid);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<PgDateTime>(
        createdAt.value,
        PgTypes.timestampWithTimezone,
      );
    }
    if (userId.present) {
      map['user_id'] = Variable<UuidValue>(userId.value, PgTypes.uuid);
    }
    if (startDate.present) {
      map['start_date'] = Variable<PgDate>(startDate.value, PgTypes.date);
    }
    if (endDate.present) {
      map['end_date'] = Variable<PgDate>(endDate.value, PgTypes.date);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CyclesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('userId: $userId, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyLogsTable extends DailyLogs
    with TableInfo<$DailyLogsTable, DailyLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<UuidValue> id = GeneratedColumn<UuidValue>(
    'id',
    aliasedName,
    false,
    type: PgTypes.uuid,
    requiredDuringInsert: false,
    defaultValue: genRandomUuid(),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<PgDateTime> createdAt =
      GeneratedColumn<PgDateTime>(
        'created_at',
        aliasedName,
        false,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: false,
        defaultValue: now(),
      );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<UuidValue> userId = GeneratedColumn<UuidValue>(
    'user_id',
    aliasedName,
    false,
    type: PgTypes.uuid,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profile (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<PgDate> date = GeneratedColumn<PgDate>(
    'date',
    aliasedName,
    false,
    type: PgTypes.date,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _symptomsMeta = const VerificationMeta(
    'symptoms',
  );
  @override
  late final GeneratedColumn<Object> symptoms = GeneratedColumn<Object>(
    'symptoms',
    aliasedName,
    false,
    type: PgTypes.jsonb,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _moodMeta = const VerificationMeta('mood');
  @override
  late final GeneratedColumn<String> mood = GeneratedColumn<String>(
    'mood',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<PgDateTime> updatedAt =
      GeneratedColumn<PgDateTime>(
        'updated_at',
        aliasedName,
        false,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: false,
        defaultValue: now(),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    userId,
    date,
    symptoms,
    mood,
    notes,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('symptoms')) {
      context.handle(
        _symptomsMeta,
        symptoms.isAcceptableOrUnknown(data['symptoms']!, _symptomsMeta),
      );
    } else if (isInserting) {
      context.missing(_symptomsMeta);
    }
    if (data.containsKey('mood')) {
      context.handle(
        _moodMeta,
        mood.isAcceptableOrUnknown(data['mood']!, _moodMeta),
      );
    } else if (isInserting) {
      context.missing(_moodMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    } else if (isInserting) {
      context.missing(_notesMeta);
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
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  DailyLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyLog(
      id: attachedDatabase.typeMapping.read(
        PgTypes.uuid,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        PgTypes.timestampWithTimezone,
        data['${effectivePrefix}created_at'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        PgTypes.uuid,
        data['${effectivePrefix}user_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        PgTypes.date,
        data['${effectivePrefix}date'],
      )!,
      symptoms: attachedDatabase.typeMapping.read(
        PgTypes.jsonb,
        data['${effectivePrefix}symptoms'],
      )!,
      mood: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mood'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        PgTypes.timestampWithTimezone,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DailyLogsTable createAlias(String alias) {
    return $DailyLogsTable(attachedDatabase, alias);
  }
}

class DailyLog extends DataClass implements Insertable<DailyLog> {
  final UuidValue id;
  final PgDateTime createdAt;
  final UuidValue userId;
  final PgDate date;
  final Object symptoms;
  final String mood;
  final String notes;
  final PgDateTime updatedAt;
  const DailyLog({
    required this.id,
    required this.createdAt,
    required this.userId,
    required this.date,
    required this.symptoms,
    required this.mood,
    required this.notes,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<UuidValue>(id, PgTypes.uuid);
    map['created_at'] = Variable<PgDateTime>(
      createdAt,
      PgTypes.timestampWithTimezone,
    );
    map['user_id'] = Variable<UuidValue>(userId, PgTypes.uuid);
    map['date'] = Variable<PgDate>(date, PgTypes.date);
    map['symptoms'] = Variable<Object>(symptoms, PgTypes.jsonb);
    map['mood'] = Variable<String>(mood);
    map['notes'] = Variable<String>(notes);
    map['updated_at'] = Variable<PgDateTime>(
      updatedAt,
      PgTypes.timestampWithTimezone,
    );
    return map;
  }

  DailyLogsCompanion toCompanion(bool nullToAbsent) {
    return DailyLogsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      userId: Value(userId),
      date: Value(date),
      symptoms: Value(symptoms),
      mood: Value(mood),
      notes: Value(notes),
      updatedAt: Value(updatedAt),
    );
  }

  factory DailyLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyLog(
      id: serializer.fromJson<UuidValue>(json['id']),
      createdAt: serializer.fromJson<PgDateTime>(json['createdAt']),
      userId: serializer.fromJson<UuidValue>(json['userId']),
      date: serializer.fromJson<PgDate>(json['date']),
      symptoms: serializer.fromJson<Object>(json['symptoms']),
      mood: serializer.fromJson<String>(json['mood']),
      notes: serializer.fromJson<String>(json['notes']),
      updatedAt: serializer.fromJson<PgDateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<UuidValue>(id),
      'createdAt': serializer.toJson<PgDateTime>(createdAt),
      'userId': serializer.toJson<UuidValue>(userId),
      'date': serializer.toJson<PgDate>(date),
      'symptoms': serializer.toJson<Object>(symptoms),
      'mood': serializer.toJson<String>(mood),
      'notes': serializer.toJson<String>(notes),
      'updatedAt': serializer.toJson<PgDateTime>(updatedAt),
    };
  }

  DailyLog copyWith({
    UuidValue? id,
    PgDateTime? createdAt,
    UuidValue? userId,
    PgDate? date,
    Object? symptoms,
    String? mood,
    String? notes,
    PgDateTime? updatedAt,
  }) => DailyLog(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    userId: userId ?? this.userId,
    date: date ?? this.date,
    symptoms: symptoms ?? this.symptoms,
    mood: mood ?? this.mood,
    notes: notes ?? this.notes,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DailyLog copyWithCompanion(DailyLogsCompanion data) {
    return DailyLog(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      userId: data.userId.present ? data.userId.value : this.userId,
      date: data.date.present ? data.date.value : this.date,
      symptoms: data.symptoms.present ? data.symptoms.value : this.symptoms,
      mood: data.mood.present ? data.mood.value : this.mood,
      notes: data.notes.present ? data.notes.value : this.notes,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyLog(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('symptoms: $symptoms, ')
          ..write('mood: $mood, ')
          ..write('notes: $notes, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    userId,
    date,
    symptoms,
    mood,
    notes,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyLog &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.userId == this.userId &&
          other.date == this.date &&
          other.symptoms == this.symptoms &&
          other.mood == this.mood &&
          other.notes == this.notes &&
          other.updatedAt == this.updatedAt);
}

class DailyLogsCompanion extends UpdateCompanion<DailyLog> {
  final Value<UuidValue> id;
  final Value<PgDateTime> createdAt;
  final Value<UuidValue> userId;
  final Value<PgDate> date;
  final Value<Object> symptoms;
  final Value<String> mood;
  final Value<String> notes;
  final Value<PgDateTime> updatedAt;
  final Value<int> rowid;
  const DailyLogsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.userId = const Value.absent(),
    this.date = const Value.absent(),
    this.symptoms = const Value.absent(),
    this.mood = const Value.absent(),
    this.notes = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyLogsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    required UuidValue userId,
    required PgDate date,
    required Object symptoms,
    required String mood,
    required String notes,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       date = Value(date),
       symptoms = Value(symptoms),
       mood = Value(mood),
       notes = Value(notes);
  static Insertable<DailyLog> custom({
    Expression<UuidValue>? id,
    Expression<PgDateTime>? createdAt,
    Expression<UuidValue>? userId,
    Expression<PgDate>? date,
    Expression<Object>? symptoms,
    Expression<String>? mood,
    Expression<String>? notes,
    Expression<PgDateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (userId != null) 'user_id': userId,
      if (date != null) 'date': date,
      if (symptoms != null) 'symptoms': symptoms,
      if (mood != null) 'mood': mood,
      if (notes != null) 'notes': notes,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyLogsCompanion copyWith({
    Value<UuidValue>? id,
    Value<PgDateTime>? createdAt,
    Value<UuidValue>? userId,
    Value<PgDate>? date,
    Value<Object>? symptoms,
    Value<String>? mood,
    Value<String>? notes,
    Value<PgDateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return DailyLogsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      symptoms: symptoms ?? this.symptoms,
      mood: mood ?? this.mood,
      notes: notes ?? this.notes,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<UuidValue>(id.value, PgTypes.uuid);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<PgDateTime>(
        createdAt.value,
        PgTypes.timestampWithTimezone,
      );
    }
    if (userId.present) {
      map['user_id'] = Variable<UuidValue>(userId.value, PgTypes.uuid);
    }
    if (date.present) {
      map['date'] = Variable<PgDate>(date.value, PgTypes.date);
    }
    if (symptoms.present) {
      map['symptoms'] = Variable<Object>(symptoms.value, PgTypes.jsonb);
    }
    if (mood.present) {
      map['mood'] = Variable<String>(mood.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<PgDateTime>(
        updatedAt.value,
        PgTypes.timestampWithTimezone,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyLogsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('symptoms: $symptoms, ')
          ..write('mood: $mood, ')
          ..write('notes: $notes, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PartnerConnectionsTable extends PartnerConnections
    with TableInfo<$PartnerConnectionsTable, PartnerConnection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PartnerConnectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<UuidValue> id = GeneratedColumn<UuidValue>(
    'id',
    aliasedName,
    false,
    type: PgTypes.uuid,
    requiredDuringInsert: false,
    defaultValue: genRandomUuid(),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<PgDateTime> createdAt =
      GeneratedColumn<PgDateTime>(
        'created_at',
        aliasedName,
        false,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: false,
        defaultValue: now(),
      );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<UuidValue> userId = GeneratedColumn<UuidValue>(
    'user_id',
    aliasedName,
    false,
    type: PgTypes.uuid,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profile (id)',
    ),
  );
  static const VerificationMeta _partnerIdMeta = const VerificationMeta(
    'partnerId',
  );
  @override
  late final GeneratedColumn<UuidValue> partnerId = GeneratedColumn<UuidValue>(
    'partner_id',
    aliasedName,
    false,
    type: PgTypes.uuid,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profile (id)',
    ),
  );
  static const VerificationMeta _inviteCodeMeta = const VerificationMeta(
    'inviteCode',
  );
  @override
  late final GeneratedColumn<String> inviteCode = GeneratedColumn<String>(
    'invite_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PartnerStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<PartnerStatus>($PartnerConnectionsTable.$converterstatus);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    userId,
    partnerId,
    inviteCode,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'partner_connections';
  @override
  VerificationContext validateIntegrity(
    Insertable<PartnerConnection> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('partner_id')) {
      context.handle(
        _partnerIdMeta,
        partnerId.isAcceptableOrUnknown(data['partner_id']!, _partnerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_partnerIdMeta);
    }
    if (data.containsKey('invite_code')) {
      context.handle(
        _inviteCodeMeta,
        inviteCode.isAcceptableOrUnknown(data['invite_code']!, _inviteCodeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  PartnerConnection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PartnerConnection(
      id: attachedDatabase.typeMapping.read(
        PgTypes.uuid,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        PgTypes.timestampWithTimezone,
        data['${effectivePrefix}created_at'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        PgTypes.uuid,
        data['${effectivePrefix}user_id'],
      )!,
      partnerId: attachedDatabase.typeMapping.read(
        PgTypes.uuid,
        data['${effectivePrefix}partner_id'],
      )!,
      inviteCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invite_code'],
      ),
      status: $PartnerConnectionsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
    );
  }

  @override
  $PartnerConnectionsTable createAlias(String alias) {
    return $PartnerConnectionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PartnerStatus, String, String> $converterstatus =
      const EnumNameConverter<PartnerStatus>(PartnerStatus.values);
}

class PartnerConnection extends DataClass
    implements Insertable<PartnerConnection> {
  final UuidValue id;
  final PgDateTime createdAt;
  final UuidValue userId;
  final UuidValue partnerId;
  final String? inviteCode;
  final PartnerStatus status;
  const PartnerConnection({
    required this.id,
    required this.createdAt,
    required this.userId,
    required this.partnerId,
    this.inviteCode,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<UuidValue>(id, PgTypes.uuid);
    map['created_at'] = Variable<PgDateTime>(
      createdAt,
      PgTypes.timestampWithTimezone,
    );
    map['user_id'] = Variable<UuidValue>(userId, PgTypes.uuid);
    map['partner_id'] = Variable<UuidValue>(partnerId, PgTypes.uuid);
    if (!nullToAbsent || inviteCode != null) {
      map['invite_code'] = Variable<String>(inviteCode);
    }
    {
      map['status'] = Variable<String>(
        $PartnerConnectionsTable.$converterstatus.toSql(status),
      );
    }
    return map;
  }

  PartnerConnectionsCompanion toCompanion(bool nullToAbsent) {
    return PartnerConnectionsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      userId: Value(userId),
      partnerId: Value(partnerId),
      inviteCode: inviteCode == null && nullToAbsent
          ? const Value.absent()
          : Value(inviteCode),
      status: Value(status),
    );
  }

  factory PartnerConnection.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PartnerConnection(
      id: serializer.fromJson<UuidValue>(json['id']),
      createdAt: serializer.fromJson<PgDateTime>(json['createdAt']),
      userId: serializer.fromJson<UuidValue>(json['userId']),
      partnerId: serializer.fromJson<UuidValue>(json['partnerId']),
      inviteCode: serializer.fromJson<String?>(json['inviteCode']),
      status: $PartnerConnectionsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<UuidValue>(id),
      'createdAt': serializer.toJson<PgDateTime>(createdAt),
      'userId': serializer.toJson<UuidValue>(userId),
      'partnerId': serializer.toJson<UuidValue>(partnerId),
      'inviteCode': serializer.toJson<String?>(inviteCode),
      'status': serializer.toJson<String>(
        $PartnerConnectionsTable.$converterstatus.toJson(status),
      ),
    };
  }

  PartnerConnection copyWith({
    UuidValue? id,
    PgDateTime? createdAt,
    UuidValue? userId,
    UuidValue? partnerId,
    Value<String?> inviteCode = const Value.absent(),
    PartnerStatus? status,
  }) => PartnerConnection(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    userId: userId ?? this.userId,
    partnerId: partnerId ?? this.partnerId,
    inviteCode: inviteCode.present ? inviteCode.value : this.inviteCode,
    status: status ?? this.status,
  );
  PartnerConnection copyWithCompanion(PartnerConnectionsCompanion data) {
    return PartnerConnection(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      userId: data.userId.present ? data.userId.value : this.userId,
      partnerId: data.partnerId.present ? data.partnerId.value : this.partnerId,
      inviteCode: data.inviteCode.present
          ? data.inviteCode.value
          : this.inviteCode,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PartnerConnection(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('userId: $userId, ')
          ..write('partnerId: $partnerId, ')
          ..write('inviteCode: $inviteCode, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, userId, partnerId, inviteCode, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PartnerConnection &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.userId == this.userId &&
          other.partnerId == this.partnerId &&
          other.inviteCode == this.inviteCode &&
          other.status == this.status);
}

class PartnerConnectionsCompanion extends UpdateCompanion<PartnerConnection> {
  final Value<UuidValue> id;
  final Value<PgDateTime> createdAt;
  final Value<UuidValue> userId;
  final Value<UuidValue> partnerId;
  final Value<String?> inviteCode;
  final Value<PartnerStatus> status;
  final Value<int> rowid;
  const PartnerConnectionsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.userId = const Value.absent(),
    this.partnerId = const Value.absent(),
    this.inviteCode = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PartnerConnectionsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    required UuidValue userId,
    required UuidValue partnerId,
    this.inviteCode = const Value.absent(),
    required PartnerStatus status,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       partnerId = Value(partnerId),
       status = Value(status);
  static Insertable<PartnerConnection> custom({
    Expression<UuidValue>? id,
    Expression<PgDateTime>? createdAt,
    Expression<UuidValue>? userId,
    Expression<UuidValue>? partnerId,
    Expression<String>? inviteCode,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (userId != null) 'user_id': userId,
      if (partnerId != null) 'partner_id': partnerId,
      if (inviteCode != null) 'invite_code': inviteCode,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PartnerConnectionsCompanion copyWith({
    Value<UuidValue>? id,
    Value<PgDateTime>? createdAt,
    Value<UuidValue>? userId,
    Value<UuidValue>? partnerId,
    Value<String?>? inviteCode,
    Value<PartnerStatus>? status,
    Value<int>? rowid,
  }) {
    return PartnerConnectionsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      partnerId: partnerId ?? this.partnerId,
      inviteCode: inviteCode ?? this.inviteCode,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<UuidValue>(id.value, PgTypes.uuid);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<PgDateTime>(
        createdAt.value,
        PgTypes.timestampWithTimezone,
      );
    }
    if (userId.present) {
      map['user_id'] = Variable<UuidValue>(userId.value, PgTypes.uuid);
    }
    if (partnerId.present) {
      map['partner_id'] = Variable<UuidValue>(partnerId.value, PgTypes.uuid);
    }
    if (inviteCode.present) {
      map['invite_code'] = Variable<String>(inviteCode.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $PartnerConnectionsTable.$converterstatus.toSql(status.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartnerConnectionsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('userId: $userId, ')
          ..write('partnerId: $partnerId, ')
          ..write('inviteCode: $inviteCode, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProfileDetailsTable extends ProfileDetails
    with TableInfo<$ProfileDetailsTable, ProfileDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<UuidValue> id = GeneratedColumn<UuidValue>(
    'id',
    aliasedName,
    false,
    type: PgTypes.uuid,
    requiredDuringInsert: false,
    defaultValue: genRandomUuid(),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<PgDateTime> createdAt =
      GeneratedColumn<PgDateTime>(
        'created_at',
        aliasedName,
        false,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: false,
        defaultValue: now(),
      );
  static const VerificationMeta _birthDateMeta = const VerificationMeta(
    'birthDate',
  );
  @override
  late final GeneratedColumn<PgDate> birthDate = GeneratedColumn<PgDate>(
    'birth_date',
    aliasedName,
    true,
    type: PgTypes.date,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
    'weight',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
    'height',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cycleAvgLengthMeta = const VerificationMeta(
    'cycleAvgLength',
  );
  @override
  late final GeneratedColumn<int> cycleAvgLength = GeneratedColumn<int>(
    'cycle_avg_length',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _periodAvgLengthMeta = const VerificationMeta(
    'periodAvgLength',
  );
  @override
  late final GeneratedColumn<int> periodAvgLength = GeneratedColumn<int>(
    'period_avg_length',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastPeriodDateStartMeta =
      const VerificationMeta('lastPeriodDateStart');
  @override
  late final GeneratedColumn<PgDate> lastPeriodDateStart =
      GeneratedColumn<PgDate>(
        'last_period_date_start',
        aliasedName,
        true,
        type: PgTypes.date,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastPeriodDateEndMeta = const VerificationMeta(
    'lastPeriodDateEnd',
  );
  @override
  late final GeneratedColumn<PgDate> lastPeriodDateEnd =
      GeneratedColumn<PgDate>(
        'last_period_date_end',
        aliasedName,
        true,
        type: PgTypes.date,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<PgDateTime> updatedAt =
      GeneratedColumn<PgDateTime>(
        'updated_at',
        aliasedName,
        false,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: false,
        defaultValue: now(),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    birthDate,
    weight,
    height,
    cycleAvgLength,
    periodAvgLength,
    lastPeriodDateStart,
    lastPeriodDateEnd,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_details';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileDetail> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('birth_date')) {
      context.handle(
        _birthDateMeta,
        birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta),
      );
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    }
    if (data.containsKey('cycle_avg_length')) {
      context.handle(
        _cycleAvgLengthMeta,
        cycleAvgLength.isAcceptableOrUnknown(
          data['cycle_avg_length']!,
          _cycleAvgLengthMeta,
        ),
      );
    }
    if (data.containsKey('period_avg_length')) {
      context.handle(
        _periodAvgLengthMeta,
        periodAvgLength.isAcceptableOrUnknown(
          data['period_avg_length']!,
          _periodAvgLengthMeta,
        ),
      );
    }
    if (data.containsKey('last_period_date_start')) {
      context.handle(
        _lastPeriodDateStartMeta,
        lastPeriodDateStart.isAcceptableOrUnknown(
          data['last_period_date_start']!,
          _lastPeriodDateStartMeta,
        ),
      );
    }
    if (data.containsKey('last_period_date_end')) {
      context.handle(
        _lastPeriodDateEndMeta,
        lastPeriodDateEnd.isAcceptableOrUnknown(
          data['last_period_date_end']!,
          _lastPeriodDateEndMeta,
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
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ProfileDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileDetail(
      id: attachedDatabase.typeMapping.read(
        PgTypes.uuid,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        PgTypes.timestampWithTimezone,
        data['${effectivePrefix}created_at'],
      )!,
      birthDate: attachedDatabase.typeMapping.read(
        PgTypes.date,
        data['${effectivePrefix}birth_date'],
      ),
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weight'],
      ),
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}height'],
      ),
      cycleAvgLength: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cycle_avg_length'],
      ),
      periodAvgLength: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}period_avg_length'],
      ),
      lastPeriodDateStart: attachedDatabase.typeMapping.read(
        PgTypes.date,
        data['${effectivePrefix}last_period_date_start'],
      ),
      lastPeriodDateEnd: attachedDatabase.typeMapping.read(
        PgTypes.date,
        data['${effectivePrefix}last_period_date_end'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        PgTypes.timestampWithTimezone,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ProfileDetailsTable createAlias(String alias) {
    return $ProfileDetailsTable(attachedDatabase, alias);
  }
}

class ProfileDetail extends DataClass implements Insertable<ProfileDetail> {
  final UuidValue id;
  final PgDateTime createdAt;
  final PgDate? birthDate;
  final int? weight;
  final int? height;
  final int? cycleAvgLength;
  final int? periodAvgLength;
  final PgDate? lastPeriodDateStart;
  final PgDate? lastPeriodDateEnd;
  final PgDateTime updatedAt;
  const ProfileDetail({
    required this.id,
    required this.createdAt,
    this.birthDate,
    this.weight,
    this.height,
    this.cycleAvgLength,
    this.periodAvgLength,
    this.lastPeriodDateStart,
    this.lastPeriodDateEnd,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<UuidValue>(id, PgTypes.uuid);
    map['created_at'] = Variable<PgDateTime>(
      createdAt,
      PgTypes.timestampWithTimezone,
    );
    if (!nullToAbsent || birthDate != null) {
      map['birth_date'] = Variable<PgDate>(birthDate, PgTypes.date);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<int>(weight);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<int>(height);
    }
    if (!nullToAbsent || cycleAvgLength != null) {
      map['cycle_avg_length'] = Variable<int>(cycleAvgLength);
    }
    if (!nullToAbsent || periodAvgLength != null) {
      map['period_avg_length'] = Variable<int>(periodAvgLength);
    }
    if (!nullToAbsent || lastPeriodDateStart != null) {
      map['last_period_date_start'] = Variable<PgDate>(
        lastPeriodDateStart,
        PgTypes.date,
      );
    }
    if (!nullToAbsent || lastPeriodDateEnd != null) {
      map['last_period_date_end'] = Variable<PgDate>(
        lastPeriodDateEnd,
        PgTypes.date,
      );
    }
    map['updated_at'] = Variable<PgDateTime>(
      updatedAt,
      PgTypes.timestampWithTimezone,
    );
    return map;
  }

  ProfileDetailsCompanion toCompanion(bool nullToAbsent) {
    return ProfileDetailsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      birthDate: birthDate == null && nullToAbsent
          ? const Value.absent()
          : Value(birthDate),
      weight: weight == null && nullToAbsent
          ? const Value.absent()
          : Value(weight),
      height: height == null && nullToAbsent
          ? const Value.absent()
          : Value(height),
      cycleAvgLength: cycleAvgLength == null && nullToAbsent
          ? const Value.absent()
          : Value(cycleAvgLength),
      periodAvgLength: periodAvgLength == null && nullToAbsent
          ? const Value.absent()
          : Value(periodAvgLength),
      lastPeriodDateStart: lastPeriodDateStart == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPeriodDateStart),
      lastPeriodDateEnd: lastPeriodDateEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPeriodDateEnd),
      updatedAt: Value(updatedAt),
    );
  }

  factory ProfileDetail.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileDetail(
      id: serializer.fromJson<UuidValue>(json['id']),
      createdAt: serializer.fromJson<PgDateTime>(json['createdAt']),
      birthDate: serializer.fromJson<PgDate?>(json['birthDate']),
      weight: serializer.fromJson<int?>(json['weight']),
      height: serializer.fromJson<int?>(json['height']),
      cycleAvgLength: serializer.fromJson<int?>(json['cycleAvgLength']),
      periodAvgLength: serializer.fromJson<int?>(json['periodAvgLength']),
      lastPeriodDateStart: serializer.fromJson<PgDate?>(
        json['lastPeriodDateStart'],
      ),
      lastPeriodDateEnd: serializer.fromJson<PgDate?>(
        json['lastPeriodDateEnd'],
      ),
      updatedAt: serializer.fromJson<PgDateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<UuidValue>(id),
      'createdAt': serializer.toJson<PgDateTime>(createdAt),
      'birthDate': serializer.toJson<PgDate?>(birthDate),
      'weight': serializer.toJson<int?>(weight),
      'height': serializer.toJson<int?>(height),
      'cycleAvgLength': serializer.toJson<int?>(cycleAvgLength),
      'periodAvgLength': serializer.toJson<int?>(periodAvgLength),
      'lastPeriodDateStart': serializer.toJson<PgDate?>(lastPeriodDateStart),
      'lastPeriodDateEnd': serializer.toJson<PgDate?>(lastPeriodDateEnd),
      'updatedAt': serializer.toJson<PgDateTime>(updatedAt),
    };
  }

  ProfileDetail copyWith({
    UuidValue? id,
    PgDateTime? createdAt,
    Value<PgDate?> birthDate = const Value.absent(),
    Value<int?> weight = const Value.absent(),
    Value<int?> height = const Value.absent(),
    Value<int?> cycleAvgLength = const Value.absent(),
    Value<int?> periodAvgLength = const Value.absent(),
    Value<PgDate?> lastPeriodDateStart = const Value.absent(),
    Value<PgDate?> lastPeriodDateEnd = const Value.absent(),
    PgDateTime? updatedAt,
  }) => ProfileDetail(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    birthDate: birthDate.present ? birthDate.value : this.birthDate,
    weight: weight.present ? weight.value : this.weight,
    height: height.present ? height.value : this.height,
    cycleAvgLength: cycleAvgLength.present
        ? cycleAvgLength.value
        : this.cycleAvgLength,
    periodAvgLength: periodAvgLength.present
        ? periodAvgLength.value
        : this.periodAvgLength,
    lastPeriodDateStart: lastPeriodDateStart.present
        ? lastPeriodDateStart.value
        : this.lastPeriodDateStart,
    lastPeriodDateEnd: lastPeriodDateEnd.present
        ? lastPeriodDateEnd.value
        : this.lastPeriodDateEnd,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ProfileDetail copyWithCompanion(ProfileDetailsCompanion data) {
    return ProfileDetail(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      weight: data.weight.present ? data.weight.value : this.weight,
      height: data.height.present ? data.height.value : this.height,
      cycleAvgLength: data.cycleAvgLength.present
          ? data.cycleAvgLength.value
          : this.cycleAvgLength,
      periodAvgLength: data.periodAvgLength.present
          ? data.periodAvgLength.value
          : this.periodAvgLength,
      lastPeriodDateStart: data.lastPeriodDateStart.present
          ? data.lastPeriodDateStart.value
          : this.lastPeriodDateStart,
      lastPeriodDateEnd: data.lastPeriodDateEnd.present
          ? data.lastPeriodDateEnd.value
          : this.lastPeriodDateEnd,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileDetail(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('birthDate: $birthDate, ')
          ..write('weight: $weight, ')
          ..write('height: $height, ')
          ..write('cycleAvgLength: $cycleAvgLength, ')
          ..write('periodAvgLength: $periodAvgLength, ')
          ..write('lastPeriodDateStart: $lastPeriodDateStart, ')
          ..write('lastPeriodDateEnd: $lastPeriodDateEnd, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    birthDate,
    weight,
    height,
    cycleAvgLength,
    periodAvgLength,
    lastPeriodDateStart,
    lastPeriodDateEnd,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileDetail &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.birthDate == this.birthDate &&
          other.weight == this.weight &&
          other.height == this.height &&
          other.cycleAvgLength == this.cycleAvgLength &&
          other.periodAvgLength == this.periodAvgLength &&
          other.lastPeriodDateStart == this.lastPeriodDateStart &&
          other.lastPeriodDateEnd == this.lastPeriodDateEnd &&
          other.updatedAt == this.updatedAt);
}

class ProfileDetailsCompanion extends UpdateCompanion<ProfileDetail> {
  final Value<UuidValue> id;
  final Value<PgDateTime> createdAt;
  final Value<PgDate?> birthDate;
  final Value<int?> weight;
  final Value<int?> height;
  final Value<int?> cycleAvgLength;
  final Value<int?> periodAvgLength;
  final Value<PgDate?> lastPeriodDateStart;
  final Value<PgDate?> lastPeriodDateEnd;
  final Value<PgDateTime> updatedAt;
  final Value<int> rowid;
  const ProfileDetailsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.weight = const Value.absent(),
    this.height = const Value.absent(),
    this.cycleAvgLength = const Value.absent(),
    this.periodAvgLength = const Value.absent(),
    this.lastPeriodDateStart = const Value.absent(),
    this.lastPeriodDateEnd = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfileDetailsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.weight = const Value.absent(),
    this.height = const Value.absent(),
    this.cycleAvgLength = const Value.absent(),
    this.periodAvgLength = const Value.absent(),
    this.lastPeriodDateStart = const Value.absent(),
    this.lastPeriodDateEnd = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<ProfileDetail> custom({
    Expression<UuidValue>? id,
    Expression<PgDateTime>? createdAt,
    Expression<PgDate>? birthDate,
    Expression<int>? weight,
    Expression<int>? height,
    Expression<int>? cycleAvgLength,
    Expression<int>? periodAvgLength,
    Expression<PgDate>? lastPeriodDateStart,
    Expression<PgDate>? lastPeriodDateEnd,
    Expression<PgDateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (birthDate != null) 'birth_date': birthDate,
      if (weight != null) 'weight': weight,
      if (height != null) 'height': height,
      if (cycleAvgLength != null) 'cycle_avg_length': cycleAvgLength,
      if (periodAvgLength != null) 'period_avg_length': periodAvgLength,
      if (lastPeriodDateStart != null)
        'last_period_date_start': lastPeriodDateStart,
      if (lastPeriodDateEnd != null) 'last_period_date_end': lastPeriodDateEnd,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfileDetailsCompanion copyWith({
    Value<UuidValue>? id,
    Value<PgDateTime>? createdAt,
    Value<PgDate?>? birthDate,
    Value<int?>? weight,
    Value<int?>? height,
    Value<int?>? cycleAvgLength,
    Value<int?>? periodAvgLength,
    Value<PgDate?>? lastPeriodDateStart,
    Value<PgDate?>? lastPeriodDateEnd,
    Value<PgDateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ProfileDetailsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      birthDate: birthDate ?? this.birthDate,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      cycleAvgLength: cycleAvgLength ?? this.cycleAvgLength,
      periodAvgLength: periodAvgLength ?? this.periodAvgLength,
      lastPeriodDateStart: lastPeriodDateStart ?? this.lastPeriodDateStart,
      lastPeriodDateEnd: lastPeriodDateEnd ?? this.lastPeriodDateEnd,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<UuidValue>(id.value, PgTypes.uuid);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<PgDateTime>(
        createdAt.value,
        PgTypes.timestampWithTimezone,
      );
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<PgDate>(birthDate.value, PgTypes.date);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (cycleAvgLength.present) {
      map['cycle_avg_length'] = Variable<int>(cycleAvgLength.value);
    }
    if (periodAvgLength.present) {
      map['period_avg_length'] = Variable<int>(periodAvgLength.value);
    }
    if (lastPeriodDateStart.present) {
      map['last_period_date_start'] = Variable<PgDate>(
        lastPeriodDateStart.value,
        PgTypes.date,
      );
    }
    if (lastPeriodDateEnd.present) {
      map['last_period_date_end'] = Variable<PgDate>(
        lastPeriodDateEnd.value,
        PgTypes.date,
      );
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<PgDateTime>(
        updatedAt.value,
        PgTypes.timestampWithTimezone,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileDetailsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('birthDate: $birthDate, ')
          ..write('weight: $weight, ')
          ..write('height: $height, ')
          ..write('cycleAvgLength: $cycleAvgLength, ')
          ..write('periodAvgLength: $periodAvgLength, ')
          ..write('lastPeriodDateStart: $lastPeriodDateStart, ')
          ..write('lastPeriodDateEnd: $lastPeriodDateEnd, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProfileTable profile = $ProfileTable(this);
  late final $CyclesTable cycles = $CyclesTable(this);
  late final $DailyLogsTable dailyLogs = $DailyLogsTable(this);
  late final $PartnerConnectionsTable partnerConnections =
      $PartnerConnectionsTable(this);
  late final $ProfileDetailsTable profileDetails = $ProfileDetailsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    profile,
    cycles,
    dailyLogs,
    partnerConnections,
    profileDetails,
  ];
}

typedef $$ProfileTableCreateCompanionBuilder =
    ProfileCompanion Function({
      Value<UuidValue> id,
      Value<PgDateTime> createdAt,
      Value<String?> displayName,
      Value<String?> avatarUrl,
      required UserRole role,
      Value<PgDateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$ProfileTableUpdateCompanionBuilder =
    ProfileCompanion Function({
      Value<UuidValue> id,
      Value<PgDateTime> createdAt,
      Value<String?> displayName,
      Value<String?> avatarUrl,
      Value<UserRole> role,
      Value<PgDateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ProfileTableReferences
    extends BaseReferences<_$AppDatabase, $ProfileTable, ProfileData> {
  $$ProfileTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CyclesTable, List<Cycle>> _cyclesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.cycles,
    aliasName: $_aliasNameGenerator(db.profile.id, db.cycles.userId),
  );

  $$CyclesTableProcessedTableManager get cyclesRefs {
    final manager = $$CyclesTableTableManager(
      $_db,
      $_db.cycles,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<UuidValue>('id')!));

    final cache = $_typedResult.readTableOrNull(_cyclesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DailyLogsTable, List<DailyLog>>
  _dailyLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.dailyLogs,
    aliasName: $_aliasNameGenerator(db.profile.id, db.dailyLogs.userId),
  );

  $$DailyLogsTableProcessedTableManager get dailyLogsRefs {
    final manager = $$DailyLogsTableTableManager(
      $_db,
      $_db.dailyLogs,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<UuidValue>('id')!));

    final cache = $_typedResult.readTableOrNull(_dailyLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PartnerConnectionsTable, List<PartnerConnection>>
  _profilesTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.partnerConnections,
    aliasName: $_aliasNameGenerator(
      db.profile.id,
      db.partnerConnections.userId,
    ),
  );

  $$PartnerConnectionsTableProcessedTableManager get profiles {
    final manager = $$PartnerConnectionsTableTableManager(
      $_db,
      $_db.partnerConnections,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<UuidValue>('id')!));

    final cache = $_typedResult.readTableOrNull(_profilesTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PartnerConnectionsTable, List<PartnerConnection>>
  _partnersTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.partnerConnections,
    aliasName: $_aliasNameGenerator(
      db.profile.id,
      db.partnerConnections.partnerId,
    ),
  );

  $$PartnerConnectionsTableProcessedTableManager get partners {
    final manager = $$PartnerConnectionsTableTableManager(
      $_db,
      $_db.partnerConnections,
    ).filter((f) => f.partnerId.id.sqlEquals($_itemColumn<UuidValue>('id')!));

    final cache = $_typedResult.readTableOrNull(_partnersTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProfileTableFilterComposer
    extends Composer<_$AppDatabase, $ProfileTable> {
  $$ProfileTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<UuidValue> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<UserRole, UserRole, String> get role =>
      $composableBuilder(
        column: $table.role,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<PgDateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> cyclesRefs(
    Expression<bool> Function($$CyclesTableFilterComposer f) f,
  ) {
    final $$CyclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cycles,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CyclesTableFilterComposer(
            $db: $db,
            $table: $db.cycles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> dailyLogsRefs(
    Expression<bool> Function($$DailyLogsTableFilterComposer f) f,
  ) {
    final $$DailyLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dailyLogs,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyLogsTableFilterComposer(
            $db: $db,
            $table: $db.dailyLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> profiles(
    Expression<bool> Function($$PartnerConnectionsTableFilterComposer f) f,
  ) {
    final $$PartnerConnectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.partnerConnections,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartnerConnectionsTableFilterComposer(
            $db: $db,
            $table: $db.partnerConnections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> partners(
    Expression<bool> Function($$PartnerConnectionsTableFilterComposer f) f,
  ) {
    final $$PartnerConnectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.partnerConnections,
      getReferencedColumn: (t) => t.partnerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartnerConnectionsTableFilterComposer(
            $db: $db,
            $table: $db.partnerConnections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProfileTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfileTable> {
  $$ProfileTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<UuidValue> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfileTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfileTable> {
  $$ProfileTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<UuidValue> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<PgDateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumnWithTypeConverter<UserRole, String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<PgDateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> cyclesRefs<T extends Object>(
    Expression<T> Function($$CyclesTableAnnotationComposer a) f,
  ) {
    final $$CyclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cycles,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CyclesTableAnnotationComposer(
            $db: $db,
            $table: $db.cycles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> dailyLogsRefs<T extends Object>(
    Expression<T> Function($$DailyLogsTableAnnotationComposer a) f,
  ) {
    final $$DailyLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dailyLogs,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.dailyLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> profiles<T extends Object>(
    Expression<T> Function($$PartnerConnectionsTableAnnotationComposer a) f,
  ) {
    final $$PartnerConnectionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.partnerConnections,
          getReferencedColumn: (t) => t.userId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PartnerConnectionsTableAnnotationComposer(
                $db: $db,
                $table: $db.partnerConnections,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> partners<T extends Object>(
    Expression<T> Function($$PartnerConnectionsTableAnnotationComposer a) f,
  ) {
    final $$PartnerConnectionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.partnerConnections,
          getReferencedColumn: (t) => t.partnerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PartnerConnectionsTableAnnotationComposer(
                $db: $db,
                $table: $db.partnerConnections,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ProfileTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfileTable,
          ProfileData,
          $$ProfileTableFilterComposer,
          $$ProfileTableOrderingComposer,
          $$ProfileTableAnnotationComposer,
          $$ProfileTableCreateCompanionBuilder,
          $$ProfileTableUpdateCompanionBuilder,
          (ProfileData, $$ProfileTableReferences),
          ProfileData,
          PrefetchHooks Function({
            bool cyclesRefs,
            bool dailyLogsRefs,
            bool profiles,
            bool partners,
          })
        > {
  $$ProfileTableTableManager(_$AppDatabase db, $ProfileTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfileTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfileTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfileTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<UuidValue> id = const Value.absent(),
                Value<PgDateTime> createdAt = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<UserRole> role = const Value.absent(),
                Value<PgDateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfileCompanion(
                id: id,
                createdAt: createdAt,
                displayName: displayName,
                avatarUrl: avatarUrl,
                role: role,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<UuidValue> id = const Value.absent(),
                Value<PgDateTime> createdAt = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                required UserRole role,
                Value<PgDateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfileCompanion.insert(
                id: id,
                createdAt: createdAt,
                displayName: displayName,
                avatarUrl: avatarUrl,
                role: role,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProfileTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                cyclesRefs = false,
                dailyLogsRefs = false,
                profiles = false,
                partners = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (cyclesRefs) db.cycles,
                    if (dailyLogsRefs) db.dailyLogs,
                    if (profiles) db.partnerConnections,
                    if (partners) db.partnerConnections,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (cyclesRefs)
                        await $_getPrefetchedData<
                          ProfileData,
                          $ProfileTable,
                          Cycle
                        >(
                          currentTable: table,
                          referencedTable: $$ProfileTableReferences
                              ._cyclesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfileTableReferences(
                                db,
                                table,
                                p0,
                              ).cyclesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (dailyLogsRefs)
                        await $_getPrefetchedData<
                          ProfileData,
                          $ProfileTable,
                          DailyLog
                        >(
                          currentTable: table,
                          referencedTable: $$ProfileTableReferences
                              ._dailyLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfileTableReferences(
                                db,
                                table,
                                p0,
                              ).dailyLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (profiles)
                        await $_getPrefetchedData<
                          ProfileData,
                          $ProfileTable,
                          PartnerConnection
                        >(
                          currentTable: table,
                          referencedTable: $$ProfileTableReferences
                              ._profilesTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfileTableReferences(db, table, p0).profiles,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (partners)
                        await $_getPrefetchedData<
                          ProfileData,
                          $ProfileTable,
                          PartnerConnection
                        >(
                          currentTable: table,
                          referencedTable: $$ProfileTableReferences
                              ._partnersTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfileTableReferences(db, table, p0).partners,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.partnerId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProfileTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfileTable,
      ProfileData,
      $$ProfileTableFilterComposer,
      $$ProfileTableOrderingComposer,
      $$ProfileTableAnnotationComposer,
      $$ProfileTableCreateCompanionBuilder,
      $$ProfileTableUpdateCompanionBuilder,
      (ProfileData, $$ProfileTableReferences),
      ProfileData,
      PrefetchHooks Function({
        bool cyclesRefs,
        bool dailyLogsRefs,
        bool profiles,
        bool partners,
      })
    >;
typedef $$CyclesTableCreateCompanionBuilder =
    CyclesCompanion Function({
      Value<UuidValue> id,
      Value<PgDateTime> createdAt,
      required UuidValue userId,
      required PgDate startDate,
      required PgDate endDate,
      Value<int> rowid,
    });
typedef $$CyclesTableUpdateCompanionBuilder =
    CyclesCompanion Function({
      Value<UuidValue> id,
      Value<PgDateTime> createdAt,
      Value<UuidValue> userId,
      Value<PgDate> startDate,
      Value<PgDate> endDate,
      Value<int> rowid,
    });

final class $$CyclesTableReferences
    extends BaseReferences<_$AppDatabase, $CyclesTable, Cycle> {
  $$CyclesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProfileTable _userIdTable(_$AppDatabase db) => db.profile.createAlias(
    $_aliasNameGenerator(db.cycles.userId, db.profile.id),
  );

  $$ProfileTableProcessedTableManager get userId {
    final $_column = $_itemColumn<UuidValue>('user_id')!;

    final manager = $$ProfileTableTableManager(
      $_db,
      $_db.profile,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CyclesTableFilterComposer
    extends Composer<_$AppDatabase, $CyclesTable> {
  $$CyclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<UuidValue> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDate> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDate> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfileTableFilterComposer get userId {
    final $$ProfileTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.profile,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfileTableFilterComposer(
            $db: $db,
            $table: $db.profile,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CyclesTableOrderingComposer
    extends Composer<_$AppDatabase, $CyclesTable> {
  $$CyclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<UuidValue> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDate> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDate> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfileTableOrderingComposer get userId {
    final $$ProfileTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.profile,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfileTableOrderingComposer(
            $db: $db,
            $table: $db.profile,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CyclesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CyclesTable> {
  $$CyclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<UuidValue> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<PgDateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<PgDate> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<PgDate> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  $$ProfileTableAnnotationComposer get userId {
    final $$ProfileTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.profile,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfileTableAnnotationComposer(
            $db: $db,
            $table: $db.profile,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CyclesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CyclesTable,
          Cycle,
          $$CyclesTableFilterComposer,
          $$CyclesTableOrderingComposer,
          $$CyclesTableAnnotationComposer,
          $$CyclesTableCreateCompanionBuilder,
          $$CyclesTableUpdateCompanionBuilder,
          (Cycle, $$CyclesTableReferences),
          Cycle,
          PrefetchHooks Function({bool userId})
        > {
  $$CyclesTableTableManager(_$AppDatabase db, $CyclesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CyclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CyclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CyclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<UuidValue> id = const Value.absent(),
                Value<PgDateTime> createdAt = const Value.absent(),
                Value<UuidValue> userId = const Value.absent(),
                Value<PgDate> startDate = const Value.absent(),
                Value<PgDate> endDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CyclesCompanion(
                id: id,
                createdAt: createdAt,
                userId: userId,
                startDate: startDate,
                endDate: endDate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<UuidValue> id = const Value.absent(),
                Value<PgDateTime> createdAt = const Value.absent(),
                required UuidValue userId,
                required PgDate startDate,
                required PgDate endDate,
                Value<int> rowid = const Value.absent(),
              }) => CyclesCompanion.insert(
                id: id,
                createdAt: createdAt,
                userId: userId,
                startDate: startDate,
                endDate: endDate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$CyclesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userId,
                                referencedTable: $$CyclesTableReferences
                                    ._userIdTable(db),
                                referencedColumn: $$CyclesTableReferences
                                    ._userIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CyclesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CyclesTable,
      Cycle,
      $$CyclesTableFilterComposer,
      $$CyclesTableOrderingComposer,
      $$CyclesTableAnnotationComposer,
      $$CyclesTableCreateCompanionBuilder,
      $$CyclesTableUpdateCompanionBuilder,
      (Cycle, $$CyclesTableReferences),
      Cycle,
      PrefetchHooks Function({bool userId})
    >;
typedef $$DailyLogsTableCreateCompanionBuilder =
    DailyLogsCompanion Function({
      Value<UuidValue> id,
      Value<PgDateTime> createdAt,
      required UuidValue userId,
      required PgDate date,
      required Object symptoms,
      required String mood,
      required String notes,
      Value<PgDateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$DailyLogsTableUpdateCompanionBuilder =
    DailyLogsCompanion Function({
      Value<UuidValue> id,
      Value<PgDateTime> createdAt,
      Value<UuidValue> userId,
      Value<PgDate> date,
      Value<Object> symptoms,
      Value<String> mood,
      Value<String> notes,
      Value<PgDateTime> updatedAt,
      Value<int> rowid,
    });

final class $$DailyLogsTableReferences
    extends BaseReferences<_$AppDatabase, $DailyLogsTable, DailyLog> {
  $$DailyLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProfileTable _userIdTable(_$AppDatabase db) => db.profile.createAlias(
    $_aliasNameGenerator(db.dailyLogs.userId, db.profile.id),
  );

  $$ProfileTableProcessedTableManager get userId {
    final $_column = $_itemColumn<UuidValue>('user_id')!;

    final manager = $$ProfileTableTableManager(
      $_db,
      $_db.profile,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DailyLogsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyLogsTable> {
  $$DailyLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<UuidValue> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDate> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Object> get symptoms => $composableBuilder(
    column: $table.symptoms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfileTableFilterComposer get userId {
    final $$ProfileTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.profile,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfileTableFilterComposer(
            $db: $db,
            $table: $db.profile,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DailyLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyLogsTable> {
  $$DailyLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<UuidValue> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDate> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Object> get symptoms => $composableBuilder(
    column: $table.symptoms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfileTableOrderingComposer get userId {
    final $$ProfileTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.profile,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfileTableOrderingComposer(
            $db: $db,
            $table: $db.profile,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DailyLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyLogsTable> {
  $$DailyLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<UuidValue> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<PgDateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<PgDate> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<Object> get symptoms =>
      $composableBuilder(column: $table.symptoms, builder: (column) => column);

  GeneratedColumn<String> get mood =>
      $composableBuilder(column: $table.mood, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<PgDateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProfileTableAnnotationComposer get userId {
    final $$ProfileTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.profile,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfileTableAnnotationComposer(
            $db: $db,
            $table: $db.profile,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DailyLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyLogsTable,
          DailyLog,
          $$DailyLogsTableFilterComposer,
          $$DailyLogsTableOrderingComposer,
          $$DailyLogsTableAnnotationComposer,
          $$DailyLogsTableCreateCompanionBuilder,
          $$DailyLogsTableUpdateCompanionBuilder,
          (DailyLog, $$DailyLogsTableReferences),
          DailyLog,
          PrefetchHooks Function({bool userId})
        > {
  $$DailyLogsTableTableManager(_$AppDatabase db, $DailyLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<UuidValue> id = const Value.absent(),
                Value<PgDateTime> createdAt = const Value.absent(),
                Value<UuidValue> userId = const Value.absent(),
                Value<PgDate> date = const Value.absent(),
                Value<Object> symptoms = const Value.absent(),
                Value<String> mood = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<PgDateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyLogsCompanion(
                id: id,
                createdAt: createdAt,
                userId: userId,
                date: date,
                symptoms: symptoms,
                mood: mood,
                notes: notes,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<UuidValue> id = const Value.absent(),
                Value<PgDateTime> createdAt = const Value.absent(),
                required UuidValue userId,
                required PgDate date,
                required Object symptoms,
                required String mood,
                required String notes,
                Value<PgDateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyLogsCompanion.insert(
                id: id,
                createdAt: createdAt,
                userId: userId,
                date: date,
                symptoms: symptoms,
                mood: mood,
                notes: notes,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DailyLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userId,
                                referencedTable: $$DailyLogsTableReferences
                                    ._userIdTable(db),
                                referencedColumn: $$DailyLogsTableReferences
                                    ._userIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DailyLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyLogsTable,
      DailyLog,
      $$DailyLogsTableFilterComposer,
      $$DailyLogsTableOrderingComposer,
      $$DailyLogsTableAnnotationComposer,
      $$DailyLogsTableCreateCompanionBuilder,
      $$DailyLogsTableUpdateCompanionBuilder,
      (DailyLog, $$DailyLogsTableReferences),
      DailyLog,
      PrefetchHooks Function({bool userId})
    >;
typedef $$PartnerConnectionsTableCreateCompanionBuilder =
    PartnerConnectionsCompanion Function({
      Value<UuidValue> id,
      Value<PgDateTime> createdAt,
      required UuidValue userId,
      required UuidValue partnerId,
      Value<String?> inviteCode,
      required PartnerStatus status,
      Value<int> rowid,
    });
typedef $$PartnerConnectionsTableUpdateCompanionBuilder =
    PartnerConnectionsCompanion Function({
      Value<UuidValue> id,
      Value<PgDateTime> createdAt,
      Value<UuidValue> userId,
      Value<UuidValue> partnerId,
      Value<String?> inviteCode,
      Value<PartnerStatus> status,
      Value<int> rowid,
    });

final class $$PartnerConnectionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PartnerConnectionsTable,
          PartnerConnection
        > {
  $$PartnerConnectionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProfileTable _userIdTable(_$AppDatabase db) => db.profile.createAlias(
    $_aliasNameGenerator(db.partnerConnections.userId, db.profile.id),
  );

  $$ProfileTableProcessedTableManager get userId {
    final $_column = $_itemColumn<UuidValue>('user_id')!;

    final manager = $$ProfileTableTableManager(
      $_db,
      $_db.profile,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProfileTable _partnerIdTable(_$AppDatabase db) =>
      db.profile.createAlias(
        $_aliasNameGenerator(db.partnerConnections.partnerId, db.profile.id),
      );

  $$ProfileTableProcessedTableManager get partnerId {
    final $_column = $_itemColumn<UuidValue>('partner_id')!;

    final manager = $$ProfileTableTableManager(
      $_db,
      $_db.profile,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_partnerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PartnerConnectionsTableFilterComposer
    extends Composer<_$AppDatabase, $PartnerConnectionsTable> {
  $$PartnerConnectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<UuidValue> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get inviteCode => $composableBuilder(
    column: $table.inviteCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PartnerStatus, PartnerStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$ProfileTableFilterComposer get userId {
    final $$ProfileTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.profile,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfileTableFilterComposer(
            $db: $db,
            $table: $db.profile,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProfileTableFilterComposer get partnerId {
    final $$ProfileTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partnerId,
      referencedTable: $db.profile,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfileTableFilterComposer(
            $db: $db,
            $table: $db.profile,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PartnerConnectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $PartnerConnectionsTable> {
  $$PartnerConnectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<UuidValue> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inviteCode => $composableBuilder(
    column: $table.inviteCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfileTableOrderingComposer get userId {
    final $$ProfileTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.profile,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfileTableOrderingComposer(
            $db: $db,
            $table: $db.profile,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProfileTableOrderingComposer get partnerId {
    final $$ProfileTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partnerId,
      referencedTable: $db.profile,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfileTableOrderingComposer(
            $db: $db,
            $table: $db.profile,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PartnerConnectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PartnerConnectionsTable> {
  $$PartnerConnectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<UuidValue> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<PgDateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get inviteCode => $composableBuilder(
    column: $table.inviteCode,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<PartnerStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$ProfileTableAnnotationComposer get userId {
    final $$ProfileTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.profile,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfileTableAnnotationComposer(
            $db: $db,
            $table: $db.profile,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProfileTableAnnotationComposer get partnerId {
    final $$ProfileTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partnerId,
      referencedTable: $db.profile,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfileTableAnnotationComposer(
            $db: $db,
            $table: $db.profile,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PartnerConnectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PartnerConnectionsTable,
          PartnerConnection,
          $$PartnerConnectionsTableFilterComposer,
          $$PartnerConnectionsTableOrderingComposer,
          $$PartnerConnectionsTableAnnotationComposer,
          $$PartnerConnectionsTableCreateCompanionBuilder,
          $$PartnerConnectionsTableUpdateCompanionBuilder,
          (PartnerConnection, $$PartnerConnectionsTableReferences),
          PartnerConnection,
          PrefetchHooks Function({bool userId, bool partnerId})
        > {
  $$PartnerConnectionsTableTableManager(
    _$AppDatabase db,
    $PartnerConnectionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PartnerConnectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PartnerConnectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PartnerConnectionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<UuidValue> id = const Value.absent(),
                Value<PgDateTime> createdAt = const Value.absent(),
                Value<UuidValue> userId = const Value.absent(),
                Value<UuidValue> partnerId = const Value.absent(),
                Value<String?> inviteCode = const Value.absent(),
                Value<PartnerStatus> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PartnerConnectionsCompanion(
                id: id,
                createdAt: createdAt,
                userId: userId,
                partnerId: partnerId,
                inviteCode: inviteCode,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<UuidValue> id = const Value.absent(),
                Value<PgDateTime> createdAt = const Value.absent(),
                required UuidValue userId,
                required UuidValue partnerId,
                Value<String?> inviteCode = const Value.absent(),
                required PartnerStatus status,
                Value<int> rowid = const Value.absent(),
              }) => PartnerConnectionsCompanion.insert(
                id: id,
                createdAt: createdAt,
                userId: userId,
                partnerId: partnerId,
                inviteCode: inviteCode,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PartnerConnectionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false, partnerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userId,
                                referencedTable:
                                    $$PartnerConnectionsTableReferences
                                        ._userIdTable(db),
                                referencedColumn:
                                    $$PartnerConnectionsTableReferences
                                        ._userIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (partnerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.partnerId,
                                referencedTable:
                                    $$PartnerConnectionsTableReferences
                                        ._partnerIdTable(db),
                                referencedColumn:
                                    $$PartnerConnectionsTableReferences
                                        ._partnerIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PartnerConnectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PartnerConnectionsTable,
      PartnerConnection,
      $$PartnerConnectionsTableFilterComposer,
      $$PartnerConnectionsTableOrderingComposer,
      $$PartnerConnectionsTableAnnotationComposer,
      $$PartnerConnectionsTableCreateCompanionBuilder,
      $$PartnerConnectionsTableUpdateCompanionBuilder,
      (PartnerConnection, $$PartnerConnectionsTableReferences),
      PartnerConnection,
      PrefetchHooks Function({bool userId, bool partnerId})
    >;
typedef $$ProfileDetailsTableCreateCompanionBuilder =
    ProfileDetailsCompanion Function({
      Value<UuidValue> id,
      Value<PgDateTime> createdAt,
      Value<PgDate?> birthDate,
      Value<int?> weight,
      Value<int?> height,
      Value<int?> cycleAvgLength,
      Value<int?> periodAvgLength,
      Value<PgDate?> lastPeriodDateStart,
      Value<PgDate?> lastPeriodDateEnd,
      Value<PgDateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$ProfileDetailsTableUpdateCompanionBuilder =
    ProfileDetailsCompanion Function({
      Value<UuidValue> id,
      Value<PgDateTime> createdAt,
      Value<PgDate?> birthDate,
      Value<int?> weight,
      Value<int?> height,
      Value<int?> cycleAvgLength,
      Value<int?> periodAvgLength,
      Value<PgDate?> lastPeriodDateStart,
      Value<PgDate?> lastPeriodDateEnd,
      Value<PgDateTime> updatedAt,
      Value<int> rowid,
    });

class $$ProfileDetailsTableFilterComposer
    extends Composer<_$AppDatabase, $ProfileDetailsTable> {
  $$ProfileDetailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<UuidValue> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDate> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cycleAvgLength => $composableBuilder(
    column: $table.cycleAvgLength,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get periodAvgLength => $composableBuilder(
    column: $table.periodAvgLength,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDate> get lastPeriodDateStart => $composableBuilder(
    column: $table.lastPeriodDateStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDate> get lastPeriodDateEnd => $composableBuilder(
    column: $table.lastPeriodDateEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProfileDetailsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfileDetailsTable> {
  $$ProfileDetailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<UuidValue> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDate> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cycleAvgLength => $composableBuilder(
    column: $table.cycleAvgLength,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get periodAvgLength => $composableBuilder(
    column: $table.periodAvgLength,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDate> get lastPeriodDateStart => $composableBuilder(
    column: $table.lastPeriodDateStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDate> get lastPeriodDateEnd => $composableBuilder(
    column: $table.lastPeriodDateEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfileDetailsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfileDetailsTable> {
  $$ProfileDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<UuidValue> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<PgDateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<PgDate> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<int> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<int> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<int> get cycleAvgLength => $composableBuilder(
    column: $table.cycleAvgLength,
    builder: (column) => column,
  );

  GeneratedColumn<int> get periodAvgLength => $composableBuilder(
    column: $table.periodAvgLength,
    builder: (column) => column,
  );

  GeneratedColumn<PgDate> get lastPeriodDateStart => $composableBuilder(
    column: $table.lastPeriodDateStart,
    builder: (column) => column,
  );

  GeneratedColumn<PgDate> get lastPeriodDateEnd => $composableBuilder(
    column: $table.lastPeriodDateEnd,
    builder: (column) => column,
  );

  GeneratedColumn<PgDateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ProfileDetailsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfileDetailsTable,
          ProfileDetail,
          $$ProfileDetailsTableFilterComposer,
          $$ProfileDetailsTableOrderingComposer,
          $$ProfileDetailsTableAnnotationComposer,
          $$ProfileDetailsTableCreateCompanionBuilder,
          $$ProfileDetailsTableUpdateCompanionBuilder,
          (
            ProfileDetail,
            BaseReferences<_$AppDatabase, $ProfileDetailsTable, ProfileDetail>,
          ),
          ProfileDetail,
          PrefetchHooks Function()
        > {
  $$ProfileDetailsTableTableManager(
    _$AppDatabase db,
    $ProfileDetailsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfileDetailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfileDetailsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfileDetailsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<UuidValue> id = const Value.absent(),
                Value<PgDateTime> createdAt = const Value.absent(),
                Value<PgDate?> birthDate = const Value.absent(),
                Value<int?> weight = const Value.absent(),
                Value<int?> height = const Value.absent(),
                Value<int?> cycleAvgLength = const Value.absent(),
                Value<int?> periodAvgLength = const Value.absent(),
                Value<PgDate?> lastPeriodDateStart = const Value.absent(),
                Value<PgDate?> lastPeriodDateEnd = const Value.absent(),
                Value<PgDateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfileDetailsCompanion(
                id: id,
                createdAt: createdAt,
                birthDate: birthDate,
                weight: weight,
                height: height,
                cycleAvgLength: cycleAvgLength,
                periodAvgLength: periodAvgLength,
                lastPeriodDateStart: lastPeriodDateStart,
                lastPeriodDateEnd: lastPeriodDateEnd,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<UuidValue> id = const Value.absent(),
                Value<PgDateTime> createdAt = const Value.absent(),
                Value<PgDate?> birthDate = const Value.absent(),
                Value<int?> weight = const Value.absent(),
                Value<int?> height = const Value.absent(),
                Value<int?> cycleAvgLength = const Value.absent(),
                Value<int?> periodAvgLength = const Value.absent(),
                Value<PgDate?> lastPeriodDateStart = const Value.absent(),
                Value<PgDate?> lastPeriodDateEnd = const Value.absent(),
                Value<PgDateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfileDetailsCompanion.insert(
                id: id,
                createdAt: createdAt,
                birthDate: birthDate,
                weight: weight,
                height: height,
                cycleAvgLength: cycleAvgLength,
                periodAvgLength: periodAvgLength,
                lastPeriodDateStart: lastPeriodDateStart,
                lastPeriodDateEnd: lastPeriodDateEnd,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProfileDetailsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfileDetailsTable,
      ProfileDetail,
      $$ProfileDetailsTableFilterComposer,
      $$ProfileDetailsTableOrderingComposer,
      $$ProfileDetailsTableAnnotationComposer,
      $$ProfileDetailsTableCreateCompanionBuilder,
      $$ProfileDetailsTableUpdateCompanionBuilder,
      (
        ProfileDetail,
        BaseReferences<_$AppDatabase, $ProfileDetailsTable, ProfileDetail>,
      ),
      ProfileDetail,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProfileTableTableManager get profile =>
      $$ProfileTableTableManager(_db, _db.profile);
  $$CyclesTableTableManager get cycles =>
      $$CyclesTableTableManager(_db, _db.cycles);
  $$DailyLogsTableTableManager get dailyLogs =>
      $$DailyLogsTableTableManager(_db, _db.dailyLogs);
  $$PartnerConnectionsTableTableManager get partnerConnections =>
      $$PartnerConnectionsTableTableManager(_db, _db.partnerConnections);
  $$ProfileDetailsTableTableManager get profileDetails =>
      $$ProfileDetailsTableTableManager(_db, _db.profileDetails);
}
