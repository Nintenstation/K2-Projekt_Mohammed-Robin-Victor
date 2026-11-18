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

/* 
 Syfte:
 Triggern används för att hålla reda på när ett evenemang senast uppdaterades.

 Aktivering:
 Triggern aktiveras automatiskt efter en UPDATE på tabellen Events.

 Test: 
 Triggern har skapats i transact-SQL och två testfall har gjorts på två olika kolumner i två olika rader, 
 och den fungerar. Vi provade att ändra priset för "En lokal fotbollsturnering" och tiden för "En sen natt där besäkaren kollar på en film" 
 och triggern syntes då i "LastUpdated" med exakt klockslag och datum på när ändringen gjordes.
 Triggern är för en extra kolumn i Events-tabellen som ska visa när en rad i Events har uppdaterats i någon av dess data celler.

 Förväntat resultat:
 Kolumnen LastUpdated uppdateras med aktuell datum- och tidpunkt
 för det eller de evenemang som har ändrats. */
