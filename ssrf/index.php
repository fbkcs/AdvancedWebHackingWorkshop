<?php

$image = $_GET['url'];
$ch = curl_init();
$optArray = array(
    CURLOPT_URL => $image,
    CURLOPT_RETURNTRANSFER => true
);
curl_setopt_array($ch, $optArray);
$imageData = base64_encode(curl_exec($ch));
curl_close($ch);
$src = 'data:;base64,'.$imageData;
echo '<img src="',$src,'">';

?>
