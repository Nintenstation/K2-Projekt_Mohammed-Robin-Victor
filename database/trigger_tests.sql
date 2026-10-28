--Olika testfall som visar att trigger fungerar på korrekt sätt

UPDATE Evenemang
SET Tid = '23:00:00.0000000'
WHERE EvenemangId = 8;

UPDATE Evenemang
SET Pris = 100.00
WHERE EvenemangId = 2;