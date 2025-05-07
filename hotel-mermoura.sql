-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 07, 2025 at 01:45 AM
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
(1, 'abdou', 'mezghache', 'abdou_mzgh', '$2y$10$PnpErkqctBLUspQup7B76ed4kIlOfQ32T3JtP0x0UraWWXpEy0OVW', 1),
(2, 'abdou', 'mezghache', 'marwen_haine', '$2y$10$eHtAtn2QjPCzYNeAKeMvvuM/UaSnP.Hey0pWQyuQIfIUFGPyb6bpm', 1),
(3, 'abdou', 'Aidoud', 'sir09charles', '$2y$10$c.wnvBrnVedVn/jGGcwECOvbLsiUT7uaDUplGMisDTFinowbf3cpm', 1),
(4, 'Shahd', 'mezghache', 'hadjer_bouragbi', '$2y$10$SrloQPAlpyu9JCKt/b.atuvazdrBuCjByGUTO4KHFfnKBXcuRj42e', 1),
(5, 'Shahd', 'Aidoud', 'shahd', '$2y$10$JYJ6WK.sH/XkwFiaQFqFR.jo51G.VX6n.PqkK2QLcgbRZw7clvOOq', 1);

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
(5, 1, 'Occupied', 1),
(6, 2, 'Empty', 1),
(7, 3, 'Empty', 1),
(9, 1, 'Empty', 1),
(10, 2, 'Empty', 1),
(11, 3, 'Empty', 1),
(13, 1, 'Empty', 1),
(14, 2, 'Empty', 1),
(15, 3, 'Empty', 1),
(16, 4, 'Empty', 1),
(17, 5, 'Empty', 1),
(18, 6, 'Empty', 1);

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

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`id_Client`, `FName_Client`, `LName_Client`, `Phone_Client`, `Email_Client`) VALUES
(1, 'abdou', 'Mezghache', '0791494240', 'abdou09mzgh@gmail.com');

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

--
-- Dumping data for table `facture`
--

INSERT INTO `facture` (`id_Facture`, `montant_total`, `date_facture`, `id_Reservation`) VALUES
(1, 500.00, '2025-05-07', 1);

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
  `id_Hotel` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reservation`
--

INSERT INTO `reservation` (`id_Reservation`, `Date_Arive`, `Date_Depart`, `Nbre_personnes`, `id_Client`, `id_Chambre`, `id_Salle`, `id_Hotel`) VALUES
(1, '2025-05-07', '2025-05-17', 1, 1, 5, NULL, 1);

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
(1, 'Single', 50.00, 20, 1),
(2, 'Double', 80.00, 0, 1),
(3, '', 60.00, 0, 1),
(4, '', 90.00, 0, 1),
(5, '', 100.00, 0, 1),
(6, '', 150.00, 0, 1);

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
  MODIFY `id_Admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `chambre`
--
ALTER TABLE `chambre`
  MODIFY `id_Chambre` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `client`
--
ALTER TABLE `client`
  MODIFY `id_Client` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `facture`
--
ALTER TABLE `facture`
  MODIFY `id_Facture` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
-- AUTO_INCREMENT for table `reservation`
--
ALTER TABLE `reservation`
  MODIFY `id_Reservation` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  ADD CONSTRAINT `reservation_ibfk_4` FOREIGN KEY (`id_Hotel`) REFERENCES `hotel` (`id_Hotel`) ON DELETE CASCADE;

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
