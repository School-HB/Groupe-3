# Rapport de Clarification du Projet

Le projet a été restructuré pour séparer proprement la couche **Frontend (React)** de la couche **Backend (PHP)**, et pour corriger les erreurs de point d'entrée.

## Changements Majeurs

### 1. Structure des dossiers
- **Avant** : Mélange de fichiers `.jsx` et `.php` dans `frontend/groupe3`. Dossier `frontend/src` ignoré.
- **Après** : 
    - Tout le code React est dans `frontend/src/`.
    - Tous les scripts PHP sont centralisés dans `backend/`.
    - Suppression des fichiers doublons et des dossiers inutilisés (`frontend/groupe3` supprimé).

### 2. Points d'entrée
- **Racine** : `index.php` redirige maintenant correctement vers `frontend/index.html`.
- **Frontend** : `index.html` utilise désormais le flux standard Vite via `src/main.jsx` -> `src/App.jsx`.

### 3. Code et Configuration
- **API** : Création de `frontend/src/config.js` pour centraliser l'URL du backend (`API_BASE_URL`).
- **Composants** : Début de la migration des composants vers l'usage de cette constante (ex: `SaisieNotes.jsx`).
- **PHP** : Correction des chemins `require_once` et des actions de formulaires dans les scripts déplacés vers `backend/`.

## Comment lancer le projet ?

1.  **Frontend (Développement)** :
    ```bash
    cd frontend
    npm install
    npm run dev
    ```
2.  **Backend** : Assurez-vous que votre serveur local (WAMP/XAMPP/Laragon) pointe vers la racine du projet et que la base de données `ecole_plus` est configurée dans `backend/db.php`.

## Visualisation de la nouvelle arborescence
```text
Projet/
├── backend/ (Tous les scripts PHP)
│   ├── db.php
│   ├── login.php
│   ├── espace_parent.php
│   └── ...
├── frontend/ (Projet React + Vite)
│   ├── src/
│   │   ├── groupe3/ (Composants React)
│   │   ├── App.jsx (Routeur principal)
│   │   ├── config.js (Config API)
│   │   └── main.jsx
│   └── index.html
└── index.php (Point d'entrée racine)
```
