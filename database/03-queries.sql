--1. En JOIN mellan två tabeller
/* 
Syfte: Besökaren ska kunna se information om ett evenemang och dess arrangör. INNER JOIN används för att slå ihop relevant information mellan evenemang och arrangören.
Verksamhetsfråga: Evenemang och respektive arrangör visas och sorteras från tidigast starttid.
En resultatrad representerar: Informationen för ett evenemang och arrangörens kontaktuppgifter.
Förväntat resultat: 5 rader som visar alla evenemang (Livekonsert, Fotbollsturnering, Konstutställning, Familjedag, MovieNight) och vilken arrangör som håller i dem. 
Så verifierades resultatet: I vår implementerade databas.
*/ 
USE EventFlow

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


--2. En JOIN genom minst tabeller.
/* 
Syfte: Att ge en överblick över alla anmälningar genom att koppla ihop vem besökaren är med vilket evenemang de ska gå på.
Verksamhetsfråga: Vilka besökare har anmält sig till vilka evenemang, och hur många platser har de bokat? 
En resultatrad representerar: En specifik anmälning kopplad till en besökare och ett evenemang, samt antalet bokade platser. 
Förväntat resultat: 5 rader som visar namnen på de som har bokat (Anna Andersson, Erik Svensson, Sara Nilsson, Johan Karlsson) och exakt vilka evenemang de ska gå på. (Anna kommer synas två gånger eftersom hon har två bokningar). 
Så verifierades resultatet: I vår implementerade databas.
*/ 
USE EventFlow

SELECT
	b.Namn AS BesökarensNamn,
	e.Titel AS EvenemangsTitel, 
	a.Anmälningsdatum, 
	a.AntalPlatser 

FROM Anmälning AS a
INNER JOIN Besökare AS b
	ON a.BesökareId = b.BesökareId 
INNER JOIN Evenemang  AS e
	ON a.EvenemangId = e.EvenemangId 
ORDER BY a.Anmälningsdatum ASC, b.Namn ASC; 


--3. En aggregatfråga med GROUP BY
/* 
Syfte: Att kunna filtrera antal evenemang per kategori.
Verksamhetsfråga: Filtrera antal evenemang per kategori.
En resultatrad representerar: Namnet på en viss kategori (utan dess Id eller duplikation) som grupp, och hur många gånger den används i Evenemang tabellen. 
Förväntat resultat: 4 rader som visar namnen på kategorierna (Musik, Sport, Kultur, Familj) med siffran 1 bredvid varje, eftersom det bara finns ett evenemang i varje kategori just nu. 
Så verifierades resultatet: I vår implementerade databas.
*/ 

USE EventFlow

SELECT
	k.Namn AS KategoriNamn,
	Count(EvenemangId) AS AntalEvenemang

FROM Kategori AS k
INNER JOIN Evenemang AS e
	ON e.KategoriId = k.KategoriId
GROUP BY k.Namn
ORDER BY k.Namn


--4. En fråga med filtrering och sortering
/* 
Syfte: Tillåter användare att filtrera bort evenemang som kostar och visa resterande evenemang i ordning.
Verksamhetsfråga: Vilka evenemang är helt gratis?
En resultatrad representerar: Ett gratis evenemang med titel, beskrivning, datum, tid och plats.
Förväntat resultat: 2 rader som bara visar namnen på de evenemang som är helt gratis: Konstutställning och Familjedag. 
Så verifierades resultatet: I vår implementerade databas.
*/ 

USE EventFlow

SELECT
	Titel, 
	Beskrivning, 
	Datum, 
	Tid, 
	Plats,
	Pris

FROM Evenemang
WHERE Pris = 0.00 
ORDER BY Datum ASC, Tid ASC; 
