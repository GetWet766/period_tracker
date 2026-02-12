// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cycle_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CycleState {

 CycleEntity? get currentCycle; List<CycleEntity> get history; bool get isLoading;
/// Create a copy of CycleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CycleStateCopyWith<CycleState> get copyWith => _$CycleStateCopyWithImpl<CycleState>(this as CycleState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CycleState&&(identical(other.currentCycle, currentCycle) || other.currentCycle == currentCycle)&&const DeepCollectionEquality().equals(other.history, history)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,currentCycle,const DeepCollectionEquality().hash(history),isLoading);

@override
String toString() {
  return 'CycleState(currentCycle: $currentCycle, history: $history, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $CycleStateCopyWith<$Res>  {
  factory $CycleStateCopyWith(CycleState value, $Res Function(CycleState) _then) = _$CycleStateCopyWithImpl;
@useResult
$Res call({
 CycleEntity? currentCycle, List<CycleEntity> history, bool isLoading
});




}
/// @nodoc
class _$CycleStateCopyWithImpl<$Res>
    implements $CycleStateCopyWith<$Res> {
  _$CycleStateCopyWithImpl(this._self, this._then);

  final CycleState _self;
  final $Res Function(CycleState) _then;

/// Create a copy of CycleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentCycle = freezed,Object? history = null,Object? isLoading = null,}) {
  return _then(_self.copyWith(
currentCycle: freezed == currentCycle ? _self.currentCycle : currentCycle // ignore: cast_nullable_to_non_nullable
as CycleEntity?,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<CycleEntity>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CycleState].
extension CycleStatePatterns on CycleState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CycleState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CycleState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CycleState value)  $default,){
final _that = this;
switch (_that) {
case _CycleState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CycleState value)?  $default,){
final _that = this;
switch (_that) {
case _CycleState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CycleEntity? currentCycle,  List<CycleEntity> history,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CycleState() when $default != null:
return $default(_that.currentCycle,_that.history,_that.isLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CycleEntity? currentCycle,  List<CycleEntity> history,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _CycleState():
return $default(_that.currentCycle,_that.history,_that.isLoading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CycleEntity? currentCycle,  List<CycleEntity> history,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _CycleState() when $default != null:
return $default(_that.currentCycle,_that.history,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _CycleState implements CycleState {
  const _CycleState({this.currentCycle, final  List<CycleEntity> history = const [], this.isLoading = false}): _history = history;
  

@override final  CycleEntity? currentCycle;
 final  List<CycleEntity> _history;
@override@JsonKey() List<CycleEntity> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}

@override@JsonKey() final  bool isLoading;

/// Create a copy of CycleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CycleStateCopyWith<_CycleState> get copyWith => __$CycleStateCopyWithImpl<_CycleState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CycleState&&(identical(other.currentCycle, currentCycle) || other.currentCycle == currentCycle)&&const DeepCollectionEquality().equals(other._history, _history)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,currentCycle,const DeepCollectionEquality().hash(_history),isLoading);

@override
String toString() {
  return 'CycleState(currentCycle: $currentCycle, history: $history, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$CycleStateCopyWith<$Res> implements $CycleStateCopyWith<$Res> {
  factory _$CycleStateCopyWith(_CycleState value, $Res Function(_CycleState) _then) = __$CycleStateCopyWithImpl;
@override @useResult
$Res call({
 CycleEntity? currentCycle, List<CycleEntity> history, bool isLoading
});




}
/// @nodoc
class __$CycleStateCopyWithImpl<$Res>
    implements _$CycleStateCopyWith<$Res> {
  __$CycleStateCopyWithImpl(this._self, this._then);

  final _CycleState _self;
  final $Res Function(_CycleState) _then;

/// Create a copy of CycleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentCycle = freezed,Object? history = null,Object? isLoading = null,}) {
  return _then(_CycleState(
currentCycle: freezed == currentCycle ? _self.currentCycle : currentCycle // ignore: cast_nullable_to_non_nullable
as CycleEntity?,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<CycleEntity>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
