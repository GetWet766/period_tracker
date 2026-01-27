// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuizData {

 List<CycleGoal> get goals; int get averageCycleLength; bool get hasMedicalConditions; bool get isCompleted;
/// Create a copy of QuizData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizDataCopyWith<QuizData> get copyWith => _$QuizDataCopyWithImpl<QuizData>(this as QuizData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizData&&const DeepCollectionEquality().equals(other.goals, goals)&&(identical(other.averageCycleLength, averageCycleLength) || other.averageCycleLength == averageCycleLength)&&(identical(other.hasMedicalConditions, hasMedicalConditions) || other.hasMedicalConditions == hasMedicalConditions)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(goals),averageCycleLength,hasMedicalConditions,isCompleted);

@override
String toString() {
  return 'QuizData(goals: $goals, averageCycleLength: $averageCycleLength, hasMedicalConditions: $hasMedicalConditions, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class $QuizDataCopyWith<$Res>  {
  factory $QuizDataCopyWith(QuizData value, $Res Function(QuizData) _then) = _$QuizDataCopyWithImpl;
@useResult
$Res call({
 List<CycleGoal> goals, int averageCycleLength, bool hasMedicalConditions, bool isCompleted
});




}
/// @nodoc
class _$QuizDataCopyWithImpl<$Res>
    implements $QuizDataCopyWith<$Res> {
  _$QuizDataCopyWithImpl(this._self, this._then);

  final QuizData _self;
  final $Res Function(QuizData) _then;

/// Create a copy of QuizData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? goals = null,Object? averageCycleLength = null,Object? hasMedicalConditions = null,Object? isCompleted = null,}) {
  return _then(_self.copyWith(
goals: null == goals ? _self.goals : goals // ignore: cast_nullable_to_non_nullable
as List<CycleGoal>,averageCycleLength: null == averageCycleLength ? _self.averageCycleLength : averageCycleLength // ignore: cast_nullable_to_non_nullable
as int,hasMedicalConditions: null == hasMedicalConditions ? _self.hasMedicalConditions : hasMedicalConditions // ignore: cast_nullable_to_non_nullable
as bool,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizData].
extension QuizDataPatterns on QuizData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizData value)  $default,){
final _that = this;
switch (_that) {
case _QuizData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizData value)?  $default,){
final _that = this;
switch (_that) {
case _QuizData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CycleGoal> goals,  int averageCycleLength,  bool hasMedicalConditions,  bool isCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizData() when $default != null:
return $default(_that.goals,_that.averageCycleLength,_that.hasMedicalConditions,_that.isCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CycleGoal> goals,  int averageCycleLength,  bool hasMedicalConditions,  bool isCompleted)  $default,) {final _that = this;
switch (_that) {
case _QuizData():
return $default(_that.goals,_that.averageCycleLength,_that.hasMedicalConditions,_that.isCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CycleGoal> goals,  int averageCycleLength,  bool hasMedicalConditions,  bool isCompleted)?  $default,) {final _that = this;
switch (_that) {
case _QuizData() when $default != null:
return $default(_that.goals,_that.averageCycleLength,_that.hasMedicalConditions,_that.isCompleted);case _:
  return null;

}
}

}

/// @nodoc


class _QuizData implements QuizData {
  const _QuizData({required final  List<CycleGoal> goals, required this.averageCycleLength, required this.hasMedicalConditions, this.isCompleted = false}): _goals = goals;
  

 final  List<CycleGoal> _goals;
@override List<CycleGoal> get goals {
  if (_goals is EqualUnmodifiableListView) return _goals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goals);
}

@override final  int averageCycleLength;
@override final  bool hasMedicalConditions;
@override@JsonKey() final  bool isCompleted;

/// Create a copy of QuizData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizDataCopyWith<_QuizData> get copyWith => __$QuizDataCopyWithImpl<_QuizData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizData&&const DeepCollectionEquality().equals(other._goals, _goals)&&(identical(other.averageCycleLength, averageCycleLength) || other.averageCycleLength == averageCycleLength)&&(identical(other.hasMedicalConditions, hasMedicalConditions) || other.hasMedicalConditions == hasMedicalConditions)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_goals),averageCycleLength,hasMedicalConditions,isCompleted);

@override
String toString() {
  return 'QuizData(goals: $goals, averageCycleLength: $averageCycleLength, hasMedicalConditions: $hasMedicalConditions, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class _$QuizDataCopyWith<$Res> implements $QuizDataCopyWith<$Res> {
  factory _$QuizDataCopyWith(_QuizData value, $Res Function(_QuizData) _then) = __$QuizDataCopyWithImpl;
@override @useResult
$Res call({
 List<CycleGoal> goals, int averageCycleLength, bool hasMedicalConditions, bool isCompleted
});




}
/// @nodoc
class __$QuizDataCopyWithImpl<$Res>
    implements _$QuizDataCopyWith<$Res> {
  __$QuizDataCopyWithImpl(this._self, this._then);

  final _QuizData _self;
  final $Res Function(_QuizData) _then;

/// Create a copy of QuizData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? goals = null,Object? averageCycleLength = null,Object? hasMedicalConditions = null,Object? isCompleted = null,}) {
  return _then(_QuizData(
goals: null == goals ? _self._goals : goals // ignore: cast_nullable_to_non_nullable
as List<CycleGoal>,averageCycleLength: null == averageCycleLength ? _self.averageCycleLength : averageCycleLength // ignore: cast_nullable_to_non_nullable
as int,hasMedicalConditions: null == hasMedicalConditions ? _self.hasMedicalConditions : hasMedicalConditions // ignore: cast_nullable_to_non_nullable
as bool,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
