<?php
echo "It's login page";
$redirect_url = $_GET['url'];
header("Location: " . $redirect_url);
?>
