import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

part 'cookie.freezed.dart';
part 'cookie.g.dart';

var _uuid = const Uuid();

@freezed
class Cookie with _$Cookie {
  const factory Cookie({
    required String id,
    required String wisdom,
    required String author,
  }) = _Cookie;

  factory Cookie.fromWisdomAndAutor(String wisdom, String author) =>
      Cookie(id: _uuid.v4(), wisdom: wisdom, author: author);

  factory Cookie.fromJson(Map<String, Object?> json) => _$CookieFromJson(json);
}
