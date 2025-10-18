// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Unauthenticated value)?  unauthenticated,TResult Function( Authenticating value)?  authenticating,TResult Function( Authenticated value)?  authenticated,TResult Function( Refreshing value)?  refreshing,TResult Function( Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Unauthenticated() when unauthenticated != null:
return unauthenticated(_that);case Authenticating() when authenticating != null:
return authenticating(_that);case Authenticated() when authenticated != null:
return authenticated(_that);case Refreshing() when refreshing != null:
return refreshing(_that);case Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Unauthenticated value)  unauthenticated,required TResult Function( Authenticating value)  authenticating,required TResult Function( Authenticated value)  authenticated,required TResult Function( Refreshing value)  refreshing,required TResult Function( Error value)  error,}){
final _that = this;
switch (_that) {
case Unauthenticated():
return unauthenticated(_that);case Authenticating():
return authenticating(_that);case Authenticated():
return authenticated(_that);case Refreshing():
return refreshing(_that);case Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Unauthenticated value)?  unauthenticated,TResult? Function( Authenticating value)?  authenticating,TResult? Function( Authenticated value)?  authenticated,TResult? Function( Refreshing value)?  refreshing,TResult? Function( Error value)?  error,}){
final _that = this;
switch (_that) {
case Unauthenticated() when unauthenticated != null:
return unauthenticated(_that);case Authenticating() when authenticating != null:
return authenticating(_that);case Authenticated() when authenticated != null:
return authenticated(_that);case Refreshing() when refreshing != null:
return refreshing(_that);case Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  unauthenticated,TResult Function()?  authenticating,TResult Function()?  authenticated,TResult Function()?  refreshing,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Unauthenticated() when unauthenticated != null:
return unauthenticated();case Authenticating() when authenticating != null:
return authenticating();case Authenticated() when authenticated != null:
return authenticated();case Refreshing() when refreshing != null:
return refreshing();case Error() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  unauthenticated,required TResult Function()  authenticating,required TResult Function()  authenticated,required TResult Function()  refreshing,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case Unauthenticated():
return unauthenticated();case Authenticating():
return authenticating();case Authenticated():
return authenticated();case Refreshing():
return refreshing();case Error():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  unauthenticated,TResult? Function()?  authenticating,TResult? Function()?  authenticated,TResult? Function()?  refreshing,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case Unauthenticated() when unauthenticated != null:
return unauthenticated();case Authenticating() when authenticating != null:
return authenticating();case Authenticated() when authenticated != null:
return authenticated();case Refreshing() when refreshing != null:
return refreshing();case Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class Unauthenticated implements AuthState {
  const Unauthenticated();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Unauthenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.unauthenticated()';
}


}




/// @nodoc


class Authenticating implements AuthState {
  const Authenticating();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Authenticating);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.authenticating()';
}


}




/// @nodoc


class Authenticated implements AuthState {
  const Authenticated();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Authenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.authenticated()';
}


}




/// @nodoc


class Refreshing implements AuthState {
  const Refreshing();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Refreshing);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.refreshing()';
}


}




/// @nodoc


class Error implements AuthState {
  const Error(this.message);
  

 final  String message;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorCopyWith<Error> get copyWith => _$ErrorCopyWithImpl<Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) _then) = _$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(this._self, this._then);

  final Error _self;
  final $Res Function(Error) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
