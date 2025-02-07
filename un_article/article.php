<?php
        // Inclure le fichier de connexion à la base de données
        include '..\database\connex_bdd.php';

        // Vérifier si l'ID de l'article est passé en paramètre
        if (isset($_GET['id'])) {
            $id_article = intval($_GET['id']);

            // Préparer la requête pour récupérer l'article
            $sql = "SELECT a.titre, a.contenu, a.date_publication, u.pseudo AS auteur
                    FROM articles a
                    JOIN utilisateurs u ON a.id_auteur = u.id_utilisateur
                    WHERE a.id_article = ?";
            $stmt = $connexion->prepare($sql);
            $stmt->bind_param("i", $id_article);
            $stmt->execute();
            $result = $stmt->get_result();

            if ($result->num_rows > 0) {
                $article = $result->fetch_assoc();
                ?>
                <article>
                    <h2><?php echo htmlspecialchars($article['titre']); ?></h2>
                    <p class="meta">
                        Publié le <?php echo date('d/m/Y', strtotime($article['date_publication'])); ?> par <?php echo htmlspecialchars($article['auteur']); ?>
                    </p>
                    <div class="contenu-article">
                        <?php echo nl2br(htmlspecialchars($article['contenu'])); ?>
                    </div>
                </article>

                <!-- Section des commentaires -->
                <section id="commentaires">
                    <h3>Commentaires</h3>
                    <?php
                    // Requête pour récupérer les commentaires liés à l'article
                    $sql_comments = "SELECT c.contenu, c.date_publication, u.pseudo
                                     FROM commentaires c
                                     JOIN utilisateurs u ON c.id_utilisateur = u.id_utilisateur
                                     WHERE c.id_article = ?
                                     ORDER BY c.date_publication DESC";
                    $stmt_comments = $connexion->prepare($sql_comments);
                    $stmt_comments->bind_param("i", $id_article);
                    $stmt_comments->execute();
                    $comments_result = $stmt_comments->get_result();

                    if ($comments_result->num_rows > 0) {
                        while ($comment = $comments_result->fetch_assoc()) {
                            ?>
                            <div class="commentaire">
                                <p><strong><?php echo htmlspecialchars($comment['pseudo']); ?></strong> le <?php echo date('d/m/Y à H:i', strtotime($comment['date_publication'])); ?></p>
                                <p><?php echo nl2br(htmlspecialchars($comment['contenu'])); ?></p>
                            </div>
                            <?php
                        }
                    } else {
                        echo "<p>Pas encore de commentaires. Soyez le premier à réagir !</p>";
                    }
                    ?>
                    <!-- Formulaire d'ajout de commentaire -->
                    <h4>Ajouter un commentaire</h4>
                    <form action="ajouter_commentaire.php" method="POST">
                        <input type="hidden" name="id_article" value="<?php echo $id_article; ?>">
                        <div>
                            <label for="pseudo">Pseudo :</label><br>
                            <input type="text" id="pseudo" name="pseudo" required>
                        </div>
                        <div>
                            <label for="contenu_commentaire">Commentaire :</label><br>
                            <textarea id="contenu_commentaire" name="contenu_commentaire" rows="5" cols="50" required></textarea>
                        </div>
                        <div>
                            <input type="submit" value="Envoyer">
                        </div>
                    </form>
                </section>
                <?php
            } else {
                echo "<p>Article introuvable.</p>";
            }
        } else {
            echo "<p>Aucun article spécifié.</p>";
        }
        ?>