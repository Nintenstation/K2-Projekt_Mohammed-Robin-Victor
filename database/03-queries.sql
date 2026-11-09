USE EventFlow;
GO

-- 1. En JOIN mellan två tabeller
/* Syfte: Besökaren ska kunna se information om ett evenemang och dess arrangör. INNER JOIN används för att slå ihop relevant information mellan evenemang och arrangören.
Verksamhetsfråga: Evenemang och respektive arrangör visas och sorteras från tidigast starttid.
En resultatrad representerar: Informationen för ett evenemang och arrangörens kontaktuppgifter.
Förväntat resultat: 5 rader som visar alla evenemang (Livekonsert, Fotbollsturnering, Konstutställning, Familjedag, MovieNight) och vilken arrangör som håller i dem. 
Så verifierades resultatet: I vår implementerade databas.*/ 
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

-- 2. En JOIN genom minst 3 tabeller.
/* Syfte: Att ge en överblick över alla anmälningar genom att koppla ihop vem besökaren är med vilket evenemang de ska gå på.
Verksamhetsfråga: Vilka besökare har anmält sig till vilka evenemang, och hur många platser har de bokat? 
En resultatrad representerar: En specifik anmälning kopplad till en besökare och ett evenemang, samt antalet bokade platser. 
Förväntat resultat: 5 rader som visar namnen på de som har bokat (Anna Andersson, Erik Svensson, Sara Nilsson, Johan Karlsson) och exakt vilka evenemang de ska gå på. (Anna kommer synas två gånger eftersom hon har två bokningar). 
Så verifierades resultatet: I vår implementerade databas.*/ 
SELECT
	a.Name AS BesökarensNamn,
	e.Title AS EvenemangsTitel, 
	r.RegistrationDate AS Anmälningsdatum, 
	r.Quantity AS AntalPlatser 

FROM Registrations AS r
INNER JOIN Attendees AS a
	ON r.AttendeeId = a.AttendeeId 
INNER JOIN Events AS e
	ON r.EventId = e.EventId 
ORDER BY r.RegistrationDate, a.Name;

-- 3. En aggregatfråga med GROUP BY
/* Syfte: Att kunna filtrera antal evenemang per kategori.
Verksamhetsfråga: Filtrera antal evenemang per kategori.
En resultatrad representerar: Namnet på en viss kategori (utan dess Id eller duplikation) som grupp, och hur många gånger den används i Evenemang tabellen. 
Förväntat resultat: 4 rader som visar namnen på kategorierna (Musik, Sport, Kultur, Familj) med siffran 1 bredvid varje, eftersom det bara finns ett evenemang i varje kategori just nu. 
Så verifierades resultatet: I vår implementerade databas.*/ 
SELECT
	c.Name AS KategoriNamn,
	COUNT(e.EventId) AS AntalEvenemang

FROM Categories AS c
INNER JOIN Events AS e
	ON e.CategoryId = c.CategoryId
GROUP BY c.Name
ORDER BY c.Name;

-- 4. En fråga med filtrering och sortering
/* Syfte: Tillåter användare att filtrera bort evenemang som kostar och visa resterande evenemang i ordning.
Verksamhetsfråga: Vilka evenemang är helt gratis?
En resultatrad representerar: Ett gratis evenemang med titel, beskrivning, datum, tid och plats.
Förväntat resultat: 2 rader som bara visar namnen på de evenemang som är helt gratis: Konstutställning och Familjedag. 
Så verifierades resultatet: I vår implementerade databas.*/ 
SELECT
	Title AS Titel, 
	Description AS Beskrivning, 
	EventDate AS Datum, 
	EventTime AS Tid, 
	Location AS Plats,
	Price AS Pris

FROM Events
WHERE Price = 0.00 
ORDER BY EventDate, EventTime;