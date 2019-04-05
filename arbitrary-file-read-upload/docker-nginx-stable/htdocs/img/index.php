
    <p>Image uploads directory</p>
    
<body>
    <h2>Upload with check for .php extension</h2>

    
  <form action="index.php" method="POST" enctype="multipart/form-data">
  File:
    <input type="file" name="image_php"> <input type="submit">
  </form>
  <p></p>
  <h2>Upload with type and image size</h2>
  <form action="index.php" method="POST" enctype="multipart/form-data">
  File:
    <input type="file" name="image"> <input type="submit">
  </form>
  <p></p>
<?php
require('../head.php');
    if ($_FILES['image_php']['error'] !== UPLOAD_ERR_OK) {
        echo "<p>Please try again</p>";
    }
    $tmp_name = $_FILES["image_php"]["tmp_name"];
    $name = $_FILES["image_php"]["name"];
    $uploaddir = getcwd() . "//uploads/";
    $uploadfile = $uploaddir . basename($_FILES['image_php']['name']);
    if (substr($name,-4,4) == ".php"){
        die("Dont upload php files plz");
    }
    if (move_uploaded_file($_FILES['image_php']['tmp_name'], $uploadfile)){
        echo "<p>File uploaded to  <a href ='uploads/$name'> $name </a></p>";
}

    $tmp_name = $_FILES['image']['tmp_name'];
    $name = basename($_FILES['image']['name']);
    $uploaddir = getcwd() . "/" . "uploads/";
    $uploadfile = $uploaddir . basename($_FILES['image']['name']);
    $type=$_FILES['image']['type'];
    $pos = strripos($type,"image");
    if ($pos === false) {
        die("Seems like imagetype not valid");
    }
    $size=getimagesize($tmp_name);
    if ($size[0]==0) {
        die("<p>Cant get image size</p>");
    }
    if (move_uploaded_file($_FILES['image']['tmp_name'], $uploadfile)){
        echo "<p>File uploaded to  <a href ='uploads/$name'> $name </a></p>";
    }
?>  