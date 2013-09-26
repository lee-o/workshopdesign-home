<?php
//
if($_POST['supprimer'] == "Supprimer la fiche" && $_POST['ID'] != ''){
	//
	$id = $_POST['ID'];
	//
	$db = mysql_connect('mysql5-22.perso', 'workshopmbdd', '2F0BzY9iKRFi');
	mysql_select_db('workshopmbdd', $db);
	
	$ord = mysql_query("SELECT ordre FROM _works WHERE id = $id") or die('error : '.mysql_error());
	$ordNum = mysql_fetch_array($ord);
	$delOrd = $ordNum['ordre'];
	
	
	$result = mysql_query('DELETE FROM _works WHERE id = \''.$id.'\'') or die('error : '.mysql_error());
	if (!$result) {
		die('Invalid query: ' . mysql_error());
	}else{
		/*$count = mysql_query("SELECT * FROM _works WHERE id > 1") or die('error : '.mysql_error());
		$nbrEntree  = mysql_num_rows($count);
		echo "<script>alert(\"Il reste ".$nbrEntree." fiches apres la mise à jour\")</script>"; 
		*/
		//On reassort les données ordre
		$reOrd = mysql_query("UPDATE _works SET ordre=ordre-1 WHERE ordre > $delOrd") or die('error : '.mysql_error());
		//
		redirige("works.htm");
	}
	mysql_close($db);
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
