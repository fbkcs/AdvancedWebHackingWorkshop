<?php
$file = file_get_contents($_GET["file"], FALSE, NULL,0,1000);
echo $file;
$path = dirname(basename(__DIR__));
$file2 = fopen($path ."/". $_GET["file2"], "r");
if ($file2) {
    while (($buffer = fgets($file2, 4096)) !== false) {
        echo $buffer;
    }
    if (!feof($file2)) {
        echo "Ошибка: fgets() неожиданно потерпел неудачу\n";
    }
    fclose($file2);
}
// TODO: file2 доделать, upload сделать
// ?file=../../../../../../../etc/passwd -> 
?>

