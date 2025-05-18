CREATE TABLE Hotel (
    id_Hotel INT PRIMARY KEY AUTO_INCREMENT,
    nom_Hotel VARCHAR(100) NOT NULL,
    Nbre_Etoiles TINYINT NOT NULL CHECK (Nbre_Etoiles BETWEEN 1 AND 5)
);

CREATE TABLE Chambre (
    id_Chambre INT PRIMARY KEY AUTO_INCREMENT,
    id_Type_Chambre INT NOT NULL,
    statut ENUM('Empty', 'Occupied') NOT NULL DEFAULT 'Empty',
    id_Hotel INT NOT NULL,
    FOREIGN KEY (id_Type_Chambre) REFERENCES Type_Chambre(id_Type_Chambre),
    FOREIGN KEY (id_Hotel) REFERENCES Hotel(id_Hotel) ON DELETE CASCADE
);

CREATE TABLE Type_Chambre (
    id_Type_Chambre INT PRIMARY KEY AUTO_INCREMENT,
    nom_type ENUM('Single', 'Double', 'Junior-Single', 'Junior-Double', 'Apart-Single', 'Apart-Double') NOT NULL,
    Prix DECIMAL(10,2) NOT NULL,
    nombres_chambres INT NOT NULL,
    id_Hotel INT NOT NULL,
    FOREIGN KEY (id_Hotel) REFERENCES Hotel(id_Hotel) ON DELETE CASCADE
);

CREATE TABLE Restaurant (
    id_Restaurant INT PRIMARY KEY AUTO_INCREMENT,
    Date_Arive DATE NOT NULL,
    -- Prix DECIMAL(10,2) NOT NULL,
    capacite INT NOT NULL, 
    Kitchen_type VARCHAR(100) NOT NULL,
    -- statut ENUM('Empty', 'Occupied') NOT NULL DEFAULT 'Empty',
    id_Client INT NOT NULL,
    id_Hotel INT,
    FOREIGN KEY (id_Client) REFERENCES Client(id_Client) ON DELETE CASCADE,
    FOREIGN KEY (id_Hotel) REFERENCES Hotel(id_Hotel) ON DELETE CASCADE
);

CREATE TABLE Salle (
    id_Salle INT PRIMARY KEY AUTO_INCREMENT,
    Type_salle ENUM('fetes', 'conference') NOT NULL,
    capacite INT NOT NULL,
    statut ENUM('Empty', 'Occupied') NOT NULL DEFAULT 'Empty',
    Prix DECIMAL(10,2) NOT NULL,
    id_Hotel INT,
    FOREIGN KEY (id_Hotel) REFERENCES Hotel(id_Hotel) ON DELETE CASCADE
);

CREATE TABLE Client (
    id_Client INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    FName_Client VARCHAR(50) NOT NULL,
    LName_Client VARCHAR(50) NOT NULL,
    Phone_Client VARCHAR(20),
    Email_Client VARCHAR(100)
);
CREATE TABLE Reservation (
    id_Reservation INT PRIMARY KEY AUTO_INCREMENT,
    Date_Arive DATE NOT NULL,
    Date_Depart DATE NOT NULL,
    Nbre_personnes INT NOT NULL,
    id_Client INT NOT NULL,
    id_Chambre INT,
    id_Hotel INT,
    FOREIGN KEY (id_Client) REFERENCES Client(id_Client) ON DELETE CASCADE,
    FOREIGN KEY (id_Chambre) REFERENCES Chambre(id_Chambre) ON DELETE CASCADE,
    -- FOREIGN KEY (id_Salle) REFERENCES Salle(id_Salle) ON DELETE CASCADE,
    -- FOREIGN KEY (id_Restaurant) REFERENCES Restaurant(id_Restaurant) ON DELETE CASCADE,
    FOREIGN KEY (id_Hotel) REFERENCES Hotel(id_Hotel) ON DELETE CASCADE
);

CREATE TABLE Facture (
    id_Facture INT PRIMARY KEY AUTO_INCREMENT,
    montant_total DECIMAL(10,2) NOT NULL,
    date_facture DATE NOT NULL,
    id_Reservation INT,
    FOREIGN KEY (id_Reservation) REFERENCES Reservation(id_Reservation)
);

CREATE TABLE Paiement (
    id_Paiement INT PRIMARY KEY AUTO_INCREMENT,
    mode_paiement VARCHAR(20) NOT NULL,
    montant DECIMAL(10,2) NOT NULL,
    date_paiement DATE NOT NULL,
    id_Facture INT,
    FOREIGN KEY (id_Facture) REFERENCES Facture(id_Facture)
);

CREATE TABLE Admin (
    id_Admin INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    User_name VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    id_Hotel INT,
    FOREIGN KEY (id_Hotel) REFERENCES Hotel(id_Hotel) ON DELETE CASCADE,
    INDEX (id_Hotel)
);


-- INSERT INTO Type_Chambre (nom_type, Prix, id_Hotel)
-- VALUES
-- ('Single', 50.00, 1),
-- ('Double', 80.00, 1),
-- ('Junior Single', 60.00, 1),
-- ('Junior Double', 90.00, 1),
-- ('Apart Single', 100.00, 1),
-- ('Apart Double', 150.00, 1);

-- INSERT INTO Chambre (id_Type_Chambre, statut, id_Hotel)
-- SELECT 1, 'Empty', 1 FROM dual LIMIT 20;

-- INSERT INTO Chambre (id_Type_Chambre, statut, id_Hotel)
-- SELECT 2, 'Empty', 1 FROM dual LIMIT 15;

-- INSERT INTO Chambre (id_Type_Chambre, statut, id_Hotel)
-- SELECT 3, 'Empty', 1 FROM dual LIMIT 12;

-- INSERT INTO Chambre (id_Type_Chambre, statut, id_Hotel)
-- SELECT 4, 'Empty', 1 FROM dual LIMIT 12;

-- INSERT INTO Chambre (id_Type_Chambre, statut, id_Hotel)
-- SELECT 5, 'Empty', 1 FROM dual LIMIT 9;

-- INSERT INTO Chambre (id_Type_Chambre, statut, id_Hotel)
-- SELECT 6, 'Empty', 1 FROM dual LIMIT 8;
