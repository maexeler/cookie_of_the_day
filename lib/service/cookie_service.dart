import 'package:riverpod/riverpod.dart';

import '../model/cookie.dart';
import '../repository/cookie_repository.dart';

/// Used to observe changes in the cookie list
/// and for creating, updating and deleteting Cookies
final cookieServiceProvider =
    StateNotifierProvider<CookieService, AsyncValue<List<Cookie>>>(
        (ref) => CookieService(ref));

/// CookieService serves a dual purpose.
///
/// - First, it gives all the functionality to create, update and delete Cookies
/// - Second, it provides us with a list of cookies.
///
/// Since all service funtions are async,
/// we wrap the cookie list in a [AsyncValue], so we can determine
/// if we are in a loding-, data-, or error state.
///
/// Besides that, our [AsyncValue] is wrapped inside a [StateNotifier] so we
/// can easily react on state changes.
///
class CookieService extends StateNotifier<AsyncValue<List<Cookie>>> {
  final Ref ref;
  CookieService(this.ref) : super(const AsyncValue.loading()) {
    retryLoadingCookies();
  }

  Future<void> retryLoadingCookies() async {
    try {
      state = const AsyncValue.loading();
      final cookies = await ref.read(cookieRepositoryProvider).getCookieList();
      state = AsyncValue.data(cookies);
    } on CookieRepositoryException catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> addCookie(String wisdom, String author) async {
    try {
      await ref
          .read(cookieRepositoryProvider)
          .addCookie(Cookie.fromWisdomAndAutor(wisdom, author));
      final cookies = await ref.read(cookieRepositoryProvider).getCookieList();
      state = AsyncValue.data(cookies);
    } on CookieRepositoryException catch (error, stackTrace) {
      _handleException(error, stackTrace);
    }
  }

  Future<void> updateCookie(
      Cookie cookie, String? wisdom, String? author) async {
    try {
      await ref
          .read(cookieRepositoryProvider)
          .updateCookie(cookie, wisdom, author);
      final cookies = await ref.read(cookieRepositoryProvider).getCookieList();
      state = AsyncValue.data(cookies);
    } on CookieRepositoryException catch (error, stackTrace) {
      _handleException(error, stackTrace);
    }
  }

  Future<void> deleteCookie(Cookie cookie) async {
    try {
      await ref.read(cookieRepositoryProvider).deleteCookie(cookie);
      final cookies = await ref.read(cookieRepositoryProvider).getCookieList();
      state = AsyncValue.data(cookies);
    } on CookieRepositoryException catch (error, stackTrace) {
      _handleException(error, stackTrace);
    }
  }

  void _handleException(
      CookieRepositoryException error, StackTrace stackTrace) {
    state = AsyncValue.error(error, stackTrace);
  }
}
