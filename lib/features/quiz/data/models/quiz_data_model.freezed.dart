// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuizDataModel {

@HiveField(0)@JsonKey(name: 'display_name') String get displayName;@HiveField(1)@JsonKey(name: 'birth_date') String get birthDate;@HiveField(2) int get weight;@HiveField(3) int get height;@HiveField(4)@JsonKey(name: 'period_avg_length') int get periodAvgLength;@HiveField(5)@JsonKey(name: 'cycle_avg_length') int get cycleAvgLength;@HiveField(6)@JsonKey(name: 'last_period') bool get lastPeriod;@HiveField(7)@JsonKey(name: 'is_completed') bool get isCompleted;
/// Create a copy of QuizDataModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizDataModelCopyWith<QuizDataModel> get copyWith => _$QuizDataModelCopyWithImpl<QuizDataModel>(this as QuizDataModel, _$identity);

  /// Serializes this QuizDataModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizDataModel&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.height, height) || other.height == height)&&(identical(other.periodAvgLength, periodAvgLength) || other.periodAvgLength == periodAvgLength)&&(identical(other.cycleAvgLength, cycleAvgLength) || other.cycleAvgLength == cycleAvgLength)&&(identical(other.lastPeriod, lastPeriod) || other.lastPeriod == lastPeriod)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayName,birthDate,weight,height,periodAvgLength,cycleAvgLength,lastPeriod,isCompleted);

@override
String toString() {
  return 'QuizDataModel(displayName: $displayName, birthDate: $birthDate, weight: $weight, height: $height, periodAvgLength: $periodAvgLength, cycleAvgLength: $cycleAvgLength, lastPeriod: $lastPeriod, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class $QuizDataModelCopyWith<$Res>  {
  factory $QuizDataModelCopyWith(QuizDataModel value, $Res Function(QuizDataModel) _then) = _$QuizDataModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0)@JsonKey(name: 'display_name') String displayName,@HiveField(1)@JsonKey(name: 'birth_date') String birthDate,@HiveField(2) int weight,@HiveField(3) int height,@HiveField(4)@JsonKey(name: 'period_avg_length') int periodAvgLength,@HiveField(5)@JsonKey(name: 'cycle_avg_length') int cycleAvgLength,@HiveField(6)@JsonKey(name: 'last_period') bool lastPeriod,@HiveField(7)@JsonKey(name: 'is_completed') bool isCompleted
});




}
/// @nodoc
class _$QuizDataModelCopyWithImpl<$Res>
    implements $QuizDataModelCopyWith<$Res> {
  _$QuizDataModelCopyWithImpl(this._self, this._then);

  final QuizDataModel _self;
  final $Res Function(QuizDataModel) _then;

/// Create a copy of QuizDataModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = null,Object? birthDate = null,Object? weight = null,Object? height = null,Object? periodAvgLength = null,Object? cycleAvgLength = null,Object? lastPeriod = null,Object? isCompleted = null,}) {
  return _then(_self.copyWith(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,birthDate: null == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as String,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,periodAvgLength: null == periodAvgLength ? _self.periodAvgLength : periodAvgLength // ignore: cast_nullable_to_non_nullable
as int,cycleAvgLength: null == cycleAvgLength ? _self.cycleAvgLength : cycleAvgLength // ignore: cast_nullable_to_non_nullable
as int,lastPeriod: null == lastPeriod ? _self.lastPeriod : lastPeriod // ignore: cast_nullable_to_non_nullable
as bool,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizDataModel].
extension QuizDataModelPatterns on QuizDataModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizDataModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizDataModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizDataModel value)  $default,){
final _that = this;
switch (_that) {
case _QuizDataModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizDataModel value)?  $default,){
final _that = this;
switch (_that) {
case _QuizDataModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)@JsonKey(name: 'display_name')  String displayName, @HiveField(1)@JsonKey(name: 'birth_date')  String birthDate, @HiveField(2)  int weight, @HiveField(3)  int height, @HiveField(4)@JsonKey(name: 'period_avg_length')  int periodAvgLength, @HiveField(5)@JsonKey(name: 'cycle_avg_length')  int cycleAvgLength, @HiveField(6)@JsonKey(name: 'last_period')  bool lastPeriod, @HiveField(7)@JsonKey(name: 'is_completed')  bool isCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizDataModel() when $default != null:
return $default(_that.displayName,_that.birthDate,_that.weight,_that.height,_that.periodAvgLength,_that.cycleAvgLength,_that.lastPeriod,_that.isCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)@JsonKey(name: 'display_name')  String displayName, @HiveField(1)@JsonKey(name: 'birth_date')  String birthDate, @HiveField(2)  int weight, @HiveField(3)  int height, @HiveField(4)@JsonKey(name: 'period_avg_length')  int periodAvgLength, @HiveField(5)@JsonKey(name: 'cycle_avg_length')  int cycleAvgLength, @HiveField(6)@JsonKey(name: 'last_period')  bool lastPeriod, @HiveField(7)@JsonKey(name: 'is_completed')  bool isCompleted)  $default,) {final _that = this;
switch (_that) {
case _QuizDataModel():
return $default(_that.displayName,_that.birthDate,_that.weight,_that.height,_that.periodAvgLength,_that.cycleAvgLength,_that.lastPeriod,_that.isCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)@JsonKey(name: 'display_name')  String displayName, @HiveField(1)@JsonKey(name: 'birth_date')  String birthDate, @HiveField(2)  int weight, @HiveField(3)  int height, @HiveField(4)@JsonKey(name: 'period_avg_length')  int periodAvgLength, @HiveField(5)@JsonKey(name: 'cycle_avg_length')  int cycleAvgLength, @HiveField(6)@JsonKey(name: 'last_period')  bool lastPeriod, @HiveField(7)@JsonKey(name: 'is_completed')  bool isCompleted)?  $default,) {final _that = this;
switch (_that) {
case _QuizDataModel() when $default != null:
return $default(_that.displayName,_that.birthDate,_that.weight,_that.height,_that.periodAvgLength,_that.cycleAvgLength,_that.lastPeriod,_that.isCompleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuizDataModel extends QuizDataModel {
  const _QuizDataModel({@HiveField(0)@JsonKey(name: 'display_name') required this.displayName, @HiveField(1)@JsonKey(name: 'birth_date') required this.birthDate, @HiveField(2) required this.weight, @HiveField(3) required this.height, @HiveField(4)@JsonKey(name: 'period_avg_length') required this.periodAvgLength, @HiveField(5)@JsonKey(name: 'cycle_avg_length') required this.cycleAvgLength, @HiveField(6)@JsonKey(name: 'last_period') required this.lastPeriod, @HiveField(7)@JsonKey(name: 'is_completed') required this.isCompleted}): super._();
  factory _QuizDataModel.fromJson(Map<String, dynamic> json) => _$QuizDataModelFromJson(json);

@override@HiveField(0)@JsonKey(name: 'display_name') final  String displayName;
@override@HiveField(1)@JsonKey(name: 'birth_date') final  String birthDate;
@override@HiveField(2) final  int weight;
@override@HiveField(3) final  int height;
@override@HiveField(4)@JsonKey(name: 'period_avg_length') final  int periodAvgLength;
@override@HiveField(5)@JsonKey(name: 'cycle_avg_length') final  int cycleAvgLength;
@override@HiveField(6)@JsonKey(name: 'last_period') final  bool lastPeriod;
@override@HiveField(7)@JsonKey(name: 'is_completed') final  bool isCompleted;

/// Create a copy of QuizDataModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizDataModelCopyWith<_QuizDataModel> get copyWith => __$QuizDataModelCopyWithImpl<_QuizDataModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuizDataModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizDataModel&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.height, height) || other.height == height)&&(identical(other.periodAvgLength, periodAvgLength) || other.periodAvgLength == periodAvgLength)&&(identical(other.cycleAvgLength, cycleAvgLength) || other.cycleAvgLength == cycleAvgLength)&&(identical(other.lastPeriod, lastPeriod) || other.lastPeriod == lastPeriod)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayName,birthDate,weight,height,periodAvgLength,cycleAvgLength,lastPeriod,isCompleted);

@override
String toString() {
  return 'QuizDataModel(displayName: $displayName, birthDate: $birthDate, weight: $weight, height: $height, periodAvgLength: $periodAvgLength, cycleAvgLength: $cycleAvgLength, lastPeriod: $lastPeriod, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class _$QuizDataModelCopyWith<$Res> implements $QuizDataModelCopyWith<$Res> {
  factory _$QuizDataModelCopyWith(_QuizDataModel value, $Res Function(_QuizDataModel) _then) = __$QuizDataModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0)@JsonKey(name: 'display_name') String displayName,@HiveField(1)@JsonKey(name: 'birth_date') String birthDate,@HiveField(2) int weight,@HiveField(3) int height,@HiveField(4)@JsonKey(name: 'period_avg_length') int periodAvgLength,@HiveField(5)@JsonKey(name: 'cycle_avg_length') int cycleAvgLength,@HiveField(6)@JsonKey(name: 'last_period') bool lastPeriod,@HiveField(7)@JsonKey(name: 'is_completed') bool isCompleted
});




}
/// @nodoc
class __$QuizDataModelCopyWithImpl<$Res>
    implements _$QuizDataModelCopyWith<$Res> {
  __$QuizDataModelCopyWithImpl(this._self, this._then);

  final _QuizDataModel _self;
  final $Res Function(_QuizDataModel) _then;

/// Create a copy of QuizDataModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? birthDate = null,Object? weight = null,Object? height = null,Object? periodAvgLength = null,Object? cycleAvgLength = null,Object? lastPeriod = null,Object? isCompleted = null,}) {
  return _then(_QuizDataModel(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,birthDate: null == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as String,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,periodAvgLength: null == periodAvgLength ? _self.periodAvgLength : periodAvgLength // ignore: cast_nullable_to_non_nullable
as int,cycleAvgLength: null == cycleAvgLength ? _self.cycleAvgLength : cycleAvgLength // ignore: cast_nullable_to_non_nullable
as int,lastPeriod: null == lastPeriod ? _self.lastPeriod : lastPeriod // ignore: cast_nullable_to_non_nullable
as bool,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
