<?php
function db_connect($ip='localhost', $user='root', $pass='', $table='test')
{
	$db = mysql_connect ($ip,$user,$pass);
	mysql_select_db ($table,$db);
}
/*---------------------------------------------------------------*/

db_connect();

if(isset($_POST['ok']))
{
	$data = mysql_fetch_array(mysql_query("SELECT * FROM users WHERE login='{$_POST['who']}'"));
	$who = mysql_fetch_array(mysql_query("SELECT * FROM users WHERE login='{$_POST['to']}'"));

	if($data['value'] >= $_POST['num'])
	{
		$price = $who['value'] + $_POST['num'];
		$_price = $data['value'] - $_POST['num'];

		mysql_query("UPDATE users SET value='{$price}' WHERE login='{$_POST['to']}'") or die("<center>Error (2)</center><hr>");
		mysql_query("UPDATE users SET value='{$_price}' WHERE login='{$_POST['who']}'") or die("<center>Error (3)</center><hr>");

		echo '<center>Success</center><hr>';
	}else
	{
		echo '<center>Error '.mysql_error().'</center><hr>';
	}
}
?>

<form method="POST">
	<input type="text" name="who" placeholder="Who"><br>
	<input type="text" name="num" placeholder="How"><br>
	<input type="text" name="to" placeholder="To"><br><br>
	<input type="submit" name="ok" value="Go!">
</form>