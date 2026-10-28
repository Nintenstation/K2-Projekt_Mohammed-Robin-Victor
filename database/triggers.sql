CREATE TRIGGER update_timestamp ON Evenemang
AFTER UPDATE
AS
	UPDATE Evenemang
	SET UppdateradSenast = SYSDATETIME()
	FROM inserted i
	WHERE Evenemang.EvenemangId = i.EvenemangId
