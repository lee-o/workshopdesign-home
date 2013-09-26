
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
$projets = $bdd->query('SELECT * FROM _lastProjects order by id ASC');
//Ajout d'une fiche projet
echo "<div id=\"addButton\">";
echo "<img id=\"morePict\" src=\"images/moreW.png\" width=\"10\" height=\"10\" border=\"none\"/>";
echo "<h2 id=\"titleMore\"><a href=\"addProjets.php\" target=\"_self\">Ajouter une fiche projet</a></h2>";
echo "</div><br>";
// On affiche chaque entrée une à une
while ($donnees = $projets->fetch())
{
	if($donnees['id'] == 1){
		//
	}else{
		echo "<div id=\"ficheContact\">";
			echo "<h2 id=\"title\">";
				echo "<FORM method=\"post\" action=\"upDateProjets.php\" enctype=\"multipart/form-data\" onSubmit=\"\">";
					echo "Nom:<br><input type=\"text\" size =\"43\" name=\"name\" value=\"".$donnees['name']."\"><br>";
					echo "<div id=\"interligne\"></div>";
					echo "Type:<br><input type=\"text\" size =\"43\" name=\"type\" value=\"".$donnees['type']."\"><br>";
					echo "<div id=\"interligne\"></div>";
					echo "Lien:<br><input type=\"text\" size =\"43\" name=\"link\" value=\"".$donnees['link']."\"><br>";
					echo "<div id=\"interligne\"></div>";
					echo "Description:<br><textarea name=\"desc\" rows=\"4\" cols=\"33\">".$donnees['description']."</textarea><br>";				
					echo "<div id=\"interligne\"></div>";
					echo "<input type=\"hidden\" name=\"ID\" value=\"".$donnees['id']."\">";
					echo "<div id=\"interligne\"></div>";
					echo "<input type=\"submit\" name=\"modifier\" value=\"Enregistrer\">";
				echo "</FORM>";
				echo "<FORM method=\"post\" action=\"deleteProjets.php\">";
					echo "<div id=\"interligne\"></div>";
					echo "<input type=\"hidden\" name=\"ID\" value=\"".$donnees['id']."\">";
					echo "<input type=\"submit\" name=\"supprimer\" value=\"Supprimer le projet\">";
				echo "</FORM>";
			echo "</h2>";
		echo "</div>";
	}
}
echo "<div class=\"clear\"></div>";
$projets->closeCursor();

?>