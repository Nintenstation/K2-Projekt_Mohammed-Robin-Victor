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
| Besökare | En rad representerar vilka besökare som har anmält sig och på det sättet deltagit i webbapplikationen. | BesökarID | (Ingen) |
| Anmälning | En rad representerar en anmälning som besökare har gjort och vilken eller vilka evenemang de har anmält sig till. | AnmälningsID | BesökarID & EvenemangID |
| Evenemang | En rad representerar vilket evenemang den är och dess information. | EvenemangID | KategoriID & ArrangörID |
| Kategori | En rad representerar en viss kategori och dess namn. | KategoriID | (Ingen) |
| Arrangör | En rad representerar arrangören och deras kontaktuppgifter (namn, mejl, telefon). | ArrangörID | (Ingen) |

### Exempeldata och upprepning
- Exempelrader finns i: https://imgur.com/a/sWEdAzD
- Nödvändigt upprepade id för kopplingar: Arrangör ID är en upprepande koppling, men detta kan betraktas som nödvändigt både på grund av att varje evenemang behöver en arrangör, samt att en arrangör kan ansvara för flera evenemang.
- Duplicerade beskrivande fakta eller listor: Detta saknas för icke-nyckel kolumner. Dock repeteras främmande nyckel, men det är inget problem när det endast refererar till en viss entitet i en seperat tabell som kommer faktiskt minska redundans och anomalier långsiktigt. 

### Situationer att testa
Situationer som vi har testat för att undersöka normaliseringen och risken för anomalier i vår databas:

1. **Insertion anomaly**: Vi har testat att göra en insättning i evenemang tabellen, och upptäckte att ingen anomali skedde. Detta är på grund av att databasen är normaliserat, på ett sätt att en existens av en entitet ska inte direkt kräva att data fylls för en annan entitet. Om vi ville sätta in data i titel-kolumnen så kommer det inte tvinga oss att fylla in data för en anmälning som inte finns (då existensen av en evenemang är inte beroende av att en anmälning kopplad till den görs, samt att tabellerna är uppdelade).

2. **Update anomaly**: Om man ska uppdatera en viss attribut för en viss entitet, behöver man modifiera steg-för-steg alla data celler i alla rader där detta sker? Tack vare den minskade redundansen som vi har uppnått med vår tabell genom normalisering så är denna uppdateringsanomali inget problem. Om man exempelvis ändrar namnet på en viss arrangör i arrangör tabellen (som används flera gånger i evenemang tabellen genom främmande nyckel) så kommer det automatiskt uppdateras överallt där det refereras. Man behöver inte manuellt ändra alla data celler där det nämns, vilket medför risk för inkorrekt data och förvärrad säkerhet och integritet.

3. **Deletion anomaly**: Om vi tog bort en viss rad, som i evenemang tabellen, så kommer man inte att råka ta bort viktigt data, som datan för en annan entitet. Exempelvis skulle en enda instans av arrangören och deras data förekomma på evenemang tabellen så kommer denna arrangören inte att raderas i vår databas om man tar bort raden i evenemang tabellen. Istället finns arrangören på en säker plats i en seperat arrangör tabell, som kommer att finnas kvar och kan användas igen som en främmande nyckel.

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
| Besökare | En rad representerar vilka besökare som har anmält sig och på det sättet deltagit i webbapplikationen. | BesökarID | (Ingen) |
| Anmälning | En rad representerar en anmälning som besökare har gjort och vilken eller vilka evenemang de har anmält sig till. | AnmälningsID | BesökarID & EvenemangID |
| Evenemang | En rad representerar vilket evenemang den är och dess information. | EvenemangID | KategoriID & ArrangörID |
| Kategori | En rad representerar en viss kategori och dess namn. | KategoriID | (Ingen) |
| Arrangör | En rad representerar arrangören och deras kontaktuppgifter (namn, mejl, telefon). | ArrangörID | (Ingen) |

### Motiverade beslut
Vi behöll strukturen på grund av att databasens struktur i denna konceptuella diagram var relativt enkla, men också att varje attribut och rad hade direkt och unik koppling med deras respektiva primär nyckel i deras tabell. För att kunna lagra data för en webbapplikation som hanterar evenemang tänkte vi att det skulle inte kräva för mycket information och entiteter för en sådan avgränsad applikation. Då fanns det minskad risk för redundans och anomalier. En annan skäl varför efter-läget är oförändrat är på grund av att denna version är baserad på ett annat ER-diagram som vi har arbetat med och diskuterat. Vi har redan försökt normalisera så mycket som möjligt i den andra diagrammet, vilket vi använde som underlag i det här arbetet.

## 4. Testresultat
Testerna görs manuellt i kalkylarket. De granskar modellen,
inte en implementerad databas eller automatiska PK/FK-regler.

| Situation och berörda id | Förväntat resultat | Resultat i v1 | Resultat i v2 | Slutsats |
| --- | --- | --- | --- | --- |
| [test 1] | [vad ska fungera?] | [vad hände?] | [vad hände?] | [förbättring eller varför v1 redan fungerade] |
| [test 2] | [vad ska fungera?] | [vad hände?] | [vad hände?] | [förbättring eller varför v1 redan fungerade] |

## 5. Sammanfattning och kvarstående frågor
- Viktigaste slutsatsen: [vad visar granskningen?]
- Minskad redundans eller undvikna anomalier: [konkret resultat]
- **Kvarstående frågor eller antaganden att kontrollera**: "Vi behöver verifiera “antal besökare” och hur det ska hanteras om ett evenemang har begränsade platser.
".
