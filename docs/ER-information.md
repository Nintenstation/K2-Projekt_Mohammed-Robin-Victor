# Databasmodell

Relational database (SQL database)

## Entiteter & attribut

Registrations:
	PkRegistrationId
	FkEventId
	FkAttendeeId
	- RegistrationDate
	- Quantity

Events:
	PkEventId
	FkOrganizerId
	FkCategoryId
	- Title
	- Description
	- EventDate
	- EventTime
	- Location
	- Price
	- Capacity
	- CoverImageUrl
	- LastUpdated

Categories:
	PkCategoryId
	- Name

Organizer:
	PkOrganizerId
	- Name
	- Phone
	- Email

Attendees:
	PkAttendeeId
	- Name
	- Phone
	- Email

## Viktiga relationer & antaganden

**Registrations**: En eller flera anmälningar måste vara kopplad till en besökare, och en eller flera anmälningar måste vara kopplad till en 
evenemang. Använd detta som kopplingsentitet mellan Attendees och Events, eftersom Attendees och Events har M:N relationer. 
(Attendees **1:N** Registrations, Registrations **N:1** Eveents). **MANDATORY** relation med Attendees och Events. 

**Events & Attendees:** En besökare kan anmäla sig till många evenemang och ett evenemang kan ha många besökare. Därför har Attendees och 
Events en M:N-relation som löses genom Registrations.
(Attendees **M:N** Events <-- Problem!). Events: **OPTIONAL** relation med Registrations & Categories, **MANDATORY** relation med Organizer. 

**Categories:** En kategori kan ha noll eller många evenemang, men varje evenemang måste tillhöra exakt en kategori. (Categories 1:N Events).
**OPTIONAL** relation med Events. 

**Organizer:** En arrangör kan ansvara för noll eller många evenemang, men varje evenemang måste ha exakt en arrangör. (Arrangör 1:N Events).
**OPTIONAL** relation med Events.

## Öppna frågor

- Vem skapar evenemang?
- Kan arrangören också anmäla sig till ett evenemang?
- Hur förhindrar vi dubbla anmälningar av samma besökare?
- Kan det finnas fler evenemang med samma detaljer?
- Vilka uppgifter behöver vi lagra om besökare?
- Vilka uppgifter behöver vi lagra om arrangören?
