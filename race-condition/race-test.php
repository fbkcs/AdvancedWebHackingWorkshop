<form enctype="multipart/form-data" action="#" method="POST">
    <input type="hidden" name="MAX_FILE_SIZE" value="30000" />
    upload and check this: <input name="userfile" type="file" />
    <input type="submit" value="Send File" />
</form>
<?php

	$uploaddir = './tmp/';
	$uploadfile = $uploaddir . basename($_FILES['userfile']['name']);

	move_uploaded_file($_FILES['userfile']['tmp_name'], $uploadfile);

//	echo $uploadfile;

	sleep(2); // Just simulate smth

	if (exif_imagetype($uploadfile) != IMAGETYPE_GIF) {
    	echo 'This is not gif';
    	unlink($uploadfile);
	}
?>
