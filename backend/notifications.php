<?php
/**
 * Service de Notification - Groupe 3
 * Gère l'envoi de messages par Email et WhatsApp.
 */

require_once('db.php');

/**
 * Envoie une notification à un utilisateur concerné.
 */
function sendNotification($user_id, $message, $type = 'MAIL') {
    global $pdo;

    // 1. Enregistrement en base de données pour historique
    $sql = "INSERT INTO notifications (user_id, message, type, statut) VALUES (?, ?, ?, 'EN_ATTENTE')";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$user_id, $message, $type]);
    $notif_id = $pdo->lastInsertId();

    // 2. Logique d'envoi réel (Stub)
    $success = false;

    if ($type === 'MAIL') {
        // Logique PHPMailer ici
        // $success = mail($to, $subject, $message, $headers);
        $success = true; // Simulation
    } elseif ($type === 'WHATSAPP') {
        // Appel API (Twilio, GreenAPI, etc.)
        $success = true; // Simulation
    }

    // 3. Mise à jour du statut
    if ($success) {
        $pdo->prepare("UPDATE notifications SET statut = 'ENVOYE' WHERE id = ?")->execute([$notif_id]);
    } else {
        $pdo->prepare("UPDATE notifications SET statut = 'ECHEC' WHERE id = ?")->execute([$notif_id]);
    }

    return $success;
}

/**
 * Notifie le parent quand une nouvelle note est validée.
 */
function notifyParentAboutNote($note_id) {
    global $pdo;

    $sql = "SELECT p.user_id as parent_user_id, u.nom as eleve_nom, n.valeur, m.nom as matiere
            FROM notes n
            JOIN eleves e ON n.eleve_id = e.id
            JOIN users u ON e.user_id = u.id
            JOIN matieres m ON n.matiere_id = m.id -- CETTE LIGNE EST ESSENTIELLE
            JOIN parent_eleve pe ON e.id = pe.eleve_id
            JOIN parents p ON pe.parent_id = p.id
            WHERE n.id = ?";
    
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$note_id]);
    $data = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($data) {
        $msg = "Bonjour, une nouvelle note de " . $data['valeur'] . "/20 en " . $data['matiere'] . " a été publiée pour " . $data['eleve_nom'] . ".";
        sendNotification($data['parent_user_id'], $msg, 'MAIL');
        // Optionnel : sendNotification($data['parent_user_id'], $msg, 'WHATSAPP');
    }
}
?>
