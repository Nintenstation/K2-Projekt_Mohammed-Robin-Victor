# Databasmodell

Relational database (SQL database)

## Entiteter & attribut

Anmälning:
	PkAnmälningId
	FkEvenemangsId
	FkBesökareId
	- Anmälningsdatum
	- AntalPlatser

Evenemang:
	PkEvenemangId
	FkArrangörId
	FkKategoriId
	- Titel
	- Beskrivning
	- Datum
	- Tid
	- Plats
	- Pris

Kategori:
	PkKategoriId
	- Namn

Arrangör:
	PkArrangörId
	- Namn
	- Telefonnummer
	- Mejl

Besökare:
	PkBesökareId
	- Namn
	- Telefon
	- Gatuaddress
	- Mejl

## Viktiga relationer & antaganden

**Anmälning**: En eller flera anmälningar måste vara kopplad till en besökare, och en eller flera anmälningar måste vara kopplad till en 
evenemang. Använd detta som kopplingsentitet mellan Besökare och evenmang, eftersom besökare och evenemang har M:N relationer. 
(Besökare **1:N** Anmälning, Anmälning **N:1** Evenemang). **MANDATORY** relation med Besökare och Evenemang. 

**Evenemang & Besökare**: En eller flera besökare kan vara på en evenemang, men många evenemang kan innehålla flera besökare också. 
(Besökare **M:N** Evenemang <-- Problem!). Evenemang: **OPTIONAL** relation med Anmälning & kategori, **MANDATORY** relation med arrangör. 

**Kategori**: En kategori kan tillhöra många evenemang, men evenemang kan endast ha en kategori. (Kategori **1:N** Evenemang). 
**OPTIONAL** relation med evenemang. 

**Arrangör**: En arrangör kan ansvara för många evenemang, men evenemang kan endast ha en enda arrangör. (Arrangör **1:N** Evenemang). 
**OPTIONAL** relation med evenemang.

## Öppna frågor

- Vem skapar evenemang?
- Kan arrangören också anmäla sig till ett evenemang?
- Hur förhindrar vi dubbla anmälningar av samma besökare?
- Kan det finnas fler evenemang med samma detaljer?
- Vilka uppgifter behöver vi lagra om besökare?
- Vilka uppgifter behöver vi lagra om arrangören?