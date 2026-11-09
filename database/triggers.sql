USE EventFlow;
GO

--Trigger som uppdaterar en viss kolumn i evenemangtabellen, och visar tid för senast uppdatering varje gång en rad uppdateras
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