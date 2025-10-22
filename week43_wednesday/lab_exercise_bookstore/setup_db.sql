-- Skapa databas
CREATE DATABASE Bokhandel;
USE Bokhandel;

-- Tabell för kunder
CREATE TABLE Kund (
    KundID INT PRIMARY KEY AUTO_INCREMENT,
    Namn VARCHAR(100),
    Adress VARCHAR(200)
);

-- Tabell för säljare
CREATE TABLE Saljare (
    SaljareID INT PRIMARY KEY AUTO_INCREMENT,
    Namn VARCHAR(100)
);

-- Tabell för författare
CREATE TABLE Forfattare (
    ForfattareID INT PRIMARY KEY AUTO_INCREMENT,
    Namn VARCHAR(100)
);

-- Tabell för böcker
CREATE TABLE Bok (
    BokID INT PRIMARY KEY AUTO_INCREMENT,
    Titel VARCHAR(150),
    Pris DECIMAL(10,2),
    ForfattareID INT,
    FOREIGN KEY (ForfattareID) REFERENCES Forfattare(ForfattareID)
);

-- Tabell för order
CREATE TABLE `Order` (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    KundID INT,
    SaljareID INT,
    OrderDatum DATE,
    FOREIGN KEY (KundID) REFERENCES Kund(KundID),
    FOREIGN KEY (SaljareID) REFERENCES Saljare(SaljareID)
);

-- Tabell för orderdetaljer
CREATE TABLE OrderDetalj (
    OrderDetaljID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    BokID INT,
    Antal INT,
    FOREIGN KEY (OrderID) REFERENCES `Order`(OrderID),
    FOREIGN KEY (BokID) REFERENCES Bok(BokID)
);