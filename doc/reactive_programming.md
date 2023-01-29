# Reactive Programming
Wir haben das Problem, dass wir in Flutter Daten haben und dass Datenänderungen im Allgemeinen eine Änderung der Darstellung zur Folge haben.  
Wie lösen wir das?

## Model, View, Controller (MVC)
Klassisch wurde das Problem folgendermassen gelöst:  
- Das Model enthält alle Daten und die Fuktionalität der Applikation, welche die Daten verändert. Jede **View** die an Datenänderungen interessiert ist, **meldet sich beim Model an**.  
- Jedes mal wenn das Model Datenänderungen auslöst, informiert es die interessierten **Views**. Diese besorgen sich bim Model die Daten und **zeichnen sich selber neu**.   
- Benutzerinteraktionen mit den Views werden von diesen erkannt und an den Controller weitergeleitet. Der Controller interpretiert die Benutzerinteraktionen und schickt passende Befehle ans Model.

## Reactive Programming (in Flutter)
Flutter funktioniert **nicht** wie MVC.  
Alle Views sind Widgets. Ein Widget ist nur eine Beschreibung was auf den Bildschirm gezeichnet werden soll. **Widgets können sich nicht selber zeichnen**. Jedes mal wenn eine Datenänderung eine Darstellungsänderung zur Folge hat, **wird ein neues Widget erstellt** und an Stelle des alten angezeigt.

Das bringt uns zum Problem, wer weis Bescheid wann ein neues Widget erstellt und angezeigt werden muss.  

Stellen sie sich vor wir haben Daten die wir visualisiern wollen. Ein gutes Wort für diese Daten ist Zustand (State).  
- Die Views benützen den Zustand für ihre Darstellung.
- Irgend Jemand weis, welche View welchen Zustand benutzt für seine Anzeige.
- Zustände können sich melden wenn sie geändert wurden

Dann ist es problemlos möglich, dass irgend Jemand die betroffenen Widgets neu erstellt und an der Stelle der alten anzeigt.

Ich denke, das ist eine gute Art sich Reactive Programming vorzustellen.
