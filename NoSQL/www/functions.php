<?
function newUser($login, $password)
{
	global $coll;
	$coll->insert(array('login' => $login, 'password' => $password));
	return true;
}

function checkPass($login, $password) 
{
	global $coll;
	$res = $coll->findOne(array('login' => $login, 'password' => $password));
	if($res):
	return true;
	endif;
}

function cleanMemberSession($login, $password)
{

	$_SESSION["login"]=$login;
	$_SESSION["password"]=$password;
	$_SESSION["loggedIn"]=true;
}

function flushMemberSession()
{
	unset($_SESSION["login"]);
	unset($_SESSION["password"]);
	unset($_SESSION["loggedIn"]);
	session_destroy();
	return true;
}

function loggedIn()
{
	if(@$_SESSION['loggedIn']):
	  return true;
	else:
	  return false;
	endif;
}
?>
