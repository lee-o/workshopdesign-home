
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
	if($oldPos < $newPos){
		$result=mysql_query("SELECT id,ordre FROM _liens WHERE ordre > $oldPos && ordre <= $newPos") or die('error : '.mysql_error());
		while($row = mysql_fetch_array($result)){
			$modifPos = mysql_query('UPDATE _liens SET ordre = \''.($row['ordre'] - 1).'\'  WHERE id = \''.$row['id'].'\'') or die('error : '.mysql_error());
		}
		$modifPos = mysql_query('UPDATE _liens SET ordre = \''.$newPos.'\'  WHERE id = \''.$ID.'\'') or die('error : '.mysql_error());
		if (!$modifPos) {
			die('Invalid query: ' . mysql_error());
		}else{
			mysql_close($db);
			redirige("liens.htm");
		}
		//
	}else if($oldPos > $newPos){
		$result=mysql_query("SELECT id,ordre FROM _liens WHERE ordre < $oldPos && ordre >= $newPos") or die('error : '.mysql_error());
		while($row = mysql_fetch_array($result)){
			$modifPos = mysql_query('UPDATE _liens SET ordre = \''.($row['ordre'] + 1).'\'  WHERE id = \''.$row['id'].'\'') or die('error : '.mysql_error());
		}
		$modifPos = mysql_query('UPDATE _liens SET ordre = \''.$newPos.'\'  WHERE id = \''.$ID.'\'') or die('error : '.mysql_error());
		if (!$modifPos) {
			die('Invalid query: ' . mysql_error());
		}else{
			mysql_close($db);
			redirige("liens.htm");
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
