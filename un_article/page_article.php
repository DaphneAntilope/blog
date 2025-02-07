<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title><?php echo htmlspecialchars($article['titre'] ?? 'Article inconnu'); ?> - Mon Blog</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>
        <h1><a href="accueil_blog.php">Mon Blog</a></h1>
        <nav>
        <ul>
            <li><a href="accueil_blog.php">Liste d'articles</a></li>
            <li><a href="admin.php">Admin</a></li>
            <li><a href="ajout_article.php">Ajouter un article</a></li>
        </ul>
        </nav>
    </header>

    <main>
        <?php include_once "article.php"?>
    </main>

    <footer>
    </footer>
</body>
</html>
