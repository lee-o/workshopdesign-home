<?php // upload de fichier image

if( isset($_POST['uploadFile']) ) { // si formulaire soumis
	$champ = "fichier"; // le nom du champ de fichier html
	$rep = "../medias/images"; // le nom du répertoire de destination du fichier d'image
	$test = uploadImg ($champ, $rep); // appel de la fonction de transfert
	//if ( $test ) echo "Transfert réussi : <img src=\"".$rep."/".$test."\">\n";
}; // fin de test

function msgErreur($msg) {
	echo "<script language=\"javascript\">alert(\"".$msg."\");</script>\n";
};

function uploadImg ($fichier, $rep) {
	echo $fichier;
	// $fichier->nom du champ de fichier html, $rep->nom du répertoire dans lequel transférer l'image
	// la fonction retourne le nom de fichier si réussite ou false
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
	
	$type_fichier = $_FILES[$fichier]['type']; // on vérifie maintenant l'extension
	if ( !strstr($type_fichier, 'jpg') && !strstr($type_fichier, 'jpeg') && !strstr($type_fichier, 'png') && !strstr($type_fichier, 'gif') ) {
		msgErreur("Le fichier n'est pas une image"); // message d'erreur
		return false;
	};
	
	$dateTemp = getdate();
	$dateTempName = $dateTemp[seconds];
	$nom_fichier = $dateTemp[seconds]."_".$_FILES[$fichier]['name']; // on copie le fichier dans le dossier de destination
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