/*
Fråga: Evenemang och respektive arrangör visas och sorteras från tidigast starttid.
En resultatrad representerar: Informationen för ett evenemang och arrangörens kontaktuppgifter.
Kontroll: Victors (arrangören) data visas upp för evenemanget BigSlap, som är ansluten till Victors arrangörId.
*/
SELECT
	e.Titel AS EvenemangsTitel,
	e.Beskrivning,
	e.Datum,
	e.Tid AS StartTid,
	e.Plats,
	e.Pris,
	a.Namn AS ArrangörensNamn,
	a.Email AS ArrangörensMejl,
	a.Telefon AS ArrangörensTelefon
FROM Evenemang AS e
INNER JOIN Arrangör AS a
	ON e.ArrangörId = a.ArrangörId
ORDER BY e.Tid

/*
Fråga: Filtrera antal evenemang per kategori.
En resultatrad representerar: Namnet på en viss kategori (utan dess Id eller duplikation) som grupp, och hur många gånger den används i Evenemang tabellen. 
Kontroll: Kategorin Festival finns som en grupp i resultattabellen, och i kolumnen skapad av Count-aggregaten är det “2”, som visar att Festival användes för två evenemang.
*/
SELECT
	k.Namn AS KategoriNamn,
	Count(EvenemangId) AS AntalEvenemang
FROM Kategori AS k
INNER JOIN Evenemang AS e
	ON e.KategoriId = k.KategoriId
GROUP BY k.Namn
ORDER BY k.Namn








