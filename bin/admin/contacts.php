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
$contacts = $bdd->query('SELECT * FROM _contacts order by id ASC');
//
$adress = $bdd->query('SELECT * FROM _adress order by id ASC');
//
// On affiche chaque entrée une à une
while ($donnees = $contacts->fetch())
{
	if($donnees['id'] == 1){
		//
	}else{
		echo "<div id=\"ficheContact\">";
			echo "<FORM method=\"post\" action=\"upDateContacts.php\" enctype=\"multipart/form-data\" onSubmit=\"\">";
			echo "<h2 id=\"title\">";
				echo "Nom*:<br><input type=\"text\" size =\"43\" name=\"name\" value=\"".$donnees['name']."\"><br>";
				echo "<div id=\"interligne\"></div>";
				echo "Téléphone:<br><input type=\"text\" size =\"43\" name=\"tel\" value=\"".$donnees['tel']."\"><br>";
				echo "<div id=\"interligne\"></div>";
				echo "Mail*:<br><input type=\"text\" size =\"43\" name=\"mail\" value=\"".$donnees['mail']."\"><br>";
				echo "<div id=\"interligne\"></div>";
				echo "Lien:<br>[Ne pas mettre le http://]<br><input type=\"text\" size =\"43\" name=\"webLink\" value=\"".$donnees['webLink']."\"><br>";
				echo "<div id=\"interligne\"></div>";
				echo "Description:<br><textarea name=\"desc\" rows=\"4\" cols=\"33\">".$donnees['description']."</textarea><br>";				
				echo "<div id=\"interligne\"></div>";
				list($width, $height, $type, $attr) = getimagesize($root.$donnees['picture']);
				$ratioImg = $height / $width * 100;
				//
				$W = $width;
				$H = $W / 100 * $ratioImg;
				//
				$newW = 288;
				$newH = $newW / 100 * $ratioImg;
				echo "Photo: <br><a href=\"".$root.$donnees['picture']."\" target=\"_blank\"><img border=\"0\" src=\"".$root.$donnees['picture']."\" width=\"".$newW."\" height=\"".$newH."\"/></a><br>";
				echo "<div id=\"interligne\"></div>";
				echo "Uploader une nouvelle photo<br>[Idéalement 320x320px, mais dans tous les cas centrée et ajustée à 320x320px dans Flash] :<br><input type=\"file\" size =\"29\" name=\"photo\" value=\"".$donnees['picture']."\"><br>";
				echo "<input type=\"hidden\" name=\"ID\" value=\"".$donnees['id']."\">";
				echo "<div id=\"interligne\"></div>";
				echo "<input type=\"submit\" name=\"modifier\" value=\"Modifier la fiche\">";
			echo "</h2>";
			echo "</FORM>";
		echo "</div>";
	}
}
//
$contacts->closeCursor();
//
// On affiche chaque entrée une à une
while ($donnees = $adress->fetch())
{
	echo "<div id=\"ficheContact\">";
		echo "<FORM method=\"post\" action=\"upDateAdress.php\" enctype=\"multipart/form-data\" onSubmit=\"\">";
		echo "<h2 id=\"title\">";
			if($donnees['id'] == 1){
				echo "Adresse courrier:";
			}else if($donnees['id'] == 2){
				echo "Adresse studio:";
			}else if($donnees['id'] == 3){
				echo "Téléphone:";
			}
			echo "<div id=\"interligne\"></div>";
			echo "Nom*:<br><input type=\"text\" size =\"43\" name=\"name\" value=\"".$donnees['name']."\"><br>";
			echo "<div id=\"interligne\"></div>";
			echo "Description*:<br><textarea name=\"description\" rows=\"4\" cols=\"33\">".$donnees['description']."</textarea><br>";	
			echo "<div id=\"interligne\"></div>";
			echo "<input type=\"hidden\" name=\"ID\" value=\"".$donnees['id']."\">";
			echo "<input type=\"submit\" name=\"Enregistrer\" value=\"Enregistrer\">";
		echo "</h2>";
		echo "</FORM>";
	echo "</div>";
}
$adress->closeCursor();
echo "<div class=\"clear\"></div>";
?>