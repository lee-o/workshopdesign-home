<?php
session_start();
$LOG = "wsd_admin";
$PAS = "0405WSD78";
if(isset($_POST['login'])){
	$login = $_POST['lgn'];
	$password = $_POST['pswd'];
	if ( $password == $PAS && $login == $LOG) { 
		$_SESSION['phplogin'] = true;
		header('Location: index.php');
		exit;
	} else {
		if($password == $PAS && $login != $LOG){
			$fail = "log";
		}else if($password != $PAS && $login == $LOG){
			$fail = "pas";
		}else{
			$fail = "all";
		}
	}
}
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>|  Workshop Design Home  |  BackOffice  |</title>
<link rel="stylesheet"  href="../css/wsd.css" type="text/css" media="screen"  />
</head>
<body>
    <div>
        <img id="pict" src="images/wsd_logo.jpg" width="368" height="148"/>
        <form method="post" action="">
        <h2>LOGIN:</br>
        <input type="login" name="lgn"></br>
        PASSWORD:</br>
        <input type="password" name="pswd"></br>
        <input type="submit" name="login" value="Login"></h2>
        </form>
    </div>
    <? 
		echo "<h2>";
		switch ($fail){
			case "log":
			echo "Login incorrect";
			break;
			case "pas":
			echo "Password incorrect";
			break;
			case "all":
			echo "Login et password incorrect";
			break;
		}
		echo "</h2";
	?>
</body>
</html>