
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
$sql = "SELECT COUNT(*) FROM _liens WHERE id > 1";
if ($count = $bdd->query($sql)) {
   $nbrEntree = $count->fetchColumn();
   //echo $nbrEntree;
}
//
//$references = $bdd->query('SELECT * FROM _references order by id ASC');
$references = $bdd->query('SELECT * FROM _liens order by ordre ASC');
//Ajout d'une fiche projet
?>
<div id="addButton">
		<h2 id="titleMore"><img id="morePict" src="images/moreW.png" width="10" height="10" border="none"/>
        <a href="addLiens.php?nbrMax=<?php echo $nbrEntree;?>" target="_self">Ajouter une fiche lien</a></h2>
</div>
<?php
// On affiche chaque entrée une à une
while ($donnees = $references->fetch())
{
	if($donnees['id'] == 1){
		//
	}else{
		echo "<div id=\"ficheLiens\">";
			echo "<h2 id=\"title\">";
				echo "<FORM name=\"ordreForm\" method=\"post\" action=\"upDateOrdreLiens.php\">";
					echo "<div>";
					echo "Position:<br><select size=\"1\"name=\"newPos\" onChange=\"this.form.submit();\">";
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
					echo "</div>";
				echo "</FORM>";
				
				
				echo "<FORM  method=\"post\" action=\"upDateLiens.php\" enctype=\"multipart/form-data\" onSubmit=\"\">";
					echo "<div id=\"visibleFront\">";
						if($donnees['visible'] == 0){
							echo "Visible:<br>Non<INPUT type=\"radio\" name=\"visible\" value=\"0\" checked>   Oui<INPUT type=\"radio\" name=\"visible\" value=\"1\">";
						}else{
							echo "Visible:<br>Non<INPUT type=\"radio\" name=\"visible\" value=\"0\">   Oui<INPUT type=\"radio\" name=\"visible\" value=\"1\" checked>";
						}
					echo "</div>";
					echo "<div id=\"interligne\"></div>";
					echo "<hr>";
					echo "<div id=\"interligne\"></div>";
					echo "<div>Nom:<input class=\saisie\" type=\"text\" size =\"29\" name=\"name\" value=\"".$donnees['name']."\"></div>";
					echo "<div id=\"interligne\"></div>";
					echo "<div>Lien:<input class=\saisie\" type=\"text\" size =\"29\" name=\"link\" value=\"".$donnees['link']."\"></div>";
					echo "<div id=\"interligne\"></div>";
					echo "<input type=\"hidden\" name=\"ID\" value=\"".$donnees['id']."\">";
					echo "<div><input type=\"submit\" name=\"modifier\" value=\"Enregistrer\"></div>";
				echo "</FORM>";
				
				
				echo "<FORM method=\"post\" action=\"deleteLiens.php\">";
					echo "<input type=\"hidden\" name=\"ID\" value=\"".$donnees['id']."\">";
					echo "<input type=\"submit\" name=\"supprimer\" value=\"Supprimer\">";
				echo "</FORM>";
				
				
			echo "</h2>";
		echo "</div>";
	}
}
$references->closeCursor();

?>