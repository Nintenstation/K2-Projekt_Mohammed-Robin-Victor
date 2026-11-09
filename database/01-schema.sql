-- 1. Kommando för att skapa databas
CREATE DATABASE EventFlow;
GO
USE EventFlow;
GO

-- 2. Skapa tabeller (i denna ordning)

-- Besökare
CREATE TABLE Attendees
(
    AttendeeId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) NOT NULL,
    Phone NVARCHAR(30) NOT NULL
);

-- Kategori
CREATE TABLE Categories
(
    CategoryId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL
);

-- Arrangör
CREATE TABLE Organizers
(
    OrganizerId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(30) NOT NULL,
    Email NVARCHAR(255) NOT NULL
);

-- Evenemang
CREATE TABLE Events
(
    EventId INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(150) NOT NULL,
    Description NVARCHAR(MAX) NOT NULL,
    EventDate DATE NOT NULL,
    EventTime TIME NOT NULL,
    Location NVARCHAR(200) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    CategoryId INT NOT NULL FOREIGN KEY REFERENCES Categories(CategoryId),
    OrganizerId INT NOT NULL FOREIGN KEY REFERENCES Organizers(OrganizerId)
);

-- Anmälning
CREATE TABLE Registrations
(
    RegistrationId INT IDENTITY(1,1) PRIMARY KEY,
    AttendeeId INT NOT NULL,
    EventId INT NOT NULL,
    RegistrationDate DATE NOT NULL,
    Quantity INT NOT NULL,

    FOREIGN KEY (AttendeeId) REFERENCES Attendees(AttendeeId),
    FOREIGN KEY (EventId) REFERENCES Events(EventId)
);

/*
ALTER TABLE Events 
ADD LastUpdated DATETIME2;
GO
*/