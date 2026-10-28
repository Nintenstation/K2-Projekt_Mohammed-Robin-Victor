--Trigger som uppdaterar en viss kolumn i evenemangtabellen, och visar tid för senast uppdatering varje gång en rad uppdateras

CREATE TRIGGER update_timestamp ON Evenemang
AFTER UPDATE
AS
	UPDATE Evenemang
	SET UppdateradSenast = SYSDATETIME()
	FROM inserted i
	WHERE Evenemang.EvenemangId = i.EvenemangId
