import React from 'react';
import { BrowserRouter as Router, Routes, Route, useLocation, Navigate } from 'react-router-dom';
import './App.css';

import DashboardNotes from './groupe3/DashboardNotes.jsx';
import SaisieNotes from './groupe3/SaisieNotes.jsx';
import NotesParMatiere from './groupe3/NotesParMatiere.jsx';
import BulletinEleve from './groupe3/BulletinEleve.jsx';
import AjoutEleve from "./groupe3/AjoutEleve.jsx";
import ChangePassword from './groupe3/ChangePassword.jsx';
import ConsulterBulletin from "./groupe3/ConsulterBulletin.jsx";
import Statistiques from "./groupe3/Statistiques.jsx";
import Deliberation from "./groupe3/Deliberation.jsx";
import NotificationLogs from "./groupe3/NotificationLogs.jsx";
import ConfigAdmin from "./groupe3/ConfigAdmin.jsx";
import GestionEnseignants from "./groupe3/GestionEnseignants.jsx";
import Login from "./groupe3/Login.jsx";

import Sidebar from './groupe3/components/Common/Sidebar.jsx';

const AppContent = () => {
  const location = useLocation();
  const isLoginPage = location.pathname === '/login';

  const user = JSON.parse(localStorage.getItem('user') || 'null');
  const mustChangePassword = user && parseInt(user.doit_changer_mdp) === 1;

  // Redirection si non connecté
  if (!user && !isLoginPage) {
    return <Navigate to="/login" replace />;
  }

  // Si l'utilisateur doit changer son mot de passe, on le bloque sur la page sécurité
  if (mustChangePassword && location.pathname !== '/profil/securite' && !isLoginPage) {
    return <Navigate to="/profil/securite" replace />;
  }

  return (
    <div className="app-wrapper">
      {!isLoginPage && <Sidebar />}
      <main className="main-content" style={{ padding: isLoginPage ? '0' : '40px' }}>
        <Routes>
          <Route path="/login" element={<Login />} />
          <Route path="/notes" element={<DashboardNotes />} />
          <Route path="/notes/saisie" element={<SaisieNotes />} />
          <Route path="/notes/matieres" element={<NotesParMatiere />} />
          <Route path="/notes/bulletin/:id" element={<BulletinEleve />} />
          <Route path="/" element={<DashboardNotes />} />
          <Route path="/notes/ajouter-eleve" element={<AjoutEleve />} />
          <Route path="/profil/securite" element={<ChangePassword />} />
          <Route path="/bulletins" element={<ConsulterBulletin />} />
          <Route path="/stats" element={<Statistiques />} />
          <Route path="/deliberation" element={<Deliberation />} />
          <Route path="/notifications" element={<NotificationLogs />} />
          <Route path="/config" element={<ConfigAdmin />} />
          <Route path="/config/enseignants" element={<GestionEnseignants />} />
        </Routes>
      </main>
    </div>
  );
};

function App() {
  return (
    <Router>
      <AppContent />
    </Router>
  );
}

export default App;
