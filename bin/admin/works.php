
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
$sql = "SELECT COUNT(*) FROM _works WHERE id > 1";
if ($count = $bdd->query($sql)) {
   $nbrEntree = $count->fetchColumn();
   //echo $nbrEntree;
}
//
//$references = $bdd->query('SELECT * FROM _references order by id ASC');
$references = $bdd->query('SELECT * FROM _works order by ordre ASC');
//Ajout d'une fiche projet
?>
<div id="addButton">
		<h2 id="titleMore"><img id="morePict" src="images/moreW.png" width="10" height="10" border="none"/>
        <a href="addWorks.php?nbrMax=<?php echo $nbrEntree;?>" target="_self">Ajouter une fiche works</a></h2>
</div>
<?php
//
// On affiche chaque entrée une à une
$numUp = 0;
while ($donnees = $references->fetch())
{
	if($donnees['id'] == 1){
		//
	}else{
		$numUp ++;
		echo "<div id=\"ficheContact\">";
			echo "<h2 id=\"title\">";
				echo "<FORM name=\"ordreForm\" method=\"post\" action=\"upDateOrdreWorks.php\">";
					echo "Position:<br><select name=\"newPos\" onChange=\"this.form.submit();\">";
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
				echo "<FORM method=\"post\" action=\"upDateWorks.php\" enctype=\"multipart/form-data\" onSubmit=\"\">";
					if($donnees['visible'] == 0){
						echo "Visible dans flash:<br>Non<INPUT type=\"radio\" name=\"visible\" value=\"0\" checked>   Oui<INPUT type=\"radio\" name=\"visible\" value=\"1\">";
					}else{
						echo "Visible dans flash:<br>Non<INPUT type=\"radio\" name=\"visible\" value=\"0\">   Oui<INPUT type=\"radio\" name=\"visible\" value=\"1\" checked>";
					}
					echo "<div id=\"interligne\"></div>";
					echo "<hr>";
					echo "<div id=\"interligne\"></div>";
					echo "Nom:<br><input id=\"resetMargin\" type=\"text\" size =\"29\" name=\"name\" value=\"".$donnees['name']."\"><br>";
					echo "<div id=\"interligne\"></div>";
					echo "Lien:<br><input id=\"resetMargin\" type=\"text\" size =\"29\" name=\"link\" value=\"".$donnees['link']."\"><br>";
					echo "<div id=\"interligne\"></div>";
					echo "<div id=\"tof_".$numUp."\">";
					if($donnees['picture'] != ''){
						$newW = 204;
						$newH = 102;
						//
						echo "Photo: <br><a href=\"".$root.$donnees['picture']."\" target=\"_blank\"><img border=\"0\" src=\"".$root.$donnees['picture']."\" width=\"".$newW."\" height=\"".$newH."\"/></a><br>";
						//
					}else{
						echo "Pas de photo<br>";
					}
					echo "</div>";
					echo "<div id=\"interligne\"></div>";

					echo "<script type=\"text/javascript\">";
						echo "$(document).ready(function() {";
							echo "$(\"#file_upload_".$numUp."\").uploadify({";
								echo "\"uploader\"  : \"swf/uploadify.swf\",";
								echo "\"script\"    : \"uploadPhoto.php\",";
								echo "\"method\" : \"GET\",";
								echo "\"scriptData\": {'width':192, 'height':86},";
								echo "\"cancelImg\" : \"images/cancel.png\",";
								echo "\"folder\"    : \"../medias/images\",";
								echo "\"auto\"      : true,";
								echo "\"displayData\"	: 'percentage',";
								echo "\"fileExt\"       : '*.jpg;*.gif;*.png',";
								echo "\"fileDesc\"      : 'Web Image Files (.JPG, .GIF, .PNG)',";
								echo "\"buttonText\"  : \"Parcourir...\",";
								echo "\"onComplete\": function(event, queueID, fileObj, response, data) {";
									//echo "$(\"#filesUploaded_".$numUp."\").empty();";
									//echo "$(\"#filesUploaded_".$numUp."\").append(\"<a href=\"+fileObj.filePath+\" target='_blank'>\"+fileObj.name+\"</a>\");";
									//echo "$(\"#filesUploaded_".$numUp."\").append(\"<a href=\"+response+\" target='_blank'>\"+fileObj.name+\"</a>\");";
									echo "$(\"#nameToBd_".$numUp."\").append(\"<input type='hidden' name='photo' value=\"+response+\">\");";
									echo "$(\"#tof_".$numUp."\").empty();";
									echo "$(\"#tof_".$numUp."\").append(\"     Photo: <br><a href=\"+response+\" target='_blank'><img border='0' src=\"+response+\" width='".$newW."' height='".$newH."'  /></a>    \");";
								echo "}";
							echo "});";
						echo "});";
					echo "</script>";
					echo "Nouvelle photo [192x86] :<br><input id=\"file_upload_".$numUp."\" name=\"_\" type=\"file\" />";
					echo "<div id=\"filesUploaded_".$numUp."\"></div>";
					echo "<div id=\"nameToBd_".$numUp."\"></div>";
					echo "<input type=\"hidden\" name=\"ID\" value=\"".$donnees['id']."\">";
					echo "<div id=\"interligne\"></div>";
					echo "<input id=\"resetMargin\" type=\"submit\" name=\"modifier\" value=\"Enregistrer\">";
				echo "</FORM>";
				echo "<FORM method=\"post\" action=\"deleteWorks.php\">";
					echo "<div id=\"interligne\"></div>";
					echo "<input type=\"hidden\" name=\"ID\" value=\"".$donnees['id']."\">";
					echo "<input id=\"resetMargin\" type=\"submit\" name=\"supprimer\" value=\"Supprimer\">";
				echo "</FORM>";
			echo "</h2>";
		echo "</div>";
	}
}
$references->closeCursor();

?>
 