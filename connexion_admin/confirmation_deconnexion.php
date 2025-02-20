<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Déconnexion Réussie</title>
    <link rel="stylesheet" href="popup_deco.css">
</head>
<body>
    <div class="popup" id="popup">
        <div class="popup-content">
            <h2>Déconnexion Réussie</h2>
            <p>Vous vous êtes déconnecté de votre espace admin.</p>
            <button onclick="fermerPopup()">OK</button>
        </div>
    </div>

    <script>
        // Afficher la pop-up
        document.getElementById('popup').style.display = 'block';

        // Fonction pour fermer la pop-up et rediriger vers la page d'accueil
        function fermerPopup() {
            window.location.href = "../index.php";
        }
    </script>
</body>
</html>
