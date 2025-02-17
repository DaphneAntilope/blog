<?php require '..\includes\header.php'?>

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
