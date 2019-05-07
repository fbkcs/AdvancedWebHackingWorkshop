<?php
	include 'config.php';
	$useragent = addslashes($_SERVER['HTTP_USER_AGENT']); 
    $ip = addslashes($_SERVER['REMOTE_ADDR']); 
    $referer = addslashes($_SERVER['HTTP_REFERER']); 
     
    //Добавляем запись 
    $sql = "INSERT INTO stats (ip, useragent, referer) 
            VALUES ('".substr($ip, 0, 16)."', '".substr($useragent, 0, 255)."', '".substr($referer, 0, 255)."')"; 
     
    mysql_query($sql) or die(mysql_error());

    $sql = "SELECT * FROM stats";

    $result = mysql_query($sql) or die(mysql_error());
    
?>


<h1>Users data:</h1>

<?php

 		echo '<pre>'; 
        while ($row = mysql_fetch_assoc($result)) { 
              echo $row['ip']."	".$row['useragent']."	".$row['referer']."\n"; 
        } 
        echo '</pre>'; 

mysql_close(); 

?>