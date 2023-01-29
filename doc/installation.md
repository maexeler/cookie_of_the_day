# Benötigte Bibliotheken
Wir wollen uns Code generieren lassen für die Modelklassen,  
benötigen Riverpod zum Bereitstellen von Daten,  
Bibliotheken für die Verwaltung von Unique-Id's und so weiter.

[Installieren](https://docs.flutter.dev/development/packages-and-plugins/using-packages#adding-a-package-dependency-to-an-app-using-flutter-pub-add) Sie die folgenden Bibliotheken:

Am Besten geht das, indem sie die folgenden Befehle in ihrem Terminal laufen lassen.

## Benötigt für die Applikation

flutter pub add flutter_hooks  
flutter pub add hooks_riverpod  
flutter pub add riverpod
flutter pub add flutter_riverpod  

flutter pub add freezed_annotation  
flutter pub add json_annotation  
flutter pub add uuid  

flutter pub add shared_preferences  
flutter pub add shake  
flutter pub add dio  

## Nur benötigt für die Applikationsentwicklung
flutter pub add  -d riverpod_generator  
flutter pub add  -d riverpod_annotation  
flutter pub add  -d freezed  
flutter pub add  -d json_serializable  
flutter pub add  -d build_runner  

Alternativ benutzen Sie die Funktionalität ihrer IDE.

