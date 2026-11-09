USE EventFlow;
GO

/*
Fråga: Evenemang och respektive arrangör visas och sorteras från tidigast starttid.
Typ av fråga: JOIN-query.
En resultatrad representerar: Informationen för ett evenemang och arrangörens kontaktuppgifter.
Kontroll: Victors (arrangören) data visas upp för evenemanget BigSlap, som är ansluten till Victors arrangörId.
*/
SELECT
    e.Title AS EvenemangsTitel,
    e.Description AS Beskrivning,
    e.EventDate AS Datum,
    e.EventTime AS StartTid,
    e.Location AS Plats,
    e.Price AS Pris,
    o.Name AS ArrangörensNamn,
    o.Email AS ArrangörensMejl,
    o.Phone AS ArrangörensTelefon

FROM Events AS e
INNER JOIN Organizers AS o
    ON e.OrganizerId = o.OrganizerId
ORDER BY e.EventTime;

/*
Fråga: Filtrera antal evenemang per kategori.
Typ av fråga: AGGREGAT-query.
En resultatrad representerar: Namnet på en viss kategori (utan dess Id eller duplikation) som grupp, och hur många gånger den används i Evenemang tabellen. 
Kontroll: Kategorin Festival finns som en grupp i resultattabellen, och i kolumnen skapad av Count-aggregaten är det “2”, som visar att Festival användes för två evenemang.
*/
SELECT
    c.Name AS KategoriNamn,
    COUNT(e.EventId) AS AntalEvenemang

FROM Categories AS c
INNER JOIN Events AS e
    ON e.CategoryId = c.CategoryId
GROUP BY c.Name
ORDER BY c.Name;