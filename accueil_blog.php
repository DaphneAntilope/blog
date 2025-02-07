<!DOCTYPE html>

<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <title>Le blog</title>
        <link rel="stylesheet" href="accueil_blog.css">
    </head>

    <body>
        <header>
            <h1>Bienvenue sur mon blog</h1>
            <nav>
                <ul>
                    <li><a href="liste_articles.php">Liste d'articles</a></li>
                    <li><a href="admin.php">Admin</a></li>
                    <li><a href="ajout_article\ajout_article.php">Ajouter un article</a></li>
                </ul>
            </nav>
        </header>

        <main>
            <h2>Tous les Articles</h2>
            <ul class="liste-articles">
                <?php include_once "liste_articles.php"?>
            </ul>
        </main>

        <footer>
            <p>Le blog. Tous droits réservés.</p>
        </footer>
    </body>
</html>
