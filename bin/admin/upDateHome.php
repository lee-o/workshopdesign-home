
<?php
$repFinal = "medias/images/";
//
if($_POST['modifier'] == "Enregistrer"){
	//
	$hauteur_player = $_POST['hauteur_player'];
	$video = $_POST['video'];
	$photo = $_FILES['photo'];
	//
	if($photo['name'] != ''){	
		//
		$champ = 'photo'; // le nom du champ de fichier html
		$rep = "../medias/images"; // le nom du répertoire de destination du fichier d'image
		$upImg = uploadImg ($champ, $rep);	
		if ( $upImg ) {
			//
			$db = mysql_connect('mysql5-22.perso', 'workshopmbdd', '2F0BzY9iKRFi');
			mysql_select_db('workshopmbdd', $db);	
			$result = mysql_query('UPDATE _home SET video = \''.$video.'\',hauteur_player = \''.$hauteur_player.'\', picture = \''.$repFinal.$upImg.'\'  WHERE id = 1') or die('error : '.mysql_error());
			if (!$result) {
				die('Invalid query: ' . mysql_error());
			}else{
				redirige("home.htm");
			}
		}
	}else{
		//
		$db = mysql_connect('mysql5-22.perso', 'workshopmbdd', '2F0BzY9iKRFi');
		mysql_select_db('workshopmbdd', $db);	
		$result = mysql_query('UPDATE _home SET video = \''.$video.'\',hauteur_player = \''.$hauteur_player.'\'  WHERE id = 1') or die('error : '.mysql_error());
		if (!$result) {
			die('Invalid query: ' . mysql_error());
		}else{
			redirige("home.htm");
		}
	}	
}
//
function redirige($vers){
	echo "<script language=\"Javascript\">document.location.replace(\"".$vers."\");</script>\n";
}
//
function msgErreur($msg) {
	echo "<script language=\"javascript\">alert(\"".$msg."\");</script>\n";
};
//
function stripDC($string){
	$str = strtr($string, "\"", "'");
	return $str;
}
//
function uploadImg ($fichier, $rep) {
	if ( !is_dir($rep) ) { // le répertoire existe t-il ?
		msgErreur("Le répertoire n'existe pas !!!"); // message d'erreur
		return false;
	};
	$rep = $rep."/"; // le dossier dans lequel transférer l'image
	$nom_temp = $_FILES[$fichier]['tmp_name']; // le nom du fichier temporaire
	if ( !is_uploaded_file($nom_temp) ) { // vérifier si le fichier est présent
		msgErreur("Le fichier est introuvable"); // message d'erreur
		return false;
	};
	//
	/*include('functions.php');
	smart_resize_image($_FILES[$fichier]['tmp_name'],
                              $width = 320,
                              $height = 0,
                              $proportional = true,
                              $output = $_FILES[$fichier]['tmp_name'],
                              $delete_original = true,
                              $use_linux_commands = false );*/
	//
	$type_fichier = $_FILES[$fichier]['type']; // on vérifie maintenant l'extension
	if ( !strstr($type_fichier, 'jpg') && !strstr($type_fichier, 'jpeg') && !strstr($type_fichier, 'png') && !strstr($type_fichier, 'gif') ) {
		msgErreur("Le fichier n'est pas une image"); // message d'erreur
		return false;
	};
	$dateTemp = getdate();
	$dateTempName = $dateTemp[seconds];
	$extension = pathinfo($_FILES[$fichier]['name'],PATHINFO_EXTENSION);
	$name_sans_extension = pathinfo($_FILES[$fichier]['name'],PATHINFO_FILENAME);
	$name_sans_extension = preg_replace('/([^a-z0-9]+)/i', '_', $name_sans_extension);
	$nom_fichier = $name_sans_extension."_".$dateTemp[minutes].$dateTemp[seconds].".".$extension;
	if ( preg_match('#[\x00-\x1F\x7F-\x9F/\\\\]#', $nom_fichier) ) { // vérifier que le nom de fichier ne contient pas de caractères suspects
		msgErreur("Nom de fichier non valide"); // message d'erreur
		return false;
	};
	// enlever les accents
	$nom_fichier = strtr($nom_fichier, 'ÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÒÓÔÕÖÙÚÛÜÝàáâãäåçèéêëìíîïðòóôõöùúûüýÿ', 'AAAAAACEEEEIIIIOOOOOUUUUYaaaaaaceeeeiiiioooooouuuuyy');
	// remplacer les caracteres autres que lettres, chiffres et point par "_"
	$nom_fichier = preg_replace('/([^.a-z0-9]+)/i', '_', $nom_fichier);
	if ( file_exists($rep . $nom_fichier) ) { // vérifier qu'il n'existe pas déjà un fichier portant ce nom
		msgErreur("Un fichier portant ce nom existe déjà !!!"); // message d'erreur
		return false;
	} else if ( !move_uploaded_file($nom_temp, $rep . $nom_fichier) ) { // transfèrer le fichier en codant les caractères spx
		msgErreur("Impossible de copier le fichier dans ".$rep); // message d'erreur
		return false;
	};
	return $nom_fichier; // sortie de fonction avec reussite
};
?>
