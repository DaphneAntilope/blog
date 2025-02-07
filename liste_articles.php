<?php
    // Connexion à la base de données
    $conn = new mysqli("localhost", "root", "", "mon_blog");
    if ($conn->connect_error) {
        die("Connexion échouée: " . $conn->connect_error);
    }
    
            // Requête pour récupérer les articles
            $sql = "SELECT id_article, titre, extrait, date_publication FROM articles ORDER BY date_publication DESC";
            $result = $conn->query($sql);
            if ($result->num_rows > 0) {
                // Affichage de chaque article
                while ($row = $result->fetch_assoc()) {
                    echo "<li>";
                    echo "<h3><a href='..\article.php?id=" . $row["id_article"] . "'>" . $row["titre"] . "</a></h3>";
                    echo "<p>" . $row["extrait"] . "</p>";
                    echo "<a href='article.php?id=" . $row["id_article"] . "' class='btn-lire-article'>Lire l'article</a>";
                    echo "</li>";
                }
            } else {
                echo "<p>Aucun article disponible pour le moment.</p>";
            }
            $conn->close();
            ?>
        </ul>
    </main>

    <footer>
        <p>&copy; <?php echo date("Y"); ?> Mon Blog. Tous droits réservés.</p>
    </footer>
</body>
</html>