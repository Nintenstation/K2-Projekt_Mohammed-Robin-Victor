# API-dokumentation

## Användarbehov
Besökaren ska kunna se tillgängliga evenemang för att hitta något intressant att delta i.

## Bas-URL och endpoint
Bas-URL: http://localhost:5043
Endpoint: /api/events

## HTTP-metod
GET – används för att hämta evenemang från API.

## Förväntad HTTP-respons
Följande text borde async funktionen skriva ut beroende på statuskoden i HTTP-responsen:

-Status kod: 200–299 (lyckat svar): JavaScript visar listan med fiktiva evenemang från API, om det finns några.

-Tom lista: Om det inte finns några evenemang visas ett meddelande som förklarar att inga evenemang finns.

-Status kod: 400–499: "Evenemang kunde inte hämtas! Försök igen.".

-Status kod: 404: Visar meddelandet "Evenemangen kunde inte hittas".

-Status kod: 500–599: Visar meddelandet "Det förekom fel i servern. Försök igen senare!". 

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

-Empty: skriver ut i en paragraf att ingen evenemang finns.

-Success: paragraf som visar antal evenemang, och vilka evenemang det är.

-Error: visar felmeddelande i paragraf.

## Testfall
Loading sker inför tryck på knapp med event listener som är kopplad till async funktionen. /api/events endpoint skriver ut lista av
evenemang. /api/test/empty endpoint gör så att paragrafen skriver ut att listan är tom. /api/events/9999 ger felmeddelande för statuskod 404
och api/test/error ger felmeddelande för statuskod mellan 500 och 599.

## Säkerhets- och integritetshänsyn
Knappen för att hämta JSON-data från API:n kommer att kopplas av under exekveringen (alltså när själva event-listener kommer att märka av
input). Sedan kopplas det igen efter exekvering är slut, oavsett om HTTP-responsen ger fel eller en lyckad resultat. Denna mekanism är
inkluderad för att användaren kommer inte råka klicka igen och återställa funktionen som exekveras, eller att onöding information hämtas.

Samtidigt innehåller denna externa API:n inga känsliga eller personliga information. Det förekommer inga nycklar eller token när API:n framkallas och producerar
resultat på frontend-sidan. Inget av informationen innehåller känslig data som kan skada användaren.

## Kända begränsningar
Informationen som finns för evenemang är testexempel, och är fiktiva. Dessutom är det beroende på en extern API.

