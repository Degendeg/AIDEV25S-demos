CREATE DATABASE vet_db;
USE vet_db;

CREATE TABLE Owner (
    OwnerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Phone VARCHAR(20),
    Email VARCHAR(100)
);

CREATE TABLE Species (
    SpeciesID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL
);

CREATE TABLE Animal (
    AnimalID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    BirthDate DATE,
    OwnerID INT NOT NULL,
    SpeciesID INT NOT NULL,
    FOREIGN KEY (OwnerID) REFERENCES Owner(OwnerID),
    FOREIGN KEY (SpeciesID) REFERENCES Species(SpeciesID)
);

INSERT INTO Species (Name) VALUES 
('Dog'),
('Cat'),
('Rabbit');

INSERT INTO Owner (FirstName, LastName, Phone, Email) VALUES 
('Anna', 'Svensson', '0701234567', 'anna@example.com'),
('Erik', 'Johansson', '0737654321', 'erik@example.com');

INSERT INTO Animal (Name, BirthDate, OwnerID, SpeciesID) VALUES 
('Bella', '2020-05-12', 1, 1),
('Misse', '2019-09-03', 1, 2),
('Snuffe', '2022-03-01', 2, 3);
