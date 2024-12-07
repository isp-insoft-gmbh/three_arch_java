% Server Architekur, ein Überblick
% Oliver Jan Krylow
% 25.08.2024

# Überblick

## Server-Architekturen

Eine kleine Studie zu 3 verschiedenen Architekturen und deren Konsequenzen.

- Layered Services (LS)
- Entity-Component-System (ECS)
- Functional Core - Imperative Shell (FCIS)

::: notes

- Layered Services ist bekannt aus APM/KKG6.
- ECS wird häufig bei Spielen verwendet.
- FCIS kommt aus dem Funktionalen Paradigma.

:::

## Bewertungskriterien

- vereinfacht
- __Testbarkeit__
- __Performance__

::: notes

- Vereinfachte Bewertung um den Rahmen durchführbar zu halten
- Testbarkeit als Proxy für Wartbarkeit
- Performance vereinfacht gemessen in Microbenschmarks

:::

## Glossar

Eine unvollständige Liste von Konzepten, die in einer Serverapplikation auftreten.

- __Identität__ (identity) Wer?
- __Daten__ (data) Was?
- __Verhalten__ (behaviour) Wie?
- __Ereignisse__ (events) Warum?
- __Persistenz__ (persistence) Wo und wie lange?
- __Lebenszyklus__ (lifecycle) Wann?

::: notes

Diese Konzepte tauchen in irgendeiner Form in __jeder__ Serverarchitektur auf.
Wie man diese jedoch strukturiert, hat Einfluss auf alle wichtigen Aspekte einer
Appliaktion.

Die Liste hat keinen Anspruch auf Vollständigkeit!

:::

## Identität, die

Echtheit einer Person oder Sache; völlige Übereinstimmung mit dem, was sie ist oder als was sie bezeichnet wird

## Ein Name

- eindeutig
- addressierbar → global auffindbar

::: notes

Namen tauchen überall in Java auf.

- Klassen
- Schnittstellen
- Pakete

:::

## Anonymität

::: notes

Anonyme Sprachkonstrukte kommen aus der Welt der funktionalen und/oder dymaischen Sprachen.
Einige wurden mit der Zeit in Java integriert.
Aber Java bleibt dennoch vorrangig eine __nominale Porgrammiersprache__.

:::

## Anonyme Klasse

`class TheThing { ... }`

statt

`new Object() { ... }`

## Maps

_POJO_

statt

`Map<String, Object>`

## Lambdas

`class TheMakerOfThings impements Runnable { ... }`

statt

`() -> { ... }`

## Tuples (*)

`record WrapperOfThings( String name, int amount, float percent) {}`

statt

`(String, int, float)`

::: notes

*: gibt es noch nicht in Java

:::

## Java setzt den Fokus auf Namen

Und deshalb tun dies Frameworks in diesem Kontext häufig auch.

::: notes

Die folgenden Alternativen nutzen anonyme Konstrukte und fügen sich deshalb nicht natürlich in Java ein.
Andere Paradigem/Sprachen nutzen diese aber!

:::

## gRPC

- gRPC konvertiert dynamische Daten zu Klassen und Instanzen mit Code Generation.
- gPRC hätte auch "einfacher" mit _Reflection_ und/oder `Map<?,?>` arbeiten können

## Jackson

- Jackson (XML) erlaubt das Annotieren von Klassen und Feldern, und (de)serialiert dessen Instanzen
- Jackson hätte auch XML und JSON als `Map<String, Object>` einlesen können

## Hibernate

- Hibernate mappt SQL-Tabellen zu Klassen und deren Instanzen
- Stattdessen hätte sich auch eine Kultur entwickeln können, die direkte SQL-Queries bevorzugt

## Namen sind wichtig!

Aber hart!

- Manager
- Helper
- Factory
- Util
- Node
- Component

::: notes

Diese Namen sind typischerweise Symptome für das Abhandensein eines sinnvollen Namens.
Oder aber für abstrakte Konstrukte, die schwer in einzelne Worte zu fassen sind.

Anonyme sowie nominale Sprachkonstrukte habe jeweils ihre Vor- und Nachteile.

:::

## Datum, das

Faktum, das
: etwas, was tatsächlich, nachweisbar vorhanden, geschehen ist; unumgängliche Tatsache

::: notes

- Synonym: Faktum!
- Plural: Daten!

:::

## Zustand

- Wahrheit
- Zeitpunkt
- unveränderlich

::: notes

Fakten beschreiben den Zustand der Welt zu einem bestimmten Zeitpunkt.

:::

## Plain Old Java Objects

- Fakten als Felder einer Klasse
- mutabel! ( __setter__ und _getter_)
- Keine _normalen_ Methoden

::: notes

Damit POJOs als "Fakten" betrachtet werden können fehlen mindestens 2 Aspekte:

- Versionisierung (betrifft Schema/Klassen)
- Historisierung (betrifft Daten/Instanzen)

Frage: Wieso haben sich in der Java-Kultur POJOs etabliert, obwohl diese scheinbar
__nicht dem OO-Paradigma folgen__?

:::

## Verhalten, das

Art und Weise, wie sich ein Lebewesen, etwas verhält.

## Serververhalten

- Fähigkeiten
- Features
- Methoden und API

::: notes

Hier schlummern auch die Konzepte "Kommunikation" und "Systemintegration" drin.
Diese hätten mit Leichtigkeit eigene Oberpunkte sein können.

Wenn das Verhalten Versioniert werden muss, überschneidet sich dies mit dem
Datenkonzept.

Frage: Wenn Daten und Verhalten fundamental verzahnt zu sein scheinen, wieso wurden
diese voneinander getrennt? OOP würde klassischerweise Daten und Verhalten kombinieren
(Felder und Methoden).

:::

## Ereignis, das

besonderer, nicht alltäglicher Vorgang, Vorfall; Geschehnis

## Serverevents

- Anfrage (request)
- Antwort (response)
- synchron oder asynchron
- häufig oder selten
- uni- oder bidirectional

::: notes

Egal ob die Clients Maschinen oder Menschen sind.
Server kann Ereignisse durch Aktionen erzeugen und auf Ereignisse mit Reaktionen
reagieren.

:::

## Persistenz, die

das Bestehenbleiben eines Zustands über längere Zeit

## Persistenz in Java

gibt es nicht.

- Java Object Serializer ist kaputt
- JPA ist Teil von Jakarta und beschränkt sich auf ORM/relationale Daten
- [Towards better Serialization](https://openjdk.org/projects/amber/design-notes/towards-better-serialization)

::: notes

Brian Goetz, Chief Java Architect sagt: "Java’s serialization makes nearly every mistake imaginable".
Er hat einen Plan, um Serialisierung in Java zu verbessern.
:::

## Persistenz der Daten

Persistenz in __allen Programmiersprachen__ beschränkt sich auf Daten.

## Persistenz von Verhalten

Verhalten, aka Methoden, sinnvoll zu persistieren ist ein offenes Problem.

::: notes

Witzigerweise wissen wir, wie man Methoden effizient kodiert und versioniert.

Quellcode + VCS!

Aber keiner weiss, wie man in komplexen Systemen, dies zur Laufzeit und mit hunderten
von transitiven Abhängigkeiten verlässlich schafft.

:::

## Lebenszyklus, der

periodischer Ablauf der Existenz von etwas

## Ein Server lebt lange

- start
- l∞p
- stop

::: notes

- Geburt
- Leben
- Tot

Der _loop_ ist der zentrale Koordinator!

- Initiert alle anderen Komponenten
- Ereignisse werden zwischengespeichert
- Zum gewünschten Zeitpunkt weitergereicht, um Verhalten auszulösen
- Orderly and/or graceful shutdown

:::

## Entwicklung

### "Business Logic"

- Identität
- Daten
- Verhalten

### "Framework"

- Ereignisse
- Persistenz
- Lebenszyklus

::: notes

Aus Sicht von Java-Entwicklern, werden die Konzepte häufig so gruppiert.

Framework kann auch Tool, Bibliothek oder OS sein.

:::

## Abandoned, but not forgotten

Wichtige Konzpete, die ausgelassen wurden.

- Kommunikation
- Systemintegration
- Einsicht (observability)
- Nachvollziehbarkeit (traceablilty)
- Robustheit
- Authentifizierung und Autorisierung

::: notes

Ausgelassen, um den Scope der Studie klein zu halten.
Beispiel, welchen Einfluss Systemintegration auf die Architektur haben kann:
Viele Dienste auf MacOS und Linux nutzen _Socket-Activation_.
D.h. der Dienst ist inaktiv, bis das System ein Ereigniss auf einem TCP Port oder
Socket registriert, um dann den Dienst zu starten. Relevante Daten werden über
die Kommandozeile weitergegeben.

In dieser Architektur, wurden Lebenszyklus und Ereignisse an das Betriebssystem
delegiert!

:::

# Layered Services (LS)
# Entity-Component-System (ECS)
# Functional Core - Imperative Shell (FCIS)
