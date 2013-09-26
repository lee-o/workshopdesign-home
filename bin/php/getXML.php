<?php
$LANGCODE = $_GET[langcode];
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
header("Content-type: text/xml");
// Si tout va bien, on peut continuer
/////////////////////////////////////////
/////////////////////////////////////////
// On récupère tout le contenu de la table jeux_video
$about = $bdd->query('SELECT * FROM _about order by id ASC');
$contact = $bdd->query('SELECT * FROM _contact order by id ASC');
$liens = $bdd->query('SELECT * FROM _liens order by ordre ASC');
$backdrop = $bdd->query('SELECT * FROM _backdrop order by ordre ASC');
$works = $bdd->query('SELECT * FROM _works order by ordre ASC');
$news = $bdd->query('SELECT * FROM _news order by id ASC');
$products = $bdd->query('SELECT * FROM _products order by ordre ASC');
/////////////////////////////////////////
/////////////////////////////////////////
/////////////////////////////////////////
//on ecrit l entete
/////////////////////////////////////////
echo "<?xml version='1.0' encoding='UTF-8'?>".chr(10);
echo "<DATA>".chr(10).chr(10);
/////////////////////////////////////////
/////////////////////////////////////////
/////////////////////////////////////////
//ici toute la nav
/////////////////////////////////////////
echo chr(9)."<navigation type='Navigation'>".chr(10).chr(10);
	/////////////////////////////////////////
	/////////////////////////////////////////
	/////////////////////////////////////////
	//ici la home
	/////////////////////////////////////////
	echo chr(9).chr(9)."<home type='Home'>".chr(10).chr(10);
		/////////////////////////////////////////
		/////////////////////////////////////////
		/////////////////////////////////////////
		//ici les works
		/////////////////////////////////////////
		echo chr(9).chr(9).chr(9)."<works type='Works'>".chr(10).chr(10);
		// On affiche chaque entrée une à une
		while ($donnees = $works->fetch())
		{
			if($donnees['id'] == 1){
				echo chr(9).chr(9).chr(9).chr(9)."<name><![CDATA[".utf8_encode($donnees['name'])."]]></name>".chr(10).chr(10);
			}else{
				if($donnees['picture'] != ""){
					if($donnees['visible'] == 1){
						echo chr(9).chr(9).chr(9).chr(9)."<ref id='".$donnees['id']."' type='Work'>".chr(10);
							echo chr(9).chr(9).chr(9).chr(9).chr(9)."<name><![CDATA[".$donnees['name']."]]></name>".chr(10);
							echo chr(9).chr(9).chr(9).chr(9).chr(9)."<picture><![CDATA[".$donnees['picture']."]]></picture>".chr(10);
							echo chr(9).chr(9).chr(9).chr(9).chr(9)."<link><![CDATA[".$donnees['link']."]]></link>".chr(10);
						echo chr(9).chr(9).chr(9).chr(9)."</ref>".chr(10).chr(10);
					}
				}
			}
		}
		echo chr(9).chr(9).chr(9)."</works>".chr(10).chr(10);
		$works->closeCursor(); // Termine le traitement de la requête
		/////////////////////////////////////////
		/////////////////////////////////////////
		/////////////////////////////////////////
		//ici les news
		/////////////////////////////////////////
		echo chr(9).chr(9).chr(9)."<news type='News'>".chr(10).chr(10);
		// On affiche chaque entrée une à une
		while ($donnees = $news->fetch())
		{
			if($donnees['id'] == 1){
				echo chr(9).chr(9).chr(9).chr(9)."<name><![CDATA[".utf8_encode($donnees['name'])."]]></name>".chr(10).chr(10);
			}else{
				echo chr(9).chr(9).chr(9).chr(9)."<ref id='".$donnees['id']."' type='New'>".chr(10);
					echo chr(9).chr(9).chr(9).chr(9).chr(9)."<name><![CDATA[".$donnees['name']."]]></name>".chr(10);
					echo chr(9).chr(9).chr(9).chr(9).chr(9)."<video><![CDATA[".$donnees['video']."]]></video>".chr(10);
					echo chr(9).chr(9).chr(9).chr(9).chr(9)."<url><![CDATA[".$donnees['url']."]]></url>".chr(10);
					echo chr(9).chr(9).chr(9).chr(9).chr(9)."<largeur_player><![CDATA[".$donnees['largeur_player']."]]></largeur_player>".chr(10);
					echo chr(9).chr(9).chr(9).chr(9).chr(9)."<hauteur_player><![CDATA[".$donnees['hauteur_player']."]]></hauteur_player>".chr(10);
				echo chr(9).chr(9).chr(9).chr(9)."</ref>".chr(10).chr(10);
			}
		}
		echo chr(9).chr(9).chr(9)."</news>".chr(10).chr(10);
		$news->closeCursor(); // Termine le traitement de la requête
		/////////////////////////////////////////
		/////////////////////////////////////////
		/////////////////////////////////////////
		//ici les products
		/////////////////////////////////////////
		echo chr(9).chr(9).chr(9)."<products type='Products'>".chr(10).chr(10);
		// On affiche chaque entrée une à une
		while ($donnees = $products->fetch())
		{
			if($donnees['id'] == 1){
				echo chr(9).chr(9).chr(9).chr(9)."<name><![CDATA[".utf8_encode($donnees['name'])."]]></name>".chr(10).chr(10);
			}else{
				if($donnees['picture'] != ""){
					if($donnees['visible'] == 1){
						echo chr(9).chr(9).chr(9).chr(9)."<ref id='".$donnees['id']."' type='Product'>".chr(10);
							echo chr(9).chr(9).chr(9).chr(9).chr(9)."<name><![CDATA[".$donnees['name']."]]></name>".chr(10);
							echo chr(9).chr(9).chr(9).chr(9).chr(9)."<picture><![CDATA[".$donnees['picture']."]]></picture>".chr(10);
							echo chr(9).chr(9).chr(9).chr(9).chr(9)."<link><![CDATA[".$donnees['link']."]]></link>".chr(10);
						echo chr(9).chr(9).chr(9).chr(9)."</ref>".chr(10).chr(10);
					}
				}
			}
		}
		echo chr(9).chr(9).chr(9)."</products>".chr(10).chr(10);
		$products->closeCursor(); // Termine le traitement de la requête
	/////////////////////////////////////////
	/////////////////////////////////////////
	/////////////////////////////////////////
	echo chr(9).chr(9)."</home>".chr(10).chr(10);
	/////////////////////////////////////////
	/////////////////////////////////////////
	/////////////////////////////////////////
	//ici le about
	/////////////////////////////////////////
	echo chr(9).chr(9)."<about type='About'>".chr(10);
	//boucle sur le contenu de la page flux
	while ($donnees = $about->fetch())
	{
		if($donnees['id'] == 1){
			echo chr(9).chr(9).chr(9)."<name><![CDATA[".utf8_encode($donnees['name'])."]]></name>".chr(10);
		}else{
			echo chr(9).chr(9).chr(9)."<description><![CDATA[".$donnees['description']."]]></description>".chr(10);
		}
	}
	echo chr(9).chr(9)."</about>".chr(10).chr(10);
	$about->closeCursor(); // Termine le traitement de la requête
	/////////////////////////////////////////
	/////////////////////////////////////////
	/////////////////////////////////////////
	//ici le contact
	/////////////////////////////////////////
	echo chr(9).chr(9)."<contact type='Contact'>".chr(10);
	//boucle sur le contenu de la page flux
	while ($donnees = $contact->fetch())
	{
		if($donnees['id'] == 1){
			echo chr(9).chr(9).chr(9)."<name><![CDATA[".utf8_encode($donnees['name'])."]]></name>".chr(10);
		}else{
			echo chr(9).chr(9).chr(9)."<description><![CDATA[".$donnees['description']."]]></description>".chr(10);
		}
	}
	echo chr(9).chr(9)."</contact>".chr(10).chr(10);
	$contact->closeCursor(); // Termine le traitement de la requête
	//on ferme le noeud navigation
echo chr(9)."</navigation>".chr(10).chr(10);
/////////////////////////////////////////
/////////////////////////////////////////
/////////////////////////////////////////
//ici les liens
/////////////////////////////////////////
echo chr(9)."<liens type='Liens'>".chr(10);
//boucle sur le contenu de la page flux
while ($donnees = $liens->fetch())
{
	if($donnees['id'] != 1){
		if($donnees['visible'] == 1){
			echo chr(9).chr(9)."<lien id='".$donnees['id']."'>".chr(10);
				echo chr(9).chr(9).chr(9)."<name><![CDATA[".utf8_encode($donnees['name'])."]]></name>".chr(10);
				echo chr(9).chr(9).chr(9)."<link><![CDATA[".$donnees['link']."]]></link>".chr(10);
			echo chr(9).chr(9)."</lien>".chr(10).chr(10);
		}
	}
}
echo chr(9)."</liens>".chr(10).chr(10);
$liens->closeCursor(); // Termine le traitement de la requête
/////////////////////////////////////////
/////////////////////////////////////////
/////////////////////////////////////////
//ici les backdrop
/////////////////////////////////////////
echo chr(9)."<backdrop type='Backdrop'>".chr(10);
//boucle sur le contenu de la page flux
while ($donnees = $backdrop->fetch())
{
	if($donnees['id'] != 1){
		if($donnees['picture'] != ""){
			if($donnees['visible'] == 1){
				echo chr(9).chr(9)."<picture><![CDATA[".$donnees['picture']."]]></picture>".chr(10);
			}
		}
	}
}
echo chr(9)."</backdrop>".chr(10).chr(10);
$backdrop->closeCursor(); // Termine le traitement de la requête
/////////////////////////////////////////
/////////////////////////////////////////
/////////////////////////////////////////
echo "</DATA>".chr(10);

?>
