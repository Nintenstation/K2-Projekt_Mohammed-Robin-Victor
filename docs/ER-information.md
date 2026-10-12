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
	- Gatuadress
	- Mejl

## Viktiga relationer & antaganden

**Anmälning**: En eller flera anmälningar måste vara kopplad till en besökare, och en eller flera anmälningar måste vara kopplad till en 
evenemang. Använd detta som kopplingsentitet mellan Besökare och evenemang, eftersom besökare och evenemang har M:N relationer. 
(Besökare **1:N** Anmälning, Anmälning **N:1** Evenemang). **MANDATORY** relation med Besökare och Evenemang. 

**Evenemang & Besökare:** En besökare kan anmäla sig till många evenemang och ett evenemang kan ha många besökare. Därför har Besökare och 
Evenemang en M:N-relation som löses genom Anmälning.
(Besökare **M:N** Evenemang <-- Problem!). Evenemang: **OPTIONAL** relation med Anmälning & kategori, **MANDATORY** relation med arrangör. 

**Kategori:** En kategori kan ha noll eller många evenemang, men varje evenemang måste tillhöra exakt en kategori. (Kategori 1:N Evenemang).
**OPTIONAL** relation med evenemang. 

**Arrangör:** En arrangör kan ansvara för noll eller många evenemang, men varje evenemang måste ha exakt en arrangör. (Arrangör 1:N Evenemang).
**OPTIONAL** relation med evenemang.

## Öppna frågor

- Vem skapar evenemang?
- Kan arrangören också anmäla sig till ett evenemang?
- Hur förhindrar vi dubbla anmälningar av samma besökare?
- Kan det finnas fler evenemang med samma detaljer?
- Vilka uppgifter behöver vi lagra om besökare?
- Vilka uppgifter behöver vi lagra om arrangören?