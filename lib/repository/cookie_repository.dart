import 'package:riverpod/riverpod.dart';

import '../model/cookie.dart';

final cookieRepositoryProvider = Provider<CookieRepository>((ref) {
  throw UnimplementedError();
});

/// A CRUD repository for Cookie
///
/// For a concrete implementation see [CookieLocalReposiory]
abstract class CookieRepository {
  Future<List<Cookie>> getCookieList();

  Future<void> addCookie(Cookie cookie);
  Future<void> updateCookie(Cookie cookie, String? wisdom, String? author);
  Future<void> deleteCookie(Cookie cookie);
}

class CookieRepositoryException implements Exception {
  final String cause;
  CookieRepositoryException(this.cause);
}
