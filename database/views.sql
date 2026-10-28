--Vy som visar hur många evenemang varje kategori har, sorterat från flest till minst--

--Skapa vyn--

CREATE VIEW vw_AntalEvenemangPerKategori
AS
SELECT
    k.KategoriId,
    k.Namn AS Kategorinamn,
COUNT(e.EvenemangId) AS AntalEvenemang
FROM kategori AS k
LEFT JOIN Evenemang AS e
  ON k.KategoriId = e.KategoriId
GROUP BY
    k.KategoriId,
    k.Namn;
GO

--Test vyn--

SELECT *
FROM vw_AntalEvenemangPerKategori
ORDER BY AntalEvenemang DESC;

--Dokumentation--

/**Verksamhetsfråga**
Hur många evenemang finns det i varje kategori?

**Vad representerar en resultatrad?**
Varje rad representerar en kategori och dess antal evenemang.

**Vilka tabeller används?**
-Kategori 
-Evenemang

**Hur har vyn testats?**
Vi har testat vyn genom att hämta resultatet och sortera antalet evenemang per kategori i fallande ordning.
Vi har även kontrollerat resultatet mot evenemangen i databasen. 
Vi använder LEFT JOIN för att även kunna visa kategorier utan evenemang, vilka ska visas med antalet 0.*/
