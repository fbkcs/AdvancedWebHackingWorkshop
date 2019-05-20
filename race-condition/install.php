<?php

$servername = "localhost";
$username = "root";
$password = "";

// Create connection
$conn = new mysqli($servername, $username, $password);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

// Create database
$sql = "CREATE DATABASE test";
if ($conn->query($sql) === TRUE) {
    echo "Database created successfully";
} else {
    echo "Error creating database: " . $conn->error;
}

$conn->close();

$connection = mysql_connect('localhost', 'root', '');
if (!$connection){
    die("Database Connection Failed" . mysql_error());
}
$select_db = mysql_select_db('test');
if (!$select_db){
    die("Database Selection Failed" . mysql_error());
}


mysql_query("CREATE TABLE IF NOT EXISTS `users` (  `id` int(11) NOT NULL AUTO_INCREMENT,  `login` text NOT NULL,  `value` int(11) NOT NULL,  PRIMARY KEY (`id`)) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3;") or die(mysql_error());
mysql_query("INSERT INTO `users` (`id`, `login`, `value`) VALUES(1, 'user1', 1000),(2, 'user2', 0);") or die(mysql_error());
?>







