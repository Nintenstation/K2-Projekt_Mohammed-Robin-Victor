# Relationer 

Registrations: En eller flera anmälningar måste vara kopplad till en besökare, och en eller flera anmälningar måste vara kopplad till en evenemang. 
Använd detta som kopplingsentitet mellan Attendees och Events, eftersom besökare och evenemang har M:N relationer. 
(Besökare 1:N Registrations, Registrations N:1 Evenemang). MANDATORY relation med Attendees och Evenemang.

Events & Attendees: En besökare kan anmäla sig till många evenemang och ett evenemang kan ha många besökare. Därför har Attendees och Events 
en M:N-relation som löses genom Registrations. (Attendees M:N Events <-- Problem!). 
Events: OPTIONAL relation med Registrations & Categories, MANDATORY relation med Organizer.

Categories: En kategori kan ha noll eller många evenemang, men varje evenemang måste tillhöra exakt en kategori. 
(Categories 1:N Events). OPTIONAL relation med Events.

Organizer: En arrangör kan ansvara för noll eller många evenemang, men varje evenemang måste ha exakt en arrangör. 
(Organizer 1:N Events). OPTIONAL relation med Events.

# Verksamhetsregler & exempel på relationer

### Verksamhetsregler

1. Besökare kan anmäla sig till fler evenemang.
2. Arrangör kan ansvara sig för fler evenemang.
3. Varje evenemang måste ha kategori och arrangör.
4. Besökare måste ange kontaktuppgifter vid anmälning (namn, mejl, telefonnummer)
5. Varje entitet behöver ha en huvudnyckel för att identifieras och användas vid hantering.

### Exempel på relationer

**En obligatorisk relation**: Evenemang måste ha en arrangör.

**En valfri relation**: Evenemang behöver inte ha en anmälning eller anmälningar för att finnas.

**En 1:N-relation**: En kategori kan användas för flera evenemang, men flera kategorier kan inte användas för en eller flera evenemang.

**En N:M-relation som löses med en kopplingsentitet**: Attendees och Events har N:M relation, då löses den med Registrations som kopplingsentitet, vilket kombinerar 
främmande nyckel från både Attendees och Events för att skapa unika fall på ett förenklat sätt.


