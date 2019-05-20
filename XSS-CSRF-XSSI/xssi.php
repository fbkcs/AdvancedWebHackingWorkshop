<?php

$user_auth = True;

header("Content-Type: application/x-javascript");
if ($user_auth == True) {
	echo "var user_mail = 'user@test.com';";
	echo "var secret_token = '63a9f0ea7bb98050796b649e85481845';";
} else {
	echo "Error!";
}


?>