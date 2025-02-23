<?php
    // Paramètres de connexion
    $serveur = "localhost";          
    $utilisateur = "anda8840_daphne_blog"; // Nom d'utilisateur MySQL
    $mot_de_passe = "Ea610_Da255_Blog25"; // Mot de passe MySQL
    $base_de_donnees = "anda8840_mon_blog";     // Nom de la base de données

    // Création de la connexion
    $connexion = new mysqli($serveur, $utilisateur, $mot_de_passe, $base_de_donnees);

    // Vérification de la connexion
    if ($connexion->connect_error) {
        die("Échec de la connexion : " . $connexion->connect_error);
    }

    // Configuration du jeu de caractères (pour gérer les accents et caractères spéciaux)
    $connexion->set_charset("utf8mb4");
?>
