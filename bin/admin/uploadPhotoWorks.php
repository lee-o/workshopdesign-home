<?php
//
function msgErreur($msg) {
	echo "<script language=\"javascript\">alert(\"".$msg."\");</script>\n";
};
//
//
if (!empty($_FILES)) {
	$tempFile = $_FILES['Filedata']['tmp_name'];
	$extensionFile = $_FILES['Filedata']['type'];
	$targetPath = $_SERVER['DOCUMENT_ROOT'] . $_REQUEST['folder'] . '/';
	$targetFileTemp =  $_FILES['Filedata']['name'];
	//$targetFile =  str_replace('//','/',$targetPath) . $_FILES['Filedata']['name'];
	//
	//on verifie si le fichier est bien présent
	if ( !is_uploaded_file($tempFile) ) { // vérifier si le fichier est présent
		msgErreur("Le fichier est introuvable"); // message d'erreur
		return false;
	};
	//
	//resize image
	include('functions.php');
	smart_resize_image($tempFile,$width = 192,$height = 86,$proportional = true,$crop = true,$output = $tempFile,$delete_original = true,$use_linux_commands = false );
	//
	//on renome le fichier au cas ou il existe
	$dateTemp = getdate();
	$dateTempName = $dateTemp[seconds];
	$extension = pathinfo($targetFileTemp,PATHINFO_EXTENSION);
	$name_sans_extension = pathinfo($targetFileTemp,PATHINFO_FILENAME);
	$name_sans_extension = preg_replace('/([^a-z0-9]+)/i', '_', $name_sans_extension);
	$targetFileTemp = $name_sans_extension."_".$dateTemp[minutes].$dateTemp[seconds].".".$extension;
	//
	// enlever les accents
	$targetFileTemp = strtr($targetFileTemp, 'ÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÒÓÔÕÖÙÚÛÜÝàáâãäåçèéêëìíîïðòóôõöùúûüýÿ', 'AAAAAACEEEEIIIIOOOOOUUUUYaaaaaaceeeeiiiioooooouuuuyy');
	// remplacer les caracteres autres que lettres, chiffres et point par "_"
	$targetFileTemp = preg_replace('/([^.a-z0-9]+)/i', '_', $targetFileTemp);
	//
	$targetFile =  str_replace('//','/',$targetPath) . $targetFileTemp;
	//
	//
	if ( file_exists($rep . $nom_fichier) ) { // vérifier qu'il n'existe pas déjà un fichier portant ce nom
		msgErreur("Un fichier portant ce nom existe déjà !!!"); // message d'erreur
		return false;
	} else if ( !move_uploaded_file($nom_temp, $rep . $nom_fichier) ) { // transfèrer le fichier en codant les caractères spx
		msgErreur("Impossible de copier le fichier dans ".$rep); // message d'erreur
		return false;
	};
	//
	//
	move_uploaded_file($tempFile,$targetFile);
	echo str_replace($_SERVER['DOCUMENT_ROOT'],'',$targetFile);

}
?>