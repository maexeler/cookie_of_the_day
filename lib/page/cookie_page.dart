import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shake/shake.dart';

import '../model/cookie.dart';
import '../page/cookie_list_page.dart';
import '../service/cookie_of_the_day_service.dart';
import 'util/cookie_error.dart';

/// Displays the Cookie of the Day
class CookiePage extends HookConsumerWidget {
  const CookiePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // use a hook to activate and deactivate the ShakeDetector
    // every time we enter the build method
    useEffect(() {
      final shakeDetector = ShakeDetector.autoStart(onPhoneShake: () {
        generateNewCookieOfTheDay(ref);
      });
      return shakeDetector.stopListening;
    }, []);

    // Redraw if the cookie of the day changes
    final cookieOfTheDayService =
        ref.watch(cookieOfTheDayServiceNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cookie Of The Day'),
        actions: [
          IconButton(
              onPressed: () {
                settingsButtonPressed(context);
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          generateNewCookieOfTheDay(ref);
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 32, right: 16),
            child: cookieOfTheDayService.when(
              // While the data is loading, show a progress indicator
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              // if we have data, show the cookie
              data: (Cookie? cookie) {
                return CookieWidget(
                  cookie ??
                      Cookie.fromWisdomAndAutor(
                        '😭 No more Cookies of the Day',
                        'bad luck',
                      ),
                );
              },
              // If data retrieval got an error, show an error screen
              error: (error, stackTrace) => CookieErrorWidget(
                  'Error loading Cookie of the Day',
                  ref
                      .read(cookieOfTheDayServiceNotifierProvider.notifier)
                      .generateCookieOfTheDay),
            ),
          ),
        ),
      ),
    );
  }

  void settingsButtonPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CookieListPage()),
    );
  }

  void generateNewCookieOfTheDay(WidgetRef ref) {
    ref
        .read(cookieOfTheDayServiceNotifierProvider.notifier)
        .generateCookieOfTheDay();
  }
}

/// Shows exactly one Cookie
class CookieWidget extends StatelessWidget {
  final Cookie cookie;
  const CookieWidget(this.cookie, {super.key});

  @override
  Widget build(BuildContext context) {
    // Perhaps we should do something better here
    TextStyle? style = Theme.of(context).textTheme.headline5;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(cookie.wisdom, style: style),
        const SizedBox(
          height: 16,
        ),
        Text('© ${cookie.author}', style: style)
      ],
    );
  }
}
