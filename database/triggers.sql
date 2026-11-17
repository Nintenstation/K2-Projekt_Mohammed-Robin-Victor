USE EventFlow;
GO

CREATE TRIGGER update_timestamp ON Events
AFTER UPDATE
AS
BEGIN
    UPDATE Events
    SET LastUpdated = SYSDATETIME()
    FROM inserted i
    WHERE Events.EventId = i.EventId;
END;
GO


-- Syfte:
-- Triggern används för att hålla reda på när ett evenemang senast uppdaterades.

-- Aktivering:
-- Triggern aktiveras automatiskt efter en UPDATE på tabellen Events.

-- Förväntat resultat:
-- Kolumnen LastUpdated uppdateras med aktuell datum- och tidpunkt
-- för det eller de evenemang som har ändrats.
