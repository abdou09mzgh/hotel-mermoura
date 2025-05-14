-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 14, 2025 at 10:28 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hotel-mermoura`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id_Admin` int(11) NOT NULL,
  `FirstName` varchar(100) NOT NULL,
  `LastName` varchar(100) NOT NULL,
  `User_name` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `id_Hotel` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id_Admin`, `FirstName`, `LastName`, `User_name`, `password`, `id_Hotel`) VALUES
(6, 'abdou', 'mezghache', 'abdou_mzgh', '$2y$10$k6LgOtAGbXc5etst5tfnhus2esSsHo0e0A2PQjmXSggl9T00zekFy', 1);

-- --------------------------------------------------------

--
-- Table structure for table `chambre`
--

CREATE TABLE `chambre` (
  `id_Chambre` int(11) NOT NULL,
  `id_Type_Chambre` int(11) NOT NULL,
  `statut` enum('Empty','Occupied') NOT NULL DEFAULT 'Empty',
  `id_Hotel` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chambre`
--

INSERT INTO `chambre` (`id_Chambre`, `id_Type_Chambre`, `statut`, `id_Hotel`) VALUES
(5, 1, 'Empty', 1),
(6, 2, 'Empty', 1),
(7, 3, 'Empty', 1),
(9, 4, 'Empty', 1),
(10, 5, 'Empty', 1),
(11, 6, 'Empty', 1);

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `id_Client` int(11) NOT NULL,
  `FName_Client` varchar(50) NOT NULL,
  `LName_Client` varchar(50) NOT NULL,
  `Phone_Client` varchar(20) DEFAULT NULL,
  `Email_Client` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `facture`
--

CREATE TABLE `facture` (
  `id_Facture` int(11) NOT NULL,
  `montant_total` decimal(10,2) NOT NULL,
  `date_facture` date NOT NULL,
  `id_Reservation` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hotel`
--

CREATE TABLE `hotel` (
  `id_Hotel` int(11) NOT NULL,
  `nom_Hotel` varchar(100) NOT NULL,
  `Nbre_Etoiles` tinyint(4) NOT NULL CHECK (`Nbre_Etoiles` between 1 and 5)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hotel`
--

INSERT INTO `hotel` (`id_Hotel`, `nom_Hotel`, `Nbre_Etoiles`) VALUES
(1, 'hotel-mermoura', 4);

-- --------------------------------------------------------

--
-- Table structure for table `paiement`
--

CREATE TABLE `paiement` (
  `id_Paiement` int(11) NOT NULL,
  `mode_paiement` varchar(20) NOT NULL,
  `montant` decimal(10,2) NOT NULL,
  `date_paiement` date NOT NULL,
  `id_Facture` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reservation`
--

CREATE TABLE `reservation` (
  `id_Reservation` int(11) NOT NULL,
  `Date_Arive` date NOT NULL,
  `Date_Depart` date NOT NULL,
  `Nbre_personnes` int(11) NOT NULL,
  `id_Client` int(11) NOT NULL,
  `id_Chambre` int(11) DEFAULT NULL,
  `id_Salle` int(11) DEFAULT NULL,
  `id_Restaurant` int(11) DEFAULT NULL,
  `id_Hotel` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `restaurant`
--

CREATE TABLE `restaurant` (
  `id_Restaurant` int(11) NOT NULL,
  `Prix` decimal(10,2) NOT NULL,
  `capacite` int(11) NOT NULL,
  `Kitchen_type` varchar(100) NOT NULL,
  `statut` enum('Empty','Occupied') NOT NULL DEFAULT 'Empty',
  `id_Hotel` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `salle`
--

CREATE TABLE `salle` (
  `id_Salle` int(11) NOT NULL,
  `Type_salle` enum('fetes','conference') NOT NULL,
  `capacite` int(11) NOT NULL,
  `statut` enum('Empty','Occupied') NOT NULL DEFAULT 'Empty',
  `Prix` decimal(10,2) NOT NULL,
  `id_Hotel` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `type_chambre`
--

CREATE TABLE `type_chambre` (
  `id_Type_Chambre` int(11) NOT NULL,
  `nom_type` enum('Single','Double','Junior-Single','Junior-Double','Apart-Single','Apart-Double') NOT NULL,
  `Prix` decimal(10,2) NOT NULL,
  `nombres_chambres` int(11) NOT NULL,
  `id_Hotel` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `type_chambre`
--

INSERT INTO `type_chambre` (`id_Type_Chambre`, `nom_type`, `Prix`, `nombres_chambres`, `id_Hotel`) VALUES
(1, 'Single', 5000.00, 20, 1),
(2, 'Double', 8000.00, 15, 1),
(3, 'Junior-Single', 10000.00, 12, 1),
(4, 'Junior-Double', 12000.00, 12, 1),
(5, 'Apart-Single', 15000.00, 9, 1),
(6, 'Apart-Double', 18000.00, 8, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_Admin`),
  ADD UNIQUE KEY `User_name` (`User_name`),
  ADD KEY `id_Hotel` (`id_Hotel`);

--
-- Indexes for table `chambre`
--
ALTER TABLE `chambre`
  ADD PRIMARY KEY (`id_Chambre`),
  ADD KEY `id_Type_Chambre` (`id_Type_Chambre`),
  ADD KEY `id_Hotel` (`id_Hotel`);

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id_Client`);

--
-- Indexes for table `facture`
--
ALTER TABLE `facture`
  ADD PRIMARY KEY (`id_Facture`),
  ADD KEY `id_Reservation` (`id_Reservation`);

--
-- Indexes for table `hotel`
--
ALTER TABLE `hotel`
  ADD PRIMARY KEY (`id_Hotel`);

--
-- Indexes for table `paiement`
--
ALTER TABLE `paiement`
  ADD PRIMARY KEY (`id_Paiement`),
  ADD KEY `id_Facture` (`id_Facture`);

--
-- Indexes for table `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`id_Reservation`),
  ADD KEY `id_Client` (`id_Client`),
  ADD KEY `id_Chambre` (`id_Chambre`),
  ADD KEY `id_Salle` (`id_Salle`),
  ADD KEY `id_Restaurant` (`id_Restaurant`),
  ADD KEY `id_Hotel` (`id_Hotel`);

--
-- Indexes for table `restaurant`
--
ALTER TABLE `restaurant`
  ADD PRIMARY KEY (`id_Restaurant`),
  ADD KEY `id_Hotel` (`id_Hotel`);

--
-- Indexes for table `salle`
--
ALTER TABLE `salle`
  ADD PRIMARY KEY (`id_Salle`),
  ADD KEY `id_Hotel` (`id_Hotel`);

--
-- Indexes for table `type_chambre`
--
ALTER TABLE `type_chambre`
  ADD PRIMARY KEY (`id_Type_Chambre`),
  ADD KEY `id_Hotel` (`id_Hotel`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id_Admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `chambre`
--
ALTER TABLE `chambre`
  MODIFY `id_Chambre` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `client`
--
ALTER TABLE `client`
  MODIFY `id_Client` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `facture`
--
ALTER TABLE `facture`
  MODIFY `id_Facture` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `hotel`
--
ALTER TABLE `hotel`
  MODIFY `id_Hotel` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `paiement`
--
ALTER TABLE `paiement`
  MODIFY `id_Paiement` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `reservation`
--
ALTER TABLE `reservation`
  MODIFY `id_Reservation` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `restaurant`
--
ALTER TABLE `restaurant`
  MODIFY `id_Restaurant` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `salle`
--
ALTER TABLE `salle`
  MODIFY `id_Salle` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `type_chambre`
--
ALTER TABLE `type_chambre`
  MODIFY `id_Type_Chambre` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`id_Hotel`) REFERENCES `hotel` (`id_Hotel`) ON DELETE CASCADE;

--
-- Constraints for table `chambre`
--
ALTER TABLE `chambre`
  ADD CONSTRAINT `chambre_ibfk_1` FOREIGN KEY (`id_Type_Chambre`) REFERENCES `type_chambre` (`id_Type_Chambre`),
  ADD CONSTRAINT `chambre_ibfk_2` FOREIGN KEY (`id_Hotel`) REFERENCES `hotel` (`id_Hotel`) ON DELETE CASCADE;

--
-- Constraints for table `facture`
--
ALTER TABLE `facture`
  ADD CONSTRAINT `facture_ibfk_1` FOREIGN KEY (`id_Reservation`) REFERENCES `reservation` (`id_Reservation`);

--
-- Constraints for table `paiement`
--
ALTER TABLE `paiement`
  ADD CONSTRAINT `paiement_ibfk_1` FOREIGN KEY (`id_Facture`) REFERENCES `facture` (`id_Facture`);

--
-- Constraints for table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`id_Client`) REFERENCES `client` (`id_Client`) ON DELETE CASCADE,
  ADD CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`id_Chambre`) REFERENCES `chambre` (`id_Chambre`) ON DELETE CASCADE,
  ADD CONSTRAINT `reservation_ibfk_3` FOREIGN KEY (`id_Salle`) REFERENCES `salle` (`id_Salle`) ON DELETE CASCADE,
  ADD CONSTRAINT `reservation_ibfk_4` FOREIGN KEY (`id_Restaurant`) REFERENCES `restaurant` (`id_Restaurant`) ON DELETE CASCADE,
  ADD CONSTRAINT `reservation_ibfk_5` FOREIGN KEY (`id_Hotel`) REFERENCES `hotel` (`id_Hotel`) ON DELETE CASCADE;

--
-- Constraints for table `restaurant`
--
ALTER TABLE `restaurant`
  ADD CONSTRAINT `restaurant_ibfk_1` FOREIGN KEY (`id_Hotel`) REFERENCES `hotel` (`id_Hotel`) ON DELETE CASCADE;

--
-- Constraints for table `salle`
--
ALTER TABLE `salle`
  ADD CONSTRAINT `salle_ibfk_1` FOREIGN KEY (`id_Hotel`) REFERENCES `hotel` (`id_Hotel`) ON DELETE CASCADE;

--
-- Constraints for table `type_chambre`
--
ALTER TABLE `type_chambre`
  ADD CONSTRAINT `type_chambre_ibfk_1` FOREIGN KEY (`id_Hotel`) REFERENCES `hotel` (`id_Hotel`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
