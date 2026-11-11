# API-dokumentation

## Användarbehov
Besökaren ska kunna se tillgängliga evenemang för att hitta något intressant att delta i.
## Bas-URL och endpoint
Bas-URL: http://localhost:5043
Endpoint: /api/events
## HTTP-metod
GET – används för att hämta evenemang från API.
## Exempel på svar
Exempel från JSON-array med evenemang.

-id: 1

-title: "Kodkväll för nybörjare"

-description: "En kväll med enkla programmeringsövningar."

-startsAt: "2026-12-02T18:00:00+01:00"

-category: "Teknik"

-organizer: "Kodföreningen"

-venue: "Kulturhuset, Stockholm"
## Fält som används
-title – evenemangets namn.

-description – beskrivning av evenemanget.

-startsAt – datum och tid.

-category – evenemangets kategori.

-organizer – arrangör.

-venue – plats.

id används för att identifiera varje evenemang.
## Loading-, empty-, success- och error-läge
-Loading: visar paragraf att datan försöker att hämtas och laddas.

-Empty: meddelar en paragraf att ingen evenemang finns i JSON-filen.

-Success: paragraf som visar antal evenemang, och vilka evenemang det är.

-Error: visar felmeddelande i paragraf.

## Säkerhets- och integritetshänsyn

## Kända begränsningar
Informationen som finns för evenemang är testexempel, och är fiktiva. Dessutom är det beroende på en extern API.

