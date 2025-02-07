<?php
    // Inclure le fichier de connexion à la base de données
    include '..\database\connex_bdd.php';

    // Vérifier si l'ID de l'article est passé en paramètre
    if (isset($_GET['id'])) {
        $id_article = intval($_GET['id']);

        // Préparer la requête pour récupérer l'article
        $sql = "SELECT a.titre, a.extrait, a.contenu, a.image, a.date_publication, u.pseudo AS auteur
                FROM articles a
                JOIN utilisateurs u ON a.id_auteur = u.id_utilisateur
                WHERE a.id_article = ?";
        $stmt = $connexion->prepare($sql);
        $stmt->bind_param("i", $id_article);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $article = $result->fetch_assoc();
        } else {
            $article = null;
        }
    } else {
        $article = null;
    }
?>