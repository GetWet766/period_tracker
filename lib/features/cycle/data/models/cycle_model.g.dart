// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cycle_model.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetCycleModelCollection on Isar {
  IsarCollection<int, CycleModel> get cycleModels => this.collection();
}

final CycleModelSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'CycleModel',
    idName: 'isarId',
    embedded: false,
    properties: [
      IsarPropertySchema(name: 'id', type: IsarType.string),
      IsarPropertySchema(name: 'userId', type: IsarType.string),
      IsarPropertySchema(name: 'startDate', type: IsarType.dateTime),
      IsarPropertySchema(name: 'endDate', type: IsarType.dateTime),
      IsarPropertySchema(name: 'createdAt', type: IsarType.dateTime),
      IsarPropertySchema(name: 'isManuallyStarted', type: IsarType.bool),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<int, CycleModel>(
    serialize: serializeCycleModel,
    deserialize: deserializeCycleModel,
    deserializeProperty: deserializeCycleModelProp,
  ),
  getEmbeddedSchemas: () => [],
);

@isarProtected
int serializeCycleModel(IsarWriter writer, CycleModel object) {
  IsarCore.writeString(writer, 1, object.id);
  {
    final value = object.userId;
    if (value == null) {
      IsarCore.writeNull(writer, 2);
    } else {
      IsarCore.writeString(writer, 2, value);
    }
  }
  IsarCore.writeLong(
    writer,
    3,
    object.startDate.toUtc().microsecondsSinceEpoch,
  );
  IsarCore.writeLong(
    writer,
    4,
    object.endDate?.toUtc().microsecondsSinceEpoch ?? -9223372036854775808,
  );
  IsarCore.writeLong(
    writer,
    5,
    object.createdAt?.toUtc().microsecondsSinceEpoch ?? -9223372036854775808,
  );
  IsarCore.writeBool(writer, 6, value: object.isManuallyStarted);
  return object.isarId;
}

@isarProtected
CycleModel deserializeCycleModel(IsarReader reader) {
  final String _id;
  _id = IsarCore.readString(reader, 1) ?? '';
  final String? _userId;
  _userId = IsarCore.readString(reader, 2);
  final DateTime _startDate;
  {
    final value = IsarCore.readLong(reader, 3);
    if (value == -9223372036854775808) {
      _startDate = DateTime.fromMillisecondsSinceEpoch(
        0,
        isUtc: true,
      ).toLocal();
    } else {
      _startDate = DateTime.fromMicrosecondsSinceEpoch(
        value,
        isUtc: true,
      ).toLocal();
    }
  }
  final DateTime? _endDate;
  {
    final value = IsarCore.readLong(reader, 4);
    if (value == -9223372036854775808) {
      _endDate = null;
    } else {
      _endDate = DateTime.fromMicrosecondsSinceEpoch(
        value,
        isUtc: true,
      ).toLocal();
    }
  }
  final DateTime? _createdAt;
  {
    final value = IsarCore.readLong(reader, 5);
    if (value == -9223372036854775808) {
      _createdAt = null;
    } else {
      _createdAt = DateTime.fromMicrosecondsSinceEpoch(
        value,
        isUtc: true,
      ).toLocal();
    }
  }
  final bool _isManuallyStarted;
  _isManuallyStarted = IsarCore.readBool(reader, 6);
  final object = CycleModel(
    id: _id,
    userId: _userId,
    startDate: _startDate,
    endDate: _endDate,
    createdAt: _createdAt,
    isManuallyStarted: _isManuallyStarted,
  );
  return object;
}

@isarProtected
dynamic deserializeCycleModelProp(IsarReader reader, int property) {
  switch (property) {
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2);
    case 3:
      {
        final value = IsarCore.readLong(reader, 3);
        if (value == -9223372036854775808) {
          return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
        }
      }
    case 4:
      {
        final value = IsarCore.readLong(reader, 4);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
        }
      }
    case 5:
      {
        final value = IsarCore.readLong(reader, 5);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
        }
      }
    case 6:
      return IsarCore.readBool(reader, 6);
    case 0:
      return IsarCore.readId(reader);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _CycleModelUpdate {
  bool call({
    required int isarId,
    String? id,
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? createdAt,
    bool? isManuallyStarted,
  });
}

class _CycleModelUpdateImpl implements _CycleModelUpdate {
  const _CycleModelUpdateImpl(this.collection);

  final IsarCollection<int, CycleModel> collection;

  @override
  bool call({
    required int isarId,
    Object? id = ignore,
    Object? userId = ignore,
    Object? startDate = ignore,
    Object? endDate = ignore,
    Object? createdAt = ignore,
    Object? isManuallyStarted = ignore,
  }) {
    return collection.updateProperties(
          [isarId],
          {
            if (id != ignore) 1: id as String?,
            if (userId != ignore) 2: userId as String?,
            if (startDate != ignore) 3: startDate as DateTime?,
            if (endDate != ignore) 4: endDate as DateTime?,
            if (createdAt != ignore) 5: createdAt as DateTime?,
            if (isManuallyStarted != ignore) 6: isManuallyStarted as bool?,
          },
        ) >
        0;
  }
}

sealed class _CycleModelUpdateAll {
  int call({
    required List<int> isarId,
    String? id,
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? createdAt,
    bool? isManuallyStarted,
  });
}

class _CycleModelUpdateAllImpl implements _CycleModelUpdateAll {
  const _CycleModelUpdateAllImpl(this.collection);

  final IsarCollection<int, CycleModel> collection;

  @override
  int call({
    required List<int> isarId,
    Object? id = ignore,
    Object? userId = ignore,
    Object? startDate = ignore,
    Object? endDate = ignore,
    Object? createdAt = ignore,
    Object? isManuallyStarted = ignore,
  }) {
    return collection.updateProperties(isarId, {
      if (id != ignore) 1: id as String?,
      if (userId != ignore) 2: userId as String?,
      if (startDate != ignore) 3: startDate as DateTime?,
      if (endDate != ignore) 4: endDate as DateTime?,
      if (createdAt != ignore) 5: createdAt as DateTime?,
      if (isManuallyStarted != ignore) 6: isManuallyStarted as bool?,
    });
  }
}

extension CycleModelUpdate on IsarCollection<int, CycleModel> {
  _CycleModelUpdate get update => _CycleModelUpdateImpl(this);

  _CycleModelUpdateAll get updateAll => _CycleModelUpdateAllImpl(this);
}

sealed class _CycleModelQueryUpdate {
  int call({
    String? id,
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? createdAt,
    bool? isManuallyStarted,
  });
}

class _CycleModelQueryUpdateImpl implements _CycleModelQueryUpdate {
  const _CycleModelQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<CycleModel> query;
  final int? limit;

  @override
  int call({
    Object? id = ignore,
    Object? userId = ignore,
    Object? startDate = ignore,
    Object? endDate = ignore,
    Object? createdAt = ignore,
    Object? isManuallyStarted = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (id != ignore) 1: id as String?,
      if (userId != ignore) 2: userId as String?,
      if (startDate != ignore) 3: startDate as DateTime?,
      if (endDate != ignore) 4: endDate as DateTime?,
      if (createdAt != ignore) 5: createdAt as DateTime?,
      if (isManuallyStarted != ignore) 6: isManuallyStarted as bool?,
    });
  }
}

extension CycleModelQueryUpdate on IsarQuery<CycleModel> {
  _CycleModelQueryUpdate get updateFirst =>
      _CycleModelQueryUpdateImpl(this, limit: 1);

  _CycleModelQueryUpdate get updateAll => _CycleModelQueryUpdateImpl(this);
}

class _CycleModelQueryBuilderUpdateImpl implements _CycleModelQueryUpdate {
  const _CycleModelQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<CycleModel, CycleModel, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? id = ignore,
    Object? userId = ignore,
    Object? startDate = ignore,
    Object? endDate = ignore,
    Object? createdAt = ignore,
    Object? isManuallyStarted = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (id != ignore) 1: id as String?,
        if (userId != ignore) 2: userId as String?,
        if (startDate != ignore) 3: startDate as DateTime?,
        if (endDate != ignore) 4: endDate as DateTime?,
        if (createdAt != ignore) 5: createdAt as DateTime?,
        if (isManuallyStarted != ignore) 6: isManuallyStarted as bool?,
      });
    } finally {
      q.close();
    }
  }
}

extension CycleModelQueryBuilderUpdate
    on QueryBuilder<CycleModel, CycleModel, QOperations> {
  _CycleModelQueryUpdate get updateFirst =>
      _CycleModelQueryBuilderUpdateImpl(this, limit: 1);

  _CycleModelQueryUpdate get updateAll =>
      _CycleModelQueryBuilderUpdateImpl(this);
}

extension CycleModelQueryFilter
    on QueryBuilder<CycleModel, CycleModel, QFilterCondition> {
  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition>
  idGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> idLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition>
  idLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> idContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> idMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 1,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition>
  userIdIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> userIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 2, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> userIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition>
  userIdGreaterThanOrEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> userIdLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 2, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition>
  userIdLessThanOrEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> userIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> userIdContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> userIdMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 2,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 2, value: ''),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition>
  userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 2, value: ''),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> startDateEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 3, value: value),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition>
  startDateGreaterThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 3, value: value),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition>
  startDateGreaterThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 3, value: value),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> startDateLessThan(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 3, value: value));
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition>
  startDateLessThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 3, value: value),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> startDateBetween(
    DateTime lower,
    DateTime upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 3, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> endDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 4));
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition>
  endDateIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 4));
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> endDateEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 4, value: value),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition>
  endDateGreaterThan(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 4, value: value),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition>
  endDateGreaterThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 4, value: value),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> endDateLessThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 4, value: value));
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition>
  endDateLessThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 4, value: value),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> endDateBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 4, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition>
  createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 5));
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition>
  createdAtIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 5));
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> createdAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 5, value: value),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition>
  createdAtGreaterThan(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 5, value: value),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition>
  createdAtGreaterThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 5, value: value),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> createdAtLessThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 5, value: value));
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition>
  createdAtLessThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 5, value: value),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> createdAtBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 5, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition>
  isManuallyStartedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> isarIdEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> isarIdGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition>
  isarIdGreaterThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> isarIdLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 0, value: value));
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition>
  isarIdLessThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterFilterCondition> isarIdBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 0, lower: lower, upper: upper),
      );
    });
  }
}

extension CycleModelQueryObject
    on QueryBuilder<CycleModel, CycleModel, QFilterCondition> {}

extension CycleModelQuerySortBy
    on QueryBuilder<CycleModel, CycleModel, QSortBy> {
  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> sortById({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> sortByIdDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> sortByUserId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> sortByUserIdDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> sortByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> sortByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> sortByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> sortByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> sortByIsManuallyStarted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy>
  sortByIsManuallyStartedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> sortByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> sortByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }
}

extension CycleModelQuerySortThenBy
    on QueryBuilder<CycleModel, CycleModel, QSortThenBy> {
  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> thenById({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> thenByIdDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> thenByUserId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> thenByUserIdDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> thenByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> thenByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> thenByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> thenByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> thenByIsManuallyStarted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy>
  thenByIsManuallyStartedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }
}

extension CycleModelQueryWhereDistinct
    on QueryBuilder<CycleModel, CycleModel, QDistinct> {
  QueryBuilder<CycleModel, CycleModel, QAfterDistinct> distinctById({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterDistinct> distinctByUserId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterDistinct> distinctByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterDistinct> distinctByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5);
    });
  }

  QueryBuilder<CycleModel, CycleModel, QAfterDistinct>
  distinctByIsManuallyStarted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6);
    });
  }
}

extension CycleModelQueryProperty1
    on QueryBuilder<CycleModel, CycleModel, QProperty> {
  QueryBuilder<CycleModel, String, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<CycleModel, String?, QAfterProperty> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<CycleModel, DateTime, QAfterProperty> startDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<CycleModel, DateTime?, QAfterProperty> endDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<CycleModel, DateTime?, QAfterProperty> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<CycleModel, bool, QAfterProperty> isManuallyStartedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<CycleModel, int, QAfterProperty> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }
}

extension CycleModelQueryProperty2<R>
    on QueryBuilder<CycleModel, R, QAfterProperty> {
  QueryBuilder<CycleModel, (R, String), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<CycleModel, (R, String?), QAfterProperty> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<CycleModel, (R, DateTime), QAfterProperty> startDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<CycleModel, (R, DateTime?), QAfterProperty> endDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<CycleModel, (R, DateTime?), QAfterProperty> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<CycleModel, (R, bool), QAfterProperty>
  isManuallyStartedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<CycleModel, (R, int), QAfterProperty> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }
}

extension CycleModelQueryProperty3<R1, R2>
    on QueryBuilder<CycleModel, (R1, R2), QAfterProperty> {
  QueryBuilder<CycleModel, (R1, R2, String), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<CycleModel, (R1, R2, String?), QOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<CycleModel, (R1, R2, DateTime), QOperations>
  startDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<CycleModel, (R1, R2, DateTime?), QOperations> endDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<CycleModel, (R1, R2, DateTime?), QOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<CycleModel, (R1, R2, bool), QOperations>
  isManuallyStartedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<CycleModel, (R1, R2, int), QOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CycleModel _$CycleModelFromJson(Map<String, dynamic> json) => CycleModel(
  id: json['id'] as String,
  startDate: DateTime.parse(json['start_date'] as String),
  userId: json['user_id'] as String?,
  endDate: json['end_date'] == null
      ? null
      : DateTime.parse(json['end_date'] as String),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  isManuallyStarted: json['isManuallyStarted'] as bool? ?? false,
);

Map<String, dynamic> _$CycleModelToJson(CycleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'isManuallyStarted': instance.isManuallyStarted,
    };
