<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
require_once('db.php');

$eleve_id = $_POST['eleve_id'] ?? '';
$matiere_id = $_POST['matiere_id'] ?? '';
$valeur = $_POST['note'] ?? ''; 
// On ajoute le semestre car il est obligatoire (NO NULL) dans ta base
$semestre_id = $_POST['semestre_id'] ?? 1; 

if ($eleve_id && $matiere_id && $valeur !== '') {
    try {
        // Correction selon ta structure : valeur, semestre_id, date_note
        $sql = "INSERT INTO notes (eleve_id, matiere_id, semestre_id, valeur, date_note) 
                VALUES (?, ?, ?, ?, NOW())";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$eleve_id, $matiere_id, $semestre_id, $valeur]);
        
        echo json_encode(["success" => true]);
    } catch (Exception $e) {
        echo json_encode(["success" => false, "error" => "Erreur BDD: " . $e->getMessage()]);
    }
} else {
    echo json_encode(["success" => false, "error" => "Données incomplètes"]);
}