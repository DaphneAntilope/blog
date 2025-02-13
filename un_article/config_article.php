<?php
// Inclure le fichier de connexion à la base de données
include '../database/connex_bdd.php'; // Utilisation de barres obliques

// Vérifier si l'ID de l'article est passé en paramètre
if (isset($_GET['id'])) {
    $id_article = intval($_GET['id']);

    // Préparer la requête pour récupérer l'article
    $sql = "SELECT articles.id_article, articles.titre, articles.extrait, articles.contenu, articles.image, articles.date_publication, utilisateurs.pseudo AS auteur
            FROM articles
            JOIN utilisateurs ON articles.id_auteur = utilisateurs.id_utilisateur
            WHERE articles.id_article = ?";
    $stmt = $connexion->prepare($sql);
    if ($stmt) {
        $stmt->bind_param("i", $id_article);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result && $result->num_rows > 0) {
            $article = $result->fetch_assoc();
        } else {
            $article = null;
        }
    } else {
        $article = null;
    }
} else {
    $article = null;
}
?>