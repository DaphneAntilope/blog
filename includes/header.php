<?php
    $page_name = basename($_SERVER['PHP_SELF'], ".php");

    switch ($page_name) {
        case 'index':
            $h1_text = 'Bienvenue sur mon blog';
            break;
        case 'liste_articles':
            $h1_text = 'Les articles';
            break;
        case 'ajout_article':
            $h1_text = 'Ajouter un article';
            break;
        case 'connexion':
            $h1_text = 'Se connecter';
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
    </head>

    <body>
        <header>
            <img src="..\visuels\logo_blog_color.png" alt="logo du blog">
            <nav>
                <ul>
                    <li><a href="..\index.php">Accueil</a></li>
                    <li><a href="..\liste_articles.php">Liste d'articles</a></li>
                    <li><a href="ajout_article\ajout_article.php">Ajouter un article</a></li>
                    <li><a href="connexion.php">Se connecter</a></li>
                </ul>
            </nav>
        </header>

        <h1><?php echo htmlspecialchars($h1_text); ?></h1>