-- phpMyAdmin SQL Dump | ECOLE+ ULTIMATE COMPLETE DATABASE
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- Base de données : `ecole_plus`

-- --------------------------------------------------------
-- SCHEMA
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `role` enum('RESPONSABLE','ENSEIGNANT','PARENT','ELEVE') NOT NULL,
  `date_creation` timestamp NOT NULL DEFAULT current_timestamp(),
  `doit_changer_mdp` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `classes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `annee_scolaire` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `matieres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `coefficient` int(11) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `classe_matiere_coeff` (
  `classe_id` int(11) NOT NULL,
  `matiere_id` int(11) NOT NULL,
  `coefficient` decimal(4,2) NOT NULL,
  PRIMARY KEY (`classe_id`,`matiere_id`),
  CONSTRAINT `cmc_ibfk_1` FOREIGN KEY (`classe_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cmc_ibfk_2` FOREIGN KEY (`matiere_id`) REFERENCES `matieres` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `eleves` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `classe_id` int(11) NOT NULL,
  `serie_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `eleves_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `eleves_ibfk_2` FOREIGN KEY (`classe_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eleve_id` int(11) NOT NULL,
  `matiere_id` int(11) NOT NULL,
  `semestre_id` int(11) NOT NULL,
  `valeur` decimal(5,2) NOT NULL,
  `date_note` date DEFAULT curdate(),
  `statut` enum('BROUILLON','VALIDE') DEFAULT 'BROUILLON',
  `verrouille` tinyint(1) DEFAULT 0,
  `type_evaluation` enum('DEVOIR','INTERROGATION') DEFAULT 'DEVOIR',
  `numero_evaluation` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_note_eval` (`eleve_id`,`matiere_id`,`semestre_id`,`type_evaluation`,`numero_evaluation`),
  CONSTRAINT `notes_ibfk_1` FOREIGN KEY (`eleve_id`) REFERENCES `eleves` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notes_ibfk_2` FOREIGN KEY (`matiere_id`) REFERENCES `matieres` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `semestres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- CONFIGURATION
-- --------------------------------------------------------

INSERT INTO `semestres` (`id`, `nom`) VALUES (1, 'Semestre 1'), (2, 'Semestre 2');

INSERT INTO `classes` (`id`, `nom`, `annee_scolaire`) VALUES
(1, '6ème', '2025-2026'), (3, '5ème', '2025-2026'), (5, '4ème', '2025-2026'),
(7, '3ème', '2025-2026'), (10, '2nde C', '2025-2026'), (11, '1ère A', '2025-2026'),
(13, 'Tle A', '2025-2026');

INSERT INTO `matieres` (`id`, `nom`, `coefficient`) VALUES
(1, 'Lecture', 2), (2, 'Communication écrite', 3), (3, 'Anglais', 2),
(4, 'SVT', 2), (5, 'PCT', 2), (6, 'Maths', 4),
(7, 'Histoire & Géographie', 2), (8, 'EPS', 1), (9, 'Philosophie', 2),
(10, 'Français', 4), (11, 'Allemand', 2), (13, 'Espagnol', 2);

-- Mapping Classes/Matières (Strict)
INSERT INTO `classe_matiere_coeff` (`classe_id`, `matiere_id`, `coefficient`) VALUES
(1,1,2),(1,2,3),(1,3,2),(1,4,3),(1,6,4),(1,7,2),(1,8,1),
(3,1,2),(3,2,3),(3,3,2),(3,4,3),(3,6,4),(3,7,2),(3,8,1),
(5,1,2),(5,2,3),(5,3,2),(5,4,3),(5,6,4),(5,7,2),(5,8,1),
(7,1,2),(7,2,3),(7,3,2),(7,4,3),(7,6,4),(7,7,2),(7,8,1),
(10,3,2),(10,4,3),(10,5,3),(10,6,4),(10,7,2),(10,8,1),(10,9,2),(10,10,4),
(11,3,2),(11,4,3),(11,6,3),(11,7,2),(11,9,4),(11,10,4),(11,11,2),(11,13,2),
(13,3,2),(13,7,2),(13,9,4),(13,10,4),(13,11,2);

-- --------------------------------------------------------
-- UTILISATEURS & ELEVES
-- --------------------------------------------------------

INSERT INTO `users` (`id`, `nom`, `prenom`, `email`, `mot_de_passe`, `role`) VALUES
(1, 'Admin', 'Directeur', 'admin@gmail.com', '$2y$10$CerN86IYKnE1b9yvxKaZ.OvmiqFv3unbJrWwNTNLPfrvPbGsT2ONG', 'RESPONSABLE'),
(55, 'BAM', 'Ulrich', 'bam@ulrich.com', '$2y$10$JxgtmM5ge3w7pIl1hYSX9uegZ73BxokuWcBG3N4aejw3qpHGk.aV6', 'ELEVE'),
(57, 'BAMI', 'Ulk', 'bami@ulk.com', '$2y$10$D2PfFsqgR2e5klTLZQw8M.0KrBkMHXj98MnReXDxFfx.rbS7S3YWG', 'ELEVE'),
(59, 'AHIDAZAN', 'Ulrich', 'ahi@ulrich.com', '...', 'ELEVE'),
(61, 'NTCHA', 'Jo', 'ntcha@jo.com', '...', 'ELEVE'),
(63, 'NTCHA', 'Joseph', 'ntcha@joseph.com', '...', 'ELEVE'),
(65, 'BIG', 'Rolince', 'big@rolince.com', '...', 'ELEVE'),
(67, 'AG', 'Amir', 'ag@amir.com', '...', 'ELEVE'),
(69, 'DOSSOU', 'Charbel', 'dossou@charbel.com', '...', 'ELEVE'),
(71, 'AGO', 'Josias', 'ago@josias.com', '...', 'ELEVE'),
(73, 'AGOSSA', 'Man', 'agossa@man.com', '...', 'ELEVE'),
(79, 'FORE', 'Epiou', 'fore@epiou.com', '...', 'ELEVE'),
(81, 'OLA', 'Mash', 'ola@mash.com', '...', 'ELEVE'),
(83, 'ADE', 'Loan', 'loan@gmail.com', '...', 'ELEVE'),
(85, 'DOSSA', 'Charbel', 'charbel@gmail.com', '...', 'ELEVE'),
(87, 'JAM', 'Jean', 'jean@gmail.com', '...', 'ELEVE'),
(89, 'DJAM', 'Deen', 'deen@gmail.com', '...', 'ELEVE'),
(91, 'MAKOU', 'Anne', 'anne@gmail.com', '...', 'ELEVE'),
(93, 'HOUI', 'Marie', 'marie@gmail.com', '...', 'ELEVE'),
(95, 'KASSA', 'Dado', 'dado@gmail.com', '...', 'ELEVE'),
(97, 'AKOBI', 'Jacob', 'jacob@gmail.com', '...', 'ELEVE'),
(99, 'SOÏGBE', 'Géred', 'gered@gmail.com', '...', 'ELEVE'),
(101, 'BABO', 'Dim', 'dim@gmail.com', '...', 'ELEVE'),
(103, 'SUCCETTE', 'Bissap', 'bissap@gmail.com', '...', 'ELEVE'),
(105, 'JUS', 'Ananas', 'ananas@gmail.com', '...', 'ELEVE'),
(109, 'SUCCETTE', 'Caramelle', 'caramelle@gmail.com', '...', 'ELEVE'),
(111, 'IFRI', 'Labo', 'labo@gmail.com', '...', 'ELEVE'),
(113, 'AGBO', 'Camel', 'camel@gmail.com', '...', 'ELEVE'),
(115, 'ABOU', 'Florent', 'florent@gmail.com', '...', 'ELEVE'),
(117, 'KALI', 'Félix', 'felix@gmail.com', '...', 'ELEVE'),
(119, 'ABISSI', 'Flore', 'flore@gmail.com', '...', 'ELEVE'),
(126, 'ULRICH', 'Pol', 'pol@gmail.com', '...', 'ELEVE');

INSERT INTO `eleves` (`id`, `user_id`, `classe_id`) VALUES
(18,55,1),(19,57,1), -- 6ème
(20,59,3),(21,61,3), -- 5ème
(22,63,5),(23,65,5), -- 4ème
(24,67,7),(25,69,7), -- 3ème
(30,81,10),(31,83,10), -- 2nde C
(34,87,11),(35,89,11), -- 1ère A
(43,105,13),(51,126,13); -- Tle A

-- --------------------------------------------------------
-- NOTES GÉNÉRÉES (MASSIVE SEED)
-- --------------------------------------------------------

INSERT INTO `notes` (`eleve_id`, `matiere_id`, `semestre_id`, `valeur`, `statut`) VALUES
-- 6ème
(18,1,1,14.00,'VALIDE'),(18,2,1,12.00,'VALIDE'),(18,3,1,15.00,'VALIDE'),(18,4,1,13.00,'VALIDE'),(18,6,1,10.00,'VALIDE'),(18,7,1,14.00,'VALIDE'),
(18,1,2,15.00,'VALIDE'),(18,6,2,11.00,'VALIDE'),
(19,1,1,11.00,'VALIDE'),(19,2,1,10.00,'VALIDE'),(19,3,1,12.00,'VALIDE'),(19,4,1,11.00,'VALIDE'),(19,6,1,09.00,'VALIDE'),(19,7,1,10.00,'VALIDE'),
-- 5ème
(20,1,1,13.00,'VALIDE'),(20,2,1,12.00,'VALIDE'),(20,3,1,14.00,'VALIDE'),(20,6,1,15.00,'VALIDE'),
(20,1,2,14.00,'VALIDE'),(20,6,2,12.00,'VALIDE'),
(21,1,1,11.00,'VALIDE'),(21,2,1,10.00,'VALIDE'),(21,6,1,08.00,'VALIDE'),
-- 1ère A
(34,3,1,15.00,'VALIDE'),(34,6,1,12.00,'VALIDE'),(34,9,1,14.50,'VALIDE'),(34,11,1,17.00,'VALIDE'),(34,10,1,13.00,'VALIDE'),
(34,13,1,12.00,'VALIDE'),(34,9,2,15.00,'VALIDE'),
(35,3,1,11.00,'VALIDE'),(35,9,1,10.00,'VALIDE'),(35,11,1,11.00,'VALIDE'),(35,10,1,15.00,'VALIDE'),
-- Tle A
(43,3,1,12.00,'VALIDE'),(43,9,1,15.00,'VALIDE'),(43,11,1,14.00,'VALIDE'),(43,10,1,13.00,'VALIDE'),(43,7,1,12.00,'VALIDE'),
(51,3,1,14.00,'VALIDE'),(51,9,1,13.00,'VALIDE'),(51,11,1,12.00,'VALIDE'),(51,10,1,16.00,'VALIDE'),(51,7,1,15.00,'VALIDE'),
-- 4ème
(22,1,1,12.00,'VALIDE'),(22,6,1,11.00,'VALIDE'),(23,1,1,14.00,'VALIDE'),(23,6,1,13.00,'VALIDE'),
-- 3ème
(24,1,1,11.00,'VALIDE'),(24,6,1,10.00,'VALIDE'),(25,1,1,15.00,'VALIDE'),(25,6,1,14.00,'VALIDE');

COMMIT;
