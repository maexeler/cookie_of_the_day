# State Management mit [Riverpod](https://riverpod.dev/)

Riverpod hilft uns bei der Zustandsverwaltung.  

Wir können
- Zustand erstellen
- Zustand finden wo und wann immer wir ihn benötigen
- Zustand überwachen und auf Zustandsänderunegen reagieren

Für eine gute Zusammenfassung siehe auch: [A minimalist guide to Riverpod](https://itnext.io/a-minimalist-guide-to-riverpod-4eb24b3386a1)

## Provider
Provider ermöglichen jederzeit einen einfachen Zugriff auf den Applikationszustand im Code. (Eine Art globale Variable oder Singleton, aber viel sicher)

Provider sind einfach zu erstellen und können ihrerseits aus Provider oder Kombinatione von Provider bestehen.

 - Bsp:  
Ein Provider für eine sortierte Liste, bestehend aus einem Provider für das Sortierkriterum und einem Provider für eine unsortierte Liste.

## Arten von Provider
Wir wollen uns nur die wichtigsten Provider ansehen. Mehr Info unter [Riverpod Provider](https://docs-v2.riverpod.dev/docs/providers/provider)

### (Simple, constant) Provider
Wir brauchen irgend ein Ding.
```Dart
class CookieRepository {...}

// Give us a CookieRepository
final cookieRepositoryProvider = Provider<CookieRepository>((ref) {
  return CookieRepository();
});
```

### State Provider
Wir brauchen ein Ding mit Zustand der von aussen geändert werden kann.
```dart
// The value type is int, the start value 0
final CounterProvider = StateProvider<int>((ref) => 0);
```

### StateNotifier<>
Eine überwachbare (observable) Klasse mit einem einzigen unveränderlichen (immutable) Wert.
```dart
// An observable List of Cookies
final cookieStateNotifier = StateNotifier<List<Cookie>>((ref) {});
```

### AsyncValue
AsyncValue ist ein Wrapper um irgendwelche Daten. Er enthält einer der drei Werte: loading, value, error.  
Wir können anschliessend das angezeigte Widget aufgrund dieses Wertes bestimmen:

```dart
// cookieService provides an AsyncValue<List<Cookie>>
cookieService.when(
    // While the data is loading, show a progress indicator
    loading: () => const Center(
        child: CircularProgressIndicator(),
    ),
    // we have data, show the cookie list
    data: (cookies) {
        return CookieListWidget(cookies);
    },
    // If data retrieval got an error, show an error screen
    error: (error, stackTrace) {
        return CookieErrorWidget(
        'Error loading Cookies');
    },
),
```

## Gebrauch von Provider
Damit wir in unserer Widget-Hierarchie auf unsere Provider zugreiffen können, müssen wir unsere Hierarchie in einen ``ProviderScope`` einwickeln.

```dart
void main() {
  runApp(
    ProviderScope( // <- Scope to provide providers
      child: const MyApp(),
    ),
  );
}

```

Alle Widgets die sich Dinge aus dem ``ProviderScope`` besorgen wollen, sollten von ``ConsumerWidget`` abgeleitet werden:

```dart
class CookiePage extends ConsumerWidget {
    ...
}
```

Anschliessend können wir uns innerhalb der Build-Funktion einen passenden Provider besorgen.

```dart
@override
  Widget build(BuildContext context, WidgetRef ref) {
    // We watch on the cookieServiceProvider. If its value changes,
    // the Widget will rebuild itself automatically
    final cookieService = ref.watch(cookieServiceProvider);

    return ... ;
}
```

## Provider: watch vs. read
Ein letztes Problem haben wir noch.  
Stellen sie sich vor dass wir einen ``CookieOfTheDayService`` haben. 

```dart
class CookieOfTheDayService extends StateNotifier<AsyncValue<Cookie?>> {

  Future<void> generateCookieOfTheDay() async { ... }
}
```
Er hat trägt ein ``Cookie`` oder ``null`` mit sich herum. Zudem hat er eine Funktion ``generateCookieOfTheDay()``, mir der wir ein neues ``Cookie`` verlangen können. Wir möchten diesen Service auf zwei Arten benutzen. Eimal als überwachte Datenquelle, welche bei Änderungen ein Neuzeichnen auslöst und einmal als Service um ein neues 'Cookie of the Day' zu verlangen.  
Zu diesem Zweck stehen uns ``watch`` und ``read`` zur Verfügung.
- ``watch`` reagiert auf Änderungen mit einem Rebuild des Widgets
- ``read`` liest nur den Wert, ohne auf Änderungen zu reagieren
- ``read(anyProvider.notifier)`` gibt uns die Unterliegende Datenstruktur zurück, so dass wir die dort vorhandene Funktionalität benutzen können.

```dart
/// Displays the Cookie of the Day
class CookiePage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final cookieOfTheDayService = 
      ref.watch(                      // <- watch to redraw if
                                      // the cookie of the day 
                                      // changes
        cookieOfTheDayServiceNotifierProvider
    );

    return Scaffold(
        ...
      ),
      body: GestureDetector(
        onTap: () {
          ref.read(                   // <- read the notifier
            cookieOfTheDayServiceNotifierProvider.notifier
          ).generateCookieOfTheDay(); // <- and use it to 
                                      //    generate a new Cookie
        },

        child: Center(
          child: cookieOfTheDayService.when(
            ... // Show the Cookie
          ),
        ),
    );
  }

```
