<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title><?php echo htmlspecialchars($article['titre'] ?? 'Article inconnu'); ?> - Mon Blog</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>
        <h1><a href="..\accueil_blog.php">Mon Blog</a></h1>
        <nav>
            <ul>
                <li><a href="accueil_blog.php">Liste d'articles</a></li>
                <li><a href="admin.php">Admin</a></li>
                <li><a href="ajout_article.php">Ajouter un article</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <?php include_once "config_article.php"?>

        <article>
            <h2><?php echo htmlspecialchars($article['titre'] ?? 'Titre inconnu'); ?></h2>
            <p class="meta">Publié le <?php echo date('d/m/Y', strtotime($article['date_publication'] ?? '')); ?> par <?php echo htmlspecialchars($article['auteur'] ?? 'Auteur inconnu'); ?></p>
            <div class="contenu-article">
                <?php echo nl2br(htmlspecialchars($article['contenu'] ?? 'Contenu non disponible')); ?>
            </div>
            <?php if (!empty($article['image'])): ?>
                <div class="image-article">
                    <img src="<?php echo htmlspecialchars($article['image'] ?? ''); ?>" alt="Image de l'article">
                </div>
            <?php endif; ?>
        </article>

        <section id="commentaires">
            <h3>Commentaires</h3>
            <!-- Affichage des commentaires -->
            <?php if (!empty($commentaires)): ?>
                <?php foreach ($commentaires as $commentaire): ?>
                    <div class="commentaire">
                        <p><strong><?php echo htmlspecialchars($commentaire['auteur']); ?></strong> le <?php echo date('d/m/Y à H:i', strtotime($commentaire['date'])); ?></p>
                        <p><?php echo nl2br(htmlspecialchars($commentaire['contenu'])); ?></p>
                    </div>
                <?php endforeach; ?>
            <?php else: ?>
                <p>Pas encore de commentaires. Soyez le premier à réagir !</p>
            <?php endif; ?>

            <!-- Formulaire d'ajout de commentaire -->
            <h4>Ajouter un commentaire</h4>
            <form action="ajouter_commentaire.php" method="POST">
                <input type="hidden" name="id_article" value="<?php echo $article['id_article']; ?>">
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
    </main>

    <footer>
        <p>&copy; <?php echo date("Y"); ?> Mon Blog. Tous droits réservés.</p>
    </footer>
</body>
</html>
