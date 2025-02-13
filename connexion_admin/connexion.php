<?php require '..\includes\header.php'?>

<form action="config_connexion.php" method="POST" enctype="multipart/form-data">
    <div>
        <label for="email">Email :</label><br>    
        <input type="email" name="email" id="email">
    </div>   
    <br> 
    <div>
        <label for="mot_de_passe">Mot de passe :</label><br>  
        <input type="password" name="mot_de_passe" id="mot_de_passe">
    </div>
    <br> 
    <div>
        <input type="submit" value="Se connecter">
    </div>
</form>