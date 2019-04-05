<?php
echo "hello there";
$redirect_url = $_GET['url'];
header("Location: " . $redirect_url);
?>
