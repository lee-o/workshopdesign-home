<?php
session_start();
if (isset($_SESSION['phplogin'])) {
   unset($_SESSION['phplogin']);
}
header('Location: index.php');
exit;
?> 