<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <title>Ajouter un nouvel article</title>
        <link rel="stylesheet" href="ajout_article.css">
        <script src="https://cdn.tiny.cloud/1/vtoaw4icl2qa7rhhcu8v58zx1inrf17493vi2oe4zmu9ce3g/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
        <script>
            tinymce.init({
                selector: '#contenu',
                language: 'fr_FR',
                plugins: 'advlist autolink lists link image charmap print preview hr anchor pagebreak',
                toolbar_mode: 'floating',
                toolbar: 'undo redo | formatselect | bold italic underline | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat | link image',
                branding: false
            });
        </script>

    </head>

    <body>
        <header>
            <h1>Ajouter un Nouvel Article</h1>
            <nav>
                <ul>
                    <li><a href="accueil_blog.php">Liste d'articles</a></li>
                    <li><a href="admin.php">Admin</a></li>
                    <li><a href="ajout_article\ajout_article.php">Ajouter un article</a></li>
                </ul>
            </nav>
        </header>

        <form action="..\ajout_article\publier_article.php" method="POST" enctype="multipart/form-data">
            <div>
                <label for="titre">Titre de l'article :</label><br>
                <input type="text" id="titre" name="titre" required>
            </div>

            <div>
                <label for="contenu">Contenu :</label><br>
                <textarea id="contenu" name="contenu" rows="10" cols="50" required></textarea>
            </div>

            <div>
                <label for="categorie">Catégorie :</label><br>
                <select id="categorie" name="categorie" required>
                    <option value="">-- Sélectionnez une catégorie --</option>
                    <option value="1">Technologie</option>
                    <option value="2">Science</option>
                    <option value="3">Art</option>
                </select>
            </div>
            <br>
            <div>
                <label for="extrait">Extrait de l'article :</label><br>
                <textarea id="extrait" name="extrait" rows="10" cols="50" required></textarea>
            </div>
            <br>
            <div>
                <label for="image">Image de mise en avant :</label><br>
                <input type="file" id="image" name="image" accept="image/*">
            </div>
            <br>
            <div>
                <input type="submit" value="Publier l'article">
            </div>
        </form>
        
    </body>
</html>
