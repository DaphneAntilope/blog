<?php
// Inclure le fichier de connexion à la base de données
include '../database/connex_bdd.php'; // Utiliser des barres obliques pour les chemins

// Activer l'affichage des erreurs pour le débogage
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Vérifier que le formulaire a été soumis
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Récupérer les données du formulaire
    $titre = trim($_POST['titre']);
    $extrait = trim($_POST['extrait']);
    $contenu = trim($_POST['contenu']);
    $id_categorie = intval($_POST['categorie']);
    $id_auteur = 1; // Remplace par l'ID de l'auteur connecté (par exemple, via une session)

    // Traitement de l'image (optionnel)
    $chemin_image = NULL;
    if (isset($_FILES['image']) && $_FILES['image']['error'] == UPLOAD_ERR_OK) {
        $image_nom = basename($_FILES['image']['name']);
        $image_tmp = $_FILES['image']['tmp_name'];
        $dossier_cible = '../uploads/images_articles/'; // Utiliser des barres obliques pour les chemins
        $chemin_image = $dossier_cible . $image_nom;

        // Déplacer l'image téléchargée dans le dossier de destination
        if (move_uploaded_file($image_tmp, $chemin_image)) {
            echo "L'image a été téléchargée avec succès. Chemin : $chemin_image<br>";
        } else {
            echo "Erreur lors du téléchargement de l'image. Vérifiez les permissions du dossier et le chemin.<br>";
            $chemin_image = NULL;
        }
    } else {
        echo "Aucune image téléchargée ou erreur lors du téléchargement : " . $_FILES['image']['error'] . "<br>";
    }

    // Afficher le chemin de l'image pour vérifier s'il est correct
    echo "Chemin de l'image : $chemin_image<br>";

    // Préparer la requête SQL pour insérer l'article dans la base de données
    $sql = "INSERT INTO articles (titre, extrait, contenu, image, date_publication, id_categorie, id_auteur)
            VALUES (?, ?, ?, ?, NOW(), ?, ?)";
    $stmt = $connexion->prepare($sql);
    if ($stmt === false) {
        die("Erreur lors de la préparation de la requête : " . $connexion->error);
    }

    $stmt->bind_param("sssiii", $titre, $extrait, $contenu, $chemin_image, $id_categorie, $id_auteur);

    // Exécuter la requête et vérifier le résultat
    if ($stmt->execute()) {
        $id_article = $stmt->insert_id;
        echo "L'article a été ajouté avec succès.<br>";

        // Ajouter les boutons "Voir l'article" et "Retour vers l'espace administrateur"
        echo "<button><a href='../un_article/article.php?id=$id_article'>Voir l'article</a></button>";
        echo "<button><a href='../connexion_admin/espace_admin.php'>Retour vers l'espace administrateur</a></button>";
    } else {
        echo "Erreur lors de l'ajout de l'article : " . $stmt->error;
    }

    // Fermer la requête préparée
    $stmt->close();
}

// Fermer la connexion à la base de données
$connexion->close();
?>
