<?php
// Turn off all error reporting
error_reporting(0);
echo "<p>Hello there! Please dont check my source code</p>";
echo "<a href='../../../read.php?file=hello.txt'>Read v1</a>";
echo "<p><a href='../../../read.php?file2=hello.txt'>Read v2</a></p>";
echo "<p><a href='../../../uploads/'>Uploader</a></p>";
echo "<p><a href='../../../img/'>Image Uploads</a></p>";
echo "<p><a href='../../../nullbyte.php?page=hello.txt%00'>NullByte Reader</a></p>";
?>