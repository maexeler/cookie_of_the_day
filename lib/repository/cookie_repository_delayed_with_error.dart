import 'dart:async';
import 'dart:math';

import '../model/cookie.dart';
import './cookie_repository_local.dart';
import 'cookie_repository.dart';

class CookieDelayedErrorReposiory extends CookieLocalReposiory {
  static const double errorRate = 0.5;
  static const int maxDelay = 2000;
  static final Random rnd = Random();

  CookieDelayedErrorReposiory();

  @override
  Future<List<Cookie>> getCookieList() async {
    _generateError();
    _delay();
    print('getCookieList()');
    return await super.getCookieList();
  }

  @override
  Future<void> addCookie(Cookie cookie) async {
    _generateError();
    _delay();
    return await super.addCookie(cookie);
  }

  @override
  Future<void> updateCookie(
      Cookie cookie, String? wisdom, String? author) async {
    _generateError();
    _delay();
    return await super.updateCookie(cookie, wisdom, author);
  }

  @override
  Future<void> deleteCookie(Cookie cookie) async {
    _generateError();
    _delay();
    return await super.deleteCookie(cookie);
  }

  void _generateError() {
    if (rnd.nextDouble() < errorRate) {
      print('Repo exception');
      throw CookieRepositoryException('No Data');
    }
  }

  void _delay() async {
    final delay = maxDelay + rnd.nextInt(maxDelay);
    print('delay: $delay');
    Future.delayed(Duration(milliseconds: delay), () {});
  }
}
