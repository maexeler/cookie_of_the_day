import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cookie_of_the_day/page/cookie_page.dart';

import '../repository/cookie_repository.dart';
// import '../repository/cookie_repository_web.dart';
import '../repository/cookie_repository_local.dart';
// import '../repository/cookie_repository_delayed_with_error.dart';

void main() {
  runApp(
    ProviderScope(
      overrides: [
        cookieRepositoryProvider
            .overrideWith(((ref) => CookieLocalReposiory())),
        // .overrideWith(((ref) => CookieWebReposiory())),
        // .overrideWith(((ref) => CookieDelayedErrorReposiory())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cookie of the day',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CookiePage(),
    );
  }
}
