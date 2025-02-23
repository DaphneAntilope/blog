<?php
// Paramètres de connexion
$serveur = "localhost";          
$utilisateur = "anda8840_daphne_blog"; 
$mot_de_passe = "Ea610_Da255_Blog25"; 
$base_de_donnees = "anda8840_mon_blog"; 

// Afficher les informations de connexion pour vérification
echo "Serveur : $serveur<br>";
echo "Utilisateur : $utilisateur<br>";
echo "Base de données : $base_de_donnees<br>";

// Création de la connexion
$connexion = new mysqli($serveur, $utilisateur, $mot_de_passe, $base_de_donnees);

// Vérification de la connexion
if ($connexion->connect_error) {
    die("Échec de la connexion : " . $connexion->connect_error);
}

// Si la connexion est réussie
echo "Connexion réussie à la base de données";
?>
