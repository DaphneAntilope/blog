<?php
// Inclure le fichier de connexion à la base de données
include '../database/connex_bdd.php'; // Chemin relatif à ton fichier de connexion

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $id_article = intval($_POST['id_article']);

    // Préparer la requête pour supprimer l'article
    $sql = "DELETE FROM articles WHERE id_article = ?";
    $stmt = $connexion->prepare($sql);
    if ($stmt) {
        $stmt->bind_param("i", $id_article);
        if ($stmt->execute()) {
            echo "L'article a été supprimé avec succès.";
            echo "<button><a href='../connexion_admin/espace_admin.php'>Retour vers l'espace administrateur</a></button>";
        } else {
            echo "Erreur lors de la suppression de l'article : " . $stmt->error;
            echo "<button><a href='../connexion_admin/espace_admin.php'>Retour vers l'espace administrateur</a></button>";
        }
        $stmt->close();
    } else {
        echo "Erreur lors de la préparation de la requête : " . $connexion->error;
        echo "<button><a href='../connexion_admin/espace_admin.php'>Retour vers l'espace administrateur</a></button>";
    }

    $connexion->close();
} else {
    echo "Requête invalide.";
    echo "<button><a href='../connexion_admin/espace_admin.php'>Retour vers l'espace administrateur</a></button>";
}
?>
