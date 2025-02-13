<?php
// Inclure le fichier de connexion à la base de données
include '..\database\connex_bdd.php';

// Vérifier que le formulaire a été soumis
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Récupérer les données du formulaire
    $titre = $_POST['titre'];
    $extrait = $_POST['extrait'];
    $contenu = $_POST['contenu'];
    $id_categorie = $_POST['categorie'];
    $id_auteur = 1; // Remplace par l'ID de l'auteur connecté (par exemple, via une session)
    
    // Traitement de l'image (optionnel)
    if (isset($_FILES['image']) && $_FILES['image']['error'] == UPLOAD_ERR_OK) {
        $image_nom = basename($_FILES['image']['name']);
        $image_tmp = $_FILES['image']['tmp_name'];
        $dossier_cible = '..\uploads\images_articles'; // Dossier où les images seront stockées
        $chemin_image = $dossier_cible . $image_nom;
        
        // Déplacer l'image téléchargée dans le dossier de destination
        if (move_uploaded_file($image_tmp, $chemin_image)) {
            echo "L'image a été téléchargée avec succès.<br>";
        } else {
            echo "Erreur lors du téléchargement de l'image.<br>";
        }
    } else {
        $chemin_image = NULL; // Pas d'image téléchargée
    }
    
    // Préparer la requête SQL pour insérer l'article dans la base de données
    $sql = "INSERT INTO articles (titre, extrait, contenu, image, date_publication, id_categorie, id_auteur)
            VALUES (?, ?, ?, ?, NOW(), ?, ?)";
    $stmt = $connexion->prepare($sql);
    $stmt->bind_param("sssiii", $titre, $extrait, $contenu, $chemin_image, $id_categorie, $id_auteur);
    
    // Exécuter la requête et vérifier le résultat
    if ($stmt->execute()) {
        $id_article = $stmt->insert_id;
        echo "L'article a été ajouté avec succès.<br>";

        // Ajouter les boutons "Voir l'article" et "Retour à l'accueil"
        echo "<button><a href='../un_article/article.php?id=$id_article'>Voir l'article</a></button>";
        echo "<button><a href='../accueil_blog.php'>Retour à l'accueil</a></button>";
    } else {
        echo "Erreur lors de l'ajout de l'article : " . $stmt->error;
    }

    
    // Fermer la requête préparée
    $stmt->close();
}

// Fermer la connexion à la base de données
$connexion->close();
?>