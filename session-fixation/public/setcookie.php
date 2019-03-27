Set cookies: 

<form action="" method="GET">
key:  <input type="text" name="key" value="" /><br />
value:  <input type="text" name="value" value="" /><br />
<input type="submit" name="submit" value="Submit" />
</form>

<?php

if (isset($_GET['key']) && isset($_GET['value'])) {
	setcookie($_GET['key'], $_GET['value']);
	header("Location: index.php");
}

?>