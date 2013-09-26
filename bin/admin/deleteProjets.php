<?php
//
if($_POST['supprimer'] == "Supprimer le projet" && $_POST['ID'] != ''){
	$id = $_POST['ID'];
	//
	$db = mysql_connect('mysql5-22.perso', 'workshopmbdd', '2F0BzY9iKRFi');
	mysql_select_db('workshopmbdd', $db);	
	$result = mysql_query('DELETE FROM _lastProjects WHERE id = \''.$id.'\'') or die('error : '.mysql_error());
	if (!$result) {
		die('Invalid query: ' . mysql_error());
	}else{ 
		redirige("projets.htm");
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
?>
