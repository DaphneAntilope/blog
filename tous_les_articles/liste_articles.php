<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <title>Accueil du Blog</title>
    <!-- Inclure le fichier CSS -->
</head>

<body>
    <div class="container">
        <?php
        // Connexion à la base de données
        $page_name = basename($_SERVER['PHP_SELF'], ".php");

        switch ($page_name) {
            case 'les_articles':
                echo '<link rel="stylesheet" href="..\tous_les_articles\liste_articles_styles.css">';
                include_once "..\database\connex_bdd.php";
                break;
            case 'espace_admin':
                echo '<link rel="stylesheet" href="..\tous_les_articles\liste_articles_styles.css">';
                include_once "..\database\connex_bdd.php";
                break;
            default:
                echo '<link rel="stylesheet" href="..\tous_les_articles\liste_articles_styles.css">';
                include_once "database\connex_bdd.php";
        }

        // Requête pour récupérer les articles
        $sql = "SELECT id_article, titre, extrait, date_publication FROM articles ORDER BY date_publication DESC";
        $result = $connexion->query($sql);
        if ($result->num_rows > 0) {
            // Affichage de chaque article
            while ($row = $result->fetch_assoc()) {
                echo "<div class='article'>";
                echo "<h3><a href='..\article.php?id=" . $row["id_article"] . "'>" . $row["titre"] . "</a></h3>";
                echo "<p>" . $row["extrait"] . "</p>";
                echo "<a href='un_article\article.php?id=" . $row["id_article"] . "' class='btn-lire-article'>Lire l'article</a>";
                echo "</div>";
            }
        } else {
            echo "<p>Aucun article disponible pour le moment.</p>";
        }
        $connexion->close();
        ?>
    </div>
</body>

</html>