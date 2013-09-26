
<?php
try
{
	// On se connecte à MySQL
	$bdd = new PDO('mysql:host=mysql5-22.perso;dbname=workshopmbdd', 'workshopmbdd', '2F0BzY9iKRFi');
}
catch(Exception $e)
{
	// En cas d'erreur, on affiche un message et on arrête tout
    die('Erreur : '.$e->getMessage());
}

//
$projets = $bdd->query('SELECT * FROM _about order by id ASC');
// On affiche chaque entrée une à une
echo "<div id=\"sepBlack\"></div>";
while ($donnees = $projets->fetch())
{
	if($donnees['id'] == 1){
		//
	}else{
		echo "<div id=\"ficheAbout\">";
			echo "<h2 id=\"title\">";
				echo "<FORM method=\"post\" action=\"upDateAbout.php\" enctype=\"multipart/form-data\" onSubmit=\"\">";
					echo "<div id=\"interligne\"></div>";
					echo "Texte de la page About:<br><textarea name=\"desc\" rows=\"20\" cols=\"80\">".$donnees['description']."</textarea><br>";
					echo "<div id=\"interligne\"></div>";
					echo "<input type=\"hidden\" name=\"ID\" value=\"".$donnees['id']."\">";
					echo "<input type=\"submit\" name=\"modifier\" value=\"Enregistrer\">";
				echo "</FORM>";
			echo "</h2>";
		echo "</div>";
	}
}

$projets->closeCursor();

?>