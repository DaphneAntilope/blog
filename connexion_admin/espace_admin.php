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
    </head>

    <body>
        <header>
            <img src="..\visuels\logo_blog_color.png" alt="logo du blog">
            <nav>
                <ul>
                    <li><a href="../index.php">Accueil</a></li>
                    <li><a href="tous_les_articles\les_articles.php">Les articles</a></li>
                    <li><a href="../connexion_admin\deconnexion.php">Se déconnecter</a></li>
                </ul>
            </nav>
        </header>

        <h1><?php echo htmlspecialchars($h1_text); ?></h1>

        <section>
            <h2>Ajouter un article</h2>
            <?php include '..\form_ajout_article\ajout_article.php'?>
        </section>
        
        <hr>
        
        <section>
            <h2>Les articles</h2>
            <div>
                <?php include '..\tous_les_articles\liste_articles.php'?>
            </div>
            
            <div>
                <h3>Supprimer un article</h3>
                <?php
                    // Inclure le fichier de connexion à la base de données
                    include '../database/connex_bdd.php'; 

                    // Préparer la requête pour récupérer les articles
                    $sql = "SELECT id_article, titre FROM articles ORDER BY date_publication DESC";
                    $result = $connexion->query($sql);
                ?>
                <!-- Script pour fenetre pop-up de demande de confirmation de suppression -->
                <script>
                    function confirmDeletion(form) {
                        if (confirm('Voulez-vous vraiment supprimer cet article ?')) {
                            form.submit();
                        } else {
                            return false;
                        }
                    }
                </script>
    

                <ul>
                    <?php
                    if ($result->num_rows > 0) {
                        while ($row = $result->fetch_assoc()) {
                            echo "<li>" . htmlspecialchars($row['titre']) . 
                                "<form action='../form_ajout_article/supprimer_article.php' method='POST' onsubmit='return confirmDeletion(this);'>
                                    <input type='hidden' name='id_article' value='" . htmlspecialchars($row['id_article']) . "'>
                                    <button type='submit' class='delete-link'>×</button>
                                </form>
                                </li>";
                        }
                    } else {
                        echo "<li>Aucun article disponible</li>";
                    }
                    ?>
                </ul>

            </div>
        </section>