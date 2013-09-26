<?php
//
if($_POST['Enregistrer'] == "Enregistrer" && $_POST['ID'] != ''){
	$id = $_POST['ID'];
	$name = stripDC($_POST['name']);
	$description = stripDC($_POST['description']);
	//
	$db = mysql_connect('mysql5-22.perso', 'workshopmbdd', '2F0BzY9iKRFi');
	mysql_select_db('workshopmbdd', $db);	
	$result = mysql_query('UPDATE _adress SET name = \''.$name.'\',description = \''.$description.'\'  WHERE id = \''.$id.'\'') or die('error : '.mysql_error());
	if (!$result) {
		die('Invalid query: ' . mysql_error());
	}else{
		//header("Location: contacts.htm"); 
		redirige("contacts.htm");
	}
}
//
function redirige($vers){
	echo "<script language=\"Javascript\">document.location.replace(\"".$vers."\");</script>\n";
}
//
function stripDC($string){
	$str = strtr($string, "\"", "'");
	return $str;
}
//
?>
