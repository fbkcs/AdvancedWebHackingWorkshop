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


mysql_query("CREATE TABLE users (	id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,	login VARCHAR(10) NOT NULL,	pass VARCHAR(32) NOT NULL, status TEXT NOT NULL);") or die(mysql_error());
mysql_query("CREATE TABLE stats (id int unsigned not null PRIMARY KEY AUTO_INCREMENT, ip varchar(16), useragent varchar(255), referer varchar(255));") or die(mysql_error());
mysql_query("INSERT INTO users (login,pass,status) VALUES ('root', MD5('toor'), 'admin');") or die(mysql_error());
?>







