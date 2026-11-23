# Normalisering – från ER-modell v1 till v2

## Avgränsning och underlag
- **Team**: Team Malmö
  
- **Vald del av projektet**: Hela ER-diagrammet och vår konceptuella databas ska granskas i detta dokument.
  
- **Tabeller som granskas**: Besökare, Evenemang, Anmälning, Arrangör, Kategori
  
- **Antaganden och verksamhetsregler**: Besökare kan anmäla sig till flera evenemang. En arrangör kan ansvara för flera evenemang. Varje evenemang måste ha
  en kategori och en arrangör. Besökare måste ange kontaktuppgifter (namn, mejl, telefon) för att kunna göra en anmälning till en evenamng. Varje entitet ska
  kunna identifieras, genom att varje entitet har en unik primärnyckel för varje rad i deras tabell.
  
- **Före-modell v1**: https://i.imgur.com/trrsygo.png
- **Efter-modell v2**: https://i.imgur.com/trrsygo.png
- **Exempeldata**: https://imgur.com/a/sWEdAzD

## 1. Före-läge – v1
| Tabell | Vad representerar en rad? | Primärnyckel (PK) | Främmande nycklar (FK) |
| --- | --- | --- | --- |
| Attendees | En rad representerar vilka besökare som har anmält sig och på det sättet deltagit i webbapplikationen. | AttendeeID | (Ingen) |
| Registrations | En rad representerar en anmälning som besökare har gjort och vilken eller vilka evenemang de har anmält sig till. | RegistrationID | AttendeeID & EventID |
| Events | En rad representerar vilket evenemang den är och dess information. | EventID | CategoryID & OrganizerID |
| Categories | En rad representerar en viss kategori och dess namn. | CategoryID | (Ingen) |
| Organizer | En rad representerar arrangören och deras kontaktuppgifter (namn, mejl, telefon). | OrganizerID | (Ingen) |

### Exempeldata och upprepning
- Exempelrader finns i: https://imgur.com/a/sWEdAzD
- Nödvändigt upprepade id för kopplingar: OrganizerID är en upprepande koppling, men detta kan betraktas som nödvändigt både på grund av att varje evenemang behöver en arrangör, samt att en arrangör kan ansvara för flera evenemang.
- Duplicerade beskrivande fakta eller listor: Detta saknas för icke-nyckel kolumner. Dock repeteras främmande nyckel, men det är inget problem när det endast refererar till en viss entitet i en seperat tabell som kommer faktiskt minska redundans och anomalier långsiktigt. 

### Situationer att testa
Situationer som vi har testat för att undersöka normaliseringen och risken för anomalier i vår databas:

1. **Insertion anomaly**: Vi har testat att göra en insättning i Events tabellen, och upptäckte att ingen anomali skedde. Detta är på grund av att databasen är normaliserat, på ett sätt att en existens av en entitet ska inte direkt kräva att data fylls för en annan entitet. Om vi ville sätta in data i Title-kolumnen så kommer det inte tvinga oss att fylla in data för en anmälning som inte finns (då existensen av en evenemang är inte beroende av att en anmälning kopplad till den görs, samt att tabellerna är uppdelade).

2. **Update anomaly**: Om man ska uppdatera en viss attribut för en viss entitet, behöver man modifiera steg-för-steg alla data celler i alla rader där detta sker? Tack vare den minskade redundansen som vi har uppnått med vår tabell genom normalisering så är denna uppdateringsanomali inget problem. Om man exempelvis ändrar namnet på en viss arrangör i Organizer tabellen (som används flera gånger i Events tabellen genom främmande nyckel) så kommer det automatiskt uppdateras överallt där det refereras. Man behöver inte manuellt ändra alla data celler där det nämns, vilket medför risk för inkorrekt data och förvärrad säkerhet och integritet.

3. **Deletion anomaly**: Om vi tog bort en viss rad, som i evenemang tabellen, så kommer man inte att råka ta bort viktigt data, som datan för en annan entitet. Exempelvis skulle en enda instans av arrangören och deras data förekomma på evenemang tabellen så kommer denna arrangören inte att raderas i vår databas om man tar bort raden i Events tabellen. Istället finns arrangören på en säker plats i en seperat Organizer tabell, som kommer att finnas kvar och kan användas igen som en främmande nyckel.

## 2. Kontroll av normalformer
### 1NF
- Kontroll: ett värde per cell, inga listor eller upprepade kolumngrupper och identifierbara rader.
- Vår bedömning och motivering: Varje tabell har deras egna primära nyckel, som kan identifiera unika rad och förhindra duplicering. Kolumner i namn och datatyp är inte upprepat i samma tabell, och varje data cell har ett atomsikt värde.
- Ändring eller verifiering: Inget ändrades förutom att vi råkade skapa en duplikation av en rad i person

### 2NF
- Kandidatnycklar som kontrollen utgår från: Vi hade inga sammansatta nycklar i vår konceptuella databas
- Finns icke-nyckelattribut som beror på bara en del av en sammansatt kandidatnyckel?: Nej, det skedde inga partiella beroenden i någon av tabellerna. Istället hade varje tabell sin egen primärnyckel.
- Ändring eller verifiering: Inget ändrades.

### 3NF
- Finns icke-nyckelattribut som beror på nyckeln via andra icke-nyckelattribut?: Alla icke-nyckel attribut var beroende på en primärnyckel som identifierade dem. Våra tabeller var relativt enkla och behövde inte större kedjor mellan tabellerna, förutom främmande nycklar.
- Ändring eller verifiering: Strukturen kan behållas eftersom alla attribut var direkt beroende av en primärnyckel, istället att vara endast indirekt beroende.

## 3. Efter-läge – v2
| Tabell | Vad representerar en rad? | Primärnyckel (PK) | Främmande nycklar (FK) |
| --- | --- | --- | --- |
| Attendees | En rad representerar vilka besökare som har anmält sig och på det sättet deltagit i webbapplikationen. | AttendeeID | (Ingen) |
| Registrations | En rad representerar en anmälning som besökare har gjort och vilken eller vilka evenemang de har anmält sig till. | RegistrationID | AttendeeID & EventID |
| Event | En rad representerar vilket evenemang den är och dess information. | EventID | CategoryID & OrganizerID |
| Category | En rad representerar en viss kategori och dess namn. | CategoryID | (Ingen) |
| Organizer | En rad representerar arrangören och deras kontaktuppgifter (namn, mejl, telefon). | OrganizerID | (Ingen) |

### Motiverade beslut
Vi behöll strukturen på grund av att databasens struktur i denna konceptuella diagram var relativt enkla, men också att varje attribut och rad hade direkt och unik koppling med deras respektiva primär nyckel i deras tabell. För att kunna lagra data för en webbapplikation som hanterar evenemang tänkte vi att det skulle inte kräva för mycket information och entiteter för en sådan avgränsad applikation. Då fanns det minskad risk för redundans och anomalier. En annan skäl varför efter-läget är oförändrat är på grund av att denna version är baserad på ett annat ER-diagram som vi har arbetat med och diskuterat. Vi har redan försökt normalisera så mycket som möjligt i den andra diagrammet, vilket vi använde som underlag i det här arbetet.

## 4. Testresultat
Exempel på tester som har gjorts:

| Insättning i Events tabell | Ska kunna göra det utan att behöva skapa annat info för en annan entitet | Man kunde skapa ny information för en evenemang utan att vara påtvingat att fylla i information för en annan entitet (som Organizer). | V1 fungerade i testen. |
| Uppdatering i Organizer tabellen på Name column | Namnet ska kunna uppdateras utan anomalin där man behöver steg för steg modifiera och uppdatera den överallt när värdet används flera gånger. | Man kunde uppdatera en viss arrangörs namn i Name column utan att man behövde uppdatera den överallt manuellt, vilket medför risker för fel och misstag. | V1 fungerade på grund av användning av främmande nycklar för att referera till en rad i Organizer, då låter den ett värde uppdateras överallt. |

## 5. Sammanfattning och kvarstående frågor
- Viktigaste slutsatsen: Granskningen visar hur viktigt det är att arbeta med den konceptuella och arkitektoniska sidan av relationsdatabas-design, eftersom det förebygger och förminskar risk för anomalier och data korruption redan innan databasen implementeras i en hanterare och SQL-queries. Det är tack vare arbete med entitetsrelationer och diagram som V1-läget blev bra.
- Minskad redundans eller undvikna anomalier: Minskad redundans och anomalier vid insättning, uppdatering, och radering.
- **Kvarstående frågor eller antaganden att kontrollera**: "Vi behöver verifiera “antal besökare” och hur det ska hanteras om ett evenemang har begränsade platser.
".
