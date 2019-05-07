<?php
include 'config.php';

if(!isset($_GET['submit'])) {
?>

<h1>Search:</h1>
<form method="GET">
user login:
<input type="text" name="username" />
<input type="submit" name="submit" />
</form>	


<?php
}else{
	$userdata = null;
	$username = $_GET['username'];
	$r = mysql_query("SELECT * FROM users WHERE login = '".$username."'") or die(mysql_error());
	$userdata = mysql_fetch_array($r);
	echo "Found user - ".$userdata["login"]." with id - ".$userdata["id"];
}
?>
