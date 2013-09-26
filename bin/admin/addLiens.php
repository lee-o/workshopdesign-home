<?php
//visible à false par défaut
$visible = 1;
$nbrMax = $_GET['nbrMax'] + 1;
$db = mysql_connect('mysql5-22.perso', 'workshopmbdd', '2F0BzY9iKRFi');
mysql_select_db('workshopmbdd', $db);	
$result = mysql_query("INSERT INTO _liens VALUES('','','$visible','$nbrMax',NULL)") or die('error : '.mysql_error());
if (!$result) {
	die('Invalid query: ' . mysql_error());
}else{ 
	redirige("liens.htm");
	
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
