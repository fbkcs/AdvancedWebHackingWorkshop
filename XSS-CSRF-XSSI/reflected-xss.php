<form type="GET" action="#">
<input name="name" type="text">
<input type="submit">
</form>

<?php

error_reporting(0);

echo "<div>Hello, ".str_replace('>', '', $_GET['name'])."</div>";

?>
