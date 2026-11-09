USE EventFlow;
GO

--Vy som visar hur många evenemang varje kategori har, sorterat från flest till minst--

--Skapa vyn--
CREATE VIEW vw_EventCountPerCategory
AS
SELECT
    c.CategoryId AS KategoriId,
    c.Name AS Kategorinamn,
    COUNT(e.EventId) AS AntalEvenemang
FROM Categories AS c
LEFT JOIN Events AS e
  ON c.CategoryId = e.CategoryId
GROUP BY
    c.CategoryId,
    c.Name;
GO

-- Test vyn --
SELECT *
FROM vw_EventCountPerCategory
ORDER BY AntalEvenemang DESC;
GO

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