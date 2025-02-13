<?php
    $page_name = basename($_SERVER['PHP_SELF'], ".php");

    switch ($page_name) {
        case 'index':
            $h1_text = 'Bienvenue sur mon blog';
            break;
        case 'les_articles':
            $h1_text = 'Les articles';
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
                    <li><a href="../index.php">Accueil</a></li>
                    <li><a href="tous_les_articles\les_articles.php">Les articles</a></li>
                    <li><a href="../connexion_admin\connexion.php">Se connecter</a></li>
                </ul>
            </nav>
        </header>

        <h1><?php echo htmlspecialchars($h1_text); ?></h1>