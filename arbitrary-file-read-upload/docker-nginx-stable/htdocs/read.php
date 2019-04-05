<?php
require('head.php');
if ($_GET['file']){
    $file = file_get_contents($_GET["file"], FILE_USE_INCLUDE_PATH);
    echo $file;
}
if ($_GET['file2']){
    $path = dirname(basename(__DIR__));
    $filename=$path ."/". $_GET["file2"];
    $file2 = fopen($filename, "r") or die("Can't open this file");
    echo fread($file2,filesize($filename));
    fclose($file2);
    }
?>

