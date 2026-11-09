USE EventFlow;
GO

/* Syfte: Söka efter ett evenemang baserat på dess titel. */

-- SLUTGILTIG VERSION: Fixa sökfunktion med en trim
/* 
Förklaring av val:
Det här är vår slutgiltiga procedur eftersom den uppfyller alla krav bäst.
Den tar emot en parameter (@SearchTerm), filtrerar sökningen tydligt med LIKE, och ignorerar stora/små bokstäver. 
Det viktigaste är att den kombinerar sökningen med TRIM() och LEN() > 0. 
Detta löser problemet vi hade där ett tomt mellanslag (' ') annars matchade evenemang som "Movie Night". 
*/

CREATE PROCEDURE dbo.usp_GetEventByTitleTrim
    @SearchTerm NVARCHAR(150)
AS
BEGIN
    SELECT 
        e.Title AS EvenemangsTitelAllTrim,
        e.Description AS Beskrivning,
        e.EventDate AS Datum,
        e.EventTime AS StartTid,
        e.Location AS Plats,
        e.Price AS Pris,
        c.Name AS KategoriNamn
    FROM Events AS e
    INNER JOIN Categories AS c 
        ON e.CategoryId = c.CategoryId
    WHERE e.Title LIKE '%' + @SearchTerm + '%' 
    AND LEN(TRIM(@SearchTerm)) > 0
    ORDER BY e.EventDate, e.EventTime;
END;
GO

-- Test och resultat för usp_GetEventByTitleTrim:
EXEC dbo.usp_GetEventByTitleTrim @SearchTerm = 'live'; 
-- Resultat: Visar 1 rad ("Livekonsert").
EXEC dbo.usp_GetEventByTitleTrim @SearchTerm = 'livekonseggg'; 
-- Resultat: Visar 0 rader (tomt resultat, inget SQL-fel).
EXEC dbo.usp_GetEventByTitleTrim @SearchTerm = ' '; 
-- Resultat: Visar 0 rader (Trim förhindrar att mellanslag ger felaktiga träffar).
EXEC dbo.usp_GetEventByTitleTrim @SearchTerm = 'MoVie Ni'; 
-- Resultat: Visar 1 rad ("Movie Night").
EXEC dbo.usp_GetEventByTitleTrim @SearchTerm = 'i'; 
-- Resultat: Visar alla evenemang som innehåller bokstaven "i".
EXEC dbo.usp_GetEventByTitleTrim @SearchTerm = 'LIVE'; 
-- Resultat: Visar 1 rad ("Livekonsert").
GO

-- ALTERNATIV: 1. Stored Procedure: Exakt titel (skiftlägeskänslig)
/* Syfte: Söka efter ett evenemang med exakt samma titel. */

CREATE PROCEDURE dbo.usp_GetEventByExactTitle
    @Title NVARCHAR(150)
AS
BEGIN
    SELECT 
        e.Title AS EvenemangsTitelExakt,
        e.Description AS Beskrivning,
        e.EventDate AS Datum,
        e.EventTime AS StartTid,
        e.Location AS Plats,
        e.Price AS Pris,
        c.Name AS KategoriNamn
    FROM Events AS e
    INNER JOIN Categories AS c 
        ON e.CategoryId = c.CategoryId
    WHERE e.Title = @Title
    ORDER BY e.EventDate, e.EventTime;
END;
GO

-- Test och resultat för usp_GetEventByExactTitle:
EXEC dbo.usp_GetEventByExactTitle @Title = 'Livekonsert'; 
-- Resultat: Visar 1 rad.
EXEC dbo.usp_GetEventByExactTitle @Title = 'Live'; 
-- Resultat: Visar 0 rader.
EXEC dbo.usp_GetEventByExactTitle @Title = 'LIVE'; 
-- Resultat: Visar 0 rader.
EXEC dbo.usp_GetEventByExactTitle @Title = ' '; 
-- Resultat: Visar 0 rader.
EXEC dbo.usp_GetEventByExactTitle @Title = 'LIVEKonSert'; 
-- Resultat: Överraskande nog visade denna 1 rad för att databasens standardinställning redan hanterar stora/små bokstäver här.
GO 

-- ALTERNATIV: 2. Stored Procedure: Exakt titel (oberoende av stora/små bokstäver)
/* Syfte: Söka efter ett evenemang med exakt titel, men det spelar ingen roll om man skriver med stora eller små bokstäver. */

CREATE PROCEDURE dbo.usp_GetEventByExactTitleNoCase
    @Title NVARCHAR(150)
AS
BEGIN
    SELECT 
        e.Title AS EvenemangsTitelExaktNoBostav,
        e.Description AS Beskrivning,
        e.EventDate AS Datum,
        e.EventTime AS StartTid,
        e.Location AS Plats,
        e.Price AS Pris,
        c.Name AS KategoriNamn
    FROM Events AS e
    INNER JOIN Categories AS c 
        ON e.CategoryId = c.CategoryId
    WHERE LOWER(e.Title) = LOWER(@Title)
    ORDER BY e.EventDate, e.EventTime;
END;
GO

-- Test och resultat för usp_GetEventByExactTitleNoCase:
EXEC dbo.usp_GetEventByExactTitleNoCase @Title = 'Livekonsert'; 
-- Resultat: Visar 1 rad.
EXEC dbo.usp_GetEventByExactTitleNoCase @Title = 'Live'; 
-- Resultat: Visar 0 rader (hela namnet måste matcha).
EXEC dbo.usp_GetEventByExactTitleNoCase @Title = 'LIVE'; 
-- Resultat: Visar 0 rader.
EXEC dbo.usp_GetEventByExactTitleNoCase @Title = ' '; 
-- Resultat: Visar 0 rader.
EXEC dbo.usp_GetEventByExactTitleNoCase @Title = 'LIVEKonSert'; 
-- Resultat: Visar 1 rad, fungerar som planerat med LOWER.
GO

-- ALTERNATIV: 3. Stored Procedure: Sök med valfritt ord (del av titel)
/* Syfte: Söka evenemang genom att skriva ett ord eller några bokstäver som finns i titeln. */

CREATE PROCEDURE dbo.usp_GetEventByTitleLetter
    @SearchTerm NVARCHAR(150)
AS
BEGIN
    SELECT 
        e.Title AS EvenemangsTitelAllBokstav,
        e.Description AS Beskrivning,
        e.EventDate AS Datum,
        e.EventTime AS StartTid,
        e.Location AS Plats,
        e.Price AS Pris,
        c.Name AS KategoriNamn
    FROM Events AS e
    INNER JOIN Categories AS c 
        ON e.CategoryId = c.CategoryId
    WHERE e.Title LIKE '%' + @SearchTerm + '%' 
    ORDER BY e.EventDate, e.EventTime;
END;
GO

-- Test och resultat för usp_GetEventByTitleLetter:
EXEC dbo.usp_GetEventByTitleLetter @SearchTerm = 'live'; 
-- Resultat: Visar 1 rad.
EXEC dbo.usp_GetEventByTitleLetter @SearchTerm = 'livekonseggg'; 
-- Resultat: Visar 0 rader (inget SQL-fel).
EXEC dbo.usp_GetEventByTitleLetter @SearchTerm = ' '; 
-- Resultat: Detta gav oväntat tillbaka evenemang som hade mellanslag (t.ex. Movie Night). Inte ett bra resultat.
EXEC dbo.usp_GetEventByTitleLetter @SearchTerm = 'i'; 
-- Resultat: Visar alla med bokstaven i.
EXEC dbo.usp_GetEventByTitleLetter @SearchTerm = 'LIVE'; 
-- Resultat: Visar 1 rad.
GO

-- ALTERNATIV 4: Spelar ingen roll med stora/små bokstäver.
/* Samma som ovan men använder LOWER() på båda sidor av LIKE-funktionen. */

CREATE PROCEDURE dbo.usp_GetEventByTitle
    @SearchTerm NVARCHAR(150)
AS
BEGIN
    SELECT 
        e.Title AS EvenemangsTitelAll,
        e.Description AS Beskrivning,
        e.EventDate AS Datum,
        e.EventTime AS StartTid,
        e.Location AS Plats,
        e.Price AS Pris,
        c.Name AS KategoriNamn
    FROM Events AS e
    INNER JOIN Categories AS c 
        ON e.CategoryId = c.CategoryId
    WHERE LOWER(e.Title) LIKE '%' + LOWER(@SearchTerm) + '%'
    ORDER BY e.EventDate, e.EventTime;
END;
GO

-- Test och resultat för usp_GetEventByTitle:
EXEC dbo.usp_GetEventByTitle @SearchTerm = 'live'; 
-- Resultat: Visar 1 rad.
EXEC dbo.usp_GetEventByTitle @SearchTerm = 'livekonseggg'; 
-- Resultat: Visar 0 rader (inget SQL-fel).
EXEC dbo.usp_GetEventByTitle @SearchTerm = ' '; 
-- Resultat: Fortfarande ett problem med tomt mellanslag som visar evenemang. (Detta var anledningen till att vi byggde Trim-versionen längst upp).
EXEC dbo.usp_GetEventByTitle @SearchTerm = 'i'; 
-- Resultat: Visar alla med bokstaven i.
EXEC dbo.usp_GetEventByTitle @SearchTerm = 'LIVE'; 
-- Resultat: Visar 1 rad.
GO