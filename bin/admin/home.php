<?php
try
{
	$bdd = new PDO('mysql:host=mysql5-22.perso;dbname=workshopmbdd', 'workshopmbdd', '2F0BzY9iKRFi');
}
catch(Exception $e)
{
    die('Erreur : '.$e->getMessage());
}
//
$home = $bdd->query('SELECT * FROM _home WHERE id=1');
$donnees = $home->fetch();
//
?>
<script type="text/javascript">
	swfobject.embedSWF("swf/PlayerVideo.swf", "PlayerVideo", "960", "<?php echo $donnees['hauteur_player']; ?>", "9.0.115", "js/expressInstall.swf", {URLVIDEO:"<?php echo $root; ?><?php echo $donnees['video']; ?>",URLPICTURE:"<?php echo $root; ?><?php echo $donnees['picture']; ?>"}, {bgcolor:"#000000",salign:"tl",scale:"noscale",menu:"false",allowfullscreen:"true"}, {id:"Preview-video-faceB",name:"Preview-video-faceB"});
</script>
<?php
echo "<div id=\"ficheHomePicture\">";
	echo "<FORM method=\"post\" action=\"upDateHome.php\" enctype=\"multipart/form-data\">";
		echo "<h2 id=\"titleHome\">";
			echo "<div id=\"interligne\"></div>";
			echo "<div id=\"PlayerVideo\"></div>";
			echo "<div id=\"interligne\"></div>";
			echo "Hauteur du player:<br>[320px de haut me paraît très bien pour garder une homogénéité dans le graphisme du site, maintenant on sais jamais, peut être vous avez des vidéos au format portrait]<br><input type=\"text\" size =\"64\" name=\"hauteur_player\" value=\"".$donnees['hauteur_player']."\"><br>";
			echo "<div id=\"interligne\"></div>";
			echo "Uploader une nouvelle photo<br>[Idéalement 960x(hauteur_player)px mais l'image sera étirée ou croppéee pour remplir l'espace du player vidéo qui est fixée dans flash à 960x(hauteur_player)px]<br><input type=\"file\" size =\"50\" name=\"photo\" value=\"".$donnees['picture']."\"><br>";
			echo "<div id=\"interligne\"></div>";
			echo "Vidéo:<br>[Fichier vidéo à placer à la mano sur le serveur via un soft ftp, attention à bien recopier le bon chemin d'accès à la vidéo.]<br><input type=\"text\" size =\"64\" name=\"video\" value=\"".$donnees['video']."\"><br>";
			echo "<div id=\"interligne\"></div>";
			echo "<input type=\"hidden\" name=\"ID\" value=\"".$donnees['id']."\">";
			echo "<input type=\"submit\" name=\"modifier\" value=\"Enregistrer\">";
		echo "</h2>";
	echo "</FORM>";
echo "</div>";
echo "<div class=\"clear\"></div>";
$home->closeCursor();
?>