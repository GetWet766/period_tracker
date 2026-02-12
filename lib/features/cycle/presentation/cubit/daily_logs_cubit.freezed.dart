// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_logs_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DailyLogsState {

 DateTime get selectedDate; DailyLogEntity? get currentLog; bool get isLoading;
/// Create a copy of DailyLogsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyLogsStateCopyWith<DailyLogsState> get copyWith => _$DailyLogsStateCopyWithImpl<DailyLogsState>(this as DailyLogsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyLogsState&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.currentLog, currentLog) || other.currentLog == currentLog)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,selectedDate,currentLog,isLoading);

@override
String toString() {
  return 'DailyLogsState(selectedDate: $selectedDate, currentLog: $currentLog, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $DailyLogsStateCopyWith<$Res>  {
  factory $DailyLogsStateCopyWith(DailyLogsState value, $Res Function(DailyLogsState) _then) = _$DailyLogsStateCopyWithImpl;
@useResult
$Res call({
 DateTime selectedDate, DailyLogEntity? currentLog, bool isLoading
});




}
/// @nodoc
class _$DailyLogsStateCopyWithImpl<$Res>
    implements $DailyLogsStateCopyWith<$Res> {
  _$DailyLogsStateCopyWithImpl(this._self, this._then);

  final DailyLogsState _self;
  final $Res Function(DailyLogsState) _then;

/// Create a copy of DailyLogsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedDate = null,Object? currentLog = freezed,Object? isLoading = null,}) {
  return _then(_self.copyWith(
selectedDate: null == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime,currentLog: freezed == currentLog ? _self.currentLog : currentLog // ignore: cast_nullable_to_non_nullable
as DailyLogEntity?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyLogsState].
extension DailyLogsStatePatterns on DailyLogsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyLogsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyLogsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyLogsState value)  $default,){
final _that = this;
switch (_that) {
case _DailyLogsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyLogsState value)?  $default,){
final _that = this;
switch (_that) {
case _DailyLogsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime selectedDate,  DailyLogEntity? currentLog,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyLogsState() when $default != null:
return $default(_that.selectedDate,_that.currentLog,_that.isLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime selectedDate,  DailyLogEntity? currentLog,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _DailyLogsState():
return $default(_that.selectedDate,_that.currentLog,_that.isLoading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime selectedDate,  DailyLogEntity? currentLog,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _DailyLogsState() when $default != null:
return $default(_that.selectedDate,_that.currentLog,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _DailyLogsState implements DailyLogsState {
  const _DailyLogsState({required this.selectedDate, this.currentLog, this.isLoading = false});
  

@override final  DateTime selectedDate;
@override final  DailyLogEntity? currentLog;
@override@JsonKey() final  bool isLoading;

/// Create a copy of DailyLogsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyLogsStateCopyWith<_DailyLogsState> get copyWith => __$DailyLogsStateCopyWithImpl<_DailyLogsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyLogsState&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.currentLog, currentLog) || other.currentLog == currentLog)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,selectedDate,currentLog,isLoading);

@override
String toString() {
  return 'DailyLogsState(selectedDate: $selectedDate, currentLog: $currentLog, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$DailyLogsStateCopyWith<$Res> implements $DailyLogsStateCopyWith<$Res> {
  factory _$DailyLogsStateCopyWith(_DailyLogsState value, $Res Function(_DailyLogsState) _then) = __$DailyLogsStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime selectedDate, DailyLogEntity? currentLog, bool isLoading
});




}
/// @nodoc
class __$DailyLogsStateCopyWithImpl<$Res>
    implements _$DailyLogsStateCopyWith<$Res> {
  __$DailyLogsStateCopyWithImpl(this._self, this._then);

  final _DailyLogsState _self;
  final $Res Function(_DailyLogsState) _then;

/// Create a copy of DailyLogsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedDate = null,Object? currentLog = freezed,Object? isLoading = null,}) {
  return _then(_DailyLogsState(
selectedDate: null == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime,currentLog: freezed == currentLog ? _self.currentLog : currentLog // ignore: cast_nullable_to_non_nullable
as DailyLogEntity?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
