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
$home = $bdd->query('SELECT * FROM _news WHERE id=1');
$donnees = $home->fetch();
//
?>
<!--<script type="text/javascript">
	swfobject.embedSWF("<?php /*echo $donnees['video'];*/ ?>", "PlayerVideo", "960", "320", "9.0.115", "js/expressInstall.swf", {}, {bgcolor:"#000000",salign:"tl",scale:"noscale",menu:"false",allowfullscreen:"true"}, {id:"Preview-video",name:"Preview-video"});
</script>-->

<script type="text/javascript">
	swfobject.embedSWF("swf/PlayerVideo.swf", "PlayerVideo", "960", "380", "9.0.115", "js/expressInstall.swf", {URLVIDEO:"http://workshopdesign-home.com/medias/videos/LA DETENTE-TEASE-p.mp4",URLPICTURE:"http://workshopdesign-home.com/medias/images/acc_video.jpg"}, {bgcolor:"#000000",salign:"tl",scale:"noscale",menu:"false",allowfullscreen:"true"}, {id:"Preview-video-faceB",name:"Preview-video-faceB"});
</script>


<?php
echo "<div id=\"ficheHomePicture\">";
	echo "<FORM method=\"post\" action=\"upDateNews.php\" enctype=\"multipart/form-data\">";
		echo "<h2 id=\"titleHome\">";
			echo "<div id=\"interligne\"></div>";
			echo "<div id=\"PlayerVideo\"></div>";
			echo "<div id=\"interligne\"></div>";
			echo "Nom:<br><input type=\"text\" size =\"64\" name=\"name\" value=\"".$donnees['name']."\"><br>";
			echo "<div id=\"interligne\"></div>";
			echo "Lien YouTube:<br><input type=\"text\" size =\"64\" name=\"video\" value=\"".$donnees['video']."\"><br>";
			echo "<div id=\"interligne\"></div>";
			echo "<input type=\"hidden\" name=\"ID\" value=\"".$donnees['id']."\">";
			echo "<input type=\"submit\" name=\"modifier\" value=\"Enregistrer\">";
		echo "</h2>";
	echo "</FORM>";
echo "</div>";
echo "<div class=\"clear\"></div>";
$home->closeCursor();
?>