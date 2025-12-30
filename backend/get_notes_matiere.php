<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
require_once('db.php');

// Récupération de l'ID de la matière depuis l'URL
$matiere_id = $_GET['matiere_id'] ?? null;

if ($matiere_id) {
    try {
        // On utilise AS pour renommer les colonnes selon ce que ton React attend
        $sql = "SELECT u.nom, u.prenom, n.valeur AS note, n.date_note AS date_saisie 
                FROM notes n
                JOIN eleves e ON n.eleve_id = e.id
                JOIN users u ON e.user_id = u.id
                WHERE n.matiere_id = ?
                ORDER BY n.date_note DESC";
        
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$matiere_id]);
        $notes = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // Renvoie le tableau (vide ou rempli) au format JSON
        echo json_encode($notes);
    } catch (PDOException $e) {
        echo json_encode(["error" => $e->getMessage()]);
    }
} else {
    echo json_encode([]);
}
?>