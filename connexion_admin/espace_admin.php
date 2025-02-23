<?php
    $page_name = basename($_SERVER['PHP_SELF'], ".php");

    switch ($page_name) {
        case 'espace_admin':
            $h1_text = 'Votre espace administrateur';
            break;
        default:
            $h1_text = '';
    }
?>

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <title><?php echo htmlspecialchars($h1_text); ?></title>
    <link rel="stylesheet" href="/includes/header.css">
    <link rel="stylesheet" href="espace_admin.css">
</head>

<body>
    <header>
        <img src="..\visuels\logo_blog_color.png" alt="logo du blog">
        <nav>
            <ul>
                <li><a href="../index.php">Accueil</a></li>
                <li><a href="tous_les_articles/les_articles.php">Les articles</a></li>
                <li><a href="../connexion_admin/deconnexion.php">Se déconnecter</a></li>
            </ul>
        </nav>
    </header>

    <h1><?php echo htmlspecialchars($h1_text); ?></h1>

    <main>
        <section id="ajout_article">
            <h2>Ajouter un article</h2>
            <?php include '..\form_ajout_article\ajout_article.php'?>
        </section>

        <hr>

        <section id="gestion_articles">
            <h2>Gérer les articles</h2>
            <div>
                <?php include '..\tous_les_articles\liste_articles.php'?>
            </div>
        </section>
    </main>