<?php
// Activer l'affichage des erreurs pour le débogage
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Inclure le fichier de connexion à la base de données
include '..\database\connex_bdd.php'; // Utilisation de barres obliques


// Vérifier si l'ID de l'article est passé en paramètre
if (isset($_GET['id'])) {
    $id_article = intval($_GET['id']);

    // Préparer la requête pour récupérer l'article
    $sql = "SELECT articles.titre, articles.extrait, articles.contenu, articles.image, articles.date_publication, utilisateurs.pseudo AS auteur
            FROM articles
            JOIN utilisateurs ON articles.id_auteur = utilisateurs.id_utilisateur
            WHERE articles.id_article = ?";
    $stmt = $connexion->prepare($sql);
    if ($stmt) {
        $stmt->bind_param("i", $id_article);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result) {
            if ($result->num_rows > 0) {
                $article = $result->fetch_assoc();
                // Affichage des valeurs récupérées pour débogage
                echo "<pre>";
                print_r($article);
                echo "</pre>";
            } else {
                $article = null;
                echo "Article introuvable.<br>";
            }
        } else {
            echo "Erreur lors de la récupération des résultats : " . $connexion->error . "<br>";
            $article = null;
        }
    } else {
        echo "Erreur lors de la préparation de la requête : " . $connexion->error . "<br>";
        $article = null;
    }
} else {
    $article = null;
    echo "ID de l'article non spécifié.<br>";
}

?>