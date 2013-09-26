
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
$news = $bdd->query('SELECT * FROM _news order by id ASC');
// On affiche chaque entrée une à une
echo "<div id=\"sepBlack\"></div>";
while ($donnees = $news->fetch())
{
	if($donnees['id'] == 1){
		//
	}else{
		?>
			<script type="text/javascript">
                swfobject.embedSWF("<?php echo $donnees['video']; ?>", "PlayerVideo", "<?php echo $donnees['largeur_player']; ?>", "<?php echo $donnees['hauteur_player']; ?>", "10.1", "js/expressInstall.swf", {}, {bgcolor:"#000000",salign:"tl",scale:"noscale",menu:"false",allowfullscreen:"true"}, {id:"Preview-video",name:"Preview-video"});
            </script>
        <?php
		echo "<div id=\"ficheAbout\">";
			echo "<h2 id=\"title\">";
				echo "<FORM method=\"post\" action=\"upDateNews.php\" enctype=\"multipart/form-data\" onSubmit=\"\">";
					echo "<div id=\"interligne\"></div>";
					echo "<div id=\"PlayerVideo\"></div>";
					echo "<div id=\"interligne\"></div>";
					echo "Nom:<br><input type=\"text\" size =\"64\" name=\"name\" value=\"".$donnees['name']."\"><br>";			
					echo "<div id=\"interligne\"></div>";
					echo "Url embed:<br><input type=\"text\" size =\"64\" name=\"video\" value=\"".$donnees['video']."\"><br>";
					echo "<div id=\"interligne\"></div>";
					echo "Url navigateur:<br><input type=\"text\" size =\"64\" name=\"url\" value=\"".$donnees['url']."\"><br>";
					echo "<div id=\"interligne\"></div>";
					echo "Hauteur du player:<br><input type=\"text\" size =\"64\" name=\"hauteur_player\" value=\"".$donnees['hauteur_player']."\"><br>";
					echo "<div id=\"interligne\"></div>";
					echo "<input type=\"hidden\" name=\"ID\" value=\"".$donnees['id']."\">";
					echo "<div id=\"interligne\"></div>";
					echo "<input type=\"submit\" name=\"modifier\" value=\"Enregistrer\">";
				echo "</FORM>";
			echo "</h2>";
		echo "</div>";
	}
}
$news->closeCursor();

?>