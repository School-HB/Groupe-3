# 🏫 ECOLE+ v3.1 Premium | Système de Pilotage Académique

> **L'excellence n'est pas un acte, c'est une habitude.** ECOLE+ est une plateforme de gestion scolaire moderne conçue pour digitaliser l'intégralité du cycle de vie académique : de la configuration des classes à la délibération finale des résultats.

---

## 💎 Écosystème de Fonctionnalités

### 🚀 Cockpit de Pilotage (Administration)
*   **Tableau de Bord Holistique** : Visualisation en temps réel des statistiques clés (taux de réussite, effectifs, alertes).
*   **Configuration Académique** : Gestion structurée des Classes, Séries (A, B, C, D) et Matières.
*   **Pondération Intelligente** : Matrice de coefficients personnalisables par classe et par matière.
*   **Gestion du Staff & Élèves** : Interface de déploiement des enseignants et inscription des élèves avec comptes parents liés.

### 📝 Gestion des Évaluations (Pôle Enseignant)
*   **Saisie Dynamique** : Interface premium pour la saisie des notes (Interrogations, Devoirs, Examens).
*   **Multi-Matières** : Support natif des matières combinées (ex: "Communication écrite et Lecture").
*   **Workflow de Validation** : Système d'état (Brouillon > Validé) garantissant l'intégrité des données avant calcul des moyennes.
*   **Dashboard Matière** : Vue analytique par classe et par sujet pour chaque enseignant.

### 📈 Analytique & Délibération
*   **Moteur de Calcul Avancé** : Calcul automatique des moyennes semestrielles et annuelles selon les pondérations.
*   **Instance de Délibération** : Outil de clôture officielle permettant de verrouiller les notes et de générer les décisions d'admission.
*   **Générateur de Bulletins** : Production de bulletins professionnels (Semestriels & Annuels) au format PDF.
*   **Logs & Notifications** : Historique des communications avec les familles et logs système.

---

## 🛠️ Architecture Technique

Le projet repose sur une architecture hybride optimisée pour la performance et la simplicité de déploiement :

| Composant | Technologie | Rôle |
| :--- | :--- | :--- |
| **Frontend** | React 19 (Vite) | Interface Glassmorphism ultra-réactive et moderne. |
| **Backend** | Pure PHP 8.x | API REST et logique métier robuste (sans dépendances lourdes). |
| **Database** | MySQL | Schéma relationnel optimisé pour le suivi scolaire. |
| **Sécurité** | Session / Auth | Système de rôles (Admin, Enseignant). |

---

## 🚀 Guide d'Installation

### 1️⃣ Préparation de la Base de Données (XAMPP)
1.  Lancez **Apache** et **MySQL** via XAMPP.
2.  Accédez à [phpMyAdmin](http://localhost/phpmyadmin).
3.  Créez une base nommée `ecole_plus`.
4.  Importez le fichier `backend/database_complet.sql`.
    > [!NOTE]
    > L'importation inclut déjà un jeu de données de test complet : classes configurées, élèves inscrits et notes de base déjà saisies pour tester immédiatement les bulletins et statistiques.


### 2️⃣ Configuration du Backend
1.  Assurez-vous que le dossier du projet est dans `C:\xampp\htdocs\ulk`.
2.  Vérifiez les accès dans `backend/db.php` (host, user, password).

### 3️⃣ Lancement du Frontend
1.  Ouvrez un terminal dans le dossier `/frontend`.
2.  Installez les dépendances :
    ```bash
    npm install
    ```
3.  Démarrez le serveur de développement :
    ```bash
    npm run dev
    ```
4.  Ouvrez l'URL qui s'affiche dans le terminal.
--

## 🔑 Identifiants de Démo

| Profil | Email | Mot de passe |
| :--- | :--- | :--- |
| **Administrateur** | `admin@gmail.com` | `admin123` |
| **Enseignant** | `kalil@yahoo.fr` | `123456` (enseignant de Com-écrite et Lecture) |


---
© 2025 - Projet ECOLE+ Premium v3.1. Développé pour l'excellence académique.
