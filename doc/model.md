# Cookie
## Was wir brauchen
Wir benötige eine Klasse welch die folgenden Felder enthält:
```dart
class Cookie {
    final String id;
    final String wisdom;
    final String author
}
```
Propbleme:
1) Auf welche Art können Cookies erzeugt werden?
2) Wer besorgt uns eine eindeutige ```id```?
3) Wie verändern wir ein Cookie wenn alle Felder ```final``` sind?
4) Brauchen wir eine JSON-Darstellung von Cookie?
5) Wie stellen wir sicher, dass Cookies ```inmutable``` (unveränderlich) ist?
6) Wann sind zwei Cookies identisch?

## Lösungsansatz
1 + 2 ) Wir brauchen einen Factory-Constructor welcher ```wisdom``` und ```author``` entgegen nimmt und die ```id``` automatisch erzeugt.  
4 )  Wir brauchen einen Factory-Constructor welcher ein Cookie aus einer JSON-Map erstellt.  
```dart
var _uuid = const Uuid();

class Cookie with _$Cookie {
  const Cookie(
    final String id,
    final String wisdom,
    final String author,
  );

  factory Cookie.fromWisdomAndAutor(String wisdom, String author) =>
      Cookie(id: _uuid.v4(), wisdom: wisdom, author: author);

  factory Cookie.fromJson(Map<String, Object?> json) {...}

  Map<String, Object?> toJson() {...}
}
```

soweit so gut.  
Aber was ist mit 3) 5) und 6)?  
Irgend wie kann es ja wohl nicht sein, dass wir die einzigen sind die dieses Problem haben. Das muss doch einfacer gehen.

## Lösung: Code generieren
Die Lösung ist, dass wir uns den nötigen Code generieren lassen. Wir benutzen dazu die Bibliothek 'freezed'.

### Vorgehen:  
Wir definieren was wir haben wollen, geben in welchen Dateien der generierte code entstehen soll und lassen den Codegenerator laufen:

```dart
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
```
Was läuft hier?

- ``@freezed`` bedeuted generiere code für eine unveränderliche Klasse;

- `` Cookie with _$Cookie{
  const factory Cookie({ ...}) = _Cookie`` ist die Beschreibung unseres Wunsches für ``frezzed``

- ``factory Cookie.fromWisdomAndAutor(String wisdom, String author) => ...`` ist unsere Implementierug von 1)

- ``part 'cookie.freezed.dart'`` ist der Ort wo der ``freezed`` code generiert wird.

- ``part 'cookie.g.dart'`` ist der Ort, wo ``to/fromJson()`` generiert wird.

### Code generieren:  
Um den Code zu generieren starten sie ein neues Teminalfenster und lassen folgendes Kommando laufen:

    flutter pub run build_runner build --delete-conflicting-outputs
oder :

    flutter pub run build_runner watch --delete-conflicting-outputs

build generiert einmal code, watch generiert code bei jedem Speichern der Datei.


