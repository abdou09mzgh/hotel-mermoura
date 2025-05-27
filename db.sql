CREATE TABLE Hotel (
    id_Hotel INT PRIMARY KEY AUTO_INCREMENT,
    nom_Hotel VARCHAR(100) NOT NULL,
    Nbre_Etoiles TINYINT NOT NULL CHECK (Nbre_Etoiles BETWEEN 1 AND 5)
);

CREATE TABLE Admin (
    id_Admin INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    User_name VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    id_Hotel INT NOT NULL,
    FOREIGN KEY (id_Hotel) REFERENCES Hotel(id_Hotel) ON DELETE CASCADE,
    INDEX (id_Hotel)
);

CREATE TABLE Client (
    id_Client INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    FName_Client VARCHAR(50) NOT NULL,
    LName_Client VARCHAR(50) NOT NULL,
    Phone_Client VARCHAR(20),
    Email_Client VARCHAR(100)
);

CREATE TABLE Type_Chambre (
    id_Type_Chambre INT PRIMARY KEY AUTO_INCREMENT,
    nom_type ENUM('Single', 'Double', 'Junior-Single', 'Junior-Double', 'Apart-Single', 'Apart-Double') NOT NULL,
    Prix DECIMAL(10,2) NOT NULL,
    nombres_chambres INT NOT NULL,
    id_Hotel INT NOT NULL,
    FOREIGN KEY (id_Hotel) REFERENCES Hotel(id_Hotel) ON DELETE CASCADE
);

CREATE TABLE Chambre (
    id_Chambre INT PRIMARY KEY AUTO_INCREMENT,
    id_Type_Chambre INT NOT NULL,
    statut ENUM('Empty', 'Occupied') NOT NULL DEFAULT 'Empty',
    id_Hotel INT NOT NULL,
    FOREIGN KEY (id_Type_Chambre) REFERENCES Type_Chambre(id_Type_Chambre),
    FOREIGN KEY (id_Hotel) REFERENCES Hotel(id_Hotel) ON DELETE CASCADE
);

CREATE TABLE Cuisine_Type (
    id_Cuisine INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Restaurant (
    id_Restaurant INT PRIMARY KEY AUTO_INCREMENT,
    capacite INT NOT NULL,
    id_Hotel INT NOT NULL,
    FOREIGN KEY (id_Hotel) REFERENCES Hotel(id_Hotel) ON DELETE CASCADE
);

CREATE TABLE Restaurant_Cuisine (
    id_Restaurant INT NOT NULL,
    id_Cuisine INT NOT NULL,
    PRIMARY KEY (id_Restaurant, id_Cuisine),
    FOREIGN KEY (id_Restaurant) REFERENCES Restaurant(id_Restaurant) ON DELETE CASCADE,
    FOREIGN KEY (id_Cuisine) REFERENCES Cuisine_Type(id_Cuisine) ON DELETE CASCADE
);

CREATE TABLE Salle (
    id_Salle INT PRIMARY KEY AUTO_INCREMENT,
    capacite INT NOT NULL,
    Prix DECIMAL(10,2) NOT NULL,
    id_Hotel INT NOT NULL,
    FOREIGN KEY (id_Hotel) REFERENCES Hotel(id_Hotel) ON DELETE CASCADE
);

CREATE TABLE Reservation_Chambre (
    id_Reservation INT PRIMARY KEY AUTO_INCREMENT,
    Date_Arive DATE NOT NULL,
    Date_Depart DATE NOT NULL,
    Nbre_personnes INT NOT NULL,
    id_Client INT NOT NULL,
    id_Chambre INT NOT NULL,
    FOREIGN KEY (id_Client) REFERENCES Client(id_Client) ON DELETE CASCADE,
    FOREIGN KEY (id_Chambre) REFERENCES Chambre(id_Chambre) ON DELETE CASCADE
);

CREATE TABLE Reservation_Restaurant (
    id_Reservation INT PRIMARY KEY AUTO_INCREMENT,
    Date_Arive DATE NOT NULL,
    Nbre_personnes INT NOT NULL,
    id_Client INT NOT NULL,
    id_Restaurant INT NOT NULL,
    id_Cuisine INT NOT NULL,
    FOREIGN KEY (id_Client) REFERENCES Client(id_Client) ON DELETE CASCADE,
    FOREIGN KEY (id_Restaurant) REFERENCES Restaurant(id_Restaurant) ON DELETE CASCADE,
    FOREIGN KEY (id_Cuisine) REFERENCES Cuisine_Type(id_Cuisine) ON DELETE CASCADE
);

CREATE TABLE Reservation_Salle (
    id_Reservation INT PRIMARY KEY AUTO_INCREMENT,
    Date_Arive DATE NOT NULL,
    Nbre_personnes INT NOT NULL,
    Type_evenement ENUM('fetes', 'conference') NOT NULL,
    id_Client INT NOT NULL,
    id_Salle INT NOT NULL,
    FOREIGN KEY (id_Client) REFERENCES Client(id_Client) ON DELETE CASCADE,
    FOREIGN KEY (id_Salle) REFERENCES Salle(id_Salle) ON DELETE CASCADE
);

CREATE TABLE Facture (
    id_Facture INT PRIMARY KEY AUTO_INCREMENT,
    montant_total DECIMAL(10,2) NOT NULL,
    date_facture DATE NOT NULL,
    id_Reservation_Chambre INT,
    id_Reservation_Restaurant INT,
    id_Reservation_Salle INT,
    FOREIGN KEY (id_Reservation_Chambre) REFERENCES Reservation_Chambre(id_Reservation),
    FOREIGN KEY (id_Reservation_Restaurant) REFERENCES Reservation_Restaurant(id_Reservation),
    FOREIGN KEY (id_Reservation_Salle) REFERENCES Reservation_Salle(id_Reservation)
);

CREATE TABLE Paiement (
    id_Paiement INT PRIMARY KEY AUTO_INCREMENT,
    mode_paiement VARCHAR(20) NOT NULL,
    montant DECIMAL(10,2) NOT NULL,
    date_paiement DATE NOT NULL,
    id_Facture INT NOT NULL,
    FOREIGN KEY (id_Facture) REFERENCES Facture(id_Facture)
);





-- -- Insert initial data into Hotel table
-- INSERT INTO Hotel (id_Hotel, nom_Hotel, Nbre_Etoiles) VALUES
-- (1, 'Hotel Mermoura', 1);

-- -- Insert initial data into Cuisine_Type table
-- INSERT INTO Cuisine_Type (name) VALUES
-- ('Italian Kitchen'),
-- ('French Kitchen'),
-- ('Algerian Kitchen'),
-- ('Turkish Kitchen'),
-- ('Asian Kitchen'),
-- ('Indian Kitchen'),
-- ('Mexican Kitchen');

-- -- Insert initial data into Reastaurant table
-- INSERT INTO Restaurant (capacite, id_Hotel) VALUES (150, 1);

-- -- Insert initial data into Reastaurant_Cuisine table
-- INSERT INTO Restaurant_Cuisine (id_Restaurant, id_Cuisine) VALUES
-- (1, 1),
-- (1, 2),
-- (1, 3),
-- (1, 4),
-- (1, 5),
-- (1, 6),
-- (1, 7);

-- -- Insert initial data into Type_Chambre table
-- INSERT INTO Type_Chambre (nom_type, Prix, nombres_chambres, id_Hotel) VALUES
-- ('Single', 5000.00, 20, 1),
-- ('Double', 8000.00, 15, 1),
-- ('Junior-Single', 10000.00, 12, 1),
-- ('Junior-Double', 13000.00, 12, 1),
-- ('Apart-Single', 15000.00, 9, 1),
-- ('Apart-Double', 18000.00, 8, 1);

-- -- Insert initial data into Chambre table
-- INSERT INTO Chambre (id_Type_Chambre, statut, id_Hotel) VALUES
-- (1, 'Empty', 1),(1, 'Empty', 1),(1, 'Empty', 1),(1, 'Empty', 1),(1, 'Empty', 1),
-- (1, 'Empty', 1),(1, 'Empty', 1),(1, 'Empty', 1),(1, 'Empty', 1),(1, 'Empty', 1),
-- (1, 'Empty', 1),(1, 'Empty', 1),(1, 'Empty', 1),(1, 'Empty', 1),(1, 'Empty', 1),
-- (1, 'Empty', 1),(1, 'Empty', 1),(1, 'Empty', 1),(1, 'Empty', 1),(1, 'Empty', 1);

-- INSERT INTO Chambre (id_Type_Chambre, statut, id_Hotel) VALUES
-- (2, 'Empty', 1),(2, 'Empty', 1),(2, 'Empty', 1),(2, 'Empty', 1),(2, 'Empty', 1),
-- (2, 'Empty', 1),(2, 'Empty', 1),(2, 'Empty', 1),(2, 'Empty', 1),(2, 'Empty', 1),
-- (2, 'Empty', 1),(2, 'Empty', 1),(2, 'Empty', 1),(2, 'Empty', 1),(2, 'Empty', 1);

-- INSERT INTO Chambre (id_Type_Chambre, statut, id_Hotel) VALUES
-- (3, 'Empty', 1),(3, 'Empty', 1),(3, 'Empty', 1),(3, 'Empty', 1),
-- (3, 'Empty', 1),(3, 'Empty', 1),(3, 'Empty', 1),(3, 'Empty', 1),
-- (3, 'Empty', 1),(3, 'Empty', 1),(3, 'Empty', 1),(3, 'Empty', 1);

-- INSERT INTO Chambre (id_Type_Chambre, statut, id_Hotel) VALUES
-- (4, 'Empty', 1),(4, 'Empty', 1),(4, 'Empty', 1),(4, 'Empty', 1),
-- (4, 'Empty', 1),(4, 'Empty', 1),(4, 'Empty', 1),(4, 'Empty', 1),
-- (4, 'Empty', 1),(4, 'Empty', 1),(4, 'Empty', 1),(4, 'Empty', 1);

-- INSERT INTO Chambre (id_Type_Chambre, statut, id_Hotel) VALUES
-- (5, 'Empty', 1),(5, 'Empty', 1),(5, 'Empty', 1),
-- (5, 'Empty', 1),(5, 'Empty', 1),(5, 'Empty', 1),
-- (5, 'Empty', 1),(5, 'Empty', 1),(5, 'Empty', 1);

-- INSERT INTO Chambre (id_Type_Chambre, statut, id_Hotel) VALUES
-- (6, 'Empty', 1),(6, 'Empty', 1),(6, 'Empty', 1),(6, 'Empty', 1),
-- (6, 'Empty', 1),(6, 'Empty', 1),(6, 'Empty', 1),(6, 'Empty', 1);

-- -- Insert initial data into Salle table
-- INSERT INTO salle (`id_Salle`, `capacite`, `Prix`, `id_Hotel`) VALUES
-- (1, 150, 150.00, 1);
