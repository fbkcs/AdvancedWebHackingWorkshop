<?php

error_reporting(0);

$user_auth = True;

header("Content-Type: application/x-javascript");
if ($user_auth == True && isset($_GET['callback']) == True) {
	echo $_GET['callback'].'({"user_mail":"user@test.com", "secret_token":"63a9f0ea7bb98050796b649e85481845"});';
} else {
	echo $_GET['callback'].'({"error":"403"})';
}


?>