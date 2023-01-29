// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cookie.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Cookie _$CookieFromJson(Map<String, dynamic> json) {
  return _Cookie.fromJson(json);
}

/// @nodoc
mixin _$Cookie {
  String get id => throw _privateConstructorUsedError;
  String get wisdom => throw _privateConstructorUsedError;
  String get author => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CookieCopyWith<Cookie> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CookieCopyWith<$Res> {
  factory $CookieCopyWith(Cookie value, $Res Function(Cookie) then) =
      _$CookieCopyWithImpl<$Res, Cookie>;
  @useResult
  $Res call({String id, String wisdom, String author});
}

/// @nodoc
class _$CookieCopyWithImpl<$Res, $Val extends Cookie>
    implements $CookieCopyWith<$Res> {
  _$CookieCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? wisdom = null,
    Object? author = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      wisdom: null == wisdom
          ? _value.wisdom
          : wisdom // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CookieCopyWith<$Res> implements $CookieCopyWith<$Res> {
  factory _$$_CookieCopyWith(_$_Cookie value, $Res Function(_$_Cookie) then) =
      __$$_CookieCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String wisdom, String author});
}

/// @nodoc
class __$$_CookieCopyWithImpl<$Res>
    extends _$CookieCopyWithImpl<$Res, _$_Cookie>
    implements _$$_CookieCopyWith<$Res> {
  __$$_CookieCopyWithImpl(_$_Cookie _value, $Res Function(_$_Cookie) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? wisdom = null,
    Object? author = null,
  }) {
    return _then(_$_Cookie(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      wisdom: null == wisdom
          ? _value.wisdom
          : wisdom // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Cookie with DiagnosticableTreeMixin implements _Cookie {
  const _$_Cookie(
      {required this.id, required this.wisdom, required this.author});

  factory _$_Cookie.fromJson(Map<String, dynamic> json) =>
      _$$_CookieFromJson(json);

  @override
  final String id;
  @override
  final String wisdom;
  @override
  final String author;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Cookie(id: $id, wisdom: $wisdom, author: $author)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Cookie'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('wisdom', wisdom))
      ..add(DiagnosticsProperty('author', author));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Cookie &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.wisdom, wisdom) || other.wisdom == wisdom) &&
            (identical(other.author, author) || other.author == author));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, wisdom, author);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CookieCopyWith<_$_Cookie> get copyWith =>
      __$$_CookieCopyWithImpl<_$_Cookie>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CookieToJson(
      this,
    );
  }
}

abstract class _Cookie implements Cookie {
  const factory _Cookie(
      {required final String id,
      required final String wisdom,
      required final String author}) = _$_Cookie;

  factory _Cookie.fromJson(Map<String, dynamic> json) = _$_Cookie.fromJson;

  @override
  String get id;
  @override
  String get wisdom;
  @override
  String get author;
  @override
  @JsonKey(ignore: true)
  _$$_CookieCopyWith<_$_Cookie> get copyWith =>
      throw _privateConstructorUsedError;
}
