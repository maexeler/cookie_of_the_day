# Cookie of the Day

Sie kennen sicher die Glückskekse die sie beim Chinesen nach dem Essen erhalten. Wenn sie diese aufbrechen, finden sie darin eine Chinesische Wahrheit.

Genau das wollen wir programmieren.

## Motivation
Dieses Beispiel versucht zu zeigen, was eine gute Flutter-Architektur ist und wie diese umgesetzt werden kann.

## Ziel
Unsere Applikation besteht aus den folgenden beiden Seiten:

Hauptseite | Verwaltung 
-------- | -------- 
![Hauptseite](./doc/pics/CookieOfTheDay.png "Hauptseite")   | ![Verwaltung](./doc/pics/CookieMaintenance.png "Verwaltung")   

## Funktionalität

### Cookie of the Day
Das Schütteln oder das berühren des Bilschirms gibt uns eine neue Weisheit.

### Cookie Verwaltung
Der obere Bereich ermöglicht es uns, ein neues Cookie hinzuzufügen. Das neue Cookie wird dann unmittelbar in der Liste der Vorhandenen Cookies angezeigt.

In der Cookie-Liste kann ein Cookie mit einer Swip-Geste nach links gelöscht werden.

Die Werte des selektierte Cookie können vor Ort geändert werden.

# Cookie of the Day Dokumentation
- [Installation der benötigten Bibliotheken](./doc/installation.md)
- [Übersicht Architektur](./doc/architecture.md)
- [Projektaufbau](./doc/project_layout.md)
    - [Model (Datenstrukturen)](./doc/model.md)
    - [Repository (Datenstore, CRUD)](./doc/repository.md)
    - [Reactive Programming](./doc/reactive_programming.md)
    - [State Management mit Riverpod](./doc/riverpod.md)
    - [Service](./doc/service.md)
    - Pages
        - [CookiePage](./doc/cookie_page.md)
        - [CookieListPage](./doc/cookie_list_page.md)

## Implementierung
Nach der [Installation der benötigten Bibliotheken](./doc/installation.md) erstellen wir den [Projektaufbau](./doc/project_layout.md) und implementieren eine erste einfache Version der [Startseite](./doc/cookie_page.md).  
Anschliessend erstellen wir uns die [Model-Datenstrukturen](./doc/model.md) und die [Repositories](./doc/repository.md).  
Nachdem wir die [Services](./doc/service.md) erstellt haben, kümmern wir uns um die [Data-Provider](./doc/provider_and_hooks.md) und verbinden diese mit der [Startseite](./doc/cookie_page.md).

Schlussendlich implementieren wir noch die [Verwaltungsseite](./doc/cookie_list_page.md)
