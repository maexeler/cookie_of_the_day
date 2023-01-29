import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/cookie.dart';
import 'cookie_repository.dart';

class CookieLocalReposiory extends CookieRepository {
  final Future<SharedPreferences> _dataStore = SharedPreferences.getInstance();
  List<Cookie> _cookies;
  bool _alreadyInitialized;

  CookieLocalReposiory()
      : _alreadyInitialized = false,
        _cookies = [];

  @override
  Future<List<Cookie>> getCookieList() async {
    await _establishCookieData();
    return _cookies;
  }

  @override
  Future<void> addCookie(Cookie cookie) async {
    await _establishCookieData();
    _cookies = [cookie, ..._cookies];
    await _saveCookies();
  }

  @override
  Future<void> updateCookie(
      Cookie cookie, String? wisdom, String? author) async {
    await _establishCookieData();
    _cookies = [..._cookies];
    _cookies.remove(cookie);
    if (wisdom != null) {
      cookie = cookie.copyWith(wisdom: wisdom);
    }
    if (author != null) {
      cookie = cookie.copyWith(author: author);
    }
    _cookies = [..._cookies, cookie];
    await _saveCookies();
  }

  @override
  Future<void> deleteCookie(Cookie cookie) async {
    await _establishCookieData();
    _cookies = [..._cookies];
    _cookies.remove(cookie);
    await _saveCookies();
  }

  Future<void> _establishCookieData() async {
    if (_alreadyInitialized) {
      return;
    }
    _alreadyInitialized = true;
    final SharedPreferences store = await _dataStore;
    final String dataString = store.getString('cookie_data') ?? '';
    if (dataString.isEmpty) {
      _cookies = _createFakeData();
      return;
    }
    _cookies = (json.decode(dataString) as List)
        .map((i) => Cookie.fromJson(i))
        .toList();
  }

  Future<void> _saveCookies() async {
    final SharedPreferences store = await _dataStore;
    String dataString = jsonEncode(_cookies);
    await store.setString('cookie_data', dataString);
  }

  List<Cookie> _createFakeData() => [
        Cookie.fromWisdomAndAutor('be happy', ''),
        Cookie.fromWisdomAndAutor("Don't panic", 'Ford Perfect'),
        Cookie.fromWisdomAndAutor('Happy wife, happy live', 'Me, myself'),
      ];
}
