import 'dart:math';
import 'package:riverpod/riverpod.dart';

import '../model/cookie.dart';
import '../repository/cookie_repository.dart';

/// Used to observe and create a new Cookie of the Day
final cookieOfTheDayServiceNotifierProvider =
    StateNotifierProvider<CookieOfTheDayService, AsyncValue<Cookie?>>(
  (ref) => CookieOfTheDayService(ref),
);

/// CookieOfTheDayService serves a dual purpose.
///
/// - First, it gives the functionality to request a new cookie.
///   (which may be null)
/// - Second, it let's us watch for a new Cookie of the Day.
///
/// Since all service funtions are async,
/// we wrap the cookie in a [AsyncValue], so we can determine
/// if we are in a loding-, data-, or error state.
///
/// Besides that, our [AsyncValue] is wrapped inside a [StateNotifier] so we
/// can easily react on state changes.
///
class CookieOfTheDayService extends StateNotifier<AsyncValue<Cookie?>> {
  final Ref ref;
  final Random rnd = Random();

  CookieOfTheDayService(this.ref) : super(const AsyncValue.loading()) {
    generateCookieOfTheDay();
  }

  Future<void> generateCookieOfTheDay() async {
    try {
      state = const AsyncValue.loading();
      final cookies = await ref.read(cookieRepositoryProvider).getCookieList();
      if (cookies.isEmpty) {
        state = AsyncValue.data(null);
        return;
      }
      final Cookie cookie = cookies[rnd.nextInt(cookies.length)];
      state = AsyncValue.data(cookie);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
