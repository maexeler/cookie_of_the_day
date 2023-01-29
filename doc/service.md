# Cookie Services
Wir haben zwei verschiedene Cookie Services, der eine verwaltet die Liste aller vorhandenen Cookies, der andere das 'Cookie des Tages'

## Eigenschaften
- Beide Services haben jeweils einen Wert, welchen wir überwachen wollen und Funktionalität die wir benutzen wollen um den Wert zu verändern
- Beide Services sind asynchron

Das heisst, beide Sevices sind vom Typ ``StateNotifier<AsyncValue<...>>``

# CookieOfTheDayService

Der ``CookieOfTheDayService`` gibt uns das aktuell 'Cookie of the Day' oder null zurück falls wir keinen Cookie haben.  
Mit der Funktion ``generateCookieOfTheDay()`` können wir ein neues Cookie anfordern.

Die Implementierung finden sie in: [cookie_of_the_day_service.dart](../lib/service/cookie_of_the_day_service.dart)

# CookieService

Der ``CookieService`` gibt uns eine Liste von Cookies zurück.  
Die Funktionen ``add``-, ``delete``- und ``updateCookie()`` dienen der Verwaltung unserer Cookie-Liste.

Die Implementierung finden sie in: [cookie_service.dart](../lib/service/cookie_service.dart)