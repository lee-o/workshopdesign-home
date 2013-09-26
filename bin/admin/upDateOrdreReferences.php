
<?php
//
$ID = $_POST['ID'];
$oldPos = $_POST['oldPos'];
$newPos = $_POST['newPos'];

//IDEALEMENT UTILISER CETTE REQUETE POUR REORDONNER LE TOUT
//$result = mysql_query("UPDATE _reference SET ordre=ordre+1 WHERE ordre >= $newpos AND ordre < $oldordre") or die('error : '.mysql_error());

if($_POST['modifier'] == "ordre" && $_POST['ID'] != ''){
	//
	$db = mysql_connect('mysql5-22.perso', 'workshopmbdd', '2F0BzY9iKRFi');
	mysql_select_db('workshopmbdd', $db);
	//
	if($oldPos < $newPos){
		//echo "on deplace de -1 les entrees de ".($oldPos + 1)." a ".$newPos." compris et on enregistre la nouvelle position en ".$newPos;
		$result=mysql_query("SELECT id,ordre FROM _references WHERE ordre > $oldPos && ordre <= $newPos") or die('error : '.mysql_error());
		while($row = mysql_fetch_array($result)){
			//echo "ordre ".$row['ordre']." devient ".($row['ordre'] - 1);
			//echo "<br />";
			$modifPos = mysql_query('UPDATE _references SET ordre = \''.($row['ordre'] - 1).'\'  WHERE id = \''.$row['id'].'\'') or die('error : '.mysql_error());
			//echo $modifPos;
			//echo "<br />";
		}
		//echo "et on enregistre ".$oldPos." en ".$newPos;
		$modifPos = mysql_query('UPDATE _references SET ordre = \''.$newPos.'\'  WHERE id = \''.$ID.'\'') or die('error : '.mysql_error());
		//echo  mysql_query('UPDATE _references SET ordre = \''.$newPos.'\'  WHERE ordre = \''.$oldPos.'\'');
		//echo "<br />";
		if (!$modifPos) {
			die('Invalid query: ' . mysql_error());
		}else{
			//echo "OK";
			mysql_close($db);
			redirige("references.htm");
		}
		//
	}else if($oldPos > $newPos){
		//echo "on deplace de +1 les entrees de ".$newPos." a ".($oldPos - 1)." compris et on enregistre la nouvelle position en ".$newPos;
		$result=mysql_query("SELECT id,ordre FROM _references WHERE ordre < $oldPos && ordre >= $newPos") or die('error : '.mysql_error());
		while($row = mysql_fetch_array($result)){
			//echo "ordre ".$row['ordre']." devient ".($row['ordre'] + 1);
			//echo "<br />";
			$modifPos = mysql_query('UPDATE _references SET ordre = \''.($row['ordre'] + 1).'\'  WHERE id = \''.$row['id'].'\'') or die('error : '.mysql_error());
			//echo mysql_query('UPDATE _references SET ordre = \''.($row['ordre'] + 1).'\'  WHERE id = \''.$row['id'].'\'');
			//echo "<br />";
		}
		//echo "et on enregistre ".$oldPos." en ".$newPos;
		$modifPos = mysql_query('UPDATE _references SET ordre = \''.$newPos.'\'  WHERE id = \''.$ID.'\'') or die('error : '.mysql_error());
		//echo $modifPos;
		//echo "<br />";
		if (!$modifPos) {
			die('Invalid query: ' . mysql_error());
		}else{
			//echo "OK";
			mysql_close($db);
			redirige("references.htm");
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
?>
