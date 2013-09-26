<?php session_start(); require 'approve.php'; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>|  Workshop Design Home  |  BackOffice  |</title>
<link rel="shortcut icon" href="images/_favicon.ico">
<link rel="stylesheet"  href="css/admin.css" type="text/css" media="screen"  />
<link href="css/uploadify.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="js/swfobject.js"></script>
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="js/jquery.uploadify.v2.1.4.min.js"></script>
</head>
<body>
<?php 
//$root = "http://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI']; 
//$root = "http://".$_SERVER['HTTP_HOST']."/";
$root = "http://".$_SERVER['HTTP_HOST'];
include("header.php");
echo "<div class=\"clear\"></div>";
echo "<div id=\"page-wrap\">";
	echo "<div id=\"conteneur\">";
		if($_GET["toLoad"] == "about"){
			include("about.php");
		}else if($_GET["toLoad"] == "news"){
			include("news.php");
		}else if($_GET["toLoad"] == "contact"){
			include("contact.php");
		}else if($_GET["toLoad"] == "products"){
			include("products.php");
		}else if($_GET["toLoad"] == "liens"){
			include("liens.php");
		}else if($_GET["toLoad"] == "backdrop"){
			include("backdrop.php");
		}else{
			include("works.php");
		}
	echo "</div>";
echo "</div>";
echo "<div class=\"clear\"></div>";
include("footer.php");
?>
</body>