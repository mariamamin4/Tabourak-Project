// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignupState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignupState()';
}


}

/// @nodoc
class $SignupStateCopyWith<$Res>  {
$SignupStateCopyWith(SignupState _, $Res Function(SignupState) __);
}


/// Adds pattern-matching-related methods to [SignupState].
extension SignupStatePatterns on SignupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SignupInitial value)?  initial,TResult Function( SignupLoading value)?  loading,TResult Function( SignupSuccess value)?  success,TResult Function( SignupError value)?  error,TResult Function( SignupUpdated value)?  updated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SignupInitial() when initial != null:
return initial(_that);case SignupLoading() when loading != null:
return loading(_that);case SignupSuccess() when success != null:
return success(_that);case SignupError() when error != null:
return error(_that);case SignupUpdated() when updated != null:
return updated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SignupInitial value)  initial,required TResult Function( SignupLoading value)  loading,required TResult Function( SignupSuccess value)  success,required TResult Function( SignupError value)  error,required TResult Function( SignupUpdated value)  updated,}){
final _that = this;
switch (_that) {
case SignupInitial():
return initial(_that);case SignupLoading():
return loading(_that);case SignupSuccess():
return success(_that);case SignupError():
return error(_that);case SignupUpdated():
return updated(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SignupInitial value)?  initial,TResult? Function( SignupLoading value)?  loading,TResult? Function( SignupSuccess value)?  success,TResult? Function( SignupError value)?  error,TResult? Function( SignupUpdated value)?  updated,}){
final _that = this;
switch (_that) {
case SignupInitial() when initial != null:
return initial(_that);case SignupLoading() when loading != null:
return loading(_that);case SignupSuccess() when success != null:
return success(_that);case SignupError() when error != null:
return error(_that);case SignupUpdated() when updated != null:
return updated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( dynamic data)?  success,TResult Function( String error)?  error,TResult Function( bool acceptPolicy)?  updated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SignupInitial() when initial != null:
return initial();case SignupLoading() when loading != null:
return loading();case SignupSuccess() when success != null:
return success(_that.data);case SignupError() when error != null:
return error(_that.error);case SignupUpdated() when updated != null:
return updated(_that.acceptPolicy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( dynamic data)  success,required TResult Function( String error)  error,required TResult Function( bool acceptPolicy)  updated,}) {final _that = this;
switch (_that) {
case SignupInitial():
return initial();case SignupLoading():
return loading();case SignupSuccess():
return success(_that.data);case SignupError():
return error(_that.error);case SignupUpdated():
return updated(_that.acceptPolicy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( dynamic data)?  success,TResult? Function( String error)?  error,TResult? Function( bool acceptPolicy)?  updated,}) {final _that = this;
switch (_that) {
case SignupInitial() when initial != null:
return initial();case SignupLoading() when loading != null:
return loading();case SignupSuccess() when success != null:
return success(_that.data);case SignupError() when error != null:
return error(_that.error);case SignupUpdated() when updated != null:
return updated(_that.acceptPolicy);case _:
  return null;

}
}

}

/// @nodoc


class SignupInitial implements SignupState {
  const SignupInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignupState.initial()';
}


}




/// @nodoc


class SignupLoading implements SignupState {
  const SignupLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignupState.loading()';
}


}




/// @nodoc


class SignupSuccess implements SignupState {
  const SignupSuccess(this.data);
  

 final  dynamic data;

/// Create a copy of SignupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupSuccessCopyWith<SignupSuccess> get copyWith => _$SignupSuccessCopyWithImpl<SignupSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupSuccess&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'SignupState.success(data: $data)';
}


}

/// @nodoc
abstract mixin class $SignupSuccessCopyWith<$Res> implements $SignupStateCopyWith<$Res> {
  factory $SignupSuccessCopyWith(SignupSuccess value, $Res Function(SignupSuccess) _then) = _$SignupSuccessCopyWithImpl;
@useResult
$Res call({
 dynamic data
});




}
/// @nodoc
class _$SignupSuccessCopyWithImpl<$Res>
    implements $SignupSuccessCopyWith<$Res> {
  _$SignupSuccessCopyWithImpl(this._self, this._then);

  final SignupSuccess _self;
  final $Res Function(SignupSuccess) _then;

/// Create a copy of SignupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(SignupSuccess(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

/// @nodoc


class SignupError implements SignupState {
  const SignupError(this.error);
  

 final  String error;

/// Create a copy of SignupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupErrorCopyWith<SignupError> get copyWith => _$SignupErrorCopyWithImpl<SignupError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'SignupState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $SignupErrorCopyWith<$Res> implements $SignupStateCopyWith<$Res> {
  factory $SignupErrorCopyWith(SignupError value, $Res Function(SignupError) _then) = _$SignupErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$SignupErrorCopyWithImpl<$Res>
    implements $SignupErrorCopyWith<$Res> {
  _$SignupErrorCopyWithImpl(this._self, this._then);

  final SignupError _self;
  final $Res Function(SignupError) _then;

/// Create a copy of SignupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(SignupError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SignupUpdated implements SignupState {
  const SignupUpdated({required this.acceptPolicy});
  

 final  bool acceptPolicy;

/// Create a copy of SignupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupUpdatedCopyWith<SignupUpdated> get copyWith => _$SignupUpdatedCopyWithImpl<SignupUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupUpdated&&(identical(other.acceptPolicy, acceptPolicy) || other.acceptPolicy == acceptPolicy));
}


@override
int get hashCode => Object.hash(runtimeType,acceptPolicy);

@override
String toString() {
  return 'SignupState.updated(acceptPolicy: $acceptPolicy)';
}


}

/// @nodoc
abstract mixin class $SignupUpdatedCopyWith<$Res> implements $SignupStateCopyWith<$Res> {
  factory $SignupUpdatedCopyWith(SignupUpdated value, $Res Function(SignupUpdated) _then) = _$SignupUpdatedCopyWithImpl;
@useResult
$Res call({
 bool acceptPolicy
});




}
/// @nodoc
class _$SignupUpdatedCopyWithImpl<$Res>
    implements $SignupUpdatedCopyWith<$Res> {
  _$SignupUpdatedCopyWithImpl(this._self, this._then);

  final SignupUpdated _self;
  final $Res Function(SignupUpdated) _then;

/// Create a copy of SignupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? acceptPolicy = null,}) {
  return _then(SignupUpdated(
acceptPolicy: null == acceptPolicy ? _self.acceptPolicy : acceptPolicy // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
