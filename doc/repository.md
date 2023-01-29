# Cookie Repository

Die Klasse ``CookieRepository`` definiert ein Interface für den Zugriff auf ein Cookie-Datastore. Sie definiert die benötigte  die CRUD Funktionalität.

Das einzig spannenede ist dass alle Funktionen ein ``Future``-Objekt zurückgeben.
Das bedeutet, dass die Funktion unmittelbar beendet wird und die Daten später aus dem ``Future``-Objekt extrahiert werden können.

```dart
import '../model/cookie.dart';

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
```
Beispielimplementationen von ``CookieRepository`` finden sie [hier](./../lib/repository/cookie_repository_local.dart) und [hier](./../lib/repository/cookie_repository_delayed_with_error.dart).