<?php
/**
 * Script de remplissage aléatoire des notes
 * Objectif: 1 à 2 admis par classe (moyenne >= 10), les autres échouent.
 * Ne touche pas aux notes existantes.
 */

require_once('db.php');

// Paramètres de configuration
$config = [
    'interrogations' => 3, // Nombre d'I par semestre
    'devoirs' => 2,        // Nombre de D par semestre
    'examens' => 1,        // Nombre d'E par semestre
];

try {
    // 1. Récupérer toutes les classes
    $classes = $pdo->query("SELECT id, nom FROM classes")->fetchAll(PDO::FETCH_ASSOC);
    $matieres = $pdo->query("SELECT id, nom FROM matieres")->fetchAll(PDO::FETCH_ASSOC);
    $semestres = [1, 2];

    echo "Démarrage du seeding...\n";

    foreach ($classes as $classe) {
        echo "Traitement de la classe: {$classe['nom']}\n";

        // 2. Récupérer les élèves de cette classe
        $stmtEleves = $pdo->prepare("SELECT id FROM eleves WHERE classe_id = ?");
        $stmtEleves->execute([$classe['id']]);
        $eleves = $stmtEleves->fetchAll(PDO::FETCH_ASSOC);

        if (empty($eleves)) continue;

        // 3. Désigner 1 ou 2 "admis" aléatoirement
        shuffle($eleves);
        $quotaAdmis = rand(1, 2);
        $admisIds = array_slice(array_column($eleves, 'id'), 0, $quotaAdmis);

        foreach ($eleves as $eleve) {
            $isAdmis = in_array($eleve['id'], $admisIds);
            
            foreach ($matieres as $matiere) {
                foreach ($semestres as $semestre) {
                    
                    // Vérifier si des notes existent déjà pour ce triplet (eleve, matiere, semestre)
                    $stmtCheck = $pdo->prepare("SELECT COUNT(*) FROM notes WHERE eleve_id = ? AND matiere_id = ? AND semestre_id = ?");
                    $stmtCheck->execute([$eleve['id'], $matiere['id'], $semestre]);
                    if ($stmtCheck->fetchColumn() > 0) continue;

                    // Moyenne souhaitée
                    $valMoyenne = $isAdmis ? rand(11, 15) : rand(4, 8);

                    // Insertion unique pour éviter les erreurs de colonnes inconnues (type_note, statut, etc)
                    $stmtInsert = $pdo->prepare("INSERT INTO notes (eleve_id, matiere_id, semestre_id, valeur) 
                                               VALUES (?, ?, ?, ?)");
                    
                    $stmtInsert->execute([$eleve['id'], $matiere['id'], $semestre, $valMoyenne]);
                }
            }
        }
    }

    echo "Seeding terminé avec succès !\n";

} catch (Exception $e) {
    die("Erreur lors du seeding: " . $e->getMessage());
}
