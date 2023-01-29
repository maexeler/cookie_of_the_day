# Archidetktur

Wir brauchen einen anständigen Aufbau unserer Applikation.  
Für eine gute Übersicht über das Problem empfehle ich den Artikel [Flutter App Architecture with Riverpod: An Introduction](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/) von Andrea.

Wir werden unser App mittels Model, Repository, Service und Data-Provider strukturieren.

# Model
Als Erstes brauchen wir 'Business Objects', in unserem Fall Cookie's.  
Business Objekte stellen die Essenz unserer Applikation dar. Sie bilden das Model.

Wir werden die Modelklassen als unveränderliche Klassen implementieren. Das bedeuted, dass wir, wenn wir eine Klasse verändern wollen, erstellen wir einfach eine Kopie aus einem Mix von alten und den neuen Daten.
Das wird sich als sehr praktisch erweisen in verbindung mit den Providerklassen.

# Repository
Repositories ermöglichen uns den Zugriff auf unsere Model-Daten. Sie implementieren die Idee eines 'Data-Stores' und müssen die CRUD[^1] Bedingungen erfüllen.
Repositories werden im Allgemeien nicht direkt benutzt von der Applikation.

# Service
Services bieten uns die Funktionalität die wir benötigen in unserer App. Sie kappseln die 'Business Logic' und vermitteln zwischen den Data-Provider und den Repositories.  
Grundsätzlich gilt: Die App spricht mit den Service, der Service mit dem Repository. Datenänderungen werden durch überwachung des Service ausgelöst.

# Provider
Provider haben zwei Aufgabe. Einersets geben sie uns Dinge (Services) die wir benutzen können um den Zustand unserer App zu verändern, Andererseits können sie das GUI informiert halten darüber, dass sich der Zustand der App geändert hat und dass ein Neuzeichnen angebracht ist.

## MVC
In MVC[^2] ist der Ablauf so, dass eine Interaktion im GUI eine Controller-Funktion aufruft. Diese benutzt die Applikation um den Zustand der Applikation zu verändern. Die Applikation benachrichtigt dann alle Views (Observer) dass der Zustand geändert hat. Die Views besorgen sich dann die neuen Daten bei der Applikation und zeichnen sich selbst neu.

## Reactive Views
Im Unterschied zu MVC-Views zeichnen sich Reactive-Views nicht neu. Wenn eine Zustandsänderung stattgefunden hat, welche die View betrifft, wird die ganze View neu erstellt und angezeigt.
Schön, aber wer weis dass die View neu erstellt werden muss?

In Flutter können wir das Problem auf der niedrigsten Stuffe mit ```setState(...)``` lösen (wollen wir aber nicht). Weiter existiern duzende von [Bibliotheken](https://docs.flutter.dev/development/data-and-backend/state-mgmt/options) die helfen dieses Problem anzupacken.

### Riverpod & Hooks
Zum Verwalten des globalen Zustandes werden wir [Riverpod](https://riverpod.dev) verwenden, und für das Verwalten von lokalen Zuständer in einer View werden wir [Hooks](https://pub.dev/packages/flutter_hooks) benutzen.
Die Wahl dieser beiden Bibliotheken ist etwas Geschmackssache, sie sind aber im Moment absolut 'State of the Art'.



### Footnotes
[^1]: Create, Read, Update, Delete  
[^2]: Model, View, Controller