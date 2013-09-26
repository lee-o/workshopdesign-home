<?php
//
if($_POST['modifier'] == "Enregistrer" && $_POST['ID'] != ''){
	$id = $_POST['ID'];
	$name = stripDC($_POST['name']);
	$link = stripDC($_POST['link']);
	$visible = $_POST['visible'];
	$photo = $_POST['photo'];
	//
	$db = mysql_connect('mysql5-22.perso', 'workshopmbdd', '2F0BzY9iKRFi');
	mysql_select_db('workshopmbdd', $db);
	if($photo != ''){	
		$result = mysql_query('UPDATE _products SET name = \''.$name.'\',link = \''.$link.'\', visible = \''.$visible.'\', picture = \''.$photo.'\'  WHERE id = \''.$id.'\'') or die('error : '.mysql_error());
	}else{
		$result = mysql_query('UPDATE _products SET name = \''.$name.'\',link = \''.$link.'\', visible = \''.$visible.'\'  WHERE id = \''.$id.'\'') or die('error : '.mysql_error());
	}
	if (!$result) {
		die('Invalid query: ' . mysql_error());
	}else{
		redirige("products.htm");
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
?>