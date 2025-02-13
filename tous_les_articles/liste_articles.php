<?php
    // Connexion à la base de données
    $page_name = basename($_SERVER['PHP_SELF'], ".php");

    if ($page_name == 'les_articles') {
        echo include_once "..\database\connex_bdd.php";
    } else {
        echo include_once "database\connex_bdd.php";
    }

            // Requête pour récupérer les articles
            $sql = "SELECT id_article, titre, extrait, date_publication FROM articles ORDER BY date_publication DESC";
            $result = $connexion->query($sql);
            if ($result->num_rows > 0) {
                // Affichage de chaque article
                while ($row = $result->fetch_assoc()) {
                    echo "<h3><a href='..\article.php?id=" . $row["id_article"] . "'>" . $row["titre"] . "</a></h3>";
                    echo "<p>" . $row["extrait"] . "</p>";
                    echo "<a href='un_article\article.php?id=" . $row["id_article"] . "' class='btn-lire-article'>Lire l'article</a>";
                    echo "</li>";
                }
            } else {
                echo "<p>Aucun article disponible pour le moment.</p>";
            }
            $connexion->close();
            ?>
        </ul>
    </main>
