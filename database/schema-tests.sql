/* ==========================================
   TEST AV OBLIGATORISKA FÄLT OCH RELATIONER
   ========================================== */

-- Vi har genomfört sex testfall för att kontrollera
-- att databasens obligatoriska fält och relationer fungerar korrekt.


/* ==========================================
   OBLIGATORISKA FÄLT
   ========================================== */

-- T01: Testade att Name i Attendees inte accepterar NULL.
-- T02: Testade att Title i Events inte accepterar NULL.


/* ==========================================
   RELATIONER (FOREIGN KEYS)
   ========================================== */

-- T03: Testade att Events inte kan kopplas till en kategori som saknas.
-- T04: Testade att Events inte kan kopplas till en arrangör som saknas.
-- T05: Testade att Registrations inte kan kopplas till en besökare som saknas.
-- T06: Testade att Registrations inte kan kopplas till ett evenemang som saknas.


/* ==========================================
   TESTKOD
   ========================================== */

USE EventFlow;
GO

-- T01: Name får inte vara NULL
BEGIN TRANSACTION;
BEGIN TRY
    INSERT INTO Attendees (Name, Email, Phone)
    VALUES (NULL, 'test@test.se', '0701234567');

    PRINT 'T01 MISSLYCKAT';
END TRY
BEGIN CATCH
    PRINT 'T01 GODKÄNT: Name får inte vara NULL';
END CATCH;
ROLLBACK TRANSACTION;
GO


-- T02: Title får inte vara NULL
BEGIN TRANSACTION;
BEGIN TRY
    INSERT INTO Events
    (Title, Description, EventDate, EventTime, Location,
     Price, Capacity, CategoryId, OrganizerId)
    VALUES
    (NULL, 'Test', '2026-12-10', '18:00',
     'Malmö', 100, 50, 1, 1);

    PRINT 'T02 MISSLYCKAT';
END TRY
BEGIN CATCH
    PRINT 'T02 GODKÄNT: Title får inte vara NULL';
END CATCH;
ROLLBACK TRANSACTION;
GO


-- T03: CategoryId måste finnas
BEGIN TRANSACTION;
BEGIN TRY
    INSERT INTO Events
    (Title, Description, EventDate, EventTime, Location,
     Price, Capacity, CategoryId, OrganizerId)
    VALUES
    ('Test', 'Test', '2026-12-10', '18:00',
     'Malmö', 100, 50, 999999, 1);

    PRINT 'T03 MISSLYCKAT';
END TRY
BEGIN CATCH
    PRINT 'T03 GODKÄNT: Ogiltig CategoryId nekas';
END CATCH;
ROLLBACK TRANSACTION;
GO


-- T04: OrganizerId måste finnas
BEGIN TRANSACTION;
BEGIN TRY
    INSERT INTO Events
    (Title, Description, EventDate, EventTime, Location,
     Price, Capacity, CategoryId, OrganizerId)
    VALUES
    ('Test', 'Test', '2026-12-10', '18:00',
     'Malmö', 100, 50, 1, 999999);

    PRINT 'T04 MISSLYCKAT';
END TRY
BEGIN CATCH
    PRINT 'T04 GODKÄNT: Ogiltig OrganizerId nekas';
END CATCH;
ROLLBACK TRANSACTION;
GO


-- T05: AttendeeId måste finnas
BEGIN TRANSACTION;
BEGIN TRY
    INSERT INTO Registrations
    (AttendeeId, EventId, RegistrationDate, Quantity)
    VALUES
    (999999, 1, GETDATE(), 1);

    PRINT 'T05 MISSLYCKAT';
END TRY
BEGIN CATCH
    PRINT 'T05 GODKÄNT: Ogiltig AttendeeId nekas';
END CATCH;
ROLLBACK TRANSACTION;
GO


-- T06: EventId måste finnas
BEGIN TRANSACTION;
BEGIN TRY
    INSERT INTO Registrations
    (AttendeeId, EventId, RegistrationDate, Quantity)
    VALUES
    (1, 999999, GETDATE(), 1);

    PRINT 'T06 MISSLYCKAT';
END TRY
BEGIN CATCH
    PRINT 'T06 GODKÄNT: Ogiltig EventId nekas';
END CATCH;
ROLLBACK TRANSACTION;
GO


/* ==========================================
   RESULTAT
   ========================================== */

-- Samtliga sex tester godkändes.
-- Databasen nekade alla ogiltiga värden och relationer enligt förväntat resultat.
-- Testerna genomfördes med transaktioner och ROLLBACK,
-- vilket innebar att ingen testdata sparades i databasen.
