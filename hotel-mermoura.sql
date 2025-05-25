-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 25, 2025 at 07:38 PM
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
  `id_Hotel` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, 7, 'Empty', 1),
(2, 7, 'Empty', 1),
(3, 7, 'Empty', 1),
(4, 7, 'Empty', 1),
(5, 7, 'Empty', 1),
(6, 7, 'Empty', 1),
(7, 7, 'Empty', 1),
(8, 7, 'Empty', 1),
(9, 7, 'Empty', 1),
(10, 7, 'Empty', 1),
(11, 7, 'Empty', 1),
(12, 7, 'Empty', 1),
(13, 7, 'Empty', 1),
(14, 7, 'Empty', 1),
(15, 7, 'Empty', 1),
(16, 7, 'Empty', 1),
(17, 7, 'Empty', 1),
(18, 7, 'Empty', 1),
(19, 7, 'Empty', 1),
(20, 7, 'Empty', 1),
(21, 8, 'Empty', 1),
(22, 8, 'Empty', 1),
(23, 8, 'Empty', 1),
(24, 8, 'Empty', 1),
(25, 8, 'Empty', 1),
(26, 8, 'Empty', 1),
(27, 8, 'Empty', 1),
(28, 8, 'Empty', 1),
(29, 8, 'Empty', 1),
(30, 8, 'Empty', 1),
(31, 8, 'Empty', 1),
(32, 8, 'Empty', 1),
(33, 8, 'Empty', 1),
(34, 8, 'Empty', 1),
(35, 8, 'Empty', 1),
(36, 9, 'Empty', 1),
(37, 9, 'Empty', 1),
(38, 9, 'Empty', 1),
(39, 9, 'Empty', 1),
(40, 9, 'Empty', 1),
(41, 9, 'Empty', 1),
(42, 9, 'Empty', 1),
(43, 9, 'Empty', 1),
(44, 9, 'Empty', 1),
(45, 9, 'Empty', 1),
(46, 9, 'Empty', 1),
(47, 9, 'Empty', 1),
(48, 10, 'Empty', 1),
(49, 10, 'Empty', 1),
(50, 10, 'Empty', 1),
(51, 10, 'Empty', 1),
(52, 10, 'Empty', 1),
(53, 10, 'Empty', 1),
(54, 10, 'Empty', 1),
(55, 10, 'Empty', 1),
(56, 10, 'Empty', 1),
(57, 10, 'Empty', 1),
(58, 10, 'Empty', 1),
(59, 10, 'Empty', 1),
(60, 11, 'Empty', 1),
(61, 11, 'Empty', 1),
(62, 11, 'Empty', 1),
(63, 11, 'Empty', 1),
(64, 11, 'Empty', 1),
(65, 11, 'Empty', 1),
(66, 11, 'Empty', 1),
(67, 11, 'Empty', 1),
(68, 11, 'Empty', 1),
(69, 12, 'Empty', 1),
(70, 12, 'Empty', 1),
(71, 12, 'Empty', 1),
(72, 12, 'Empty', 1),
(73, 12, 'Empty', 1),
(74, 12, 'Empty', 1),
(75, 12, 'Empty', 1),
(76, 12, 'Empty', 1);

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
  `id_Reservation_Chambre` int(11) DEFAULT NULL,
  `id_Reservation_Restaurant` int(11) DEFAULT NULL,
  `id_Reservation_Salle` int(11) DEFAULT NULL
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
(1, 'Mermoura', 4);

-- --------------------------------------------------------

--
-- Table structure for table `paiement`
--

CREATE TABLE `paiement` (
  `id_Paiement` int(11) NOT NULL,
  `mode_paiement` varchar(20) NOT NULL,
  `montant` decimal(10,2) NOT NULL,
  `date_paiement` date NOT NULL,
  `id_Facture` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reservation_chambre`
--

CREATE TABLE `reservation_chambre` (
  `id_Reservation` int(11) NOT NULL,
  `Date_Arive` date NOT NULL,
  `Date_Depart` date NOT NULL,
  `Nbre_personnes` int(11) NOT NULL,
  `id_Client` int(11) NOT NULL,
  `id_Chambre` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reservation_restaurant`
--

CREATE TABLE `reservation_restaurant` (
  `id_Reservation` int(11) NOT NULL,
  `Date_Arive` date NOT NULL,
  `Nbre_personnes` int(11) NOT NULL,
  `id_Client` int(11) NOT NULL,
  `id_Restaurant` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reservation_salle`
--

CREATE TABLE `reservation_salle` (
  `id_Reservation` int(11) NOT NULL,
  `Date_Arive` date NOT NULL,
  `Nbre_personnes` int(11) NOT NULL,
  `id_Client` int(11) NOT NULL,
  `id_Salle` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `restaurant`
--

CREATE TABLE `restaurant` (
  `id_Restaurant` int(11) NOT NULL,
  `capacite` int(11) NOT NULL,
  `Kitchen_type` varchar(100) NOT NULL,
  `id_Hotel` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `salle`
--

CREATE TABLE `salle` (
  `id_Salle` int(11) NOT NULL,
  `Type_salle` enum('fetes','conference') NOT NULL,
  `capacite` int(11) NOT NULL,
  `Prix` decimal(10,2) NOT NULL,
  `id_Hotel` int(11) NOT NULL
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
(7, 'Single', 5000.00, 20, 1),
(8, 'Double', 8000.00, 15, 1),
(9, 'Junior-Single', 10000.00, 12, 1),
(10, 'Junior-Double', 13000.00, 12, 1),
(11, 'Apart-Single', 15000.00, 9, 1),
(12, 'Apart-Double', 18000.00, 8, 1);

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
  ADD KEY `id_Reservation_Chambre` (`id_Reservation_Chambre`),
  ADD KEY `id_Reservation_Restaurant` (`id_Reservation_Restaurant`),
  ADD KEY `id_Reservation_Salle` (`id_Reservation_Salle`);

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
-- Indexes for table `reservation_chambre`
--
ALTER TABLE `reservation_chambre`
  ADD PRIMARY KEY (`id_Reservation`),
  ADD KEY `id_Client` (`id_Client`),
  ADD KEY `id_Chambre` (`id_Chambre`);

--
-- Indexes for table `reservation_restaurant`
--
ALTER TABLE `reservation_restaurant`
  ADD PRIMARY KEY (`id_Reservation`),
  ADD KEY `id_Client` (`id_Client`),
  ADD KEY `id_Restaurant` (`id_Restaurant`);

--
-- Indexes for table `reservation_salle`
--
ALTER TABLE `reservation_salle`
  ADD PRIMARY KEY (`id_Reservation`),
  ADD KEY `id_Client` (`id_Client`),
  ADD KEY `id_Salle` (`id_Salle`);

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
  MODIFY `id_Admin` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chambre`
--
ALTER TABLE `chambre`
  MODIFY `id_Chambre` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `client`
--
ALTER TABLE `client`
  MODIFY `id_Client` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `facture`
--
ALTER TABLE `facture`
  MODIFY `id_Facture` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hotel`
--
ALTER TABLE `hotel`
  MODIFY `id_Hotel` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `paiement`
--
ALTER TABLE `paiement`
  MODIFY `id_Paiement` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reservation_chambre`
--
ALTER TABLE `reservation_chambre`
  MODIFY `id_Reservation` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reservation_restaurant`
--
ALTER TABLE `reservation_restaurant`
  MODIFY `id_Reservation` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reservation_salle`
--
ALTER TABLE `reservation_salle`
  MODIFY `id_Reservation` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id_Type_Chambre` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
  ADD CONSTRAINT `facture_ibfk_1` FOREIGN KEY (`id_Reservation_Chambre`) REFERENCES `reservation_chambre` (`id_Reservation`),
  ADD CONSTRAINT `facture_ibfk_2` FOREIGN KEY (`id_Reservation_Restaurant`) REFERENCES `reservation_restaurant` (`id_Reservation`),
  ADD CONSTRAINT `facture_ibfk_3` FOREIGN KEY (`id_Reservation_Salle`) REFERENCES `reservation_salle` (`id_Reservation`);

--
-- Constraints for table `paiement`
--
ALTER TABLE `paiement`
  ADD CONSTRAINT `paiement_ibfk_1` FOREIGN KEY (`id_Facture`) REFERENCES `facture` (`id_Facture`);

--
-- Constraints for table `reservation_chambre`
--
ALTER TABLE `reservation_chambre`
  ADD CONSTRAINT `reservation_chambre_ibfk_1` FOREIGN KEY (`id_Client`) REFERENCES `client` (`id_Client`) ON DELETE CASCADE,
  ADD CONSTRAINT `reservation_chambre_ibfk_2` FOREIGN KEY (`id_Chambre`) REFERENCES `chambre` (`id_Chambre`) ON DELETE CASCADE;

--
-- Constraints for table `reservation_restaurant`
--
ALTER TABLE `reservation_restaurant`
  ADD CONSTRAINT `reservation_restaurant_ibfk_1` FOREIGN KEY (`id_Client`) REFERENCES `client` (`id_Client`) ON DELETE CASCADE,
  ADD CONSTRAINT `reservation_restaurant_ibfk_2` FOREIGN KEY (`id_Restaurant`) REFERENCES `restaurant` (`id_Restaurant`) ON DELETE CASCADE;

--
-- Constraints for table `reservation_salle`
--
ALTER TABLE `reservation_salle`
  ADD CONSTRAINT `reservation_salle_ibfk_1` FOREIGN KEY (`id_Client`) REFERENCES `client` (`id_Client`) ON DELETE CASCADE,
  ADD CONSTRAINT `reservation_salle_ibfk_2` FOREIGN KEY (`id_Salle`) REFERENCES `salle` (`id_Salle`) ON DELETE CASCADE;

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
