# Relationer 

Anmälning: En eller flera anmälningar måste vara kopplad till en besökare, och en eller flera anmälningar måste vara kopplad till en evenemang. 
Använd detta som kopplingsentitet mellan Besökare och evenemang, eftersom besökare och evenemang har M:N relationer. 
(Besökare 1:N Anmälning, Anmälning N:1 Evenemang). MANDATORY relation med Besökare och Evenemang.

Evenemang & Besökare: En besökare kan anmäla sig till många evenemang och ett evenemang kan ha många besökare. Därför har Besökare och Evenemang 
en M:N-relation som löses genom Anmälning. (Besökare M:N Evenemang <-- Problem!). 
Evenemang: OPTIONAL relation med Anmälning & kategori, MANDATORY relation med arrangör.

Kategori: En kategori kan ha noll eller många evenemang, men varje evenemang måste tillhöra exakt en kategori. 
(Kategori 1:N Evenemang). OPTIONAL relation med evenemang.

Arrangör: En arrangör kan ansvara för noll eller många evenemang, men varje evenemang måste ha exakt en arrangör. 
(Arrangör 1:N Evenemang). OPTIONAL relation med evenemang.

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

**En N:M-relation som löses med en kopplingsentitet**: Besökare och evenemang har N:M relation, då löses den med Anmälning som kopplingsentitet, vilket kombinerar 
främmande nyckel från både Besökare och Evenemang för att skapa unika fall på ett förenklat sätt.


