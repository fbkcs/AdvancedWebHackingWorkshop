<?include_once("config.php");?>
<html>
<head>
  <title>Server Side Java Script</title>
</head>
<body>
<p>Index PHP<p>
<?php
if (isset($_POST['login']) and isset($_POST['password'])){
$login = $_POST['login'];
$pass = $_POST['password'];
$q = "function() { var loginn = '$login';
    var passs = '$pass'; db.users.insert({id : 2,
    login : loginn, pass : passs}); }";

//1'; var passs = db.version(); var test='
$db->execute($q);
cleanMemberSession($_POST["login"], $_POST["password"]);
header("Location: ssjs_view.php");
}
?>
	<form name="form1" method="post"action="<?=$_SERVER["PHP_SELF"]; ?>">
	<fieldset>
	<legend>Login</legend>
	<table>
	<tr>
	<td><label for="login">Username:</label></td><td><input name="login" value="<?= isset($_POST["login"]) ? $_POST["login"] : "" ; ?>" type="text" id="username" size="30" /></td>
	</tr>
	<tr>
	<td><label for="password">Password:</label></td><td><input name="password" type="password" id="password" size="30" /></td>
	</tr>
	<tr>
	<td class="submit"></td><td><input name="submit" type="submit" value="Submit" /></td>
	</tr>
	</table>
	</fieldset>
	</form>
</body>
</html>
