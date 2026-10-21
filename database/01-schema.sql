1.Kommando för att skapa databas
CREATE DATABASE EventFlow

-- 2. Skapa tabeller (i denna ordning)

-- Besökare

CREATE TABLE Besökare
(
    BesökareId INT IDENTITY(1,1) PRIMARY KEY,
    Namn NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) NOT NULL,
    Telefon NVARCHAR(30) NOT NULL
);

-- Kategori

CREATE TABLE Kategori
(
    KategoriId INT IDENTITY(1,1) PRIMARY KEY,
    Namn NVARCHAR(100) NOT NULL
);

-- Arrangör

CREATE TABLE Arrangör
(
    ArrangörId INT IDENTITY(1,1) PRIMARY KEY,
    Namn NVARCHAR(100) NOT NULL,
    Telefon NVARCHAR(30) NOT NULL,
    Email NVARCHAR(255) NOT NULL
);

-- Evenemang

CREATE TABLE Evenemang
(
    EvenemangId INT IDENTITY(1,1) PRIMARY KEY,
    Titel NVARCHAR(150) NOT NULL,
    Beskrivning NVARCHAR(MAX) NOT NULL,
    Datum DATE NOT NULL,
    Tid TIME NOT NULL,
    Plats NVARCHAR(200) NOT NULL,
    Pris DECIMAL(10,2) NOT NULL,
    KategoriId INT NOT NULL FOREIGN KEY REFERENCES Kategori(KategoriId),
    ArrangörId INT NOT NULL FOREIGN KEY REFERENCES Arrangör(ArrangörId)
);

-- Anmälning
CREATE TABLE Anmälning
(
    AnmälningId INT IDENTITY(1,1) PRIMARY KEY,
    BesökareId INT NOT NULL,
    EvenemangId INT NOT NULL,
    Anmälningsdatum DATE NOT NULL,
    AntalPlatser INT NOT NULL,

    FOREIGN KEY (BesökareId) REFERENCES Besökare(BesökareId),
    FOREIGN KEY (EvenemangId) REFERENCES Evenemang(EvenemangId)
);

