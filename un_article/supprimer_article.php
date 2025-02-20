<?php
// Inclure le fichier de connexion à la base de données
include '../database/connex_bdd.php';

// Vérifier que l'ID de l'article est fourni
if (isset($_GET['id_article'])) {
    $id_article = intval($_GET['id_article']);

    // Préparer la requête pour supprimer l'article
    $sql = "DELETE FROM articles WHERE id_article = ?";
    $stmt = $connexion->prepare($sql);
    if ($stmt) {
        $stmt->bind_param("i", $id_article);
        if ($stmt->execute()) {
            echo "L'article a été supprimé avec succès.";
            header("Location: ../espace_admin.php"); // Rediriger vers l'espace admin après suppression
            exit();
        } else {
            echo "Erreur lors de la suppression de l'article : " . $stmt->error;
        }
        $stmt->close();
    } else {
        echo "Erreur lors de la préparation de la requête : " . $connexion->error;
    }

    $connexion->close();
} else {
    echo "ID de l'article manquant.";
}
?>
