<?php
session_start(); // Initialise la session pour pouvoir la détruire

// On vide toutes les variables de session
$_SESSION = array();

// On détruit la session
session_destroy();

// Redirection vers la page de login ou l'accueil
header("Location: ../frontend/login.php");
exit;
?>