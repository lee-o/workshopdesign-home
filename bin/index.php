<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<title>|  Workshop Design  |</title>
		<meta name="language" content="fr" />
		<meta name="Robots" content="all" />
		<meta name="copyright" content="(c) 2010 Workshop Design , tous droits réservés" />
		<meta name="description" content="WORKSHOPDESIGN Importateur et distributeur de produit design. Collection et inspiration design. CONTRACT / E-STORE / TRENDMAG Expert en union subtile, WORKSHOPDESIGN oeuvre pour un mariage réussi entre inspiration et collection design. Nos activités : CONTRACT Notre spécialisation en aménagement d'hôtel haut de gamme nous donne la capacité de répondre aux contrats les plus ambitieux. E-STORE propose une nouvelle expérience de shopping on line grâce à sa recherche et sa sélection de produits design. TRENDMAG inspire vos décisions et vous renseigne sur les nouvelles tendances." />
		<meta name="keywords" content="DESIGNER, TOM DIXON, STARCK, LUMINAIRE DESIGN, AMENAGEMENT D'HÔTEL, HÔTEL DESIGN, MARCEL WANDERS, KARIM RASHID, FAUTEUIL DE DESIGNER, LAMPE DESIGN, HÔTEL AND RESORT, CONTRACT, RESTAURANT DESIGN, MOBILIER D'EXTERIEUR, ATELIER DESIGN, DESIGN, LUMINAIRE, DECORATION, OUTDOOR, ZAHA HADID, WORKSHOP. MOBILIER DESIGN" />
        <link rel="stylesheet"  href="css/wsd.css" type="text/css" media="screen"  />
        <link type="text/css" href="php/rsslib/rss-style.css" rel="stylesheet">
		<link rel="shortcut icon" href="medias/_favicon.ico">
		<script type="text/javascript" src="js/swfobject.js"></script>
		<script type="text/javascript" src="js/swfmacmousewheel2.js"></script>
		<script type="text/javascript">
			function outputStatus(e) {
				//alert("On affiche le scroll, ou pas ... succes:" + e.success);
				if(e.success == false){
					document.body.style.overflow='auto'; 
					//document.body.style.backgroundColor = "#006699";
				}else{
					document.body.style.overflow='hidden'; 
				}
			}
			var flashvars = {
				racine : "http://www.workshopdesign-home.com",
				langcode : "fr"
			};
			var params = {
				menu: "false",
				scale: "noScale",
				salign: "tl",
				allowFullscreen: "true",
				allowScriptAccess: "always",
				bgcolor: "#FFFFFF",
				wmode: "window"
			};
			var attributes = {id:"flashMovie", name:"testObject"};
			swfobject.embedSWF("swf/main.swf", "flashMovie", "100%", "100%", "10.0.45","js/expressInstall.swf", flashvars, params, attributes, outputStatus);
			//swfmacmousewheel.registerObject(attributes.id);
		</script>
        <script type="text/javascript">
			var _gaq = _gaq || [];
			_gaq.push(['_setAccount', 'UA-20017065-1']);
			_gaq.push(['_trackPageview']);
			(function() {
				var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
				ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
				var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
			})();
			function Page(p){
				_gaq.push(['_trackPageview',p]);
			}
			function Event(p1,p2){
				_gaq.push(['_trackEvent', p1, p2]);
			}
		</script>
	</head>
	<body>
		<div id="flashContainer">
        
			<div id="flashMovie">
                <div id="dlFlashBtn">
                    <h3>Vous devez installer <a href="http://www.adobe.com/go/getflashplayer">Flash Player 10</a> et autoriser javascript pour voir le contenu du site.</h3>
                    <a href="http://www.adobe.com/go/getflashplayer"><img id="dlPict" src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" title="Get Adobe Flash player" /></a>
                </div>
                <? try
				{
					$bdd = new PDO('mysql:host=mysql5-22.perso;dbname=workshopmbdd', 'workshopmbdd', '2F0BzY9iKRFi');
				}
				catch(Exception $e)
				{
					die('Erreur : '.$e->getMessage());
				}
				?>
            	<img id="pict" src="medias/images/wsd_logo_home.jpg" width="368" height="148"/><br /><hr /><br />
                <h1>About</h1>
			    <?
				$about = $bdd->query('SELECT * FROM _about');
				$donnees = $about->fetch();
				echo "<div class=\"rsslib\">";
					echo "<h4>".utf8_decode($donnees['description'])."</h4>";
				echo "</div>";
				$about->closeCursor();
				?>
                </h2>
				<br /><hr /><br>
                <h1>Works</h1>
			    <?
				$works = $bdd->query('SELECT * FROM _works order by ordre ASC');
				while ($donnees = $works->fetch())
				{
					if($donnees['id'] == 1){
					}else{
						if($donnees['picture'] != ""){
							if($donnees['visible'] == 1){
								echo "<div class=\"rsslib\">";
									echo "<h2><a href=http://".$donnees['link']." target=\"_blank\">".utf8_decode($donnees['name'])."</a></h2>";
									echo "<img id='pict' src='".$donnees['picture']."'width='204' height='102'/><br>";
								echo "</div>";
							}
						}
					}
				}
				$works->closeCursor();
				?>
                </h2>
				<br /><hr /><br>
                <h1>Products</h1>
			    <?
				$products = $bdd->query('SELECT * FROM _products order by ordre ASC');
				while ($donnees = $products->fetch())
				{
					if($donnees['id'] == 1){
					}else{
						if($donnees['picture'] != ""){
							if($donnees['visible'] == 1){
								echo "<div class=\"rsslib\">";
									echo "<h2><a href=http://".$donnees['link']." target=\"_blank\">".utf8_decode($donnees['name'])."</a></h2>";
									echo "<img id='pict' src='".$donnees['picture']."'width='204' height='102'/><br>";
								echo "</div>";
							}
						}
					}
				}
				$products->closeCursor();
				?>
                </h2>
				<br /><hr /><br>
                <h1>Contact</h1>
			    <?
				$contact = $bdd->query('SELECT * FROM _contact');
				$donnees = $contact->fetch();
				echo "<div class=\"rsslib\">";
					echo "<h4>".utf8_decode($donnees['description'])."</h4>";
				echo "</div>";
				$contact->closeCursor();
				?>
                </h2>
				<br /><hr /><br>
                <h1>Other Links</h1>
			    <?
				$liens = $bdd->query('SELECT * FROM _liens order by ordre ASC');
				while ($donnees = $liens->fetch())
				{
					if($donnees['id'] == 1){
					}else{
						if($donnees['visible'] == 1){
							echo "<div class=\"rsslib\">";
								echo "<h2><a href=http://".$donnees['link']." target=\"_blank\">".utf8_decode($donnees['name'])."</a></h2>";
							echo "</div>";
						}
					}
				}
				$liens->closeCursor();
				?>
                </h2>
				<br /><hr /><br>
                <h1>Les news &quot;Workshop Design&quot;</h1>
                <fieldset class="rsslib">
                <?php
                    //require_once($_SERVER['DOCUMENT_ROOT']."/php/rsslib/rsslib.php");
                    $url = "http://www.workshopdesign-store.com/xml/syndication.rss";
                    //echo utf8_decode(RSS_Display($url, 15, false, true));
                    require_once($_SERVER['DOCUMENT_ROOT']."/php/magpierss/rss_fetch.inc");
					
					$num_items = 3;
					$rss = fetch_rss($url);
					$items = array_slice($rss->items, 0, $num_items);
					echo "<div class=\"rsslib\">";
					foreach ( $items as $item ) {


                    /*$rss = fetch_rss($url);
                    echo "<div class=\"rsslib\">";
                        foreach ($rss->items as $item ) {*/
                            $title = $item[title];
                            $url   = $item[link];
                            $desc   = $item[description];
                            echo "<a href=$url>$title</a><br>$desc</li><br>";
                        }
                    echo "</div>";
                ?>
                </fieldset>
                <br />		
			</div>	
		</div>
	</body>
</html>