// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cycle_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CycleLogModel {

 String get id;@JsonKey(name: 'user_id') String get userId; DateTime get date;@JsonKey(name: 'flow_level') String? get flowLevel; List<String>? get symptoms; String? get notes;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of CycleLogModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CycleLogModelCopyWith<CycleLogModel> get copyWith => _$CycleLogModelCopyWithImpl<CycleLogModel>(this as CycleLogModel, _$identity);

  /// Serializes this CycleLogModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CycleLogModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.date, date) || other.date == date)&&(identical(other.flowLevel, flowLevel) || other.flowLevel == flowLevel)&&const DeepCollectionEquality().equals(other.symptoms, symptoms)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,date,flowLevel,const DeepCollectionEquality().hash(symptoms),notes,createdAt);

@override
String toString() {
  return 'CycleLogModel(id: $id, userId: $userId, date: $date, flowLevel: $flowLevel, symptoms: $symptoms, notes: $notes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $CycleLogModelCopyWith<$Res>  {
  factory $CycleLogModelCopyWith(CycleLogModel value, $Res Function(CycleLogModel) _then) = _$CycleLogModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, DateTime date,@JsonKey(name: 'flow_level') String? flowLevel, List<String>? symptoms, String? notes,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$CycleLogModelCopyWithImpl<$Res>
    implements $CycleLogModelCopyWith<$Res> {
  _$CycleLogModelCopyWithImpl(this._self, this._then);

  final CycleLogModel _self;
  final $Res Function(CycleLogModel) _then;

/// Create a copy of CycleLogModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? date = null,Object? flowLevel = freezed,Object? symptoms = freezed,Object? notes = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,flowLevel: freezed == flowLevel ? _self.flowLevel : flowLevel // ignore: cast_nullable_to_non_nullable
as String?,symptoms: freezed == symptoms ? _self.symptoms : symptoms // ignore: cast_nullable_to_non_nullable
as List<String>?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CycleLogModel].
extension CycleLogModelPatterns on CycleLogModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CycleLogModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CycleLogModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CycleLogModel value)  $default,){
final _that = this;
switch (_that) {
case _CycleLogModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CycleLogModel value)?  $default,){
final _that = this;
switch (_that) {
case _CycleLogModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  DateTime date, @JsonKey(name: 'flow_level')  String? flowLevel,  List<String>? symptoms,  String? notes, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CycleLogModel() when $default != null:
return $default(_that.id,_that.userId,_that.date,_that.flowLevel,_that.symptoms,_that.notes,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  DateTime date, @JsonKey(name: 'flow_level')  String? flowLevel,  List<String>? symptoms,  String? notes, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _CycleLogModel():
return $default(_that.id,_that.userId,_that.date,_that.flowLevel,_that.symptoms,_that.notes,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId,  DateTime date, @JsonKey(name: 'flow_level')  String? flowLevel,  List<String>? symptoms,  String? notes, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _CycleLogModel() when $default != null:
return $default(_that.id,_that.userId,_that.date,_that.flowLevel,_that.symptoms,_that.notes,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CycleLogModel extends CycleLogModel {
  const _CycleLogModel({required this.id, @JsonKey(name: 'user_id') required this.userId, required this.date, @JsonKey(name: 'flow_level') this.flowLevel, final  List<String>? symptoms, this.notes, @JsonKey(name: 'created_at') required this.createdAt}): _symptoms = symptoms,super._();
  factory _CycleLogModel.fromJson(Map<String, dynamic> json) => _$CycleLogModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override final  DateTime date;
@override@JsonKey(name: 'flow_level') final  String? flowLevel;
 final  List<String>? _symptoms;
@override List<String>? get symptoms {
  final value = _symptoms;
  if (value == null) return null;
  if (_symptoms is EqualUnmodifiableListView) return _symptoms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? notes;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of CycleLogModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CycleLogModelCopyWith<_CycleLogModel> get copyWith => __$CycleLogModelCopyWithImpl<_CycleLogModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CycleLogModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CycleLogModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.date, date) || other.date == date)&&(identical(other.flowLevel, flowLevel) || other.flowLevel == flowLevel)&&const DeepCollectionEquality().equals(other._symptoms, _symptoms)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,date,flowLevel,const DeepCollectionEquality().hash(_symptoms),notes,createdAt);

@override
String toString() {
  return 'CycleLogModel(id: $id, userId: $userId, date: $date, flowLevel: $flowLevel, symptoms: $symptoms, notes: $notes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CycleLogModelCopyWith<$Res> implements $CycleLogModelCopyWith<$Res> {
  factory _$CycleLogModelCopyWith(_CycleLogModel value, $Res Function(_CycleLogModel) _then) = __$CycleLogModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, DateTime date,@JsonKey(name: 'flow_level') String? flowLevel, List<String>? symptoms, String? notes,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$CycleLogModelCopyWithImpl<$Res>
    implements _$CycleLogModelCopyWith<$Res> {
  __$CycleLogModelCopyWithImpl(this._self, this._then);

  final _CycleLogModel _self;
  final $Res Function(_CycleLogModel) _then;

/// Create a copy of CycleLogModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? date = null,Object? flowLevel = freezed,Object? symptoms = freezed,Object? notes = freezed,Object? createdAt = null,}) {
  return _then(_CycleLogModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,flowLevel: freezed == flowLevel ? _self.flowLevel : flowLevel // ignore: cast_nullable_to_non_nullable
as String?,symptoms: freezed == symptoms ? _self._symptoms : symptoms // ignore: cast_nullable_to_non_nullable
as List<String>?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
