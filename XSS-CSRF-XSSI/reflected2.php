<form type="GET" action="#">
<input name="url" type="text">
<input type="submit">
</form>
<?php

error_reporting(0);

echo 'Your image - <img src="'.$_GET['url'].'">';

?>
