<?php
ob_start();
error_reporting(E_ALL);
try
{
  $m    = new MongoClient('mongodb://mongodb:27017');
  $db   = $m->test;
  $coll = $db->users;
}
catch (MongoConnectionException $e)
{
  die('Error connecting to MongoDB server');
} 
catch (MongoException $e) {
  die('Error: ' . $e->getMessage());
}
include_once("functions.php");
session_start();
// $_SESSION["login"]='';
// $_SESSION["password"]='';
// $_SESSION["loggedIn"]='';
?>
<?//var_dump($_SESSION);var_dump($_POST);?>
