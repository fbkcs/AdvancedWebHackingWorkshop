
    <p>Uploads directory</p>
    
<form enctype="multipart/form-data" action="index.php" method="POST">
    <input type="hidden" name="MAX_FILE_SIZE" value="3000000" />
    Choose any file to upload <input name="userfile" type="file" />
    <input type="submit" value="Upload file" />
</form>
<?php

    require('../head.php');
    $uploaddir = getcwd() . "/";
    $uploadfile = $uploaddir . basename($_FILES['userfile']['name']);
    $name = basename($_FILES['userfile']['name']);
    if (move_uploaded_file($_FILES['userfile']['tmp_name'], $uploadfile)){
        echo "<p>File uploaded to  <a href ='$name'> $name </a></p>";
    }
    else{
        echo "Problems with uploading";
    }
?>
