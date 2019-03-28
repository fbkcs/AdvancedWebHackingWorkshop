
<?php
// router.php
if (preg_match('/\.(?:png|jpg|jpeg|gif)$/', $_SERVER["REQUEST_URI"])) {
    return false;    // сервер возвращает файлы напрямую.
} else { 
    echo "<p>Hello there! Please dont check my source code</p>";
}
echo "<a href='read.php?file=hello.txt'>Читалка</a>"
?>
