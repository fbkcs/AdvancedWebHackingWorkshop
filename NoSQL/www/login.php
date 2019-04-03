<?
include_once("config.php");
if(loggedIn()):
header('Location: members.php');
endif;
if(isset($_POST["submit"])):
  if(!($row = checkPass($_POST["login"], $_POST["password"]))):
    echo "<p>Incorrect login/password, try again</p>";
    exit;
  endif;
  cleanMemberSession($_POST["login"], $_POST["password"]);
  header("Location: members.php");
endif;
?>
<html>
<head>
  <title>Simple Authentication with MongoDB</title>
  <style type="text/css">
fieldset {
width:320px;
font-family:Verdana, Arial, Helvetica, sans-serif;
font-size:14px;
}
legend {
width:100px;
text-align:center;
background:#DDE7F0;
border:solid 1px;
margin:1px;
font-weight:bold;
color:#0000FF;
}
</style>
</head>
<body>
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
