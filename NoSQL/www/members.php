<?
include_once("config.php");

if(!loggedIn()):
header('Location: index.php');
endif;

print("Welcome to the members page <b>".$_SESSION["login"]."</b><br>\n");
print("<a href=\"logout.php"."\">Logout</a>");
?>
