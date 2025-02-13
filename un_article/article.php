<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title><?php echo htmlspecialchars($article['titre'] ?? 'Article inconnu'); ?> - Mon Blog</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>
        <h1><a href="index.php">Mon Blog</a></h1>
        <nav>
            <ul>
                <li><a href="liste_articles.php">Liste d'articles</a></li>
                <li><a href="admin.php">Admin</a></li>
                <li><a href="ajout_article\ajout_article.php">Ajouter un article</a></li>
            </ul>
        </nav>
    </header>

    <?php include_once "config_article.php"?>

    <main>   
        <?php if ($article): ?>
            <article>
                <h1><?php echo ($article['titre'] ?? 'Titre inconnu'); ?></h1>
                <p class="meta">
                    Publié le <?php echo date('d/m/Y', strtotime($article['date_publication'] ?? '')); ?> par <?php echo htmlspecialchars($article['auteur'] ?? 'Auteur inconnu'); ?>
                </p>
                <div class="contenu-article">
                    <?php echo (($article['contenu'] ?? 'Contenu non disponible')); ?>
                </div>
                <?php if (!empty($article['image'])): ?>
                    <div class="image-article">
                        <img src="<?php echo ($article['image'] ?? ''); ?>" alt="Image de l'article">
                    </div>
                <?php endif; ?>
            </article>
        <?php else: ?>
            <p>Article introuvable.</p>
        <?php endif; ?>
    </main>

    <footer>
        <p>&copy; <?php echo date('Y'); ?> Mon Blog. Tous droits réservés.</p>
    </footer>
</body>
</html>
