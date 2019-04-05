<p><a href="nullbyte.php?page=../../../../../../../etc/passwd%00"> Press me to see how it works</a></p>
<?php
require('head.php');
$page = $_GET['page'];
if (file_exists($page. '.php')) {
    include $page . '.php';
}
?>
