-- phpMyAdmin SQL Dump | TOTAL RECOVERY PREMIUM
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- Base de données : `ecole_plus`

-- --------------------------------------------------------
-- STRUCTURE DES TABLES
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `bulletins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eleve_id` int(11) NOT NULL,
  `annee_scolaire` varchar(255) NOT NULL,
  `moyenne` decimal(5,2) DEFAULT NULL,
  `date_creation` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `classes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `annee_scolaire` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `classe_matiere_coeff` (
  `classe_id` int(11) NOT NULL,
  `matiere_id` int(11) NOT NULL,
  `coefficient` decimal(4,2) NOT NULL,
  PRIMARY KEY (`classe_id`,`matiere_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `coefficients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `matiere_id` int(11) NOT NULL,
  `valeur` int(11) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `deliberations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `classe_id` int(11) NOT NULL,
  `semestre_id` int(11) NOT NULL,
  `date_cloture` timestamp NOT NULL DEFAULT current_timestamp(),
  `responsable_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `eleves` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `classe_id` int(11) NOT NULL,
  `serie_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `enseignants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `matiere` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `enseignant_classe` (
  `enseignant_id` int(11) NOT NULL,
  `classe_id` int(11) NOT NULL,
  PRIMARY KEY (`enseignant_id`,`classe_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `evaluations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `matiere_id` int(11) NOT NULL,
  `eleve_id` int(11) NOT NULL,
  `semestre_id` int(11) NOT NULL,
  `valeur` decimal(5,2) NOT NULL,
  `date_eval` date DEFAULT curdate(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `matieres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `coefficient` int(11) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `type` enum('MAIL','WHATSAPP') DEFAULT 'MAIL',
  `statut` enum('EN_ATTENTE','ENVOYE','ECHEC') DEFAULT 'EN_ATTENTE',
  `date_envoi` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `parents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `parent_eleve` (
  `parent_id` int(11) NOT NULL,
  `eleve_id` int(11) NOT NULL,
  PRIMARY KEY (`parent_id`,`eleve_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `responsables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `fonction` varchar(255) DEFAULT 'Administrateur',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `semestres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `series` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `statistiques` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eleve_id` int(11) NOT NULL,
  `moyenne` decimal(5,2) DEFAULT NULL,
  `rang` int(11) DEFAULT NULL,
  `annee_scolaire` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- DONNÉES : CONFIGURATION
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

INSERT INTO `classe_matiere_coeff` (`classe_id`, `matiere_id`, `coefficient`) VALUES
(1,1,2),(1,2,3),(1,3,2),(1,4,2),(1,6,4),(1,7,2),(1,8,1),
(3,1,2),(3,2,3),(3,3,2),(3,4,2),(3,6,4),(3,7,2),(3,8,1),
(11,3,2),(11,6,2),(11,9,4),(11,10,4),(11,11,2),(11,13,2),
(13,3,2),(13,9,3),(13,10,4),(13,11,2),(13,7,2);

-- --------------------------------------------------------
-- DONNÉES : USERS & TEACHERS
-- --------------------------------------------------------

INSERT INTO `users` (`id`, `nom`, `prenom`, `email`, `mot_de_passe`, `role`) VALUES
(1, 'Directeur', 'Admin', 'admin@gmail.com', '$2y$10$CerN86IYKnE1b9yvxKaZ.OvmiqFv3unbJrWwNTNLPfrvPbGsT2ONG', 'RESPONSABLE'),
(121, 'KOUAKOU', 'Elshson', 'kouakou@yahoo.fr', '$2y$10$Zvu0Nk8fikoxEe0CkGg6.uoEyI3pVHfSwzU8fclzQchebRzhH/936', 'ENSEIGNANT'),
(122, 'KPEKOU', 'Vad', 'vad@yahoo.fr', '$2y$10$jg.9XRTFxouqA7NLgP3Qeekvhh4E9/0ADmKyq8qNQwz7N3T7ii6Li', 'ENSEIGNANT'),
(123, 'SAGBO', 'Laurent', 'laurent@yahoo.fr', '$2y$10$eV0wYO62ey3REYnCxZi.LO8jCVGYufWrSfd7fEQ7H3Yl0UGHUn//C', 'ENSEIGNANT'),
(124, 'ALI', 'Boss', 'boss@yahoo.fr', '$2y$10$UnAo2LsTLao0syo6q50hFOM9NU5S6rE25yYRMUQFJTu38nTNkRIsq', 'ENSEIGNANT'),
(125, 'AKOWE', 'Kalil', 'kalil@yahoo.fr', '$2y$10$q0ZaYVb413KkW9Yx4qBo6uZlhEAMw6YDGRLHdT0qI3K7FtzoVlYM2', 'ENSEIGNANT');

INSERT INTO `enseignants` (`id`, `user_id`, `matiere`) VALUES
(4, 121, 'Maths'), (5, 122, 'Histoire & Géographie'), (6, 123, 'SVT'), (7, 124, 'Anglais'), (8, 125, 'Communication écrite et Lecture');

INSERT INTO `enseignant_classe` (`enseignant_id`, `classe_id`) VALUES
(4,1),(4,3),(4,5),(4,7),(4,11),(4,13), (5,1),(5,13), (6,1),(7,1),(7,11),(7,13), (8,1),(8,3),(8,5);

-- --------------------------------------------------------
-- DONNÉES : STUDENTS & PARENTS (52 students)
-- --------------------------------------------------------

INSERT INTO `users` (`id`, `nom`, `prenom`, `email`, `mot_de_passe`, `role`) VALUES
(55, 'BAM', 'Ulrich', 'bam@ulrich.com', '...', 'ELEVE'), (56, 'BAM', 'Parent', 'parent@bam.com', '...', 'PARENT'),
(57, 'BAMI', 'Ulk', 'bami@ulk.com', '...', 'ELEVE'), (58, 'BAMI', 'Parent', 'parent@bami.com', '...', 'PARENT'),
(59, 'AHIDAZAN', 'Ulrich', 'ahi@ulrich.com', '...', 'ELEVE'), (60, 'AHIDAZAN', 'Parent', 'parent@ahi.com', '...', 'PARENT'),
(61, 'NTCHA', 'Jo', 'ntcha@jo.com', '...', 'ELEVE'), (62, 'NTCHA', 'Parent', 'parent@ntcha.com', '...', 'PARENT'),
(63, 'NTCHA', 'Joseph', 'ntcha@joseph.com', '...', 'ELEVE'), (64, 'NTCHA', 'Parent', 'parent@joseph.com', '...', 'PARENT'),
(65, 'BIG', 'Rolince', 'big@rolince.com', '...', 'ELEVE'), (66, 'BIG', 'Parent', 'parent@rolince.com', '...', 'PARENT'),
(67, 'AG', 'Amir', 'ag@amir.com', '...', 'ELEVE'), (68, 'AG', 'Parent', 'parent@amir.com', '...', 'PARENT'),
(69, 'DOSSOU', 'Charbel', 'dossou@charbel.com', '...', 'ELEVE'), (70, 'DOSSOU', 'Parent', 'parent@charbel.com', '...', 'PARENT'),
(71, 'AGO', 'Josias', 'ago@josias.com', '...', 'ELEVE'), (72, 'AGO', 'Parent', 'parent@josias.com', '...', 'PARENT'),
(73, 'AGOSSA', 'Man', 'agossa@man.com', '...', 'ELEVE'), (74, 'AGOSSA', 'Parent', 'parent@man.com', '...', 'PARENT'),
(79, 'FORE', 'Epiou', 'fore@epiou.com', '...', 'ELEVE'), (80, 'FORE', 'Parent', 'parent@epiou.com', '...', 'PARENT'),
(81, 'OLA', 'Mash', 'ola@mash.com', '...', 'ELEVE'), (82, 'OLA', 'Parent', 'parent@mash.com', '...', 'PARENT'),
(83, 'ADE', 'Loan', 'loan@gmail.com', '...', 'ELEVE'), (84, 'ADE', 'Parent', 'ade@gmail.com', '...', 'PARENT'),
(85, 'DOSSA', 'Charbel', 'charbel@gmail.com', '...', 'ELEVE'), (86, 'DOSSA', 'Parent', 'dossa@gmail.com', '...', 'PARENT'),
(87, 'JAM', 'Jean', 'jean@gmail.com', '...', 'ELEVE'), (88, 'JAM', 'Parent', 'jam@gmail.com', '...', 'PARENT'),
(89, 'DJAM', 'Deen', 'deen@gmail.com', '...', 'ELEVE'), (90, 'DJAM', 'Parent', 'djam@gmail.com', '...', 'PARENT'),
(91, 'MAKOU', 'Anne', 'anne@gmail.com', '...', 'ELEVE'), (92, 'MAKOU', 'Parent', 'makou@gmail.com', '...', 'PARENT'),
(93, 'HOUI', 'Marie', 'marie@gmail.com', '...', 'ELEVE'), (94, 'HOUI', 'Parent', 'houi@gmail.com', '...', 'PARENT'),
(95, 'KASSA', 'Dado', 'dado@gmail.com', '...', 'ELEVE'), (96, 'KASSA', 'Parent', 'kassa@gmail.com', '...', 'PARENT'),
(97, 'AKOBI', 'Jacob', 'jacob@gmail.com', '...', 'ELEVE'), (98, 'AKOBI', 'Parent', 'akobi@gmail.com', '...', 'PARENT'),
(99, 'SOÏGBE', 'Géred', 'gered@gmail.com', '...', 'ELEVE'), (100, 'SOÏGBE', 'Parent', 'soigbe@gmail.com', '...', 'PARENT'),
(101, 'BABO', 'Dim', 'dim@gmail.com', '...', 'ELEVE'), (102, 'BABO', 'Parent', 'babo@gmail.com', '...', 'PARENT'),
(103, 'SUCCETTE', 'Bissap', 'bissap@gmail.com', '...', 'ELEVE'), (104, 'SUCCETTE', 'Parent', 'succette@gmail.com', '...', 'PARENT'),
(105, 'JUS', 'Ananas', 'ananas@gmail.com', '...', 'ELEVE'), (106, 'JUS', 'Parent', 'jus@gmail.com', '...', 'PARENT'),
(117, 'KALI', 'Félix', 'felix@gmail.com', '...', 'ELEVE'), (118, 'KALI', 'Parent', 'kali@gmail.com', '...', 'PARENT');

INSERT INTO `eleves` (`id`, `user_id`, `classe_id`) VALUES
(18,55,1),(19,57,1),(20,59,3),(21,61,3),(22,63,5),(23,65,5),(24,67,7),(25,69,7),
(30,79,10),(31,81,10),(32,83,15),(33,85,15),(34,87,11),(35,89,11),
(43,105,13),(49,117,14);

INSERT INTO `parents` (`id`, `user_id`) VALUES
(3,56),(4,58),(5,60),(6,62),(7,64),(8,66),(9,68),(10,70),(15,80),(16,82),(17,84),(18,86),(19,88),(20,90),(28,106),(33,118);

INSERT INTO `parent_eleve` (`parent_id`, `eleve_id`) VALUES
(3,18),(4,19),(5,20),(6,21),(7,22),(8,23),(9,24),(10,25),(15,30),(16,31),(17,32),(18,33),(19,34),(20,35),(28,43),(33,49);

-- --------------------------------------------------------
-- RICH NOTES DATA (Interros + Devoirs pour éviter le vide)
-- --------------------------------------------------------

INSERT INTO `notes` (`eleve_id`, `matiere_id`, `semestre_id`, `valeur`, `statut`, `type_evaluation`, `numero_evaluation`) VALUES
-- 18 (6ème) - Lecture
(18,1,1,14.00,'VALIDE','INTERROGATION',1), (18,1,1,12.00,'VALIDE','INTERROGATION',2), (18,1,1,15.00,'VALIDE','DEVOIR',1),
(18,1,2,11.00,'VALIDE','INTERROGATION',1), (18,1,2,16.00,'VALIDE','DEVOIR',1),
-- 18 (6ème) - Com Ecrite
(18,2,1,13.00,'VALIDE','INTERROGATION',1), (18,2,1,15.00,'VALIDE','DEVOIR',1),
-- 19 (6ème) - Lecture
(19,1,1,08.00,'VALIDE','INTERROGATION',1), (19,1,1,10.00,'VALIDE','INTERROGATION',2), (19,1,1,09.00,'VALIDE','DEVOIR',1),
-- 20 (5ème)
(20,1,1,12.50,'VALIDE','INTERROGATION',1), (20,1,1,14.00,'VALIDE','DEVOIR',1), (20,6,1,11.00,'VALIDE','DEVOIR',1),
-- 34 (1ère A)
(34,3,1,15.00,'VALIDE','INTERROGATION',1), (34,3,1,14.00,'VALIDE','DEVOIR',1),
(34,9,1,12.00,'VALIDE','DEVOIR',1), (34,11,1,16.00,'VALIDE','DEVOIR',1),
-- Tle A (43)
(43,3,1,11.00,'VALIDE','INTERROGATION',1), (43,3,1,13.00,'VALIDE','DEVOIR',1),
(43,9,1,14.00,'VALIDE','DEVOIR',1);

-- --------------------------------------------------------
-- CONTRAINTES & FINITIONS
-- --------------------------------------------------------

INSERT INTO `responsables` (`id`, `user_id`, `fonction`) VALUES (1, 1, 'Admin');

ALTER TABLE `bulletins` ADD CONSTRAINT `b_fk1` FOREIGN KEY (`eleve_id`) REFERENCES `eleves` (`id`) ON DELETE CASCADE;
ALTER TABLE `classe_matiere_coeff` ADD CONSTRAINT `cmc_fk1` FOREIGN KEY (`classe_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE;
ALTER TABLE `enseignant_classe` ADD CONSTRAINT `ec_fk1` FOREIGN KEY (`enseignant_id`) REFERENCES `enseignants` (`id`) ON DELETE CASCADE;
ALTER TABLE `parent_eleve` ADD CONSTRAINT `pe_fk1` FOREIGN KEY (`parent_id`) REFERENCES `parents` (`id`) ON DELETE CASCADE;
ALTER TABLE `parent_eleve` ADD CONSTRAINT `pe_fk2` FOREIGN KEY (`eleve_id`) REFERENCES `eleves` (`id`) ON DELETE CASCADE;

COMMIT;
