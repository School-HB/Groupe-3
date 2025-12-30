-- phpMyAdmin SQL Dump | ECOLE+ Correction Majeure
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- Base de données : `ecole_plus`

-- --------------------------------------------------------
-- Création des Tables (Schéma Complet)
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `users` (
  [id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2) int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `role` enum('RESPONSABLE','ENSEIGNANT','PARENT','ELEVE') NOT NULL,
  `date_creation` timestamp NOT NULL DEFAULT current_timestamp(),
  `doit_changer_mdp` tinyint(1) DEFAULT 0,
  PRIMARY KEY ([id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2)),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `classes` (
  [id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2) int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `annee_scolaire` varchar(255) NOT NULL,
  PRIMARY KEY ([id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `matieres` (
  [id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2) int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `coefficient` int(11) DEFAULT 1,
  PRIMARY KEY ([id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `classe_matiere_coeff` (
  `classe_id` int(11) NOT NULL,
  `matiere_id` int(11) NOT NULL,
  `coefficient` decimal(4,2) NOT NULL,
  PRIMARY KEY (`classe_id`,`matiere_id`),
  CONSTRAINT `cmc_ibfk_1` FOREIGN KEY (`classe_id`) REFERENCES `classes` ([id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2)) ON DELETE CASCADE,
  CONSTRAINT `cmc_ibfk_2` FOREIGN KEY (`matiere_id`) REFERENCES `matieres` ([id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2)) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `eleves` (
  [id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2) int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `classe_id` int(11) NOT NULL,
  `serie_id` int(11) DEFAULT NULL,
  PRIMARY KEY ([id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2)),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `eleves_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` ([id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2)) ON DELETE CASCADE,
  CONSTRAINT `eleves_ibfk_2` FOREIGN KEY (`classe_id`) REFERENCES `classes` ([id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2)) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `notes` (
  [id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2) int(11) NOT NULL AUTO_INCREMENT,
  `eleve_id` int(11) NOT NULL,
  `matiere_id` int(11) NOT NULL,
  `semestre_id` int(11) NOT NULL,
  `valeur` decimal(5,2) NOT NULL,
  `date_note` date DEFAULT curdate(),
  `statut` enum('BROUILLON','VALIDE') DEFAULT 'BROUILLON',
  `verrouille` tinyint(1) DEFAULT 0,
  `type_evaluation` enum('DEVOIR','INTERROGATION') DEFAULT 'DEVOIR',
  `numero_evaluation` tinyint(4) DEFAULT 1,
  PRIMARY KEY ([id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2)),
  UNIQUE KEY `unique_note_eval` (`eleve_id`,`matiere_id`,`semestre_id`,`type_evaluation`,`numero_evaluation`),
  CONSTRAINT `notes_ibfk_1` FOREIGN KEY (`eleve_id`) REFERENCES `eleves` ([id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2)) ON DELETE CASCADE,
  CONSTRAINT `notes_ibfk_2` FOREIGN KEY (`matiere_id`) REFERENCES `matieres` ([id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2)) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `parents` (
  [id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2) int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  PRIMARY KEY ([id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2)),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `parents_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` ([id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2)) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `parent_eleve` (
  `parent_id` int(11) NOT NULL,
  `eleve_id` int(11) NOT NULL,
  PRIMARY KEY (`parent_id`,`eleve_id`),
  CONSTRAINT `pe_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `parents` ([id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2)) ON DELETE CASCADE,
  CONSTRAINT `pe_ibfk_2` FOREIGN KEY (`eleve_id`) REFERENCES `eleves` ([id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2)) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `semestres` (
  [id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2) int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  PRIMARY KEY ([id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- Données de Configuration
-- --------------------------------------------------------

INSERT INTO `semestres` ([id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2), `nom`) VALUES (1, 'Semestre 1'), (2, 'Semestre 2');

INSERT INTO `classes` ([id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2), `nom`, `annee_scolaire`) VALUES
(1, '6ème', '2025-2026'), (3, '5ème', '2025-2026'), (5, '4ème', '2025-2026'),
(7, '3ème', '2025-2026'), (10, '2nde C', '2025-2026'), (11, '1ère A', '2025-2026');

INSERT INTO `matieres` ([id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2), `nom`, `coefficient`) VALUES
(1, 'Lecture', 2), (2, 'Communication écrite', 3), (3, 'Anglais', 2),
(4, 'SVT', 2), (5, 'PCT', 2), (6, 'Maths', 4),
(7, 'Histoire & Géographie', 2), (8, 'EPS', 1), (9, 'Philosophie', 2),
(10, 'Français', 4), (11, 'Allemand', 2);

-- Configuration Strict : 6ème n'a PAS d'Allemand ni de Philo
INSERT INTO `classe_matiere_coeff` (`classe_id`, `matiere_id`, `coefficient`) VALUES
(1, 1, 2.00), (1, 2, 3.00), (1, 3, 2.00), (1, 4, 3.00), (1, 6, 4.00), (1, 7, 2.00), (1, 8, 1.00),
(11, 3, 2.00), (11, 6, 3.00), (11, 9, 2.00), (11, 10, 4.00), (11, 11, 2.00);

-- --------------------------------------------------------
-- Utilisateurs (Admin & Élèves)
-- --------------------------------------------------------

INSERT INTO `users` ([id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2), `nom`, `prenom`, `email`, `mot_de_passe`, `role`) VALUES
(1, 'Directeur', 'Admin', 'admin@gmail.com', '$2y$10$CerN86IYKnE1b9yvxKaZ.OvmiqFv3unbJrWwNTNLPfrvPbGsT2ONG', 'RESPONSABLE'),
(55, 'BAM', 'Ulrich', 'bam@ulrich.com', '$2y$10$JxgtmM5ge3w7pIl1hYSX9uegZ73BxokuWcBG3N4aejw3qpHGk.aV6', 'ELEVE'),
(57, 'BAMI', 'Ulk', 'bami@ulk.com', '$2y$10$D2PfFsqgR2e5klTLZQw8M.0KrBkMHXj98MnReXDxFfx.rbS7S3YWG', 'ELEVE'),
(87, 'JAM', 'Jean', 'jean@gmail.com', '$2y$10$aPA6ebm9O/rF6ql4JJkN/.CGbU4eFf8d8osov8SDxGf/MevZLAKQC', 'ELEVE');

INSERT INTO `eleves` ([id](cci:1://file:///c:/xampp/htdocs/g3/ulk/frontend/src/groupe3/components/Common/Sidebar.jsx:3:0-109:2), `user_id`, `classe_id`) VALUES
(18, 55, 1), (19, 57, 1), (34, 87, 11);

-- --------------------------------------------------------
-- GÉNÉRATION DES NOTES COHÉRENTES
-- --------------------------------------------------------

INSERT INTO `notes` (`eleve_id`, `matiere_id`, `semestre_id`, `valeur`, `statut`, `type_evaluation`, `numero_evaluation`) VALUES
-- Ulrich (6ème - Pas d'allemand)
(18, 1, 1, 14.00, 'VALIDE', 'DEVOIR', 1), (18, 2, 1, 12.50, 'VALIDE', 'DEVOIR', 1),
(18, 3, 1, 15.00, 'VALIDE', 'DEVOIR', 1), (18, 6, 1, 11.00, 'VALIDE', 'DEVOIR', 1),
(18, 7, 1, 13.00, 'VALIDE', 'DEVOIR', 1), (18, 1, 2, 16.00, 'VALIDE', 'DEVOIR', 1),
(18, 6, 2, 10.50, 'VALIDE', 'DEVOIR', 1),

-- Ulk (6ème - Pas d'allemand)
(19, 1, 1, 11.00, 'VALIDE', 'DEVOIR', 1), (19, 2, 1, 09.00, 'VALIDE', 'DEVOIR', 1),
(19, 3, 1, 12.00, 'VALIDE', 'DEVOIR', 1), (19, 6, 1, 08.00, 'VALIDE', 'DEVOIR', 1),
(19, 7, 1, 10.00, 'VALIDE', 'DEVOIR', 1), (19, 1, 2, 13.00, 'VALIDE', 'DEVOIR', 1),

-- Jean (1ère A - A Allemand et Philo)
(34, 3, 1, 15.00, 'VALIDE', 'DEVOIR', 1), (34, 6, 1, 12.00, 'VALIDE', 'DEVOIR', 1),
(34, 9, 1, 14.50, 'VALIDE', 'DEVOIR', 1), (34, 10, 1, 13.00, 'VALIDE', 'DEVOIR', 1),
(34, 11, 1, 17.00, 'VALIDE', 'DEVOIR', 1), (34, 11, 2, 14.00, 'VALIDE', 'DEVOIR', 1);

COMMIT;