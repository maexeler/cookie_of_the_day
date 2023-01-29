import 'dart:async';
import 'package:dio/dio.dart';
import '../model/cookie.dart';
import 'cookie_repository.dart';

class CookieWebReposiory extends CookieRepository {
  late final Dio dio;
  static String baseUrl =
      // Use this for ease of use, no modify of the data possible
      'https://my-json-server.typicode.com/maexeler/jsondata';

  // Use this for a local server mirrowed to the web
  // 'https://8220-2a02-1210-1665-2100-58c3-a276-f2e9-4dac.eu.ngrok.io';
  static const String cookieUrl = '/cookies';

  CookieWebReposiory() {
    var options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    dio = Dio(options);
  }

  @override
  Future<List<Cookie>> getCookieList() async {
    var response = await dio.get(cookieUrl);
    List<Cookie> cookies =
        response.data.map<Cookie>((i) => Cookie.fromJson(i)).toList();
    return cookies;
  }

  @override
  Future<void> addCookie(Cookie cookie) async {
    try {
      await dio.post(cookieUrl, data: cookie.toJson());
    } catch (e) {
      throw CookieRepositoryException('Add cookie failed');
    }
  }

  @override
  Future<void> updateCookie(
      Cookie cookie, String? wisdom, String? author) async {
    try {
      await dio.put(
        '$cookieUrl/${cookie.id}',
        data: cookie.copyWith(wisdom: wisdom ?? '', author: author ?? ''),
      );
    } catch (e) {
      throw CookieRepositoryException('Update cookie failed');
    }
  }

  @override
  Future<void> deleteCookie(Cookie cookie) async {
    try {
      await dio.delete('$cookieUrl/${cookie.id}');
    } catch (e) {
      throw CookieRepositoryException('Delete cookie failed');
    }
  }
}
