<form type="GET" action="#">
<input name="msg" type="text">
<input type="submit">
</form>
<?php

if (isset($_GET['msg'])){

file_put_contents('guests.txt', $_GET['msg']);
echo "Added!<br>";

}

echo "Guestbook content: ";
readfile('guests.txt');



?>
