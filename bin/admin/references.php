
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
//on check combien d entree dans la table
$sql = "SELECT COUNT(*) FROM _references WHERE id > 1";
if ($count = $bdd->query($sql)) {
   $nbrEntree = $count->fetchColumn();
   //echo $nbrEntree;
}
//
//$references = $bdd->query('SELECT * FROM _references order by id ASC');
$references = $bdd->query('SELECT * FROM _references order by ordre ASC');
//Ajout d'une fiche projet
echo "<div id=\"addButton\">";
echo "<img id=\"morePict\" src=\"images/moreW.png\" width=\"10\" height=\"10\" border=\"none\"/>";
echo "<h2 id=\"titleMore\"><a href=\"addReferences.php?nbrMax=".$nbrEntree."\" target=\"_self\">Ajouter une fiche référence</a></h2>";
echo "</div><br>";
//
// On affiche chaque entrée une à une
while ($donnees = $references->fetch())
{
	if($donnees['id'] == 1){
		//
	}else{
		echo "<div id=\"ficheContact\">";
			echo "<h2 id=\"title\">";
				echo "<FORM name=\"ordreForm\" method=\"post\" action=\"upDateOrdreReferences.php\">";
					echo "Position:<br>[ATTENTION: Enregistrer la fiche avant de modifier son numéro d'ordre, sinon toute modification sera perdue]<br><select name=\"newPos\" onChange=\"this.form.submit();\">";
					for ($i = 1; $i <= $nbrEntree; $i++) {
						if($i == $donnees['ordre']){
							echo "<option value=\"".$i."\" selected>".$i."</option>";
						}else{
							echo "<option value=\"".$i."\">".$i."</option>";
						}
					}
					echo "</select> / ".$nbrEntree."";
					echo "<input type=\"hidden\" name=\"oldPos\" value=\"".$donnees['ordre']."\">";
					echo "<input type=\"hidden\" name=\"ID\" value=\"".$donnees['id']."\">";
					echo "<input type=\"hidden\" name=\"modifier\" value=\"ordre\">";
					echo "<div id=\"interligne\"></div>";
					echo "<hr>";
					echo "<div id=\"interligne\"></div>";
				echo "</FORM>";
				echo "<FORM method=\"post\" action=\"upDateReferences.php\" enctype=\"multipart/form-data\" onSubmit=\"\">";
					if($donnees['visible'] == 0){
						echo "Visible dans flash:<br>Non<INPUT type=\"radio\" name=\"visible\" value=\"0\" checked>   Oui<INPUT type=\"radio\" name=\"visible\" value=\"1\">";
					}else{
						echo "Visible dans flash:<br>Non<INPUT type=\"radio\" name=\"visible\" value=\"0\">   Oui<INPUT type=\"radio\" name=\"visible\" value=\"1\" checked>";
					}
					echo "<div id=\"interligne\"></div>";
					echo "<hr>";
					echo "<div id=\"interligne\"></div>";
					echo "Nom:<br><input type=\"text\" size =\"43\" name=\"name\" value=\"".$donnees['name']."\"><br>";
					echo "<div id=\"interligne\"></div>";
					echo "Type:<br><input type=\"text\" size =\"43\" name=\"type\" value=\"".$donnees['type']."\"><br>";
					echo "<div id=\"interligne\"></div>";
					echo "Description:<br><textarea name=\"desc\" rows=\"4\" cols=\"33\">".$donnees['description']."</textarea><br>";				
					echo "<div id=\"interligne\"></div>";
					echo "Lien client:<br><input type=\"text\" size =\"43\" name=\"link\" value=\"".$donnees['link']."\"><br>";
					echo "<div id=\"interligne\"></div>";
					echo "Réalisation:<br><input type=\"text\" size =\"43\" name=\"realisation\" value=\"".$donnees['realisation']."\"><br>";
					echo "<div id=\"interligne\"></div>";
					echo "Lien réalisation:<br><input type=\"text\" size =\"43\" name=\"lienRealisation\" value=\"".$donnees['lienRealisation']."\"><br>";
					echo "<div id=\"interligne\"></div>";
					echo "Production:<br><input type=\"text\" size =\"43\" name=\"production\" value=\"".$donnees['production']."\"><br>";
					echo "<div id=\"interligne\"></div>";
					echo "Lien production:<br><input type=\"text\" size =\"43\" name=\"lienProduction\" value=\"".$donnees['lienProduction']."\"><br>";
					echo "<div id=\"interligne\"></div>";
					if($donnees['picture'] != ''){
						list($width, $height, $type, $attr) = getimagesize($root.$donnees['picture']);
						$ratioImg = $height / $width * 100;
						//
						$W = $width;
						$H = $W / 100 * $ratioImg;
						//
						$newW = 288;
						$newH = $newW / 100 * $ratioImg;
						echo "Photo: <br><a href=\"".$root.$donnees['picture']."\" target=\"_blank\"><img border=\"0\" src=\"".$root.$donnees['picture']."\" width=\"".$newW."\" height=\"".$newH."\"/></a><br>";
					}else{
						echo "Pas de photo<br>";
					}
					echo "<div id=\"interligne\"></div>";
					/*echo "Couleur du filet autour de l'image<br>[La couleur du cartouche texte et la couleur de texte est fonction de ca aussi] :<br><input type=\"radio\" name=\"contour\" value=\"Blanc\"checked> Blanc<input type=\"radio\" name=\"contour\" value=\"Noir\"> Noir<br>";
					echo "<div id=\"interligne\"></div>";*/
					echo "Uploader une nouvelle photo<br>[Idéalement 320x320px, mais dans tous les cas centrée et ajustée à 320x320px dans Flash] :<br><input type=\"file\" size =\"29\" name=\"photo\" value=\"".$donnees['picture']."\"><br>";
					echo "<input type=\"hidden\" name=\"ID\" value=\"".$donnees['id']."\">";
					echo "<div id=\"interligne\"></div>";
					echo "<input type=\"submit\" name=\"modifier\" value=\"Enregistrer\">";
				echo "</FORM>";
				echo "<FORM method=\"post\" action=\"deleteReferences.php\">";
					echo "<div id=\"interligne\"></div>";
					echo "<input type=\"hidden\" name=\"ID\" value=\"".$donnees['id']."\">";
					echo "<input type=\"submit\" name=\"supprimer\" value=\"Supprimer la fiche\">";
				echo "</FORM>";
			echo "</h2>";
		echo "</div>";
	}
}
echo "<div class=\"clear\"></div>";
$references->closeCursor();

?>