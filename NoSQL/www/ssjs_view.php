<?
include_once("config.php");

if(!loggedIn()):
header('Location: index.php');
endif;

$user = getData($_SESSION['login']);    
print("You username: <b>".$user["login"]."</b><br>\n");
print("You password: <b>".$user["pass"]."</b><br>\n");
?>
