# Normalisering – från ER-modell v1 till v2

## Avgränsning och underlag
- Team: Team Malmö
- Vald del av projektet: Hela ER-diagrammet och vår konceptuella databas ska granskas i detta dokument.
- Tabeller som granskas: Besökare, Evenemang, Anmälning, Arrangör, Kategori
- Antaganden och verksamhetsregler: [exempelvis om samma kombination får förekomma flera gånger]
- Före-modell v1: [länk till diagram eller fil]
- Efter-modell v2: [länk till diagram eller fil]
- Exempeldata: [länk till delat kalkylark eller normalisering-exempel.xlsx]

## 1. Före-läge – v1
| Tabell | Vad representerar en rad? | Primärnyckel (PK) | Främmande nycklar (FK) |
| --- | --- | --- | --- |
| [tabellnamn] | [beskrivning] | [kolumn eller kombination] | [kolumn → refererad tabell och kolumn] |

### Exempeldata och upprepning
- Exempelrader finns i: [flikar med prefixet v1_]
- Nödvändigt upprepade id för kopplingar: [ange vilka]
- Duplicerade beskrivande fakta eller listor: [ange vilka, eller förklara varför de saknas]

### Situationer att testa
Välj minst två situationer. Ange berörda tabeller och id.
1. [lägg till, ändra eller ta bort – exakt vad?]
2. [lägg till, ändra eller ta bort – exakt vad?]

## 2. Kontroll av normalformer
### 1NF
- Kontroll: ett värde per cell, inga listor eller upprepade kolumngrupper och identifierbara rader.
- Vår bedömning och motivering: [ange konkreta kolumner och nycklar]
- Ändring eller verifiering: [vad ändrades eller varför kan strukturen behållas?]

### 2NF
- Kandidatnycklar som kontrollen utgår från: [ange nycklar och vilka regler som gör dem unika]
- Finns icke-nyckelattribut som beror på bara en del av en sammansatt kandidatnyckel? [beskriv, eller förklara varför inte]
- Ändring eller verifiering: [vad ändrades eller varför kan strukturen behållas?]

### 3NF
- Finns icke-nyckelattribut som beror på nyckeln via andra icke-nyckelattribut? [ange eventuell beroendekedja]
- Ändring eller verifiering: [vad ändrades eller varför kan strukturen behållas?]

## 3. Efter-läge – v2
| Tabell | Ansvar | PK | FK och refererad tabell |
| --- | --- | --- | --- |
| [tabellnamn] | [vilken information lagras här?] | [nyckel] | [referens] |

### Motiverade beslut
- Vi ändrade [struktur] eftersom [beroende eller problem].
- Vi behöll [struktur] eftersom [motivering].
- Kopplingarna från v1 bevaras genom [främmande nycklar].
- Samma information finns i v2-flikarna, men [beskriv eventuell ny placering].

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
- Kvarstående frågor eller antaganden att kontrollera: [ange vilka, eller inga]