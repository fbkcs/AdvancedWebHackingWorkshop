<?php
if( (!(isset($_COOKIE['cook'])) ) ){//|| !(strpos(file_get_contents("users.txt"),base64_decode($_COOKIE['cook']))) ) {
	header("Location: /");
}
if (isset($_GET['type'],$_GET['old'],$_GET['user'],$_GET['pass']) && $_GET['type'] === 'ch')
{
	  if(strpos($_GET['user'], ' ') || strpos($_GET['pass'], ' ') || strpos($_GET['user'], '  ') || strpos($_GET['pass'], ' ')){
    die();
  }
	$file = fopen("users.txt", "a") or die("Unable to register!");
  $string = file_get_contents("users.txt");
  $string = explode("\n", $string);

    if((in_array($_GET['user'], $string))) {
    	die();
}
		rename($_GET['old'].".txt", $_GET['user'].".txt");
		$file = fopen($_GET['user'].".txt", "w");
		fwrite($file, $_GET['user'].' '.$_GET['pass']."\n");
		fclose($file);
	    $str=file_get_contents('users.txt');
	    $str=str_replace($_GET['old'], $_GET['user'],$str);
	    file_put_contents('users.txt', $str);
	    setcookie("cook", base64_encode($_GET['user']));
	echo "
	<!DOCTYPE html>
	<html>
	<body>
	<h1>Your creds have been successfully updated!</h1>
	<a href='/profile.php'>BACK</a>
	</body>
	</html>
	";
}
elseif (isset($_GET['type']) && $_GET['type'] === 'out') {
	setcookie("cook", "", time()-3600);
	header("Location: /");
}
else
{
	echo "
	<!DOCTYPE html>
	<html>
	<body>
	<h1>Hi, dear ".base64_decode($_COOKIE['cook'])."</h1>
	<h2>Your creds:</h2>
	<h3 id='demo'></h3>
	<br>
	<br>
	<h2>If you want to change the data, do it with the form below:</h2>
	<form>
	  Change creds:<br>
	  <input type='text' name='user'><br>
	  <input type='password' name='pass'><br>
	  <input type='hidden' name='type' value='ch'><br>
	  <input type='hidden' name='old' value='".base64_decode($_COOKIE['cook'])."'><br>
	  <input type='submit' value='GO!'>
	</form>
	<br>
	<br>
	<form>
	  Log out:<br>
	  <input type='hidden' name='type' value='out'><br>
	  <input type='submit' value='GO!'>
	</form>
	</body>
	</html>
	<script>
		const Http = new XMLHttpRequest();
		const url='".base64_decode($_COOKIE['cook']).".txt';
		Http.open('GET', url);
		Http.send();
		Http.onreadystatechange=(e)=>{document.getElementById('demo').innerHTML = Http.responseText}    
	</script>";
}