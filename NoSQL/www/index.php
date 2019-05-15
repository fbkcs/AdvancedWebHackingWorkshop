<?include_once("config.php");?>
<html>
<head>
  <title>Simple Authentication with MongoDB</title>
</head>
<body>
<p>Index PHP<p>
  <?if(!loggedIn()):?>
    <a href="join.php">Register</a> |
    <a href="login.php">Login</a> |
    <a href="ssjs.php">Server Side Java Script</a> |
  <?else:?>
    <a href="logout.php">Logout</a>
  <?endif;?>
</body>
</html>