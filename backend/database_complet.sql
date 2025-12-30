-- phpMyAdmin SQL Dump | ECOLE+ FULL MERGED DATABASE
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `ecole_plus`
--

-- --------------------------------------------------------
-- STRUCTURE DES TABLES
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
  PRIMARY KEY (`classe_id`,`matiere_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `eleves` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `classe_id` int(11) NOT NULL,
  `serie_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `enseignants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `matiere` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `enseignant_classe` (
  `enseignant_id` int(11) NOT NULL,
  `classe_id` int(11) NOT NULL,
  PRIMARY KEY (`enseignant_id`,`classe_id`)
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
  UNIQUE KEY `unique_note_eval` (`eleve_id`,`matiere_id`,`semestre_id`,`type_evaluation`,`numero_evaluation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `parents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `parent_eleve` (
  `parent_id` int(11) NOT NULL,
  `eleve_id` int(11) NOT NULL,
  PRIMARY KEY (`parent_id`,`eleve_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `responsables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `fonction` varchar(255) DEFAULT 'Administrateur',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `semestres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `bulletins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eleve_id` int(11) NOT NULL,
  `annee_scolaire` varchar(255) NOT NULL,
  `moyenne` decimal(5,2) DEFAULT NULL,
  `date_creation` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- DONNÉES DE CONFIGURATION
-- --------------------------------------------------------

INSERT INTO `semestres` (`id`, `nom`) VALUES (1, 'Semestre 1'), (2, 'Semestre 2');

INSERT INTO `classes` (`id`, `nom`, `annee_scolaire`) VALUES
(1, '6ème', '2025-2026'), (3, '5ème', '2025-2026'), (5, '4ème', '2025-2026'),
(7, '3ème', '2025-2026'), (9, '2nde A', '2025-2026'), (10, '2nde C', '2025-2026'),
(11, '1ère A', '2025-2026'), (12, '1ère D', '2025-2026'), (13, 'Tle A', '2025-2026'),
(14, 'Tle D', '2025-2026'), (15, '2nde D', '2023-2024'), (16, '2nde B', '2023-2024'),
(17, '1ère B', '2023-2024'), (18, '1ère C', '2023-2024'), (19, 'Tle B', '2023-2024'),
(20, 'Tle C', '2023-2024');

INSERT INTO `matieres` (`id`, `nom`, `coefficient`) VALUES
(1, 'Lecture', 2), (2, 'Communication écrite', 3), (3, 'Anglais', 2),
(4, 'SVT', 2), (5, 'PCT', 2), (6, 'Maths', 4),
(7, 'Histoire & Géographie', 2), (8, 'EPS', 1), (9, 'Philosophie', 2),
(10, 'Français', 4), (11, 'Allemand', 2), (12, 'Économie', 3), (13, 'Espagnol', 2);

-- Mapping Classes/Matières (Toutes les matières de base)
INSERT INTO `classe_matiere_coeff` (`classe_id`, `matiere_id`, `coefficient`) VALUES
(1,1,2),(1,2,3),(1,3,2),(1,4,2),(1,6,4),(1,7,2),(1,8,1),
(3,1,2),(3,2,3),(3,3,2),(3,4,2),(3,6,4),(3,7,2),(3,8,1),
(11,3,2),(11,6,2),(11,9,4),(11,10,4),(11,11,2),(11,13,2),
(13,3,2),(13,9,3),(13,10,4),(13,11,2),(13,7,2);

-- --------------------------------------------------------
-- UTILISATEURS (Admin, Profs, Élèves, Parents)
-- --------------------------------------------------------

INSERT INTO `users` (`id`, `nom`, `prenom`, `email`, `mot_de_passe`, `role`) VALUES
(1, 'Directeur', 'Admin', 'admin@gmail.com', '$2y$10$CerN86IYKnE1b9yvxKaZ.OvmiqFv3unbJrWwNTNLPfrvPbGsT2ONG', 'RESPONSABLE'),
-- Profs
(121, 'KOUAKOU', 'Elshson', 'kouakou@yahoo.fr', '$2y$10$Zvu0Nk8fikoxEe0CkGg6.uoEyI3pVHfSwzU8fclzQchebRzhH/936', 'ENSEIGNANT'),
(122, 'KPEKOU', 'Vad', 'vad@yahoo.fr', '$2y$10$jg.9XRTFxouqA7NLgP3Qeekvhh4E9/0ADmKyq8qNQwz7N3T7ii6Li', 'ENSEIGNANT'),
(123, 'SAGBO', 'Laurent', 'laurent@yahoo.fr', '$2y$10$eV0wYO62ey3REYnCxZi.LO8jCVGYufWrSfd7fEQ7H3Yl0UGHUn//C', 'ENSEIGNANT'),
(124, 'ALI', 'Boss', 'boss@yahoo.fr', '$2y$10$UnAo2LsTLao0syo6q50hFOM9NU5S6rE25yYRMUQFJTu38nTNkRIsq', 'ENSEIGNANT'),
(125, 'AKOWE', 'Kalil', 'kalil@yahoo.fr', '$2y$10$q0ZaYVb413KkW9Yx4qBo6uZlhEAMw6YDGRLHdT0qI3K7FtzoVlYM2', 'ENSEIGNANT'),
-- Élèves & Parents
(55, 'BAM', 'Ulrich', 'bam@ulrich.com', '...', 'ELEVE'), (56, 'BAM', 'Parent', 'parent@bam.com', '...', 'PARENT'),
(57, 'BAMI', 'Ulk', 'bami@ulk.com', '...', 'ELEVE'), (58, 'BAMI', 'Parent', 'parent@bami.com', '...', 'PARENT'),
(59, 'AHIDAZAN', 'Ulrich', 'ahi@ulrich.com', '...', 'ELEVE'), (60, 'AHIDAZAN', 'Parent', 'parent@ahi.com', '...', 'PARENT'),
(87, 'JAM', 'Jean', 'jean@gmail.com', '...', 'ELEVE'), (88, 'JAM', 'Parent', 'jam@gmail.com', '...', 'PARENT'),
(105, 'JUS', 'Ananas', 'ananas@gmail.com', '...', 'ELEVE'), (106, 'JUS', 'Parent', 'jus@gmail.com', '...', 'PARENT'),
(126, 'ULRICH', 'Pol', 'pol@gmail.com', '...', 'ELEVE'), (127, 'ulrich', 'Parent', 'go@gmail', '...', 'PARENT');

-- --------------------------------------------------------
-- STRUCTURES SPÉCIFIQUES (Profs, Élèves, Parents, Responsables)
-- --------------------------------------------------------

INSERT INTO `responsables` (`id`, `user_id`, `fonction`) VALUES (1, 1, 'Admin');

INSERT INTO `enseignants` (`id`, `user_id`, `matiere`) VALUES
(4, 121, 'Maths'), (5, 122, 'Histoire & Géographie'), (6, 123, 'SVT'), (7, 124, 'Anglais'), (8, 125, 'Communication écrite et Lecture');

INSERT INTO `enseignant_classe` (`enseignant_id`, `classe_id`) VALUES
(4,1),(4,3),(4,11),(4,13), (5,1),(5,13), (6,1),(7,1),(7,11),(7,13), (8,1);

INSERT INTO `eleves` (`id`, `user_id`, `classe_id`) VALUES
(18,55,1), (19,57,1), (20,59,3), (34,87,11), (43,105,13), (51,126,13);

INSERT INTO `parents` (`id`, `user_id`) VALUES
(3, 56), (4, 58), (5, 60), (19, 88), (28, 106), (35, 127);

INSERT INTO `parent_eleve` (`parent_id`, `eleve_id`) VALUES
(3, 18), (4, 19), (5, 20), (19, 34), (28, 43), (35, 51);

-- --------------------------------------------------------
-- NOTES COHÉRENTES
-- --------------------------------------------------------

INSERT INTO `notes` (`eleve_id`, `matiere_id`, `semestre_id`, `valeur`, `statut`) VALUES
-- 6ème
(18,1,1,14.00,'VALIDE'),(18,2,1,12.00,'VALIDE'),(18,3,1,15.00,'VALIDE'),(18,4,1,13.00,'VALIDE'),(18,6,1,10.00,'VALIDE'),(18,7,1,14.00,'VALIDE'),
(18,1,2,15.00,'VALIDE'),(18,6,2,11.00,'VALIDE'),
(19,1,1,11.00,'VALIDE'),(19,2,1,10.00,'VALIDE'),(19,3,1,12.00,'VALIDE'),(19,4,1,11.00,'VALIDE'),(19,6,1,09.00,'VALIDE'),(19,7,1,10.00,'VALIDE'),
-- 5ème
(20,1,1,13.00,'VALIDE'),(20,6,1,15.00,'VALIDE'),(20,1,2,14.00,'VALIDE'),(20,6,2,12.00,'VALIDE'),
-- 1ère A
(34,3,1,15.00,'VALIDE'),(34,6,1,12.00,'VALIDE'),(34,9,1,14.50,'VALIDE'),(34,11,1,17.00,'VALIDE'),(34,10,1,13.00,'VALIDE'),
-- Tle A
(43,3,1,12.00,'VALIDE'),(43,9,1,15.00,'VALIDE'),(43,11,1,14.00,'VALIDE'),(43,10,1,13.00,'VALIDE'),(43,7,1,12.00,'VALIDE'),
(51,3,1,14.00,'VALIDE'),(51,9,1,13.00,'VALIDE'),(51,11,1,12.00,'VALIDE'),(51,10,1,16.00,'VALIDE'),(51,7,1,15.00,'VALIDE');

-- --------------------------------------------------------
-- CONTRAINTES & INDEX
-- --------------------------------------------------------
ALTER TABLE `bulletins` ADD CONSTRAINT `bulletins_ibfk_1` FOREIGN KEY (`eleve_id`) REFERENCES `eleves` (`id`) ON DELETE CASCADE;
ALTER TABLE `eleves` ADD CONSTRAINT `eleves_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
ALTER TABLE `eleves` ADD CONSTRAINT `eleves_ibfk_2` FOREIGN KEY (`classe_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE;
ALTER TABLE `enseignants` ADD CONSTRAINT `enseignants_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
ALTER TABLE `enseignant_classe` ADD CONSTRAINT `ec_ibfk_1` FOREIGN KEY (`enseignant_id`) REFERENCES `enseignants` (`id`) ON DELETE CASCADE;
ALTER TABLE `enseignant_classe` ADD CONSTRAINT `ec_ibfk_2` FOREIGN KEY (`classe_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE;
ALTER TABLE `notes` ADD CONSTRAINT `notes_ibfk_1` FOREIGN KEY (`eleve_id`) REFERENCES `eleves` (`id`) ON DELETE CASCADE;
ALTER TABLE `notes` ADD CONSTRAINT `notes_ibfk_2` FOREIGN KEY (`matiere_id`) REFERENCES `matieres` (`id`) ON DELETE CASCADE;
ALTER TABLE `parents` ADD CONSTRAINT `parents_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
ALTER TABLE `parent_eleve` ADD CONSTRAINT `pe_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `parents` (`id`) ON DELETE CASCADE;
ALTER TABLE `parent_eleve` ADD CONSTRAINT `pe_ibfk_2` FOREIGN KEY (`eleve_id`) REFERENCES `eleves` (`id`) ON DELETE CASCADE;
ALTER TABLE `responsables` ADD CONSTRAINT `responsables_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

COMMIT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
