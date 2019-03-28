
<?php
// router.php
if (preg_match('/\.(?:png|jpg|jpeg|gif|php|txt)$/', $_SERVER["REQUEST_URI"])) {
    return false;    // сервер возвращает файлы напрямую.
} else { 
    echo "<p>Uploads directory</p>";
}
?>
