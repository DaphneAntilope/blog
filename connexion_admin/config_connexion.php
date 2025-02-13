<?php
// Activer l'affichage des erreurs pour le débogage
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Inclure le fichier de connexion à la base de données
include '../database/connex_bdd.php'; // Chemin relatif à ton fichier de connexion

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $email = trim($_POST['email']);
    $mot_de_passe = trim($_POST['mot_de_passe']);

    // Préparer la requête pour vérifier les informations d'utilisateur
    $sql = "SELECT * FROM utilisateurs WHERE email = ?";
    $stmt = $connexion->prepare($sql);
    if ($stmt) {
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($result->num_rows > 0) {
            $user = $result->fetch_assoc();

            // Vérifier le mot de passe en texte brut
            if ($mot_de_passe == $user['mot_de_passe']) {
                // Vérifier si l'utilisateur est administrateur
                if ($user['role'] == 'admin') {
                    echo "Bienvenue, administrateur " . htmlspecialchars($user['pseudo']) . "!";
                    // Redirection ou traitement supplémentaire pour les administrateurs
                    header("Location: ../connexion_admin/espace_admin.php"); // Remplace par la page d'accueil de l'admin
                    exit();
                } else {
                    echo "Vous n'êtes pas administrateur.";
                }
            } else {
                echo "Mot de passe incorrect.";
            }
        } else {
            echo "Email non trouvé.";
        }
        $stmt->close();
    } else {
        echo "Erreur lors de la préparation de la requête : " . $connexion->error;
    }

    $connexion->close();
}
?>
