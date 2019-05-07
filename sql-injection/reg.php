<?php
include 'config.php';

if(!isset($_POST['submit'])) {
?>


<h1>Registration</h1>
<form method="POST">
Username:
<input type="text" name="username" />
Password:
<input type="password" name="password" />
<input type="submit" name="submit" />
</form>	


<?php
} else {
	$username = mysql_escape_string($_POST['username']);
	$password = mysql_escape_string($_POST['password']);
	$r = mysql_query("SELECT * FROM users WHERE login='$username'");
	if(mysql_num_rows($r)) die("User already registered!");
	else {
		if(mysql_query("INSERT INTO users (login,pass,status)
                                     VALUES ('$username','".md5($password)."','user')")) {
			echo "Successfully registered!";
		} else echo mysql_error();
	}
}
?>