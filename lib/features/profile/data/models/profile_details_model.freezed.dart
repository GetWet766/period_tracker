// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_details_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileDetailsModel {

 String get id;@JsonKey(name: 'birth_date') DateTime get birthDate; int get weight; int get height;@JsonKey(name: 'cycle_avg_length') int get cycleAvgLength;@JsonKey(name: 'period_avg_length') int get periodAvgLength;@JsonKey(name: 'last_period_date_start') DateTime get lastPeriodDateStart;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;@JsonKey(name: 'last_period_date_end') DateTime? get lastPeriodDateEnd;
/// Create a copy of ProfileDetailsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileDetailsModelCopyWith<ProfileDetailsModel> get copyWith => _$ProfileDetailsModelCopyWithImpl<ProfileDetailsModel>(this as ProfileDetailsModel, _$identity);

  /// Serializes this ProfileDetailsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileDetailsModel&&(identical(other.id, id) || other.id == id)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.height, height) || other.height == height)&&(identical(other.cycleAvgLength, cycleAvgLength) || other.cycleAvgLength == cycleAvgLength)&&(identical(other.periodAvgLength, periodAvgLength) || other.periodAvgLength == periodAvgLength)&&(identical(other.lastPeriodDateStart, lastPeriodDateStart) || other.lastPeriodDateStart == lastPeriodDateStart)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastPeriodDateEnd, lastPeriodDateEnd) || other.lastPeriodDateEnd == lastPeriodDateEnd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,birthDate,weight,height,cycleAvgLength,periodAvgLength,lastPeriodDateStart,createdAt,updatedAt,lastPeriodDateEnd);

@override
String toString() {
  return 'ProfileDetailsModel(id: $id, birthDate: $birthDate, weight: $weight, height: $height, cycleAvgLength: $cycleAvgLength, periodAvgLength: $periodAvgLength, lastPeriodDateStart: $lastPeriodDateStart, createdAt: $createdAt, updatedAt: $updatedAt, lastPeriodDateEnd: $lastPeriodDateEnd)';
}


}

/// @nodoc
abstract mixin class $ProfileDetailsModelCopyWith<$Res>  {
  factory $ProfileDetailsModelCopyWith(ProfileDetailsModel value, $Res Function(ProfileDetailsModel) _then) = _$ProfileDetailsModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'birth_date') DateTime birthDate, int weight, int height,@JsonKey(name: 'cycle_avg_length') int cycleAvgLength,@JsonKey(name: 'period_avg_length') int periodAvgLength,@JsonKey(name: 'last_period_date_start') DateTime lastPeriodDateStart,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt,@JsonKey(name: 'last_period_date_end') DateTime? lastPeriodDateEnd
});




}
/// @nodoc
class _$ProfileDetailsModelCopyWithImpl<$Res>
    implements $ProfileDetailsModelCopyWith<$Res> {
  _$ProfileDetailsModelCopyWithImpl(this._self, this._then);

  final ProfileDetailsModel _self;
  final $Res Function(ProfileDetailsModel) _then;

/// Create a copy of ProfileDetailsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? birthDate = null,Object? weight = null,Object? height = null,Object? cycleAvgLength = null,Object? periodAvgLength = null,Object? lastPeriodDateStart = null,Object? createdAt = null,Object? updatedAt = null,Object? lastPeriodDateEnd = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,birthDate: null == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,cycleAvgLength: null == cycleAvgLength ? _self.cycleAvgLength : cycleAvgLength // ignore: cast_nullable_to_non_nullable
as int,periodAvgLength: null == periodAvgLength ? _self.periodAvgLength : periodAvgLength // ignore: cast_nullable_to_non_nullable
as int,lastPeriodDateStart: null == lastPeriodDateStart ? _self.lastPeriodDateStart : lastPeriodDateStart // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastPeriodDateEnd: freezed == lastPeriodDateEnd ? _self.lastPeriodDateEnd : lastPeriodDateEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileDetailsModel].
extension ProfileDetailsModelPatterns on ProfileDetailsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileDetailsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileDetailsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileDetailsModel value)  $default,){
final _that = this;
switch (_that) {
case _ProfileDetailsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileDetailsModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileDetailsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'birth_date')  DateTime birthDate,  int weight,  int height, @JsonKey(name: 'cycle_avg_length')  int cycleAvgLength, @JsonKey(name: 'period_avg_length')  int periodAvgLength, @JsonKey(name: 'last_period_date_start')  DateTime lastPeriodDateStart, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(name: 'last_period_date_end')  DateTime? lastPeriodDateEnd)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileDetailsModel() when $default != null:
return $default(_that.id,_that.birthDate,_that.weight,_that.height,_that.cycleAvgLength,_that.periodAvgLength,_that.lastPeriodDateStart,_that.createdAt,_that.updatedAt,_that.lastPeriodDateEnd);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'birth_date')  DateTime birthDate,  int weight,  int height, @JsonKey(name: 'cycle_avg_length')  int cycleAvgLength, @JsonKey(name: 'period_avg_length')  int periodAvgLength, @JsonKey(name: 'last_period_date_start')  DateTime lastPeriodDateStart, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(name: 'last_period_date_end')  DateTime? lastPeriodDateEnd)  $default,) {final _that = this;
switch (_that) {
case _ProfileDetailsModel():
return $default(_that.id,_that.birthDate,_that.weight,_that.height,_that.cycleAvgLength,_that.periodAvgLength,_that.lastPeriodDateStart,_that.createdAt,_that.updatedAt,_that.lastPeriodDateEnd);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'birth_date')  DateTime birthDate,  int weight,  int height, @JsonKey(name: 'cycle_avg_length')  int cycleAvgLength, @JsonKey(name: 'period_avg_length')  int periodAvgLength, @JsonKey(name: 'last_period_date_start')  DateTime lastPeriodDateStart, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(name: 'last_period_date_end')  DateTime? lastPeriodDateEnd)?  $default,) {final _that = this;
switch (_that) {
case _ProfileDetailsModel() when $default != null:
return $default(_that.id,_that.birthDate,_that.weight,_that.height,_that.cycleAvgLength,_that.periodAvgLength,_that.lastPeriodDateStart,_that.createdAt,_that.updatedAt,_that.lastPeriodDateEnd);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileDetailsModel extends ProfileDetailsModel {
  const _ProfileDetailsModel({required this.id, @JsonKey(name: 'birth_date') required this.birthDate, required this.weight, required this.height, @JsonKey(name: 'cycle_avg_length') required this.cycleAvgLength, @JsonKey(name: 'period_avg_length') required this.periodAvgLength, @JsonKey(name: 'last_period_date_start') required this.lastPeriodDateStart, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt, @JsonKey(name: 'last_period_date_end') this.lastPeriodDateEnd}): super._();
  factory _ProfileDetailsModel.fromJson(Map<String, dynamic> json) => _$ProfileDetailsModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'birth_date') final  DateTime birthDate;
@override final  int weight;
@override final  int height;
@override@JsonKey(name: 'cycle_avg_length') final  int cycleAvgLength;
@override@JsonKey(name: 'period_avg_length') final  int periodAvgLength;
@override@JsonKey(name: 'last_period_date_start') final  DateTime lastPeriodDateStart;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;
@override@JsonKey(name: 'last_period_date_end') final  DateTime? lastPeriodDateEnd;

/// Create a copy of ProfileDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileDetailsModelCopyWith<_ProfileDetailsModel> get copyWith => __$ProfileDetailsModelCopyWithImpl<_ProfileDetailsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileDetailsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileDetailsModel&&(identical(other.id, id) || other.id == id)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.height, height) || other.height == height)&&(identical(other.cycleAvgLength, cycleAvgLength) || other.cycleAvgLength == cycleAvgLength)&&(identical(other.periodAvgLength, periodAvgLength) || other.periodAvgLength == periodAvgLength)&&(identical(other.lastPeriodDateStart, lastPeriodDateStart) || other.lastPeriodDateStart == lastPeriodDateStart)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastPeriodDateEnd, lastPeriodDateEnd) || other.lastPeriodDateEnd == lastPeriodDateEnd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,birthDate,weight,height,cycleAvgLength,periodAvgLength,lastPeriodDateStart,createdAt,updatedAt,lastPeriodDateEnd);

@override
String toString() {
  return 'ProfileDetailsModel(id: $id, birthDate: $birthDate, weight: $weight, height: $height, cycleAvgLength: $cycleAvgLength, periodAvgLength: $periodAvgLength, lastPeriodDateStart: $lastPeriodDateStart, createdAt: $createdAt, updatedAt: $updatedAt, lastPeriodDateEnd: $lastPeriodDateEnd)';
}


}

/// @nodoc
abstract mixin class _$ProfileDetailsModelCopyWith<$Res> implements $ProfileDetailsModelCopyWith<$Res> {
  factory _$ProfileDetailsModelCopyWith(_ProfileDetailsModel value, $Res Function(_ProfileDetailsModel) _then) = __$ProfileDetailsModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'birth_date') DateTime birthDate, int weight, int height,@JsonKey(name: 'cycle_avg_length') int cycleAvgLength,@JsonKey(name: 'period_avg_length') int periodAvgLength,@JsonKey(name: 'last_period_date_start') DateTime lastPeriodDateStart,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt,@JsonKey(name: 'last_period_date_end') DateTime? lastPeriodDateEnd
});




}
/// @nodoc
class __$ProfileDetailsModelCopyWithImpl<$Res>
    implements _$ProfileDetailsModelCopyWith<$Res> {
  __$ProfileDetailsModelCopyWithImpl(this._self, this._then);

  final _ProfileDetailsModel _self;
  final $Res Function(_ProfileDetailsModel) _then;

/// Create a copy of ProfileDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? birthDate = null,Object? weight = null,Object? height = null,Object? cycleAvgLength = null,Object? periodAvgLength = null,Object? lastPeriodDateStart = null,Object? createdAt = null,Object? updatedAt = null,Object? lastPeriodDateEnd = freezed,}) {
  return _then(_ProfileDetailsModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,birthDate: null == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,cycleAvgLength: null == cycleAvgLength ? _self.cycleAvgLength : cycleAvgLength // ignore: cast_nullable_to_non_nullable
as int,periodAvgLength: null == periodAvgLength ? _self.periodAvgLength : periodAvgLength // ignore: cast_nullable_to_non_nullable
as int,lastPeriodDateStart: null == lastPeriodDateStart ? _self.lastPeriodDateStart : lastPeriodDateStart // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastPeriodDateEnd: freezed == lastPeriodDateEnd ? _self.lastPeriodDateEnd : lastPeriodDateEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
