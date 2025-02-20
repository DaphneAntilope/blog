<?php
// Commencer la session
session_start();

// Libérer toutes les variables de session
session_unset();

// Détruire la session
session_destroy();

// Rediriger l'utilisateur vers la page de confirmation de déconnexion
header("Location: confirmation_deconnexion.php");
exit();
?>
