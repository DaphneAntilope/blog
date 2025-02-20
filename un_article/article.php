<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <title>Article</title>
    <link rel="stylesheet" href="article.css"> <!-- Inclure le fichier CSS -->
</head>

<body>
    <?php require '../includes/header.php'; ?>

    <?php include_once "config_article.php"; ?>

    <main>
        <?php if ($article): ?>
        <article>
            <div>
                <a href="../form_ajout_article/modifier_article.php?id_article=<?php echo htmlspecialchars($article['id_article']); ?>" id="btn-modif-article">Modifier</a>
                <a href="#" onclick="supprimerArticle(<?php echo htmlspecialchars($article['id_article']); ?>)" id="btn-suppr-article">Supprimer</a>
            </div> 
            <h2><?php echo ($article['titre'] ?? 'Titre inconnu'); ?></h2>
            <p class="meta">
                Publié le <?php echo date('d/m/Y', strtotime($article['date_publication'] ?? '')); ?> par
                <?php echo htmlspecialchars($article['auteur'] ?? 'Auteur inconnu'); ?>
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

    <script>
        // Fonction JavaScript pour confirmer et supprimer un article
        function supprimerArticle(id_article) {
            if (confirm('Êtes-vous sûr de vouloir supprimer cet article ?')) {
                // Rediriger vers le fichier de suppression avec l'ID de l'article
                window.location.href = '../form_ajout_article/supprimer_article.php?id_article=' + id_article;
            }
        }
    </script>

</body>

</html>