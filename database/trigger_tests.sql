USE EventFlow;
GO

--Olika testfall som visar att trigger fungerar på korrekt sätt
UPDATE Events
SET EventTime = '23:00:00.0000000'
WHERE EventId = 8;

UPDATE Events
SET Price = 100.00
WHERE EventId = 2;
GO